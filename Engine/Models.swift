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

enum DecisionVerdict: String, Codable {
    case unsound
    case incomplete
    case sound

    var isSound: Bool { self == .sound }

    func label(_ language: AppLanguage) -> String {
        switch (self, language) {
        case (.unsound, .polish): return "BŁĘDNE"
        case (.unsound, .english): return "UNSOUND"
        case (.incomplete, .polish): return "NIEPEŁNE"
        case (.incomplete, .english): return "INCOMPLETE"
        case (.sound, .polish): return "TRAFNE"
        case (.sound, .english): return "SOUND"
        }
    }
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

struct Meters: Equatable, Codable {
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
    var patternStory: Loc?

    var id: String { statute.pl }
}

struct Choice: Codable, Equatable, Identifiable {
    var id: String
    var kind: ChoiceKind
    var verdict: DecisionVerdict
    var delta: MeterDelta
    var title: Loc
    var subtitle: Loc
    var ratio: RatioCopy

    var pass: Bool { verdict.isSound }

    enum CodingKeys: String, CodingKey {
        case id, kind, verdict, pass, delta, title, subtitle, ratio
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(String.self, forKey: .id)
        kind = try c.decode(ChoiceKind.self, forKey: .kind)
        if let decoded = try c.decodeIfPresent(DecisionVerdict.self, forKey: .verdict) {
            verdict = decoded
        } else {
            verdict = try c.decode(Bool.self, forKey: .pass) ? .sound : .unsound
        }
        delta = try c.decode(MeterDelta.self, forKey: .delta)
        title = try c.decode(Loc.self, forKey: .title)
        subtitle = try c.decode(Loc.self, forKey: .subtitle)
        ratio = try c.decode(RatioCopy.self, forKey: .ratio)
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(id, forKey: .id)
        try c.encode(kind, forKey: .kind)
        try c.encode(verdict, forKey: .verdict)
        try c.encode(delta, forKey: .delta)
        try c.encode(title, forKey: .title)
        try c.encode(subtitle, forKey: .subtitle)
        try c.encode(ratio, forKey: .ratio)
    }
}

enum DocketTone: String, Codable, Equatable {
    case shadow
    case probono
}

enum ComicVoice: String, Codable, Equatable {
    case caption
    case balloon
}

struct ComicBeat: Codable, Equatable, Identifiable {
    var asset: String
    var caption: Loc
    var voice: ComicVoice

    var id: String { asset + caption.pl + voice.rawValue }

    enum CodingKeys: String, CodingKey {
        case asset, caption, voice
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        asset = try c.decode(String.self, forKey: .asset)
        caption = try c.decode(Loc.self, forKey: .caption)
        voice = try c.decodeIfPresent(ComicVoice.self, forKey: .voice) ?? .caption
    }
}

struct Lesson: Codable, Equatable, Identifiable {
    var id: String
    var order: Int
    var seasonId: String
    var seasonTitle: Loc
    var demo: Bool
    var exhibit: ExhibitKind
    var hero: String
    var tone: DocketTone
    var title: Loc
    var subtitle: Loc
    var deadline: Loc
    var context: Loc
    var beats: [ComicBeat]
    var exhibitLabel: Loc
    var exhibitText: Loc
    var innerVoice: Loc
    var redFlags: [Loc]
    var choices: [Choice]
    var awareness: AwarenessBrief
    var sourceIds: [String]
    /// Bundle resource name without extension (e.g. "Mission01Intro").
    var introVideo: String?
    /// Ace Attorney–style stepped play + theatrical verdict (case 01 only).
    var storyMode: Bool

    enum CodingKeys: String, CodingKey {
        case id, order, seasonId, seasonTitle, demo, exhibit, hero, tone, title, subtitle, deadline, context
        case beats, exhibitLabel, exhibitText, innerVoice, redFlags, choices, awareness, sourceIds
        case introVideo, storyMode
    }

