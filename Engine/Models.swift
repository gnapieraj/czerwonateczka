import Foundation

enum AppLanguage: String, CaseIterable, Codable {
    case polish
    case english
}

enum ExhibitKind: String, Codable, CaseIterable {
    case pleading
    case prompt
    case phone
    case pdf
    case usb
    case email
    case memo
    case hr
}

enum ChoiceKind: String, Codable {
    case stamp
    case reject
    case verify
}

struct Loc: Codable, Equatable {
    var pl: String
    var en: String

    func t(_ language: AppLanguage) -> String {
        language == .polish ? pl : en
    }
}

struct MeterDelta: Codable, Equatable {
    var tajemnica: Int
    var sad: Int
    var klient: Int
    var rozliczalnosc: Int
}

struct Meters: Equatable {
    var tajemnica: Int
    var sad: Int
    var klient: Int
    var rozliczalnosc: Int

    static let full = Meters(tajemnica: 100, sad: 100, klient: 100, rozliczalnosc: 100)

    func applying(_ delta: MeterDelta) -> Meters {
        Meters(
            tajemnica: clamp(tajemnica + delta.tajemnica),
            sad: clamp(sad + delta.sad),
            klient: clamp(klient + delta.klient),
            rozliczalnosc: clamp(rozliczalnosc + delta.rozliczalnosc)
        )
    }

    private func clamp(_ value: Int) -> Int {
        min(100, max(0, value))
    }
}

struct RatioCopy: Codable, Equatable, Identifiable {
    var statute: Loc
    var consequence: Loc
    var reflex: Loc
    var pattern: Loc

    var id: String { statute.pl }
}

struct Choice: Codable, Equatable, Identifiable {
    var id: String
    var kind: ChoiceKind
    var pass: Bool
    var delta: MeterDelta
    var title: Loc
    var subtitle: Loc
    var ratio: RatioCopy
}

struct Lesson: Codable, Equatable, Identifiable {
    var id: String
    var order: Int
    var demo: Bool
    var exhibit: ExhibitKind
    var title: Loc
    var subtitle: Loc
    var deadline: Loc
    var context: Loc
    var exhibitLabel: Loc
    var exhibitText: Loc
    var innerVoice: Loc
    var redFlags: [Loc]
    var choices: [Choice]
}

struct Outcome: Equatable {
    var lesson: Lesson
    var choice: Choice
    var meters: Meters
}

enum Route: Equatable {
    case splash
    case desk
    case play(Lesson)
    case ratio(Outcome)
    case sources
    case settings
    case bible
}
