import SwiftUI

enum Noir {
    static let void = Color(red: 0.03, green: 0.03, blue: 0.035)
    static let ink = Color(red: 0.07, green: 0.07, blue: 0.08)
    static let paper = Color(red: 0.91, green: 0.88, blue: 0.80)
    static let paperDim = Color(red: 0.72, green: 0.68, blue: 0.60)
    static let blood = Color(red: 0.72, green: 0.08, blue: 0.10)
    static let mist = Color(white: 0.58)
    static let line = Color.white.opacity(0.10)
}

enum Typeface {
    /// Comic lettering (Gobo Caps, OFL). Latin Extended-A — ą ę ć ł ń ó ś ź ż.
    static let comic = "Gobo Caps"
    static let comicItalic = "Gobo Caps Italic"

    static func display(_ size: CGFloat) -> Font { .custom(comic, size: size) }
    static func body(_ size: CGFloat) -> Font { .custom(comic, size: size) }
    static func italic(_ size: CGFloat) -> Font { .custom(comicItalic, size: size) }
    static func mono(_ size: CGFloat) -> Font { .custom(comic, size: size) }
}

/// Locked fiction. Names are invented; they must not track a real Warsaw firm or street parcel.
enum Canon {
    static let firmPL = "Kancelaria Colgante i Wspólnicy"
    static let firmEN = "Colgante & Partners"
    static let addressPL = "5. piętro, biurowiec od Świętokrzyskiej, Śródmieście, Warszawa"
    static let addressEN = "5th floor, office block off Świętokrzyska, Downtown Warsaw"
    static let windowPL = "Za żaluzją: PKiN w deszczu."
    static let windowEN = "Beyond the blinds: the Palace of Culture in the rain."
    static let domainReal = "colgante.pl"
    static let domainLookalike = "colgante-partners.com"
    static let fictionPL = "Kancelaria, adres i osoby są fikcyjne. Wszelkie podobieństwo do prawdziwych kancelarii jest niezamierzone."
    static let fictionEN = "The firm, address and people are fictional. Any resemblance to a real practice is unintended."

    static func firm(_ language: AppLanguage) -> String { language == .polish ? firmPL : firmEN }
    static func address(_ language: AppLanguage) -> String { language == .polish ? addressPL : addressEN }
    static func window(_ language: AppLanguage) -> String { language == .polish ? windowPL : windowEN }
    static func fiction(_ language: AppLanguage) -> String { language == .polish ? fictionPL : fictionEN }
}

enum Cast: String, CaseIterable {
    case mecenas, iglica, chropot, irena

    var asset: String {
        switch self {
        case .mecenas: return "MecenasPOV"
        case .iglica: return "AplikantIglica"
        case .chropot: return "PartnerChropot"
        case .irena: return "SekretariatIrena"
        }
    }

    func name(_ lang: AppLanguage) -> String {
        switch (self, lang) {
        case (.mecenas, .polish): return "Ty"
        case (.mecenas, .english): return "You"
        case (.iglica, .polish): return "Filip Iglica"
        case (.iglica, .english): return "Filip Iglica"
        case (.chropot, .polish): return "Partner Chropot"
        case (.chropot, .english): return "Partner Chropot"
        case (.irena, .polish): return "Irena, asystentka"
        case (.irena, .english): return "Irena, assistant"
        }
    }

    func lockLine(_ lang: AppLanguage) -> String {
        switch (self, lang) {
        case (.mecenas, .polish):
            return "Mecenas przy biurku. Spokojny jak lampa bankierska, ostrożny jak stempel — pełnej twarzy nie widać, bo decyzje padają na ciebie."
        case (.mecenas, .english):
            return "Counsel at the desk. Calm as a banker’s lamp, careful as a stamp — never a full face, because the calls land on you."
        case (.iglica, .polish):
            return "Aplikant. Gorliwy nosiciel akt i nerwowych uśmiechów — żyje między westchnieniem a „już robię”, zanim zdąży pomyśleć."
        case (.iglica, .english):
            return "Trainee. Eager carrier of files and nervous smiles — lives between a sigh and “on it”, before he can think."
        case (.chropot, .polish):
            return "Treser deadline’ów. Żąda draftu na wczoraj, a otwiera go za dwa tygodnie — niecierpliwy, bo decyzje mają padać natychmiast."
        case (.chropot, .english):
            return "Deadline wrangler. Demands a draft for yesterday, opens it two weeks later — impatient, because decisions must fall at once."
        case (.irena, .polish):
            return "Władczyni kalendarza. Zorganizowana, stanowcza, odporna na fochy partnerów — wie, jak załatwić wszystko, zanim ktokolwiek zapyta."
        case (.irena, .english):
            return "Keeper of the calendar. Organised, firm, immune to partners’ moods — she knows how to fix anything before anyone asks."
        }
    }
}

extension ExhibitKind {
    var leadCast: Cast {
        switch self {
        case .pleading, .prompt, .memo: return .iglica
        case .phone, .pdf, .email: return .mecenas
        case .usb, .hr: return .irena
        }
    }

    var secondCast: Cast? {
        switch self {
        case .pleading, .memo: return .chropot
        case .phone: return .chropot
        case .usb: return .mecenas
        default: return nil
        }
    }
}
