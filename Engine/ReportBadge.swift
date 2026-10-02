import UIKit

/// Offline completion badge PNG (Credsverse-like look, no third-party service).
enum ReportBadge {
    static let size = CGSize(width: 1080, height: 1080)

    static func render(_ report: TrainingReport) -> Data {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = true
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        let image = renderer.image { ctx in
            let cg = ctx.cgContext
            let bounds = CGRect(origin: .zero, size: size)

            // Noir background
            UIColor(red: 0.07, green: 0.07, blue: 0.08, alpha: 1).setFill()
            cg.fill(bounds)

            // Blood frame
            let inset: CGFloat = 48
            let frame = bounds.insetBy(dx: inset, dy: inset)
            UIColor(red: 0.72, green: 0.08, blue: 0.10, alpha: 1).setStroke()
            cg.setLineWidth(6)
            cg.stroke(frame)

            let language = report.appLanguage
            let mist = UIColor(white: 0.62, alpha: 1)
            let paper = UIColor(red: 0.91, green: 0.88, blue: 0.80, alpha: 1)

            var y: CGFloat = 120
            drawCentered(
                Copy.s(language, pl: "CZERWONA TECZKA", en: "CZERWONA TECZKA"),
                font: titleFont(28), color: UIColor(red: 0.72, green: 0.08, blue: 0.10, alpha: 1),
                y: &y, tracking: 4
            )
            y += 12
            drawCentered(
                Copy.s(language, pl: "ODZNAKA UKOŃCZENIA", en: "COMPLETION BADGE"),
                font: .systemFont(ofSize: 18, weight: .semibold), color: mist,
                y: &y, tracking: 2
            )
            y += 36

            // Seal circle
            let sealCenter = CGPoint(x: size.width / 2, y: y + 140)
            let sealRadius: CGFloat = 120
            UIColor(red: 0.72, green: 0.08, blue: 0.10, alpha: 1).setFill()
            cg.fillEllipse(in: CGRect(x: sealCenter.x - sealRadius, y: sealCenter.y - sealRadius, width: sealRadius * 2, height: sealRadius * 2))
            UIColor.white.setStroke()
            cg.setLineWidth(3)
            cg.strokeEllipse(in: CGRect(x: sealCenter.x - sealRadius + 10, y: sealCenter.y - sealRadius + 10, width: (sealRadius - 10) * 2, height: (sealRadius - 10) * 2))

            let sealText = report.passed
                ? Copy.s(language, pl: "UKOŃCZONO", en: "COMPLETED")
                : Copy.s(language, pl: "W TOK", en: "IN PROGRESS")
            let sealAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 22, weight: .heavy),
                .foregroundColor: UIColor.white,
                .kern: 2,
            ]
            let sealSize = (sealText as NSString).size(withAttributes: sealAttrs)
            (sealText as NSString).draw(
                at: CGPoint(x: sealCenter.x - sealSize.width / 2, y: sealCenter.y - sealSize.height / 2),
                withAttributes: sealAttrs
            )
            y = sealCenter.y + sealRadius + 48

            let name = report.employeeName.isEmpty ? "—" : report.employeeName
            drawCentered(name, font: titleFont(36), color: paper, y: &y)
            y += 10
            if !report.organization.isEmpty {
                drawCentered(report.organization, font: .systemFont(ofSize: 20, weight: .medium), color: mist, y: &y)
                y += 8
            }
            drawCentered(report.trainingName, font: .systemFont(ofSize: 18), color: paper, y: &y, maxWidth: size.width - 160)
            y += 24
            drawCentered(
                "\(report.completionDate) · \(report.provider)",
                font: .systemFont(ofSize: 16), color: mist, y: &y
            )
            y += 8
            drawCentered(
                Copy.s(language, pl: "Ważne do \(report.validUntil)", en: "Valid until \(report.validUntil)"),
                font: .systemFont(ofSize: 15), color: mist, y: &y
            )

            // Footer meta (no claim that public verify is live)
            let footerY = size.height - 100
            let shortId = String(report.reportId.uuidString.prefix(8)).uppercased()
            let verifyNote = ReportVerify.isPublicRegistryLive
                ? ReportVerify.publicURL(reportId: report.reportId).absoluteString
                : Copy.s(
                    language,
                    pl: "Weryfikacja publiczna (v2) — w przygotowaniu · id \(shortId)",
                    en: "Public verify (v2) — coming soon · id \(shortId)"
                )
            var footerYMut = footerY
            drawCentered(verifyNote, font: .monospacedSystemFont(ofSize: 13, weight: .regular), color: mist, y: &footerYMut, maxWidth: size.width - 120)
        }
        return image.pngData() ?? Data()
    }

    private static func titleFont(_ size: CGFloat) -> UIFont {
        UIFont(name: Typeface.comic, size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }

    private static func drawCentered(
        _ string: String,
        font: UIFont,
        color: UIColor,
        y: inout CGFloat,
        tracking: CGFloat = 0,
        maxWidth: CGFloat = size.width - 120
    ) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.lineBreakMode = .byWordWrapping
        var attrs: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraph,
        ]
        if tracking != 0 { attrs[.kern] = tracking }
        let attributed = NSAttributedString(string: string, attributes: attrs)
        let bounds = attributed.boundingRect(
            with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        let x = (size.width - maxWidth) / 2
        attributed.draw(with: CGRect(x: x, y: y, width: maxWidth, height: ceil(bounds.height)), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        y += ceil(bounds.height)
    }
}
