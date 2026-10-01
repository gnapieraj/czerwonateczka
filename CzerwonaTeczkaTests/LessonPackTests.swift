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

    func testTwentyFourAwarenessNights() throws {
        let lessons = try loadPack()
        XCTAssertEqual(lessons.count, 24)
        XCTAssertEqual(lessons.filter { $0.seasonId == "0" }.count, 12)
        XCTAssertEqual(lessons.filter { $0.seasonId == "1" }.count, 12)
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

    func testCastBibleMatchesCurrentClimate() {
        for language in AppLanguage.allCases {
            for person in Cast.allCases {
                let text = (person.name(language) + " " + person.lockLine(language)).lowercased()
                XCTAssertFalse(text.contains("pkp"), person.rawValue)
                XCTAssertFalse(text.contains("pociąg"), person.rawValue)
                XCTAssertFalse(text.contains("mfa"), person.rawValue)
                XCTAssertFalse(text.contains("prompt"), person.rawValue)
                XCTAssertFalse(text.contains("usb"), person.rawValue)
                XCTAssertFalse(text.contains("sms"), person.rawValue)
                XCTAssertFalse(text.contains("wokand"), person.rawValue)
                XCTAssertFalse(text.contains("docket"), person.rawValue)
            }
        }
        XCTAssertEqual(Cast.chropot.name(.polish), "Partner Chropot")
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
        XCTAssertEqual(store.stamps[lesson.id]?.briefed, false, "verdict counts for the report only after the briefing")
        XCTAssertNotNil(store.stamps[lesson.id]?.stampedAt)
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
        XCTAssertEqual(store.stamps[lesson.id]?.briefed, true)
        XCTAssertEqual(store.lesson(after: lesson)?.id, "02-list")
    }

    @MainActor
    func testEmployerReportUnlocksAtNinetyPercentAfterBriefings() throws {
        let pack = try loadPack()
        let store = GameStore(lessons: pack)
        store.clearStamps()
        XCTAssertNil(store.defaultReportScope)
        for lesson in pack where lesson.seasonId == "0" {
            let choiceId = lesson.id == "06-pomoc" ? "decoy-a" : "trap"
            let choice = try XCTUnwrap(lesson.choices.first { $0.id == choiceId })
            store.choose(choice, in: lesson)
        }
        XCTAssertEqual(store.evaluate(.season("0")).unbriefed.count, 12)
        XCTAssertFalse(store.hasPassingReportScope, "briefings not read yet")
        for lesson in pack where lesson.seasonId == "0" {
            store.markBriefed(lesson.id)
        }
        let evaluation = store.evaluate(.season("0"))
        XCTAssertEqual(evaluation.soundCount, 11)
        XCTAssertTrue(evaluation.passed)
        XCTAssertEqual(store.defaultReportScope, .season("0"))
        XCTAssertFalse(store.evaluate(.pack).passed, "season 1 still unstamped")
        XCTAssertEqual(store.reportScopes, [.season("0"), .season("1"), .pack])
    }

    @MainActor
    func testFirstLaunchOpensTheRulebookBeforeTheNight() throws {
        let pack = try loadPack()
        UserDefaults.standard.set(false, forKey: "docket.seenBible")
        UserDefaults.standard.set(false, forKey: "docket.seenHowToPlay")
        let store = GameStore(lessons: pack)
        store.clearStamps()
        store.start()
        XCTAssertEqual(store.route, .howToPlay)
        XCTAssertFalse(store.seenHowToPlay)
        XCTAssertFalse(store.seenBible)
        store.dismissHowToPlay()
        XCTAssertEqual(store.route, .bible)
        store.back()
        XCTAssertEqual(store.route, .desk)
    }

    @MainActor
    func testResetFirstLaunchReturnsToSplashOnboarding() throws {
        let pack = try loadPack()
        UserDefaults.standard.set(true, forKey: "docket.seenBible")
        UserDefaults.standard.set(true, forKey: "docket.seenHowToPlay")
        let store = GameStore(lessons: pack)
        store.clearStamps()
        store.start()
        XCTAssertEqual(store.route, .desk)
        let first = try XCTUnwrap(pack.first)
        store.open(first)
        XCTAssertEqual(store.route, .comic(first))
        store.resetFirstLaunch()
        XCTAssertEqual(store.route, .splash)
        XCTAssertTrue(store.stamps.isEmpty)
        XCTAssertFalse(store.seenBible)
        XCTAssertFalse(store.seenHowToPlay)
        store.start()
        XCTAssertEqual(store.route, .howToPlay)
    }

    @MainActor
    func testStartWhenOnboardingDoneGoesStraightToDesk() throws {
        let pack = try loadPack()
        UserDefaults.standard.set(true, forKey: "docket.seenBible")
        UserDefaults.standard.set(true, forKey: "docket.seenHowToPlay")
        let store = GameStore(lessons: pack)
        store.clearStamps()
        let first = try XCTUnwrap(pack.first)
        let trap = try XCTUnwrap(first.choices.first { $0.id == "trap" })
        store.choose(trap, in: first)
        store.start()
        XCTAssertEqual(store.route, .desk)
    }

    func testPhoneHangUpNamesTheHabit() {
        XCTAssertEqual(
            ExhibitGesture.resolve(lessonId: "01-kod", flags: ["first-yes", "second-no", "called"]),
            "trap"
        )
        XCTAssertEqual(
            ExhibitGesture.resolve(lessonId: "01-kod", flags: ["first-yes", "second-no"]),
            "decoy-b"
        )
        XCTAssertEqual(
            ExhibitGesture.resolve(lessonId: "01-kod", flags: ["first-no"]),
            "decoy-b"
        )
        XCTAssertEqual(
            ExhibitGesture.resolve(lessonId: "07-sms", flags: ["order"]),
            "trap"
        )
        XCTAssertEqual(
            ExhibitGesture.resolve(lessonId: "12-okup", flags: ["unplug"]),
            "decoy-b"
        )
        XCTAssertEqual(
            ExhibitGesture.resolve(lessonId: "12-okup", flags: ["unplug", "list"]),
            "trap"
        )
        XCTAssertEqual(DocketHabit.all.count, 24)
        XCTAssertEqual(Set(DocketHabit.all.map(\.lessonId)).count, 24)
    }

    func testEveryNightHasAGesture() throws {
        let pack = try loadPack()
        for lesson in pack where lesson.storyMode {
            XCTAssertNotNil(ExhibitGesture.scene(for: lesson.id), lesson.id)
        }
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

    @MainActor
    func testAssociateSeasonOpensAfterTheTwelfthStamp() throws {
        let pack = try loadPack()
        XCTAssertEqual(pack.filter { $0.seasonId == "1" }.count, 12)
        let store = GameStore(lessons: pack)
        store.clearStamps()
        store.selectSeason("1")
        let associate = try XCTUnwrap(pack.first { $0.id == "13-chmura" })
        XCTAssertFalse(store.canPlay(associate))
        for lesson in pack where lesson.seasonId == "0" {
            let trap = try XCTUnwrap(lesson.choices.first { $0.id == "trap" })
            store.choose(trap, in: lesson)
        }
        XCTAssertTrue(store.canPlay(associate))
        store.finishBriefing()
        XCTAssertEqual(store.selectedSeasonId, "1")
        XCTAssertEqual(store.route, .desk)
    }

    func testLegacyBinaryStampMigration() throws {
        let legacy = Data(#"[{"lessonId":"01-kod","pass":true,"kind":"verify"},{"lessonId":"02-list","pass":false,"kind":"stamp"}]"#.utf8)
        let stamps = try JSONDecoder().decode([DocketStamp].self, from: legacy)
        XCTAssertEqual(stamps.map(\.verdict), [.sound, .unsound])
    }

    func testNextNightOpensTheComicNotTheContextPage() {
        let flagged = ["--lesson=01-kod", "--comic-page=2"]
        XCTAssertEqual(ComicIntroView.launchPageIndex(for: "01-kod", arguments: flagged), 1)
        XCTAssertEqual(ComicIntroView.launchPageIndex(for: "02-list", arguments: flagged), 0)
        XCTAssertEqual(ComicIntroView.launchPageIndex(for: "02-list", arguments: []), 0)
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