    static let prologueSeasonId = "0"
    static let prologueSeasonTitle = Loc(pl: "Wstęp · 12 nocy", en: "Prologue · 12 nights")

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(String.self, forKey: .id)
        order = try c.decode(Int.self, forKey: .order)
        seasonId = try c.decodeIfPresent(String.self, forKey: .seasonId) ?? Self.prologueSeasonId
        seasonTitle = try c.decodeIfPresent(Loc.self, forKey: .seasonTitle) ?? Self.prologueSeasonTitle
        demo = try c.decode(Bool.self, forKey: .demo)
        exhibit = try c.decode(ExhibitKind.self, forKey: .exhibit)
        hero = try c.decode(String.self, forKey: .hero)
        tone = try c.decode(DocketTone.self, forKey: .tone)
        title = try c.decode(Loc.self, forKey: .title)
        subtitle = try c.decode(Loc.self, forKey: .subtitle)
        deadline = try c.decode(Loc.self, forKey: .deadline)
        context = try c.decode(Loc.self, forKey: .context)
        beats = try c.decode([ComicBeat].self, forKey: .beats)
        exhibitLabel = try c.decode(Loc.self, forKey: .exhibitLabel)
        exhibitText = try c.decode(Loc.self, forKey: .exhibitText)
        innerVoice = try c.decode(Loc.self, forKey: .innerVoice)
        redFlags = try c.decode([Loc].self, forKey: .redFlags)
        choices = try c.decode([Choice].self, forKey: .choices)
        awareness = try c.decode(AwarenessBrief.self, forKey: .awareness)
        sourceIds = try c.decode([String].self, forKey: .sourceIds)
        introVideo = try c.decodeIfPresent(String.self, forKey: .introVideo)
        storyMode = try c.decodeIfPresent(Bool.self, forKey: .storyMode) ?? false
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(id, forKey: .id)
        try c.encode(order, forKey: .order)
        try c.encode(seasonId, forKey: .seasonId)
        try c.encode(seasonTitle, forKey: .seasonTitle)
        try c.encode(demo, forKey: .demo)
        try c.encode(exhibit, forKey: .exhibit)
        try c.encode(hero, forKey: .hero)
        try c.encode(tone, forKey: .tone)
        try c.encode(title, forKey: .title)
        try c.encode(subtitle, forKey: .subtitle)
        try c.encode(deadline, forKey: .deadline)
        try c.encode(context, forKey: .context)
        try c.encode(beats, forKey: .beats)
        try c.encode(exhibitLabel, forKey: .exhibitLabel)
        try c.encode(exhibitText, forKey: .exhibitText)
        try c.encode(innerVoice, forKey: .innerVoice)
        try c.encode(redFlags, forKey: .redFlags)
        try c.encode(choices, forKey: .choices)
        try c.encode(awareness, forKey: .awareness)
        try c.encode(sourceIds, forKey: .sourceIds)
        try c.encodeIfPresent(introVideo, forKey: .introVideo)
        if storyMode { try c.encode(true, forKey: .storyMode) }
    }
}

struct AwarenessBrief: Codable, Equatable {
    var threat: Loc
    var minimize: Loc
    var practice: Loc
    var watchFor: [Loc]
}

struct Outcome: Equatable {
    var lesson: Lesson
    var choice: Choice
    var meters: Meters
}

struct DocketStamp: Codable, Equatable {
    var lessonId: String
    var verdict: DecisionVerdict
    var kind: ChoiceKind

    var pass: Bool { verdict.isSound }

    enum CodingKeys: String, CodingKey {
        case lessonId, verdict, pass, kind
    }

    init(lessonId: String, verdict: DecisionVerdict, kind: ChoiceKind) {
        self.lessonId = lessonId
        self.verdict = verdict
        self.kind = kind
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        lessonId = try c.decode(String.self, forKey: .lessonId)
        kind = try c.decode(ChoiceKind.self, forKey: .kind)
        if let decoded = try c.decodeIfPresent(DecisionVerdict.self, forKey: .verdict) {
            verdict = decoded
        } else {
            verdict = try c.decode(Bool.self, forKey: .pass) ? .sound : .unsound
        }
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(lessonId, forKey: .lessonId)
        try c.encode(verdict, forKey: .verdict)
        try c.encode(kind, forKey: .kind)
    }
}

enum Route: Equatable {
    case splash
    case desk
    case howToPlay
    case cutscene(Lesson)
    case comic(Lesson)
    case play(Lesson)
    case verdict(Outcome)
    case ratio(Outcome)
    case awareness(Lesson)
    case sources([String]?)
    case settings
    case bible
}
