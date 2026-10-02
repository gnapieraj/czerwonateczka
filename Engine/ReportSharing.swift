import CoreImage
import CryptoKit
import Foundation
import UIKit

// MARK: - Public verify (plan §7, wariant A)

/// Public verify URL + Ed25519-signed payload (no employee name).
///
/// Trust model (documented in plan-raport-dyplom.md §0 / §7):
/// - Free build embeds a signing seed; the website embeds only the public key.
/// - A valid signature proves the payload was produced by a build that holds the seed —
///   not that Colgante operates a hosted ledger of every diploma.
/// - Static `registry.json` fixtures are an optional demo path (same public fields).
/// - Forging still requires extracting the app seed (or a future org HSM). Honest limits.
enum ReportVerify {
    /// True when the public page can validate a signed payload (or a static fixture).
    /// Flip only while that path actually verifies — never as a marketing stub.
    static let isPublicRegistryLive = true

    /// Ed25519 seed (32 bytes) for the free flavor. Org builds (v3) should replace this.
    static let freeSigningSeedHex = "36f2f2c1361b21477ff2950488e64c2a3e18d9d3daa784be14801048e0bc7fe4"
    static let freePublicKeyHex = "954ef85698d05c50a721386495599fab025aab4303e44b74fb36903102d5842e"

    static var baseURL: URL {
        URL(string: "https://\(Canon.domainReal)/verify")!
    }

    static func publicURL(reportId: UUID) -> URL {
        baseURL.appendingPathComponent(reportId.uuidString.lowercased()).appendingPathComponent("")
    }

    /// Canonical QR / LinkedIn URL: path id + compact signed token in `p`.
    static func signedPublicURL(for report: TrainingReport) -> URL {
        var components = URLComponents(url: publicURL(reportId: report.reportId), resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "p", value: signedToken(for: report))]
        return components.url!
    }

    /// Payload fields safe to show on a public page (wariant A). Never includes employeeName.
    static func publicFields(from report: TrainingReport) -> [String: String] {
        var fields: [String: String] = [
            "reportId": report.reportId.uuidString.lowercased(),
            "status": report.status.rawValue,
            "completionDate": report.completionDate,
            "validUntil": report.validUntil,
            "trainingName": report.trainingName,
            "provider": report.provider,
            "lessonCount": String(report.lessonCount),
            "contentVersion": report.contentVersion,
            "lessonsPackHash": report.lessonsPackHash,
            "buildFlavor": report.buildFlavor,
        ]
        if report.publishOrganization, !report.organization.isEmpty {
            fields["organization"] = report.organization
        }
        return fields
    }

    static func publicPayload(from report: TrainingReport) -> PublicReportPayload {
        PublicReportPayload(
            v: 1,
            id: report.reportId.uuidString.lowercased(),
            st: report.status.rawValue,
            cd: report.completionDate,
            vu: report.validUntil,
            tn: report.trainingName,
            n: report.lessonCount,
            h: report.lessonsPackHash,
            cv: report.contentVersion,
            iss: report.provider,
            bf: report.buildFlavor,
            org: (report.publishOrganization && !report.organization.isEmpty) ? report.organization : nil
        )
    }

    static func signedToken(for report: TrainingReport) -> String {
        sign(publicPayload(from: report))
    }

    static func sign(_ payload: PublicReportPayload, seedHex: String = freeSigningSeedHex) -> String {
        let body = payload.canonicalJSON
        let seed = Data(hexString: seedHex) ?? Data()
        let privateKey = try! Curve25519.Signing.PrivateKey(rawRepresentation: seed)
        let signature = try! privateKey.signature(for: body)
        return base64url(body) + "." + base64url(Data(signature))
    }

    static func verify(token: String, publicKeyHex: String = freePublicKeyHex) -> PublicReportPayload? {
        let parts = token.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: false)
        guard parts.count == 2,
              let body = Data(base64url: String(parts[0])),
              let signature = Data(base64url: String(parts[1])),
              let keyData = Data(hexString: publicKeyHex),
              let publicKey = try? Curve25519.Signing.PublicKey(rawRepresentation: keyData),
              publicKey.isValidSignature(signature, for: body),
              let payload = try? JSONDecoder().decode(PublicReportPayload.self, from: body)
        else { return nil }
        return payload
    }
}

