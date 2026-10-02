import XCTest
@testable import CzerwonaTeczka

/// Employer report MVP (plan-raport-dyplom.md §5, §6). Pure engine — no UI, no network.
final class TrainingReportTests: XCTestCase {
    private let fixedDate = Date(timeIntervalSince1970: 1_790_000_000) // 2026-09-21 Europe/Warsaw

    // MARK: Pass policy

    func testRequiredSoundUsesIntegerCeiling() {
        XCTAssertEqual(PassPolicy.requiredSound(lessonCount: 12), 11)
        XCTAssertEqual(PassPolicy.requiredSound(lessonCount: 24), 22)
        XCTAssertEqual(PassPolicy.requiredSound(lessonCount: 10), 9)
        XCTAssertEqual(PassPolicy.requiredSound(lessonCount: 1), 1)
        XCTAssertEqual(PassPolicy.requiredSound(lessonCount: 0), 0)
        XCTAssertTrue(PassPolicy.meetsThreshold(sound: 11, of: 12))
        XCTAssertFalse(PassPolicy.meetsThreshold(sound: 10, of: 12))
        XCTAssertTrue(PassPolicy.meetsThreshold(sound: 22, of: 24))
        XCTAssertFalse(PassPolicy.meetsThreshold(sound: 21, of: 24))
        XCTAssertFalse(PassPolicy.meetsThreshold(sound: 0, of: 0))
    }

    func testSeasonPassesWithElevenSoundOutOfTwelve() throws {
        let pack = try loadPack()
        var stamps = soundStamps(for: pack, seasonId: "0")
        stamps["03-prompt"] = stamp("03-prompt", .unsound)
        let evaluation = PassPolicy.evaluate(scope: .season("0"), lessons: pack, stamps: stamps)
        XCTAssertEqual(evaluation.lessonCount, 12)
        XCTAssertEqual(evaluation.soundCount, 11)
        XCTAssertEqual(evaluation.unsoundCount, 1)
        XCTAssertEqual(evaluation.percentSound, 92)
        XCTAssertTrue(evaluation.passed)
        XCTAssertEqual(evaluation.belowThreshold.map(\.id), ["03-prompt"])
    }

    func testIncompleteCountsAsNotSound() throws {
        let pack = try loadPack()
        var stamps = soundStamps(for: pack, seasonId: "0")
        stamps["03-prompt"] = stamp("03-prompt", .incomplete)
        stamps["07-sms"] = stamp("07-sms", .incomplete)
        let evaluation = PassPolicy.evaluate(scope: .season("0"), lessons: pack, stamps: stamps)
        XCTAssertEqual(evaluation.soundCount, 10)
        XCTAssertEqual(evaluation.incompleteCount, 2)
        XCTAssertEqual(evaluation.missingSound, 1)
        XCTAssertFalse(evaluation.passed)
    }

    func testMissingStampOrUnreadBriefingBlocksPass() throws {
        let pack = try loadPack()
        var stamps = soundStamps(for: pack, seasonId: "0")
        stamps["12-okup"] = nil
        var evaluation = PassPolicy.evaluate(scope: .season("0"), lessons: pack, stamps: stamps)
        XCTAssertEqual(evaluation.unstamped.map(\.id), ["12-okup"])
        XCTAssertFalse(evaluation.passed)

        stamps["12-okup"] = stamp("12-okup", .sound, briefed: false)
        evaluation = PassPolicy.evaluate(scope: .season("0"), lessons: pack, stamps: stamps)
        XCTAssertTrue(evaluation.allStamped)
        XCTAssertEqual(evaluation.unbriefed.map(\.id), ["12-okup"])
        XCTAssertNil(evaluation.lessons.last?.countedVerdict, "verdict counts only after the briefing")
        XCTAssertFalse(evaluation.passed)
    }

    func testPackScopeNeedsTwentyTwoOfTwentyFour() throws {
        let pack = try loadPack()
        var stamps = soundStamps(for: pack, seasonId: "0").merging(soundStamps(for: pack, seasonId: "1")) { a, _ in a }
        stamps["05-arkusz"] = stamp("05-arkusz", .unsound)
        stamps["17-wydruk"] = stamp("17-wydruk", .incomplete)
        var evaluation = PassPolicy.evaluate(scope: .pack, lessons: pack, stamps: stamps)
        XCTAssertEqual(evaluation.lessonCount, 24)
        XCTAssertEqual(evaluation.requiredSound, 22)
        XCTAssertTrue(evaluation.passed)
        stamps["21-termin"] = stamp("21-termin", .unsound)
        evaluation = PassPolicy.evaluate(scope: .pack, lessons: pack, stamps: stamps)
        XCTAssertEqual(evaluation.soundCount, 21)
        XCTAssertFalse(evaluation.passed)
    }

