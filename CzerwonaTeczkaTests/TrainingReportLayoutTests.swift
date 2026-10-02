import PDFKit
import XCTest
@testable import CzerwonaTeczka

/// PDF layout + LinkedIn badge / verify helpers (offline-first).
final class TrainingReportLayoutTests: XCTestCase {
    private let fixedDate = Date(timeIntervalSince1970: 1_790_000_000) // 2026-09-21 Europe/Warsaw

    func testSeasonZeroPDFFitsOnOnePage() throws {
        let pack = try loadPack()
        let report = makeSeason0(pack: pack)
        let data = ReportPDF.render(report)
        XCTAssertEqual(ReportPDF.pageCount(of: data), 1, "Sezon 0 (12) must not orphan the disclaimer on page 2")
        XCTAssertGreaterThan(data.count, 2_000)
    }

    func testShortMultiSeasonPacksFitOnOnePage() throws {
        let pack = try loadPack()
        for nights in [3, 4] {
            let report = makeShortPack(pack: pack, nightsPerSeason: nights)
            let data = ReportPDF.render(report)
            XCTAssertEqual(ReportPDF.pageCount(of: data), 1, "2×\(nights) nights should stay on one A4 page")
        }
    }

    func testFullPackPDFPageCountIsReasonable() throws {
        let pack = try loadPack()
        let report = makeFullPack(pack: pack)
        let data = ReportPDF.render(report)
        XCTAssertLessThanOrEqual(ReportPDF.pageCount(of: data), 2)
        XCTAssertGreaterThan(data.count, 3_000)
    }

    func testLinkedInAddURLContainsOrgDatesAndCertUrl() throws {
        let pack = try loadPack()
        let report = makeSeason0(pack: pack)
        let url = try XCTUnwrap(LinkedInCertification.addToProfileURL(for: report))
        let text = url.absoluteString
        XCTAssertTrue(text.contains("linkedin.com/profile/add"))
        XCTAssertTrue(text.contains("CERTIFICATION_NAME"))
        XCTAssertTrue(text.contains("Colgante"))
        XCTAssertTrue(text.contains("issueYear=2026"))
        XCTAssertTrue(text.contains("certUrl="))
        XCTAssertTrue(text.contains("colgante.pl/verify/"))
        XCTAssertTrue(ReportVerify.isPublicRegistryLive, "v2 flips the flag only while signed verify works")
        let fields = ReportVerify.publicFields(from: report)
        XCTAssertEqual(fields["reportId"], report.reportId.uuidString.lowercased())
        XCTAssertEqual(fields["validUntil"], report.validUntil)
        XCTAssertFalse(fields.values.contains(report.employeeName), "wariant A: no employee name on public payload")
        XCTAssertNil(fields["organization"], "org is omitted unless publishOrganization is on")

        let token = ReportVerify.signedToken(for: report)
        let verified = try XCTUnwrap(ReportVerify.verify(token: token))
        XCTAssertEqual(verified.id, report.reportId.uuidString.lowercased())
        XCTAssertEqual(verified.vu, report.validUntil)
        XCTAssertEqual(verified.cd, report.completionDate)
        XCTAssertNil(verified.org)
        XCTAssertTrue(ReportVerify.signedPublicURL(for: report).absoluteString.contains("p="))
        XCTAssertNotNil(ReportQR.image(for: report, side: 96))
    }

    func testEnglishDiplomaFlagAndPublishedOrgOnVerifyPayload() throws {
        let pack = try loadPack()
        var form = ReportForm(employeeName: "Anna Nowak", organization: "Kancelaria Testowa")
        form.diplomaEnglish = true
        form.publishOrganizationOnVerify = true
        var config = ReportConfig.free
        config.contentVersion = "9.9+7"
        let stamps = soundStamps(for: pack, seasonId: "0")
        let evaluation = PassPolicy.evaluate(scope: .season("0"), lessons: pack, stamps: stamps)
        let report = ReportBuilder.make(
            evaluation: evaluation,
            allLessons: pack,
            form: form,
            config: config,
            now: fixedDate
        )
        XCTAssertEqual(report.language, "en")
        XCTAssertTrue(report.publishOrganization)
        XCTAssertEqual(report.validUntil, "2027-09-21")
        let payload = ReportVerify.publicPayload(from: report)
        XCTAssertEqual(payload.org, "Kancelaria Testowa")
        XCTAssertTrue(report.trainingName.contains("Season") || report.trainingName.contains("Czerwona Teczka"))
        let pdf = ReportPDF.render(report)
        XCTAssertEqual(ReportPDF.pageCount(of: pdf), 1)
    }

