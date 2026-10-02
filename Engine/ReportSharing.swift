import Foundation

/// Public verify URL helpers (plan §7, wariant A — no employee name on the public page).
enum ReportVerify {
    /// Flip when colgante.pl hosts a live registry. Until then the app must not claim verify works.
    static let isPublicRegistryLive = false

    static var baseURL: URL {
        URL(string: "https://\(Canon.domainReal)/verify")!
    }

    static func publicURL(reportId: UUID) -> URL {
        baseURL.appendingPathComponent(reportId.uuidString.lowercased())
    }

    /// Payload fields safe to show on a public page (wariant A). Never includes employeeName.
    static func publicFields(from report: TrainingReport) -> [String: String] {
        [
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
            "organizationPublished": report.organization.isEmpty ? "" : report.organization,
        ]
    }
}

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
        // Point at the public verify URL shape even when the registry is not live yet —
        // LinkedIn stores the link; the page itself explains the offline / coming-soon state.
        items.append(URLQueryItem(name: "certUrl", value: ReportVerify.publicURL(reportId: report.reportId).absoluteString))
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