    // MARK: Report payload

    func testPassedReportIsCompletedWithTwelveMonthValidity() throws {
        let pack = try loadPack()
        let report = makeReport(pack: pack, stamps: soundStamps(for: pack, seasonId: "0"))
        XCTAssertEqual(report.status, .completed)
        XCTAssertTrue(report.passed)
        XCTAssertEqual(report.employeeName, "Anna Nowak")
        XCTAssertEqual(report.organization, "Kancelaria Testowa")
        XCTAssertEqual(report.completionDate, "2026-09-21")
        XCTAssertEqual(report.validUntil, "2027-09-21")
        XCTAssertEqual(report.nextReminderAt, "2027-08-22")
        XCTAssertEqual(report.language, "pl")
        XCTAssertEqual(report.buildFlavor, "free")
        XCTAssertEqual(report.contentVersion, "9.9+7")
        XCTAssertEqual(report.seasons.count, 1)
        XCTAssertEqual(report.allLessons.count, 12)
        XCTAssertEqual(report.allLessons.first?.lessonId, "01-kod")
        XCTAssertEqual(report.allLessons.first?.lastVerdict, "TRAFNE")
        XCTAssertEqual(report.scope.kind, "season")
        XCTAssertEqual(report.scope.seasonIds, ["0"])
        XCTAssertTrue(report.trainingName.contains("Wstęp"))
        XCTAssertFalse(report.disclaimer.isEmpty)
    }

    func testFailedReportNeverSaysCompleted() throws {
        let pack = try loadPack()
        var stamps = soundStamps(for: pack, seasonId: "0")
        stamps["01-kod"] = stamp("01-kod", .unsound)
        stamps["02-list"] = stamp("02-list", .unsound)
        let report = makeReport(pack: pack, stamps: stamps)
        XCTAssertEqual(report.status, .notCompleted)
        XCTAssertFalse(report.passed)
        XCTAssertEqual(report.percentSound, 83)
        let csv = ReportCSV.register(report)
        XCTAssertTrue(csv.contains(",NIEUKONCZONO,"))
        XCTAssertFalse(csv.contains(",UKONCZONO,"))
        XCTAssertEqual(report.status.label(.polish), "NIEUKOŃCZONO")
    }

    // MARK: CSV

    func testRegisterCSVHeaderMatchesPlanTemplate() throws {
        let expected = "data_ukonczenia,imie_i_nazwisko,organizacja,nazwa_szkolenia,forma,dostawca,zakres_tematow,status,procent_trafne,liczba_lekcji,liczba_trafne,liczba_bledne,liczba_niepelne,wazne_do,nastepne_przypomnienie,jezyk_dyplomu,report_id,content_version,lessons_pack_hash,build_flavor"
        XCTAssertEqual(ReportCSV.registerColumns.joined(separator: ","), expected)
        XCTAssertEqual(ReportCSV.lessonColumns, ["report_id", "lesson_id", "tytul", "werdykt", "data_stempel"])

        let pack = try loadPack()
        let report = makeReport(pack: pack, stamps: soundStamps(for: pack, seasonId: "0"))
        let csv = ReportCSV.register(report)
        let lines = csv.dropFirst(ReportCSV.bom.count).split(separator: "\n", omittingEmptySubsequences: false)
        XCTAssertEqual(String(lines[0]), expected)
        XCTAssertEqual(lines.count, 3, "header, one row, trailing newline")
        XCTAssertTrue(lines[1].hasPrefix("2026-09-21,Anna Nowak,Kancelaria Testowa,"))
        XCTAssertTrue(lines[1].contains("01-kod Drugie zatwierdzenie | 02-list Doklejone pismo"))
        XCTAssertTrue(lines[1].contains(",UKONCZONO,100,12,12,0,0,2027-09-21,2027-08-22,pl,\(report.reportId.uuidString),9.9+7,\(report.lessonsPackHash),free"))

        let perNight = ReportCSV.lessons(report).dropFirst(ReportCSV.bom.count).split(separator: "\n")
        XCTAssertEqual(perNight.count, 13)
        XCTAssertEqual(String(perNight[1]), "\(report.reportId.uuidString),01-kod,Drugie zatwierdzenie,TRAFNE,2026-09-21")
    }

    func testCSVEscapesCommasQuotesAndNewlines() {
        XCTAssertEqual(ReportCSV.escape("plain"), "plain")
        XCTAssertEqual(ReportCSV.escape("Kowalski, Jan"), "\"Kowalski, Jan\"")
        XCTAssertEqual(ReportCSV.escape("say \"hi\""), "\"say \"\"hi\"\"\"")
        XCTAssertEqual(ReportCSV.escape("a\nb"), "\"a\nb\"")
    }

