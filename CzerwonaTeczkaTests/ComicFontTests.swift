import CoreText
import UIKit
import XCTest
@testable import CzerwonaTeczka

/// Panel B balloons kept falling back to the system font. A full font name resolves at launch
/// and stops resolving after the app returns from the background, so every name must be a
/// PostScript name, and every glyph on a plate must exist in the face that draws it.
final class ComicFontTests: XCTestCase {
    private let names = [Typeface.comic, Typeface.comicItalic]

    func testTypefaceNamesArePostScriptNamesOfBundledFaces() {
        let bundled = UIFont.fontNames(forFamilyName: "Gobo Caps")
        for name in names {
            XCTAssertTrue(bundled.contains(name), "\(name) is not a PostScript name in \(bundled)")
            XCTAssertEqual(UIFont(name: name, size: 20)?.fontName, name)
            let font = CTFontCreateWithName(name as CFString, 20, nil)
            XCTAssertEqual(CTFontCopyPostScriptName(font) as String, name, "CoreText fell back for \(name)")
        }
    }

    func testLetteringUsesItalicForBalloonsOnly() {
        XCTAssertEqual(Typeface.lettering(.balloon), Typeface.italic(20))
        XCTAssertEqual(Typeface.lettering(.caption), Typeface.display(20))
    }

    func testEveryPlateCharacterIsCoveredByTheComicFaces() throws {
        let lessons = try LessonLoader.load()
        XCTAssertFalse(lessons.isEmpty)
        for name in names {
            let font = CTFontCreateWithName(name as CFString, 20, nil)
            var missing: [String: Set<String>] = [:]
            for lesson in lessons {
                var texts: [Loc] = lesson.beats.map(\.caption)
                texts += [lesson.title, lesson.deadline, lesson.context, lesson.innerVoice]
                for loc in texts {
                    for text in [loc.pl, loc.en] {
                        for character in text {
                            let units = Array(String(character).utf16)
                            var glyphs = [CGGlyph](repeating: 0, count: units.count)
                            if !CTFontGetGlyphsForCharacters(font, units, &glyphs, units.count) {
                                missing[String(character), default: []].insert(lesson.id)
                            }
                        }
                    }
                }
            }
            XCTAssertTrue(missing.isEmpty, "\(name) lacks glyphs: \(missing.mapValues { $0.sorted() })")
        }
    }
}
