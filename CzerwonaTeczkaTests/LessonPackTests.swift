import XCTest
@testable import CzerwonaTeczka

final class LessonPackTests: XCTestCase {
    func testEightLessonsThreeDemo() throws {
        let lessons = try loadPack()
        XCTAssertEqual(lessons.count, 8)
        XCTAssertEqual(lessons.filter(\.demo).count, 3)
        XCTAssertEqual(lessons.filter(\.demo).map(\.id), ["01-sygnatura", "03-glos", "04-prostokaty"])
    }

    func testSecrecyIsArticleSixNotSeventeen() throws {
        let blob = try loadBlob()
        XCTAssertTrue(blob.contains("Art. 6") || blob.contains("art. 6"))
        XCTAssertTrue(blob.contains("Dz.U. 2024 poz. 1564"))
        if blob.contains("art. 17") || blob.contains("Art. 17") {
            XCTAssertTrue(
                blob.contains("izby") || blob.contains("izba") || blob.contains("chamber"),
                "art. 17 may appear only as a warning that it is the chamber, not secrecy"
            )
        }
        let whisper = try loadPack().first { $0.id == "02-szept" }
        let stamp = try XCTUnwrap(whisper?.choices.first { $0.kind == .stamp })
        XCTAssertTrue(stamp.ratio.statute.pl.contains("Art. 6"))
        XCTAssertFalse(stamp.ratio.statute.pl.contains("Art. 17"))
    }

    func testGhostCiteStampHitsCourt() throws {
        let lesson = try XCTUnwrap(try loadPack().first { $0.id == "01-sygnatura" })
        let stamp = try XCTUnwrap(lesson.choices.first { $0.kind == .stamp })
        XCTAssertFalse(stamp.pass)
        XCTAssertEqual(stamp.delta.sad, -45)
        XCTAssertTrue(lesson.choices.contains { $0.kind == .verify && $0.pass })
    }

    func testUSBDecisionAndEmotionBan() throws {
        let blob = try loadBlob()
        XCTAssertTrue(blob.contains("DKN.5131.31.2022"))
        XCTAssertTrue(blob.contains("23 580") || blob.contains("23580"))
        XCTAssertTrue(blob.contains("II SA/Wa 1342/23"))
        XCTAssertTrue(blob.contains("ust. 1 lit. f") || blob.contains("5(1)(f)"))
        let emotion = try XCTUnwrap(try loadPack().first { $0.id == "08-emocje" })
        let stamp = try XCTUnwrap(emotion.choices.first { $0.kind == .stamp })
        XCTAssertFalse(stamp.pass)
        XCTAssertTrue(stamp.ratio.statute.pl.contains("art. 99") || stamp.ratio.statute.pl.contains("Art. 99"))
    }

    func testEachLessonHasThreeActionsAndAPass() throws {
        for lesson in try loadPack() {
            XCTAssertEqual(lesson.choices.count, 3)
            XCTAssertTrue(lesson.choices.contains { $0.kind == .stamp })
            XCTAssertTrue(lesson.choices.contains { $0.kind == .reject })
            XCTAssertTrue(lesson.choices.contains { $0.kind == .verify })
            XCTAssertTrue(lesson.choices.contains(\.pass), lesson.id)
        }
    }

    func testWarsawCanonInOpeningFiles() throws {
        let pack = try loadPack()
        let opening = pack.filter { ["01-sygnatura", "03-glos", "04-prostokaty"].contains($0.id) }
        for lesson in opening {
            XCTAssertTrue(lesson.context.pl.contains("Królewsk") || lesson.context.pl.contains("piętr"))
        }
    }

    private func loadPack() throws -> [Lesson] {
        let url = try XCTUnwrap(
            Bundle(for: LessonPackTests.self).url(forResource: "Lessons", withExtension: "json")
        )
        return try JSONDecoder().decode([Lesson].self, from: Data(contentsOf: url)).sorted { $0.order < $1.order }
    }

    private func loadBlob() throws -> String {
        let url = try XCTUnwrap(
            Bundle(for: LessonPackTests.self).url(forResource: "Lessons", withExtension: "json")
        )
        return try String(contentsOf: url, encoding: .utf8)
    }
}
