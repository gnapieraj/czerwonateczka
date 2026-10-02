import UIKit

/// Offline completion badge PNG — folder-led diploma card (no traffic-sign seal).
enum ReportBadge {
    static let size = CGSize(width: 1080, height: 1080)

    /// Production default is `.folder`. Other styles exist for side-by-side previews.
    enum Style: String, CaseIterable {
        case credential // thin red rules + outline seal + typography
        case folder     // folder motif lead, diploma card
        case ribbon     // ribbon banner status, no disc
    }

    static let productionStyle: Style = .folder

    static func render(_ report: TrainingReport, style: Style = productionStyle) -> Data {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = true
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        let image = renderer.image { ctx in
            let cg = ctx.cgContext
            let bounds = CGRect(origin: .zero, size: size)
            let language = report.appLanguage
            let blood = UIColor(red: 0.72, green: 0.08, blue: 0.10, alpha: 1)
            let mist = UIColor(white: 0.62, alpha: 1)
            let paper = UIColor(red: 0.91, green: 0.88, blue: 0.80, alpha: 1)
            let ink = UIColor(red: 0.07, green: 0.07, blue: 0.08, alpha: 1)
            let dim = UIColor(white: 0.38, alpha: 1)

            ink.setFill()
            cg.fill(bounds)

            // Outer soft frame + inner blood rule (credential card, not a stamp disc)
            let outer = bounds.insetBy(dx: 36, dy: 36)
            UIColor(white: 0.22, alpha: 1).setStroke()
            cg.setLineWidth(2)
            cg.stroke(outer)
            let frame = bounds.insetBy(dx: 52, dy: 52)
            blood.setStroke()
            cg.setLineWidth(3)
            cg.stroke(frame)

            // Corner ticks — subtle diploma cue
            drawCornerTicks(in: frame, color: blood, length: 28, cg: cg)

            var y: CGFloat = 88

            switch style {
            case .credential:
                drawOutlineSeal(at: CGPoint(x: size.width / 2, y: y + 70), blood: blood, paper: paper, cg: cg)
                y += 160
            case .folder:
                drawFolderMotif(at: CGPoint(x: size.width / 2, y: y + 56), blood: blood, cg: cg)
                y += 130
            case .ribbon:
                drawRibbonBanner(
                    at: CGPoint(x: size.width / 2, y: y + 56),
                    text: report.passed
                        ? Copy.s(language, pl: "UKOŃCZONO", en: "COMPLETED")
                        : Copy.s(language, pl: "W TOKU", en: "IN PROGRESS"),
                    blood: blood,
                    paper: paper,
                    cg: cg
                )
                y += 130
            }

            drawCentered(
                Copy.s(language, pl: "CZERWONA TECZKA", en: "CZERWONA TECZKA"),
                font: titleFont(26), color: blood, y: &y, tracking: 5
            )
            y += 18
            drawHairline(y: y, color: blood, width: 220)
            y += 28

            drawCentered(
                Copy.s(language, pl: "CERTYFIKAT UKOŃCZENIA", en: "CERTIFICATE OF COMPLETION"),
                font: .systemFont(ofSize: 22, weight: .semibold), color: paper,
                y: &y, tracking: 1.5
            )
            y += 10
            drawCentered(
                Copy.s(language, pl: "Szkolenie edukacyjne · Colgante", en: "Educational training · Colgante"),
                font: .systemFont(ofSize: 15, weight: .medium), color: mist,
                y: &y
            )
            y += 36

            // Status is conveyed by title / ribbon — avoid a red "UKOŃCZONO" chip (reads like zakaz).
            if !report.passed {
                drawCentered(
                    Copy.s(language, pl: "W toku — próg jeszcze nieosiągnięty", en: "In progress — threshold not yet met"),
                    font: .systemFont(ofSize: 14, weight: .medium), color: mist,
                    y: &y
                )
                y += 20
            }

            let name = report.employeeName.isEmpty ? "—" : report.employeeName
            drawCentered(name, font: titleFont(40), color: paper, y: &y)
            y += 12
            if !report.organization.isEmpty {
                drawCentered(report.organization, font: .systemFont(ofSize: 20, weight: .medium), color: mist, y: &y)
                y += 10
            }

            drawHairline(y: y + 4, color: dim, width: 320)
            y += 28

            drawCentered(
                Copy.s(language, pl: "ZAKRES", en: "SCOPE"),
                font: .systemFont(ofSize: 13, weight: .semibold), color: blood,
                y: &y, tracking: 3
            )
            y += 8
            drawCentered(report.trainingName, font: .systemFont(ofSize: 20, weight: .regular), color: paper, y: &y, maxWidth: size.width - 180)
            y += 22

            drawMetaRow(
                left: Copy.s(language, pl: "DATA", en: "DATE"),
                leftValue: report.completionDate,
                right: Copy.s(language, pl: "WAŻNE DO", en: "VALID UNTIL"),
                rightValue: report.validUntil,
                y: &y,
                mist: mist,
                paper: paper,
                blood: blood
            )
            y += 18
            drawCentered(
                Copy.s(language, pl: "Wystawca: \(report.provider)", en: "Issuer: \(report.provider)"),
                font: .systemFont(ofSize: 16, weight: .medium), color: mist,
                y: &y
            )

            // Footer — short id, trustworthy credential cue
            let shortId = String(report.reportId.uuidString.prefix(8)).uppercased()
            let footerTop = size.height - 130
            drawHairline(y: footerTop, color: blood, width: 280)
            var footerY = footerTop + 22
            drawCentered(
                Copy.s(language, pl: "Identyfikator odznaki  ·  \(shortId)", en: "Badge ID  ·  \(shortId)"),
                font: .monospacedSystemFont(ofSize: 15, weight: .medium), color: paper,
                y: &footerY
            )
            footerY += 8
            let verifyNote = ReportVerify.isPublicRegistryLive
                ? ReportVerify.publicURL(reportId: report.reportId).absoluteString
                : Copy.s(
                    language,
                    pl: "Weryfikacja publiczna (v2) — w przygotowaniu",
                    en: "Public verify (v2) — coming soon"
                )
            drawCentered(verifyNote, font: .systemFont(ofSize: 13, weight: .regular), color: mist, y: &footerY, maxWidth: size.width - 140)
        }
        return image.pngData() ?? Data()
    }

