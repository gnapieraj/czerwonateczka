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

    func testEightLessonsThreeDemo() throws {
        let lessons = try loadPack()
        XCTAssertEqual(lessons.count, 8)
        XCTAssertEqual(lessons.filter(\.demo).count, 3)
        XCTAssertEqual(lessons.filter(\.demo).map(\.id), ["01-sygnatura", "03-glos", "04-prostokaty"])
    }

    func testSecrecyIsArticleSixNotSeventeen() throws {
        let blob = try loadBlob()
        XCTAssertTrue(blob.contains("Art. 6") || blob.contains("art. 6"))
        XCTAssertTrue(Bibliography.items.contains { $0.id == "bar" && $0.note.pl.contains("2024 poz. 1564") })
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
        XCTAssertEqual(stamp.verdict, .unsound)
        XCTAssertEqual(stamp.delta.sad, -45)
        XCTAssertTrue(lesson.choices.contains { $0.kind == .verify && $0.verdict == .sound })
        XCTAssertTrue(lesson.exhibitText.pl.contains("III CZP 12/22"))
        XCTAssertTrue(lesson.innerVoice.pl.hasSuffix("?"))
    }

    func testUSBDecisionAndEmotionBan() throws {
        let blob = try loadBlob()
        XCTAssertTrue(blob.contains("DKN.5131.31.2022"))
        XCTAssertTrue(blob.contains("23 580") || blob.contains("23580"))
        XCTAssertTrue(blob.contains("II SA/Wa 1342/23"))
        XCTAssertTrue(blob.contains("ust. 1 lit. f") || blob.contains("5(1)(f)"))
        let emotion = try XCTUnwrap(try loadPack().first { $0.id == "08-emocje" })
        let stamp = try XCTUnwrap(emotion.choices.first { $0.kind == .stamp })
        XCTAssertEqual(stamp.verdict, .unsound)
        XCTAssertTrue(stamp.ratio.pattern.pl.contains("art. 99") || stamp.ratio.pattern.pl.contains("Art. 99"))
    }

    func testEachLessonHasThreeActionsAndNuancedVerdicts() throws {
        for lesson in try loadPack() {
            XCTAssertEqual(lesson.choices.count, 3)
            XCTAssertTrue(lesson.choices.contains { $0.kind == .stamp })
            XCTAssertTrue(lesson.choices.contains { $0.kind == .reject })
            XCTAssertTrue(lesson.choices.contains { $0.kind == .verify })
            XCTAssertEqual(lesson.choices.first { $0.kind == .stamp }?.verdict, .unsound, lesson.id)
            XCTAssertEqual(lesson.choices.first { $0.kind == .verify }?.verdict, .sound, lesson.id)
            XCTAssertFalse(lesson.sourceIds.isEmpty, lesson.id)
        }
        let incomplete = try loadPack().flatMap(\.choices).filter { $0.verdict == .incomplete }
        XCTAssertFalse(incomplete.isEmpty)
    }

    func testWarsawCanonInOpeningFiles() throws {
        let pack = try loadPack()
        let opening = pack.filter { ["01-sygnatura", "03-glos", "04-prostokaty"].contains($0.id) }
        for lesson in opening {
            XCTAssertTrue(lesson.context.pl.contains("piętr") || lesson.context.pl.contains("Śródmieśc") || lesson.context.pl.contains("Świętokrzysk"))
        }
    }

    func testRealPublicCasesHaveAStory() throws {
        let pack = try loadPack()
        let mata = try XCTUnwrap(pack.first { $0.id == "01-sygnatura" })
        let mataStamp = try XCTUnwrap(mata.choices.first { $0.kind == .stamp })
        XCTAssertTrue(mataStamp.ratio.patternStory?.pl.contains("Avianca") == true)
        XCTAssertTrue(mataStamp.ratio.patternStory?.pl.contains("ChatGPT") == true)

        let whisper = try XCTUnwrap(pack.first { $0.id == "02-szept" })
        let whisperStamp = try XCTUnwrap(whisper.choices.first { $0.kind == .stamp })
        XCTAssertTrue(whisperStamp.ratio.patternStory?.pl.contains("Heppner") == true)
        XCTAssertTrue(whisperStamp.ratio.patternStory?.pl.contains("Claude") == true)

        let voice = try XCTUnwrap(pack.first { $0.id == "03-glos" })
        let voiceStamp = try XCTUnwrap(voice.choices.first { $0.kind == .stamp })
        XCTAssertTrue(voiceStamp.ratio.patternStory?.pl.contains("Corbyn") == true)
        XCTAssertFalse(voiceStamp.ratio.pattern.pl.contains("Heppner"))

        let usb = try XCTUnwrap(pack.first { $0.id == "05-pendrive" })
        let usbStamp = try XCTUnwrap(usb.choices.first { $0.kind == .stamp })
        XCTAssertTrue(usbStamp.ratio.patternStory?.pl.contains("23 580") == true)
        XCTAssertTrue(usbStamp.ratio.patternStory?.pl.contains("Rzecznik") == true)

        let mail = try XCTUnwrap(pack.first { $0.id == "06-mail" })
        let mailStamp = try XCTUnwrap(mail.choices.first { $0.kind == .stamp })
        XCTAssertTrue(mailStamp.ratio.patternStory?.pl.contains("475") == true)

        let copilot = try XCTUnwrap(pack.first { $0.id == "07-copilot" })
        let copilotStamp = try XCTUnwrap(copilot.choices.first { $0.kind == .stamp })
        XCTAssertTrue(copilotStamp.ratio.patternStory?.pl.contains("Pinsent") == true)
        XCTAssertTrue(copilotStamp.ratio.patternStory?.pl.contains("Insolvency") == true)
    }

    func testEachLessonHasAwarenessBrief() throws {
        for lesson in try loadPack() {
            XCTAssertFalse(lesson.awareness.threat.pl.isEmpty, lesson.id)
            XCTAssertFalse(lesson.awareness.minimize.pl.isEmpty, lesson.id)
            XCTAssertFalse(lesson.awareness.practice.pl.isEmpty, lesson.id)
            XCTAssertGreaterThanOrEqual(lesson.awareness.watchFor.count, 4, lesson.id)
            XCTAssertFalse(lesson.awareness.threat.pl.lowercased().contains("gra edukacyjna"))
        }
        let whisper = try XCTUnwrap(try loadPack().first { $0.id == "02-szept" })
        XCTAssertTrue(whisper.awareness.threat.pl.contains("Art. 6") || whisper.awareness.threat.pl.contains("art. 6"))
        XCTAssertTrue(whisper.awareness.threat.pl.contains("art. 266"))
        let usb = try XCTUnwrap(try loadPack().first { $0.id == "05-pendrive" })
        XCTAssertTrue(usb.awareness.threat.pl.contains("DKN.5131.31.2022"))
        let emotion = try XCTUnwrap(try loadPack().first { $0.id == "08-emocje" })
        XCTAssertTrue(emotion.awareness.threat.pl.contains("ust. 1 lit. f") || emotion.awareness.threat.pl.contains("5(1)(f)"))
        XCTAssertTrue(emotion.awareness.threat.pl.contains("danych biometrycznych"))
    }

    func testKnownLegalErrorsDoNotRegress() throws {
        let blob = try loadBlob()
        for banned in [
            "art. 107 k.k.",
            "Art. 107 k.k.",
            "Art. 3 § 1 i § 2",
            "ISAP są źródłem prawa",
            "ISAP jest źródłem prawa",
            "Trzy sygnatury nie istnieją",
            "UODO już wyceniło ten gest",
            "Rzecznik Dyscyplinarny Izby Adwokackiej w Warszawie",
            "III CZP z numerem, którego nie ma"
        ] {
            XCTAssertFalse(blob.contains(banned), "regression: \(banned)")
        }
        XCTAssertTrue(blob.contains("III CSKP 88/21"))
        XCTAssertTrue(blob.contains("motywem 18") || blob.contains("recital 18"))
        XCTAssertTrue(blob.contains("ECLI:EU:C:2024:805"))
        XCTAssertTrue(blob.contains("28 października 2026"))
    }

    func testEverySourceReferenceExistsInBibliography() throws {
        let known = Set(Bibliography.items.map(\.id))
        XCTAssertEqual(Bibliography.legalState, "10.09.2026")
        for lesson in try loadPack() {
            XCTAssertTrue(Set(lesson.sourceIds).isSubset(of: known), lesson.id)
        }
    }

    @MainActor
    func testAllLessonDecisionAndSourceRoutes() throws {
        let pack = try loadPack()
        let store = GameStore(lessons: pack)
        store.clearStamps()

        for lesson in pack {
            for choice in lesson.choices {
                store.backToDesk()
                store.open(lesson)
                XCTAssertEqual(store.route, .comic(lesson))
                store.openDossier(lesson)
                XCTAssertEqual(store.route, .play(lesson))
                store.choose(choice, in: lesson)
                XCTAssertEqual(store.stamp(for: lesson)?.verdict, choice.verdict)
                guard case .ratio(let outcome) = store.route else {
                    return XCTFail("missing ratio route for \(lesson.id)/\(choice.id)")
                }
                XCTAssertEqual(outcome.choice.verdict, choice.verdict)
                store.openSources(for: lesson)
                XCTAssertEqual(store.route, .sources(lesson.sourceIds))
                store.back()
                XCTAssertEqual(store.route, .ratio(outcome))
            }
        }
    }

    func testLegacyBinaryStampMigration() throws {
        let legacy = Data(#"[{"lessonId":"01-sygnatura","pass":true,"kind":"verify"},{"lessonId":"02-szept","pass":false,"kind":"stamp"}]"#.utf8)
        let stamps = try JSONDecoder().decode([DocketStamp].self, from: legacy)
        XCTAssertEqual(stamps.map(\.verdict), [.sound, .unsound])
        XCTAssertFalse(String(decoding: try JSONEncoder().encode(stamps), as: UTF8.self).contains(#""pass""#))
    }

    func testEachLessonHasComicBeats() throws {
        for lesson in try loadPack() {
            XCTAssertGreaterThanOrEqual(lesson.beats.count, 3, lesson.id)
            XCTAssertLessThanOrEqual(lesson.beats.count, 6, lesson.id)
            XCTAssertEqual(lesson.beats.count, 4, "\(lesson.id) storyboard should currently fill two pages")
            XCTAssertFalse(lesson.hero.isEmpty, lesson.id)
            XCTAssertTrue(lesson.hero.hasPrefix("Mission"), lesson.id)
            XCTAssertEqual(Set(lesson.beats.map(\.asset)).count, lesson.beats.count, "\(lesson.id) repeats a panel asset")
            for beat in lesson.beats {
                XCTAssertFalse(beat.caption.pl.isEmpty, lesson.id)
                XCTAssertFalse(beat.caption.en.isEmpty, lesson.id)
                XCTAssertLessThanOrEqual(beat.caption.pl.count, 140, lesson.id)
                XCTAssertNotNil(UIImage(named: beat.asset), "\(lesson.id) missing comic asset \(beat.asset)")
            }
            XCTAssertTrue(lesson.innerVoice.pl.hasSuffix("?"), "\(lesson.id) inner voice should ask, not solve")
            XCTAssertTrue(lesson.innerVoice.en.hasSuffix("?"), "\(lesson.id) inner voice should ask, not solve")
        }
        let emotion = try XCTUnwrap(try loadPack().first { $0.id == "08-emocje" })
        XCTAssertEqual(emotion.tone, .probono)
        XCTAssertTrue(emotion.subtitle.pl.lowercased().contains("pro bono"))
        XCTAssertTrue(emotion.context.pl.contains("dziennikark") || emotion.context.pl.contains("newsroom"))
    }

    func testFictionDoesNotTrackRealFirms() throws {
        let blob = try loadBlob()
        for banned in ["Vogel", "Kruk", "Wilk", "Królewska 16", "vogelkruk"] {
            XCTAssertFalse(blob.contains(banned), "leftover real-world name: \(banned)")
        }
        XCTAssertTrue(blob.contains("colgante") || blob.contains("Chropot") || blob.contains("Iglica"))
        for lesson in try loadPack() {
            XCTAssertFalse(lesson.hero.isEmpty, lesson.id)
            XCTAssertTrue(lesson.hero.hasPrefix("Mission"), lesson.id)
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
