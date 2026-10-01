import UIKit

/// A4 diploma rendered with UIGraphicsPDFRenderer. No per-night verdicts (plan decision 2).
enum ReportPDF {
    static let pageSize = CGSize(width: 595.2, height: 841.8)
    static let margin: CGFloat = 52

    private static let ink = UIColor(red: 0.07, green: 0.07, blue: 0.08, alpha: 1)
    private static let blood = UIColor(red: 0.72, green: 0.08, blue: 0.10, alpha: 1)
    private static let mist = UIColor(white: 0.42, alpha: 1)
    private static let rule = UIColor(white: 0.80, alpha: 1)

    static func render(_ report: TrainingReport) -> Data {
        let language = report.appLanguage
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = [
            kCGPDFContextTitle as String: Copy.s(language, pl: "Czerwona Teczka — potwierdzenie ukończenia", en: "Czerwona Teczka — completion statement"),
            kCGPDFContextAuthor as String: report.provider,
            kCGPDFContextCreator as String: "Czerwona Teczka \(report.contentVersion)",
            kCGPDFContextSubject as String: "reportId=\(report.reportId.uuidString) completedAt=\(ReportDates.iso8601(report.completedAt))",
        ]
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize), format: format)
        return renderer.pdfData { context in
            var page = Page(context: context)
            page.begin()
            drawHeader(report, on: &page)
            drawStatus(report, on: &page)
            drawFacts(report, on: &page)
            drawTopics(report, on: &page)
            drawFooter(report, on: &page)
        }
    }

    // MARK: Sections

    private static func drawHeader(_ report: TrainingReport, on page: inout Page) {
        let language = report.appLanguage
        page.text(
            Copy.s(language, pl: "CZERWONA TECZKA · MODUŁ AWARENESS", en: "CZERWONA TECZKA · AWARENESS MODULE"),
            font: .systemFont(ofSize: 10, weight: .semibold), color: blood, tracking: 2
        )
        page.space(6)
        page.text(
            Copy.s(language, pl: "Potwierdzenie ukończenia modułu edukacyjnego", en: "Statement of completion of an educational module"),
            font: titleFont(26), color: ink
        )
        page.space(4)
        page.text(report.trainingName, font: .systemFont(ofSize: 13, weight: .medium), color: mist)
        page.space(14)
        page.rule(color: blood, width: 2)
        page.space(18)
    }

    private static func drawStatus(_ report: TrainingReport, on page: inout Page) {
        let language = report.appLanguage
        let name = report.employeeName.isEmpty ? "—" : report.employeeName
        page.text(Copy.s(language, pl: "Potwierdza się, że", en: "This confirms that"), font: .systemFont(ofSize: 11), color: mist)
        page.space(4)
        page.text(name, font: titleFont(30), color: ink)
        page.space(6)
        if !report.organization.isEmpty {
            page.text(report.organization, font: .systemFont(ofSize: 14, weight: .medium), color: ink)
            page.space(6)
        }
        if report.passed {
            page.text(
                Copy.s(
                    language,
                    pl: "ukończył(a) moduł edukacyjny z zakresu bezpieczeństwa informacji i ochrony danych w kancelarii.",
                    en: "completed the educational module on information security and data protection in a law practice."
                ),
                font: .systemFont(ofSize: 12), color: ink
            )
            page.space(14)
            page.badge(report.status.label(language), color: blood)
        } else {
            page.text(
                Copy.s(
                    language,
                    pl: "nie ukończył(a) jeszcze modułu — poniżej progu zaliczenia lub niekompletny zakres.",
                    en: "has not yet completed the module — below the pass threshold or an incomplete scope."
                ),
                font: .systemFont(ofSize: 12), color: ink
            )
            page.space(14)
            page.badge(report.status.label(language), color: mist)
        }
        page.space(22)
    }

    private static func drawFacts(_ report: TrainingReport, on page: inout Page) {
        let language = report.appLanguage
        let months = Copy.s(language, pl: "mies.", en: "months")
        let thresholdNote = Copy.s(language, pl: "trafnych decyzji, komplet nocy i briefingów", en: "sound calls, every night and briefing done")
        let rows: [(String, String)] = [
            (Copy.s(language, pl: "Data ukończenia", en: "Completion date"), "\(report.completionDate) (Europe/Warsaw)"),
            (Copy.s(language, pl: "Forma", en: "Format"), report.trainingForm),
            (Copy.s(language, pl: "Dostawca", en: "Provider"), report.provider),
            (Copy.s(language, pl: "Ważne do", en: "Valid until"), "\(report.validUntil) (\(report.validityMonths) \(months))"),
            (Copy.s(language, pl: "Następne szkolenie przypominające", en: "Next refresher"), report.nextReminderAt),
            (Copy.s(language, pl: "Próg zaliczenia", en: "Pass threshold"), "≥ \(report.thresholdPercent)% \(thresholdNote)"),
        ]
        for (label, value) in rows {
            page.labelValue(label, value, labelFont: .systemFont(ofSize: 9, weight: .semibold), valueFont: .systemFont(ofSize: 11), labelColor: mist, valueColor: ink)
        }
        page.space(16)
    }

    private static func drawTopics(_ report: TrainingReport, on page: inout Page) {
        let language = report.appLanguage
        page.text(
            Copy.s(language, pl: "ZAKRES — TEMATY (\(report.lessonCount))", en: "SCOPE — TOPICS (\(report.lessonCount))"),
            font: .systemFont(ofSize: 10, weight: .semibold), color: blood, tracking: 1.5
        )
        page.space(6)
        page.rule(color: rule, width: 0.5)
        page.space(6)
        for season in report.seasons {
            page.text(season.title, font: .systemFont(ofSize: 11, weight: .semibold), color: ink)
            page.space(3)
            for lesson in season.lessons {
                let number = String(format: "%02d", lesson.order)
                let line = "\(number)  ·  \(lesson.lessonId)  ·  \(lesson.title)  —  \(lesson.subtitle)"
                page.text(line, font: .systemFont(ofSize: 9.5), color: ink, lineSpacing: 1)
            }
            page.space(8)
        }
        page.space(10)
    }

    private static func drawFooter(_ report: TrainingReport, on page: inout Page) {
        let language = report.appLanguage
        page.ensure(120)
        page.rule(color: rule, width: 0.5)
        page.space(8)
        let versionLabel = Copy.s(language, pl: "wersja treści", en: "content version")
        let issuedLabel = Copy.s(language, pl: "wydano", en: "issued")
        let hashLabel = Copy.s(language, pl: "pakiet lekcji w zakresie", en: "lessons in scope")
        let issued = ReportDates.iso8601(report.issuedAt)
        let meta = [
            "reportId: \(report.reportId.uuidString)",
            "\(versionLabel): \(report.contentVersion) · build: \(report.buildFlavor) · \(issuedLabel): \(issued)",
            "SHA-256 (\(hashLabel)): \(report.lessonsPackHash)",
        ]
        for line in meta {
            page.text(line, font: monoFont(7.5), color: mist, lineSpacing: 1)
        }
        page.space(10)
        page.text(report.disclaimer, font: .italicSystemFont(ofSize: 8.5), color: mist, lineSpacing: 1)
        page.space(4)
        page.text(Canon.fiction(language), font: .italicSystemFont(ofSize: 8.5), color: mist, lineSpacing: 1)
    }

    // MARK: Fonts

    private static func titleFont(_ size: CGFloat) -> UIFont {
        UIFont(name: Typeface.comic, size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }

    private static func monoFont(_ size: CGFloat) -> UIFont {
        .monospacedSystemFont(ofSize: size, weight: .regular)
    }

    // MARK: Page cursor

    private struct Page {
        let context: UIGraphicsPDFRendererContext
        var y: CGFloat = ReportPDF.margin
        var number = 0

        var contentWidth: CGFloat { ReportPDF.pageSize.width - ReportPDF.margin * 2 }
        var bottom: CGFloat { ReportPDF.pageSize.height - ReportPDF.margin }

        init(context: UIGraphicsPDFRendererContext) {
            self.context = context
        }

        mutating func begin() {
            context.beginPage()
            number += 1
            y = ReportPDF.margin
            let footer = String(number)
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 8), .foregroundColor: ReportPDF.mist]
            let size = (footer as NSString).size(withAttributes: attributes)
            (footer as NSString).draw(
                at: CGPoint(x: ReportPDF.pageSize.width - ReportPDF.margin - size.width, y: ReportPDF.pageSize.height - ReportPDF.margin / 2),
                withAttributes: attributes
            )
        }

        mutating func ensure(_ height: CGFloat) {
            if y + height > bottom { begin() }
        }

        mutating func space(_ height: CGFloat) {
            y += height
        }

        mutating func rule(color: UIColor, width: CGFloat) {
            ensure(width + 2)
            let path = UIBezierPath()
            path.move(to: CGPoint(x: ReportPDF.margin, y: y))
            path.addLine(to: CGPoint(x: ReportPDF.pageSize.width - ReportPDF.margin, y: y))
            path.lineWidth = width
            color.setStroke()
            path.stroke()
            y += width
        }

        mutating func text(_ string: String, font: UIFont, color: UIColor, tracking: CGFloat = 0, lineSpacing: CGFloat = 2) {
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = lineSpacing
            paragraph.lineBreakMode = .byWordWrapping
            var attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, .paragraphStyle: paragraph]
            if tracking != 0 { attributes[.kern] = tracking }
            let attributed = NSAttributedString(string: string, attributes: attributes)
            let bounds = attributed.boundingRect(
                with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )
            ensure(bounds.height)
            attributed.draw(with: CGRect(x: ReportPDF.margin, y: y, width: contentWidth, height: ceil(bounds.height)), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
            y += ceil(bounds.height)
        }

        mutating func labelValue(_ label: String, _ value: String, labelFont: UIFont, valueFont: UIFont, labelColor: UIColor, valueColor: UIColor) {
            let labelWidth: CGFloat = 170
            let valueAttributes: [NSAttributedString.Key: Any] = [.font: valueFont, .foregroundColor: valueColor]
            let valueBounds = (value as NSString).boundingRect(
                with: CGSize(width: contentWidth - labelWidth, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: valueAttributes,
                context: nil
            )
            let height = max(ceil(valueBounds.height), 14) + 6
            ensure(height)
            (label.uppercased() as NSString).draw(
                in: CGRect(x: ReportPDF.margin, y: y + 2, width: labelWidth - 8, height: height),
                withAttributes: [.font: labelFont, .foregroundColor: labelColor, .kern: 0.8]
            )
            (value as NSString).draw(
                with: CGRect(x: ReportPDF.margin + labelWidth, y: y, width: contentWidth - labelWidth, height: height),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: valueAttributes,
                context: nil
            )
            y += height
        }

        mutating func badge(_ string: String, color: UIColor) {
            let font = UIFont.systemFont(ofSize: 15, weight: .heavy)
            let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.white, .kern: 3]
            let size = (string as NSString).size(withAttributes: attributes)
            let rect = CGRect(x: ReportPDF.margin, y: y, width: size.width + 32, height: size.height + 14)
            ensure(rect.height)
            color.setFill()
            UIBezierPath(rect: rect).fill()
            (string as NSString).draw(at: CGPoint(x: rect.minX + 16, y: rect.minY + 7), withAttributes: attributes)
            y += rect.height
        }
    }
}