    // MARK: - Motifs (outline / ribbon — never a filled red disc)

    private static func drawOutlineSeal(at center: CGPoint, blood: UIColor, paper: UIColor, cg: CGContext) {
        let r: CGFloat = 62
        blood.setStroke()
        cg.setLineWidth(3)
        cg.strokeEllipse(in: CGRect(x: center.x - r, y: center.y - r, width: r * 2, height: r * 2))
        cg.setLineWidth(1.5)
        cg.strokeEllipse(in: CGRect(x: center.x - r + 10, y: center.y - r + 10, width: (r - 10) * 2, height: (r - 10) * 2))

        // Small filled center disc is OK at ~18pt — reads as a wax-seal nub, not a road sign
        blood.setFill()
        let nub: CGFloat = 10
        cg.fillEllipse(in: CGRect(x: center.x - nub, y: center.y - nub, width: nub * 2, height: nub * 2))

        // Simple laurel arcs (left / right)
        drawLaurel(side: -1, center: center, radius: r + 18, color: blood, cg: cg)
        drawLaurel(side: 1, center: center, radius: r + 18, color: blood, cg: cg)

        let mono = "CT"
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: paper,
            .kern: 2,
        ]
        let sz = (mono as NSString).size(withAttributes: attrs)
        (mono as NSString).draw(
            at: CGPoint(x: center.x - sz.width / 2, y: center.y - r + 22),
            withAttributes: attrs
        )
    }

    private static func drawLaurel(side: CGFloat, center: CGPoint, radius: CGFloat, color: UIColor, cg: CGContext) {
        color.setStroke()
        cg.setLineWidth(2)
        cg.setLineCap(.round)
        let path = CGMutablePath()
        let baseX = center.x + side * (radius - 8)
        path.move(to: CGPoint(x: baseX, y: center.y + 48))
        path.addQuadCurve(
            to: CGPoint(x: baseX + side * 8, y: center.y - 48),
            control: CGPoint(x: baseX + side * 36, y: center.y)
        )
        cg.addPath(path)
        cg.strokePath()
        for i in 0..<5 {
            let t = CGFloat(i) / 4.0
            let y = center.y + 48 - t * 96
            let flare = 10 + (0.5 - abs(t - 0.5)) * 16
            let leaf = CGMutablePath()
            leaf.move(to: CGPoint(x: baseX + side * (4 + t * 6), y: y))
            leaf.addLine(to: CGPoint(x: baseX + side * (4 + t * 6 + flare), y: y - 6))
            cg.addPath(leaf)
            cg.strokePath()
        }
    }

    private static func drawFolderMotif(at center: CGPoint, blood: UIColor, cg: CGContext) {
        blood.setStroke()
        cg.setLineWidth(3)
        cg.setLineJoin(.round)
        let w: CGFloat = 110
        let h: CGFloat = 78
        let x = center.x - w / 2
        let y = center.y - h / 2 + 6
        let tab: CGFloat = 36
        let path = CGMutablePath()
        path.move(to: CGPoint(x: x, y: y + 14))
        path.addLine(to: CGPoint(x: x, y: y + h))
        path.addLine(to: CGPoint(x: x + w, y: y + h))
        path.addLine(to: CGPoint(x: x + w, y: y + 14))
        path.addLine(to: CGPoint(x: x + tab + 12, y: y + 14))
        path.addLine(to: CGPoint(x: x + tab, y: y))
        path.addLine(to: CGPoint(x: x, y: y))
        path.closeSubpath()
        cg.addPath(path)
        cg.strokePath()
        blood.setFill()
        let tabFill = CGMutablePath()
        tabFill.move(to: CGPoint(x: x + 2, y: y + 2))
        tabFill.addLine(to: CGPoint(x: x + tab - 1, y: y + 2))
        tabFill.addLine(to: CGPoint(x: x + tab + 10, y: y + 14))
        tabFill.addLine(to: CGPoint(x: x + 2, y: y + 14))
        tabFill.closeSubpath()
        cg.addPath(tabFill)
        cg.fillPath()
    }

    private static func drawRibbonBanner(
        at center: CGPoint,
        text: String,
        blood: UIColor,
        paper: UIColor,
        cg: CGContext
    ) {
        let bannerW: CGFloat = 340
        let bannerH: CGFloat = 52
        let notch: CGFloat = 22
        let x = center.x - bannerW / 2
        let y = center.y - bannerH / 2
        let path = CGMutablePath()
        path.move(to: CGPoint(x: x + notch, y: y))
        path.addLine(to: CGPoint(x: x + bannerW - notch, y: y))
        path.addLine(to: CGPoint(x: x + bannerW, y: y + bannerH / 2))
        path.addLine(to: CGPoint(x: x + bannerW - notch, y: y + bannerH))
        path.addLine(to: CGPoint(x: x + notch, y: y + bannerH))
        path.addLine(to: CGPoint(x: x, y: y + bannerH / 2))
        path.closeSubpath()
        blood.setFill()
        cg.addPath(path)
        cg.fillPath()
        paper.setStroke()
        cg.setLineWidth(1.5)
        cg.addPath(path)
        cg.strokePath()

        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: paper,
            .kern: 3,
        ]
        let sz = (text as NSString).size(withAttributes: attrs)
        (text as NSString).draw(
            at: CGPoint(x: center.x - sz.width / 2, y: center.y - sz.height / 2),
            withAttributes: attrs
        )
    }

    private static func drawCornerTicks(in frame: CGRect, color: UIColor, length: CGFloat, cg: CGContext) {
        color.setStroke()
        cg.setLineWidth(2)
        cg.setLineCap(.square)
        let points: [(CGPoint, CGPoint, CGPoint)] = [
            (CGPoint(x: frame.minX, y: frame.minY + length), CGPoint(x: frame.minX, y: frame.minY), CGPoint(x: frame.minX + length, y: frame.minY)),
            (CGPoint(x: frame.maxX - length, y: frame.minY), CGPoint(x: frame.maxX, y: frame.minY), CGPoint(x: frame.maxX, y: frame.minY + length)),
            (CGPoint(x: frame.minX, y: frame.maxY - length), CGPoint(x: frame.minX, y: frame.maxY), CGPoint(x: frame.minX + length, y: frame.maxY)),
            (CGPoint(x: frame.maxX - length, y: frame.maxY), CGPoint(x: frame.maxX, y: frame.maxY), CGPoint(x: frame.maxX, y: frame.maxY - length)),
        ]
        for (a, b, c) in points {
            let p = CGMutablePath()
            p.move(to: a)
            p.addLine(to: b)
            p.addLine(to: c)
            cg.addPath(p)
            cg.strokePath()
        }
    }

    private static func drawHairline(y: CGFloat, color: UIColor, width: CGFloat) {
        let x = (size.width - width) / 2
        color.setStroke()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x, y: y))
        path.addLine(to: CGPoint(x: x + width, y: y))
        path.lineWidth = 1.5
        path.stroke()
    }

    private static func drawMetaRow(
        left: String,
        leftValue: String,
        right: String,
        rightValue: String,
        y: inout CGFloat,
        mist: UIColor,
        paper: UIColor,
        blood: UIColor
    ) {
        let colW = (size.width - 200) / 2
        let leftOrigin = 100 as CGFloat
        let rightOrigin = size.width / 2 + 20
        let labelFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        let valueFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        let para = NSMutableParagraphStyle()
        para.alignment = .center
        let labelAttrs: [NSAttributedString.Key: Any] = [
            .font: labelFont, .foregroundColor: blood, .kern: 2, .paragraphStyle: para,
        ]
        let valueAttrs: [NSAttributedString.Key: Any] = [
            .font: valueFont, .foregroundColor: paper, .paragraphStyle: para,
        ]
        (left as NSString).draw(in: CGRect(x: leftOrigin, y: y, width: colW, height: 18), withAttributes: labelAttrs)
        (right as NSString).draw(in: CGRect(x: rightOrigin, y: y, width: colW, height: 18), withAttributes: labelAttrs)
        y += 20
        (leftValue as NSString).draw(in: CGRect(x: leftOrigin, y: y, width: colW, height: 24), withAttributes: valueAttrs)
        (rightValue as NSString).draw(in: CGRect(x: rightOrigin, y: y, width: colW, height: 24), withAttributes: valueAttrs)
        y += 28
        _ = mist
    }

    // MARK: - Typography helpers

    private static func titleFont(_ size: CGFloat) -> UIFont {
        UIFont(name: Typeface.comic, size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }

    private static func drawCentered(
        _ string: String,
        font: UIFont,
        color: UIColor,
        y: inout CGFloat,
        tracking: CGFloat = 0,
        maxWidth: CGFloat = size.width - 140
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
        attributed.draw(
            with: CGRect(x: x, y: y, width: maxWidth, height: ceil(bounds.height)),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        y += ceil(bounds.height)
    }
}
