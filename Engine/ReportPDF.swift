import PDFKit
import UIKit

/// A4 diploma rendered with UIGraphicsPDFRenderer. No per-night verdicts (plan decision 2).
/// Layout goals: fit typical scopes (≤12, often 24) without an orphaned footer page;
/// when a second page is needed, open it with a continuation header and keep meta+disclaimer with content.
enum ReportPDF {
    static let pageSize = CGSize(width: 595.2, height: 841.8)
    static let margin: CGFloat = 48

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
            var page = Page(context: context, language: language, trainingName: report.trainingName)
            page.begin()
            drawHeader(report, on: &page)
            drawStatus(report, on: &page)
            drawFacts(report, on: &page)
            drawTopics(report, on: &page)
            drawFooter(report, on: &page)
        }
    }

    /// Number of pages in a rendered diploma (for layout tests).
    static func pageCount(of data: Data) -> Int {
        PDFDocument(data: data)?.pageCount ?? 0
    }

    // MARK: Sections

    private static func drawHeader(_ report: TrainingReport, on page: inout Page) {
        let language = report.appLanguage
        page.text(
            Copy.s(language, pl: "CZERWONA TECZKA · MODUŁ AWARENESS", en: "CZERWONA TECZKA · AWARENESS MODULE"),
            font: .systemFont(ofSize: 9.5, weight: .semibold), color: blood, tracking: 1.6
        )
        page.space(4)
        page.text(
            Copy.s(language, pl: "Potwierdzenie ukończenia modułu edukacyjnego", en: "Statement of completion of an educational module"),
            font: titleFont(22), color: ink
        )
        page.space(2)
        page.text(report.trainingName, font: .systemFont(ofSize: 12, weight: .medium), color: mist)
        page.space(8)
        page.rule(color: blood, width: 1.5)
        page.space(10)
    }

    private static func drawStatus(_ report: TrainingReport, on page: inout Page) {
        let language = report.appLanguage
        let name = report.employeeName.isEmpty ? "—" : report.employeeName
        page.text(Copy.s(language, pl: "Potwierdza się, że", en: "This confirms that"), font: .systemFont(ofSize: 10), color: mist)
        page.space(2)
        page.text(name, font: titleFont(26), color: ink)
        page.space(3)
        if !report.organization.isEmpty {
            page.text(report.organization, font: .systemFont(ofSize: 13, weight: .medium), color: ink)
            page.space(3)
        }
        if report.passed {
            page.text(
                Copy.s(
                    language,
                    pl: "ukończył(a) moduł edukacyjny z zakresu bezpieczeństwa informacji i ochrony danych w kancelarii.",
                    en: "completed the educational module on information security and data protection in a law practice."
                ),
                font: .systemFont(ofSize: 11), color: ink
            )
            page.space(8)
            page.badge(report.status.label(language), color: blood)
        } else {
            page.text(
                Copy.s(
                    language,
                    pl: "nie ukończył(a) jeszcze modułu — poniżej progu zaliczenia lub niekompletny zakres.",
                    en: "has not yet completed the module — below the pass threshold or an incomplete scope."
                ),
                font: .systemFont(ofSize: 11), color: ink
            )
            page.space(8)
            page.badge(report.status.label(language), color: mist)
        }
        page.space(12)
    }

    private static func drawFacts(_ report: TrainingReport, on page: inout Page) {
        let language = report.appLanguage
        let months = Copy.s(language, pl: "mies.", en: "months")
        let thresholdNote = Copy.s(language, pl: "trafnych decyzji, komplet nocy i briefingów", en: "sound decisions, all nights and briefings completed")
        let rows: [(String, String)] = [
            (Copy.s(language, pl: "Data ukończenia", en: "Completion date"), "\(report.completionDate) (Europe/Warsaw)"),
            (Copy.s(language, pl: "Forma", en: "Format"), report.trainingForm),
            (Copy.s(language, pl: "Dostawca", en: "Provider"), report.provider),
            (Copy.s(language, pl: "Ważne do", en: "Valid until"), "\(report.validUntil) (\(report.validityMonths) \(months))"),
            (Copy.s(language, pl: "Następne szkolenie przypominające", en: "Next refresher"), report.nextReminderAt),
            (Copy.s(language, pl: "Próg zaliczenia", en: "Pass threshold"), "≥ \(report.thresholdPercent)% \(thresholdNote)"),
        ]
        for (label, value) in rows {
            page.labelValue(
                label, value,
                labelFont: .systemFont(ofSize: 8, weight: .semibold),
                valueFont: .systemFont(ofSize: 10),
                labelColor: mist, valueColor: ink,
                rowPad: 3
            )
        }
        page.space(10)
    }

    private static func drawTopics(_ report: TrainingReport, on page: inout Page) {
        let language = report.appLanguage
        let lessonCount = report.lessonCount
        let topicFont = topicFontSize(for: lessonCount)
        let useTwoColumns = lessonCount >= 10
        let footerReserve = estimatedFooterHeight(report)

        page.text(
            Copy.s(language, pl: "ZAKRES — TEMATY (\(lessonCount))", en: "SCOPE — TOPICS (\(lessonCount))"),
            font: .systemFont(ofSize: 9.5, weight: .semibold), color: blood, tracking: 1.2
        )
        page.space(4)
        page.rule(color: rule, width: 0.5)
        page.space(4)

        if useTwoColumns {
            drawTopicsTwoColumn(report, fontSize: topicFont, footerReserve: footerReserve, on: &page)
        } else {
            drawTopicsSingleColumn(report, fontSize: topicFont, footerReserve: footerReserve, on: &page)
        }
        page.space(6)
    }

    private static func topicFontSize(for lessonCount: Int) -> CGFloat {
        switch lessonCount {
        case ...6: return 9.5
        case 7...12: return 8.5
        case 13...18: return 8
        default: return 7.5
        }
    }

    private static func drawTopicsSingleColumn(
        _ report: TrainingReport,
        fontSize: CGFloat,
        footerReserve: CGFloat,
        on page: inout Page
    ) {
        let font = UIFont.systemFont(ofSize: fontSize)
        for season in report.seasons {
            page.ensure(font.lineHeight + 16, reserving: footerReserve)
            page.text(season.title, font: .systemFont(ofSize: fontSize + 1, weight: .semibold), color: ink)
            page.space(2)
            for lesson in season.lessons {
                let number = String(format: "%02d", lesson.order)
                let line = "\(number)  ·  \(lesson.lessonId)  ·  \(lesson.title)  —  \(lesson.subtitle)"
                page.ensure(font.lineHeight + 2, reserving: footerReserve)
                page.text(line, font: font, color: ink, lineSpacing: 0.5)
            }
            page.space(4)
        }
    }

    private static func drawTopicsTwoColumn(
        _ report: TrainingReport,
        fontSize: CGFloat,
        footerReserve: CGFloat,
        on page: inout Page
    ) {
        let font = UIFont.systemFont(ofSize: fontSize)
        let titleFont = UIFont.systemFont(ofSize: fontSize + 0.5, weight: .semibold)
        let gap: CGFloat = 14
        let colWidth = (page.contentWidth - gap) / 2

        for season in report.seasons {
            page.ensure(titleFont.lineHeight + 8, reserving: footerReserve)
            page.text(season.title, font: titleFont, color: ink)
            page.space(3)

            let lines = season.lessons.map { lesson -> String in
                let number = String(format: "%02d", lesson.order)
                return "\(number) · \(lesson.lessonId) · \(lesson.title)"
            }
            var index = 0
            while index < lines.count {
                let remainingHeight = page.bottom - page.y - footerReserve
                let lineHeight = ceil(font.lineHeight) + 1
                let rowsThatFit = max(1, Int(floor(remainingHeight / lineHeight)))
                let leftCount = min(rowsThatFit, Int(ceil(Double(lines.count - index) / 2.0)))
                let rightCount = min(rowsThatFit, lines.count - index - leftCount)
                if leftCount == 0 {
                    page.beginContinuation()
                    continue
                }
                let left = Array(lines[index..<(index + leftCount)])
                let rightStart = index + leftCount
                let right = Array(lines[rightStart..<(rightStart + rightCount)])
                let blockHeight = CGFloat(max(left.count, right.count)) * lineHeight
                page.ensure(blockHeight, reserving: footerReserve)
                let startY = page.y
                drawColumn(left, atX: ReportPDF.margin, y: startY, width: colWidth, font: font, lineHeight: lineHeight)
                drawColumn(right, atX: ReportPDF.margin + colWidth + gap, y: startY, width: colWidth, font: font, lineHeight: lineHeight)
                page.y = startY + blockHeight
                index = rightStart + rightCount
                if index < lines.count {
                    page.beginContinuation()
                }
            }
            page.space(4)
        }
    }

    private static func drawColumn(_ lines: [String], atX x: CGFloat, y: CGFloat, width: CGFloat, font: UIFont, lineHeight: CGFloat) {
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: ink]
        for (offset, line) in lines.enumerated() {
            let rect = CGRect(x: x, y: y + CGFloat(offset) * lineHeight, width: width, height: lineHeight)
            (line as NSString).draw(with: rect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        }
    }

    private static func drawFooter(_ report: TrainingReport, on page: inout Page) {
        let language = report.appLanguage
        let qrSide: CGFloat = 192
        let height = estimatedFooterHeight(report, qrSide: qrSide)
        // Prefer keeping meta + disclaimer with the topics. Never leave them alone on a blank page
        // when the previous page still has room after a modest compact — but if we truly need a
        // new page, open it with a continuation header so page 2 is intentional.
        if page.y + height > page.bottom {
            page.beginContinuation()
        }
        page.rule(color: rule, width: 0.5)
        page.space(6)

        let shortVerifyURL = ReportVerify.publicURL(reportId: report.reportId)
        let qrURL = ReportVerify.isPublicRegistryLive
            ? ReportVerify.signedPublicURL(for: report)
            : shortVerifyURL
        let qrImage = ReportQR.image(url: qrURL, side: qrSide)
        let metaWidth = qrImage == nil ? page.contentWidth : page.contentWidth - qrSide - 10
        let metaTop = page.y

        let versionLabel = Copy.s(language, pl: "wersja treści", en: "content version")
        let issuedLabel = Copy.s(language, pl: "wydano", en: "issued")
        let hashLabel = Copy.s(language, pl: "pakiet lekcji w zakresie", en: "lessons in scope")
        let verifyLabel = Copy.s(language, pl: "weryfikacja", en: "verify")
        let issued = ReportDates.iso8601(report.issuedAt)
        let meta = [
            "reportId: \(report.reportId.uuidString)",
            "\(versionLabel): \(report.contentVersion) · build: \(report.buildFlavor) · \(issuedLabel): \(issued)",
            "SHA-256 (\(hashLabel)): \(report.lessonsPackHash)",
            "\(verifyLabel): \(shortVerifyURL.absoluteString)",
        ]
        var metaY = metaTop
        for line in meta {
            let font = monoFont(6.5)
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = 0.4
            paragraph.lineBreakMode = .byCharWrapping
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font, .foregroundColor: mist, .paragraphStyle: paragraph,
            ]
            let attributed = NSAttributedString(string: line, attributes: attributes)
            let bounds = attributed.boundingRect(
                with: CGSize(width: metaWidth, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )
            attributed.draw(
                with: CGRect(x: ReportPDF.margin, y: metaY, width: metaWidth, height: ceil(bounds.height)),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )
            metaY += ceil(bounds.height) + 1
        }

        if let qrImage {
            let qrRect = CGRect(
                x: ReportPDF.pageSize.width - ReportPDF.margin - qrSide,
                y: metaTop,
                width: qrSide,
                height: qrSide
            )
            qrImage.draw(in: qrRect)
            page.y = max(metaY, metaTop + qrSide) + 4
        } else {
            page.y = metaY + 4
        }

        page.space(2)
        page.text(report.disclaimer, font: .italicSystemFont(ofSize: 8), color: mist, lineSpacing: 0.5)
        page.space(2)
        page.text(Canon.fiction(language), font: .italicSystemFont(ofSize: 8), color: mist, lineSpacing: 0.5)
    }

    private static func estimatedFooterHeight(_ report: TrainingReport, qrSide: CGFloat = 72) -> CGFloat {
        // Rule + meta/QR row + disclaimer + fiction. Conservative for ensure().
        let width = pageSize.width - margin * 2 - qrSide - 10
        let disclaimer = (report.disclaimer as NSString).boundingRect(
            with: CGSize(width: pageSize.width - margin * 2, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: UIFont.italicSystemFont(ofSize: 8)],
            context: nil
        ).height
        let fiction = (Canon.fiction(report.appLanguage) as NSString).boundingRect(
            with: CGSize(width: pageSize.width - margin * 2, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: UIFont.italicSystemFont(ofSize: 8)],
            context: nil
        ).height
        // Meta lines can wrap (especially the verify URL); reserve room for QR beside them.
        let metaBlock = max(qrSide, 4 * 11)
        _ = width
        return 0.5 + 6 + CGFloat(metaBlock) + 6 + ceil(disclaimer) + 2 + ceil(fiction) + 4
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
        let language: AppLanguage
        let trainingName: String
        var y: CGFloat = ReportPDF.margin
        var number = 0

        var contentWidth: CGFloat { ReportPDF.pageSize.width - ReportPDF.margin * 2 }
        var bottom: CGFloat { ReportPDF.pageSize.height - ReportPDF.margin }

        init(context: UIGraphicsPDFRendererContext, language: AppLanguage, trainingName: String) {
            self.context = context
            self.language = language
            self.trainingName = trainingName
        }

        mutating func begin() {
            context.beginPage()
            number += 1
            y = ReportPDF.margin
            drawPageNumber()
        }

        mutating func beginContinuation() {
            begin()
            let kicker = Copy.s(language, pl: "CZERWONA TECZKA · CIĄG DALSZY", en: "CZERWONA TECZKA · CONTINUED")
            text(kicker, font: .systemFont(ofSize: 9, weight: .semibold), color: ReportPDF.blood, tracking: 1.2)
            space(2)
            text(trainingName, font: .systemFont(ofSize: 11, weight: .medium), color: ReportPDF.mist)
            space(6)
            rule(color: ReportPDF.rule, width: 0.5)
            space(8)
        }

        private func drawPageNumber() {
            let footer = String(number)
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 8), .foregroundColor: ReportPDF.mist]
            let size = (footer as NSString).size(withAttributes: attributes)
            (footer as NSString).draw(
                at: CGPoint(x: ReportPDF.pageSize.width - ReportPDF.margin - size.width, y: ReportPDF.pageSize.height - ReportPDF.margin / 2),
                withAttributes: attributes
            )
        }

        /// Ensures `height` fits; when `reserving` is set, also leave room for the footer on this page.
        mutating func ensure(_ height: CGFloat, reserving footerReserve: CGFloat = 0) {
            if y + height + footerReserve > bottom {
                beginContinuation()
            }
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

        mutating func text(_ string: String, font: UIFont, color: UIColor, tracking: CGFloat = 0, lineSpacing: CGFloat = 1.5) {
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

        mutating func labelValue(
            _ label: String, _ value: String,
            labelFont: UIFont, valueFont: UIFont,
            labelColor: UIColor, valueColor: UIColor,
            rowPad: CGFloat = 6
        ) {
            let labelWidth: CGFloat = 160
            let valueAttributes: [NSAttributedString.Key: Any] = [.font: valueFont, .foregroundColor: valueColor]
            let valueBounds = (value as NSString).boundingRect(
                with: CGSize(width: contentWidth - labelWidth, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: valueAttributes,
                context: nil
            )
            let height = max(ceil(valueBounds.height), 12) + rowPad
            ensure(height)
            (label.uppercased() as NSString).draw(
                in: CGRect(x: ReportPDF.margin, y: y + 1, width: labelWidth - 8, height: height),
                withAttributes: [.font: labelFont, .foregroundColor: labelColor, .kern: 0.6]
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
            let font = UIFont.systemFont(ofSize: 13, weight: .heavy)
            let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.white, .kern: 2.5]
            let size = (string as NSString).size(withAttributes: attributes)
            let rect = CGRect(x: ReportPDF.margin, y: y, width: size.width + 24, height: size.height + 10)
            ensure(rect.height)
            color.setFill()
            UIBezierPath(rect: rect).fill()
            (string as NSString).draw(at: CGPoint(x: rect.minX + 12, y: rect.minY + 5), withAttributes: attributes)
            y += rect.height
        }
    }
}