/// Compact public payload (wariant A). Short keys keep the QR URL scannable.
struct PublicReportPayload: Codable, Equatable {
    var v: Int
    var id: String
    var st: String
    var cd: String
    var vu: String
    var tn: String
    var n: Int
    var h: String
    var cv: String
    var iss: String
    var bf: String
    var org: String?

    var canonicalJSON: Data {
        let encoder = JSONEncoder()
        // withoutEscapingSlashes keeps "Colgante / …" stable and QR-friendly.
        encoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
        return (try? encoder.encode(self)) ?? Data()
    }

    var isCompleted: Bool { st == ReportStatus.completed.rawValue }

    func isValid(on day: String) -> Bool {
        isCompleted && vu >= day
    }
}

// MARK: - QR

enum ReportQR {
    /// PNG-ready UIImage of a QR pointing at the signed verify URL.
    static func image(for report: TrainingReport, side: CGFloat = 96) -> UIImage? {
        image(url: ReportVerify.signedPublicURL(for: report), side: side)
    }

    static func image(url: URL, side: CGFloat) -> UIImage? {
        let data = Data(url.absoluteString.utf8)
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        // L packs denser URLs; print size on A4 is large enough for phone cameras.
        filter.setValue("L", forKey: "inputCorrectionLevel")
        guard let output = filter.outputImage else { return nil }
        let scale = max(1, side / output.extent.width)
        let scaled = output.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        let bounds = CGRect(x: 0, y: 0, width: side, height: side)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = true
        return UIGraphicsImageRenderer(size: bounds.size, format: format).image { ctx in
            UIColor.white.setFill()
            ctx.fill(bounds)
            UIImage(ciImage: scaled).draw(in: bounds.insetBy(dx: 2, dy: 2))
        }
    }
}

// MARK: - LinkedIn

/// LinkedIn "Add certification" deeplink (Credsverse-like share path, offline-first).
enum LinkedInCertification {
    static let organizationName = "Colgante / Czerwona Teczka"

    static func addToProfileURL(for report: TrainingReport) -> URL? {
        guard report.passed else { return nil }
        var components = URLComponents(string: "https://www.linkedin.com/profile/add")!
        let issue = issueMonthYear(from: report.completionDate)
        let expiry = issueMonthYear(from: report.validUntil)
        var items: [URLQueryItem] = [
            URLQueryItem(name: "startTask", value: "CERTIFICATION_NAME"),
            URLQueryItem(name: "name", value: report.trainingName),
            URLQueryItem(name: "organizationName", value: organizationName),
            URLQueryItem(name: "certId", value: report.reportId.uuidString.lowercased()),
        ]
        if let issue {
            items.append(URLQueryItem(name: "issueYear", value: String(issue.year)))
            items.append(URLQueryItem(name: "issueMonth", value: String(issue.month)))
        }
        if let expiry {
            items.append(URLQueryItem(name: "expirationYear", value: String(expiry.year)))
            items.append(URLQueryItem(name: "expirationMonth", value: String(expiry.month)))
        }
        let certURL = ReportVerify.isPublicRegistryLive
            ? ReportVerify.signedPublicURL(for: report)
            : ReportVerify.publicURL(reportId: report.reportId)
        items.append(URLQueryItem(name: "certUrl", value: certURL.absoluteString))
        components.queryItems = items
        return components.url
    }

    private static func issueMonthYear(from day: String) -> (year: Int, month: Int)? {
        let parts = day.split(separator: "-")
        guard parts.count >= 2, let year = Int(parts[0]), let month = Int(parts[1]), (1...12).contains(month) else {
            return nil
        }
        return (year, month)
    }
}

// MARK: - Encoding helpers

private func base64url(_ data: Data) -> String {
    data.base64EncodedString()
        .replacingOccurrences(of: "+", with: "-")
        .replacingOccurrences(of: "/", with: "_")
        .replacingOccurrences(of: "=", with: "")
}

private extension Data {
    init?(hexString: String) {
        let cleaned = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard cleaned.count.isMultiple(of: 2) else { return nil }
        var data = Data(capacity: cleaned.count / 2)
        var index = cleaned.startIndex
        while index < cleaned.endIndex {
            let next = cleaned.index(index, offsetBy: 2)
            guard let byte = UInt8(cleaned[index..<next], radix: 16) else { return nil }
            data.append(byte)
            index = next
        }
        self = data
    }

    init?(base64url string: String) {
        var s = string.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")
        let pad = (4 - s.count % 4) % 4
        s.append(String(repeating: "=", count: pad))
        self.init(base64Encoded: s)
    }
}