    func testBadgePNGIsNonEmpty() throws {
        let pack = try loadPack()
        let report = makeSeason0(pack: pack)
        let png = ReportBadge.render(report)
        XCTAssertEqual(ReportBadge.productionStyle.rawValue, ReportBadge.Style.folder.rawValue)
        XCTAssertEqual(png, ReportBadge.render(report, style: .folder), "default production badge style must be folder")
        XCTAssertGreaterThan(png.count, 5_000)
        XCTAssertTrue(png.starts(with: Data([0x89, 0x50, 0x4E, 0x47])))
    }

    func testWriteReportFixturesIfRequested() throws {
        let fixtures = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .appendingPathComponent("Fixtures/Reports", isDirectory: true)
        let force = ProcessInfo.processInfo.environment["WRITE_REPORT_FIXTURES"] == "1"
        let marker = fixtures.appendingPathComponent("sezon0-12.pdf")
        if !force && FileManager.default.fileExists(atPath: marker.path) {
            throw XCTSkip("fixtures present; set WRITE_REPORT_FIXTURES=1 to regenerate")
        }
        let pack = try loadPack()
        try FileManager.default.createDirectory(at: fixtures, withIntermediateDirectories: true)

        func write(_ name: String, _ report: TrainingReport) throws {
            try ReportPDF.render(report).write(to: fixtures.appendingPathComponent(name), options: .atomic)
            let badgeName = name.replacingOccurrences(of: ".pdf", with: "-badge.png")
            try ReportBadge.render(report, style: ReportBadge.productionStyle).write(to: fixtures.appendingPathComponent(badgeName), options: .atomic)
        }

        try write("sezon0-12.pdf", makeSeason0(pack: pack, name: "Grzegorz Napieraj", org: "It Security"))
        try write("short-2x3.pdf", makeShortPack(pack: pack, nightsPerSeason: 3))
        try write("short-2x4.pdf", makeShortPack(pack: pack, nightsPerSeason: 4))
        try write("pack-24.pdf", makeFullPack(pack: pack))
        XCTAssertTrue(FileManager.default.fileExists(atPath: fixtures.appendingPathComponent("sezon0-12.pdf").path))
    }