    // MARK: JSON

    func testJSONRoundTripKeepsNestedSeasonsAndLastVerdict() throws {
        let pack = try loadPack()
        var stamps = soundStamps(for: pack, seasonId: "0")
        stamps["04-haslo"] = stamp("04-haslo", .incomplete)
        let report = makeReport(pack: pack, stamps: stamps)
        let data = try ReportJSON.encode(report)
        let text = try XCTUnwrap(String(data: data, encoding: .utf8))
        XCTAssertTrue(text.contains("\"seasons\""))
        XCTAssertTrue(text.contains("\"lastVerdict\""))
        XCTAssertTrue(text.contains("\"NIEPELNE\""))
        XCTAssertTrue(text.contains("\"2027-08-22\""))
        XCTAssertFalse(text.contains("hrEmail"), "the HR hint is UI-only and never exported")
        let decoded = try ReportJSON.decode(data)
        XCTAssertEqual(decoded.reportId, report.reportId)
        XCTAssertEqual(decoded.seasons, report.seasons)
        XCTAssertEqual(decoded.status, report.status)
    }

    // MARK: Hash

    func testSha256KnownVector() {
        XCTAssertEqual(
            ReportHash.sha256Hex(Data("abc".utf8)),
            "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
        )
    }

    func testLessonsPackHashIsStableAndScoped() throws {
        let pack = try loadPack()
        let season0 = ReportScope.season("0").lessons(from: pack)
        let season1 = ReportScope.season("1").lessons(from: pack)
        XCTAssertEqual(ReportHash.lessonsPackHash(season0), ReportHash.lessonsPackHash(season0))
        XCTAssertEqual(ReportHash.lessonsPackHash(season0), ReportHash.lessonsPackHash(Array(season0.reversed())), "order-independent input")
        XCTAssertNotEqual(ReportHash.lessonsPackHash(season0), ReportHash.lessonsPackHash(season1))
        XCTAssertNotEqual(ReportHash.lessonsPackHash(season0), ReportHash.lessonsPackHash(pack))
        XCTAssertEqual(ReportHash.lessonsPackHash(season0).count, 64)

        var edited = season0
        edited[0].title = Loc(pl: "Inny tytuł", en: "Other title")
        XCTAssertNotEqual(ReportHash.lessonsPackHash(season0), ReportHash.lessonsPackHash(edited))
    }

    // MARK: Stamps

    func testLegacyStampsCountAsBriefedAndNewOnesKeepDates() throws {
        let legacy = Data(#"[{"lessonId":"01-kod","verdict":"sound","kind":"verify"}]"#.utf8)
        let decoded = try JSONDecoder().decode([DocketStamp].self, from: legacy)
        XCTAssertTrue(decoded[0].briefed)
        XCTAssertNil(decoded[0].stampedAt)

        let fresh = DocketStamp(lessonId: "02-list", verdict: .sound, kind: .reject, stampedAt: fixedDate, briefed: false)
        let data = try JSONEncoder().encode([fresh])
        let back = try JSONDecoder().decode([DocketStamp].self, from: data)
        XCTAssertEqual(back, [fresh])
        XCTAssertFalse(back[0].briefed)
    }

    func testReportFormIgnoresLegacyHREmailHint() throws {
        let legacy = Data(#"{"employeeName":"Anna Nowak","organization":"Kancelaria Testowa","hrEmailHint":"hr@firma.pl"}"#.utf8)
        let decoded = try JSONDecoder().decode(ReportForm.self, from: legacy)
        XCTAssertEqual(decoded, ReportForm(employeeName: "Anna Nowak", organization: "Kancelaria Testowa"))
    }

    // MARK: Helpers

    private func makeReport(pack: [Lesson], stamps: [String: DocketStamp]) -> TrainingReport {
        var config = ReportConfig.free
        config.contentVersion = "9.9+7"
        let evaluation = PassPolicy.evaluate(scope: .season("0"), lessons: pack, stamps: stamps)
        return ReportBuilder.make(
            evaluation: evaluation,
            allLessons: pack,
            form: ReportForm(employeeName: " Anna Nowak ", organization: "Kancelaria Testowa"),
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
        let url = Bundle(for: TrainingReportTests.self).url(forResource: "Lessons", withExtension: "json")
            ?? URL(fileURLWithPath: #filePath)
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .appendingPathComponent("Resources/Lessons.json")
        return try JSONDecoder().decode([Lesson].self, from: Data(contentsOf: url)).sorted { $0.order < $1.order }
    }
}
