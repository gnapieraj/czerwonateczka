import CoreText
import UIKit
import XCTest
@testable import CzerwonaTeczka

final class LessonPackTests: XCTestCase {
    func testComicFontLoadsPolishLetters() throws {
        let regular = UIFont(name: Typeface.comic, size: 22)
        let italic = UIFont(name: Typeface.comicItalic, size: 22)
        XCTAssertNotNil(regular, "Gobo Caps must be in UIAppFonts")
        XCTAssertNotNil(italic, "Gobo Caps Italic must be in UIAppFonts")
        let font = try XCTUnwrap(regular)
        for scalar in "ąćęłńóśźżĄĆĘŁŃÓŚŹŻ".unicodeScalars {
            var ch = UniChar(scalar.value)
            var glyph: CGGlyph = 0
            let ok = CTFontGetGlyphsForCharacters(font, &ch, &glyph, 1)
            XCTAssertTrue(ok && glyph != 0, "missing glyph for \(scalar)")
        }
    }

    func testOriginalPianoBedIsInRepo() {
        let url = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Resources/Audio/NightDocket.m4a")
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path), url.path)
        XCTAssertNotNil(Bundle(for: Soundtrack.self).url(forResource: "NightDocket", withExtension: "m4a"))
    }

    func testTwelveAwarenessNights() throws {
        let lessons = try loadPack()
        XCTAssertEqual(lessons.count, 12)
        XCTAssertEqual(lessons.filter(\.demo).map(\.id), ["01-kod", "02-list", "03-prompt"])
        XCTAssertTrue(lessons.allSatisfy(\.storyMode))
        XCTAssertTrue(lessons.allSatisfy { $0.introVideo == nil })
        XCTAssertTrue(lessons.allSatisfy { $0.sourceIds.isEmpty })
        let first = try XCTUnwrap(lessons.first)
        let trap = try XCTUnwrap(first.choices.first { $0.id == "trap" })
        XCTAssertEqual(trap.verdict, .sound)
        XCTAssertTrue(trap.title.pl.contains("książki"))
    }

    func testEachNightHasOneTrapAndTwoPanels() throws {
        for lesson in try loadPack() {
            XCTAssertEqual(lesson.choices.count, 3, lesson.id)
            XCTAssertEqual(lesson.choices.filter { $0.verdict == .sound }.count, 1, lesson.id)
            XCTAssertEqual(lesson.beats.count, 2, lesson.id)
            XCTAssertEqual(Set(lesson.beats.map(\.asset)).count, lesson.beats.count, lesson.id)
            XCTAssertTrue(lesson.innerVoice.pl.hasSuffix("?"))
            XCTAssertFalse(lesson.awareness.practice.pl.isEmpty)
            XCTAssertNotEqual(lesson.awareness.minimize.pl, lesson.awareness.practice.pl)
            for beat in lesson.beats {
                XCTAssertLessThanOrEqual(beat.caption.pl.count, 140, lesson.id)
                XCTAssertNotNil(UIImage(named: beat.asset), beat.asset)
            }
        }
    }

    func testFictionDoesNotTrackRealFirms() throws {
        let blob = try loadBlob()
        for banned in ["Vogel", "Kruk", "Wilk", "Królewska 16", "vogelkruk", "Art. 6", "DKN.5131", "aplikantk"] {
            XCTAssertFalse(blob.contains(banned), banned)
        }
        XCTAssertTrue(blob.contains("Iglica"))
        XCTAssertTrue(blob.contains("Chropot"))
        XCTAssertTrue(blob.contains("aplikant") || blob.contains("Aplikant") || blob.contains("Iglica"))
    }

    @MainActor
    func testNightGoesComicThenTrapThenStamp() throws {
        let pack = try loadPack()
        let store = GameStore(lessons: pack)
        store.clearStamps()
        let lesson = try XCTUnwrap(pack.first)
        let trap = try XCTUnwrap(lesson.choices.first { $0.id == "trap" })
        store.open(lesson)
        XCTAssertEqual(store.route, .comic(lesson))
        store.openDossier(lesson)
        store.choose(trap, in: lesson)
        guard case .verdict(let splash) = store.route else {
            return XCTFail("missing stamp")
        }
        XCTAssertEqual(splash.choice.verdict, .sound)
        XCTAssertEqual(store.streak, 1)
        store.finishVerdict(splash)
        guard case .ratio = store.route else {
            return XCTFail("missing reflex")
        }
        store.continueToBriefing(splash)
        guard case .awareness(let briefed) = store.route else {
            return XCTFail("missing required briefing")
        }
        XCTAssertEqual(briefed.id, lesson.id)
        store.finishBriefing()
        XCTAssertEqual(store.route, .desk)
        XCTAssertEqual(store.lesson(after: lesson)?.id, "02-list")
    }

    @MainActor
    func testLaterNightsStayLockedUntilPreviousStamp() throws {
        let pack = try loadPack()
        let store = GameStore(lessons: pack)
        store.clearStamps()
        let first = try XCTUnwrap(pack.first)
        let second = try XCTUnwrap(pack.dropFirst().first)
        XCTAssertTrue(store.isCurrentNight(first))
        XCTAssertTrue(store.canPlay(first))
        XCTAssertFalse(store.canPlay(second))
        store.open(second)
        XCTAssertEqual(store.route, .splash)
        store.open(first)
        XCTAssertEqual(store.route, .comic(first))
        let trap = try XCTUnwrap(first.choices.first { $0.id == "trap" })
        store.openDossier(first)
        store.choose(trap, in: first)
        XCTAssertTrue(store.canPlay(second))
        XCTAssertTrue(store.isCurrentNight(second))
    }

    func testLegacyBinaryStampMigration() throws {
        let legacy = Data(#"[{"lessonId":"01-kod","pass":true,"kind":"verify"},{"lessonId":"02-list","pass":false,"kind":"stamp"}]"#.utf8)
        let stamps = try JSONDecoder().decode([DocketStamp].self, from: legacy)
        XCTAssertEqual(stamps.map(\.verdict), [.sound, .unsound])
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