    /// Writes 3 badge style previews (credential / folder / ribbon) when WRITE_BADGE_PREVIEWS=1.
    func testWriteBadgeStylePreviewsIfRequested() throws {
        guard ProcessInfo.processInfo.environment["WRITE_BADGE_PREVIEWS"] == "1" else {
            throw XCTSkip("set WRITE_BADGE_PREVIEWS=1 to regenerate style previews")
        }
        let pack = try loadPack()
        let report = makeFullPack(pack: pack)
        // Absolute host Desktop - Simulator NSHomeDirectory is the sandbox.
        let desktop = URL(fileURLWithPath: "/Users/AI/Desktop/CzerwonaTeczka-badge-previews", isDirectory: true)
        let world = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("World/report-fixtures/badge-previews", isDirectory: true)
        for dir in [desktop, world] {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        for style in ReportBadge.Style.allCases {
            let data = ReportBadge.render(report, style: style)
            XCTAssertGreaterThan(data.count, 5_000)
            let name = "badge-\(style.rawValue)-pack24.png"
            for dir in [desktop, world] {
                try data.write(to: dir.appendingPathComponent(name), options: .atomic)
            }
        }
        let worldRoot = world.deletingLastPathComponent()
        try ReportBadge.render(report, style: ReportBadge.productionStyle).write(
            to: worldRoot.appendingPathComponent("pack-24-badge.png"),
            options: .atomic
        )
        try ReportBadge.render(makeSeason0(pack: pack, name: "Grzegorz Napieraj", org: "It Security"), style: ReportBadge.productionStyle).write(
            to: worldRoot.appendingPathComponent("sezon0-12-badge.png"),
            options: .atomic
        )
        try ReportBadge.render(makeShortPack(pack: pack, nightsPerSeason: 3), style: ReportBadge.productionStyle).write(
            to: worldRoot.appendingPathComponent("short-2x3-badge.png"),
            options: .atomic
        )
        try ReportBadge.render(makeShortPack(pack: pack, nightsPerSeason: 4), style: ReportBadge.productionStyle).write(
            to: worldRoot.appendingPathComponent("short-2x4-badge.png"),
            options: .atomic
        )
    }

    // MARK: Helpers

    private func makeSeason0(pack: [Lesson], name: String = "Anna Nowak", org: String = "Kancelaria Testowa") -> TrainingReport {
        var config = ReportConfig.free
        config.contentVersion = "9.9+7"
        let stamps = soundStamps(for: pack, seasonId: "0")
        let evaluation = PassPolicy.evaluate(scope: .season("0"), lessons: pack, stamps: stamps)
        return ReportBuilder.make(
            evaluation: evaluation,
            allLessons: pack,
            form: ReportForm(employeeName: name, organization: org),
            config: config,
            now: fixedDate
        )
    }

    private func makeFullPack(pack: [Lesson]) -> TrainingReport {
        var config = ReportConfig.free
        config.contentVersion = "9.9+7"
        let stamps = soundStamps(for: pack, seasonId: "0").merging(soundStamps(for: pack, seasonId: "1")) { a, _ in a }
        let evaluation = PassPolicy.evaluate(scope: .pack, lessons: pack, stamps: stamps)
        return ReportBuilder.make(
            evaluation: evaluation,
            allLessons: pack,
            form: ReportForm(employeeName: "Grzegorz Napieraj", organization: "It Security"),
            config: config,
            now: fixedDate
        )
    }

    private func makeShortPack(pack: [Lesson], nightsPerSeason: Int) -> TrainingReport {
        let season0 = pack.filter { $0.seasonId == "0" }.sorted { $0.order < $1.order }.prefix(nightsPerSeason)
        let season1 = pack.filter { $0.seasonId == "1" }.sorted { $0.order < $1.order }.prefix(nightsPerSeason)
        let subset = Array(season0 + season1)
        var stamps: [String: DocketStamp] = [:]
        for lesson in subset { stamps[lesson.id] = stamp(lesson.id, .sound) }
        let evaluation = PassPolicy.evaluate(scope: .pack, lessons: subset, stamps: stamps)
        var config = ReportConfig.free
        config.contentVersion = "9.9+7"
        return ReportBuilder.make(
            evaluation: evaluation,
            allLessons: subset,
            form: ReportForm(employeeName: "Grzegorz Napieraj", organization: "It Security"),
            config: config,
            now: fixedDate
        )
    }

    private func stamp(_ id: String, _ verdict: DecisionVerdict, briefed: Bool = true) -> DocketStamp {
        DocketStamp(lessonId: id, verdict: verdict, kind: .verify, stampedAt: fixedDate, briefed: briefed)
    }

    private func soundStamps(for pack: [Lesson], seasonId: String) -> [String: DocketStamp] {
        var stamps: [String: DocketStamp] = [:]
        for lesson in pack where lesson.seasonId == seasonId {
            stamps[lesson.id] = stamp(lesson.id, .sound)
        }
        return stamps
    }

    private func loadPack() throws -> [Lesson] {
        let url = Bundle(for: TrainingReportLayoutTests.self).url(forResource: "Lessons", withExtension: "json")
            ?? URL(fileURLWithPath: #filePath)
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .appendingPathComponent("Resources/Lessons.json")
        return try JSONDecoder().decode([Lesson].self, from: Data(contentsOf: url)).sorted { $0.order < $1.order }
    }
}
