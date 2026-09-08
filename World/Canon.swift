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
    static func display(_ size: CGFloat) -> Font { .system(size: size, weight: .semibold, design: .serif) }
    static func body(_ size: CGFloat) -> Font { .system(size: size, weight: .regular, design: .default) }
    static func mono(_ size: CGFloat) -> Font { .system(size: size, weight: .medium, design: .monospaced) }
}

/// Locked fiction. Names are invented; they must not track a real Warsaw firm or street parcel.
enum Canon {
    static let firmPL = "Kancelaria Okiennica, Chropot i Wspólnicy"
    static let firmEN = "Okiennica, Chropot & Partners"
    static let addressPL = "5. piętro, biurowiec od Świętokrzyskiej, Śródmieście, Warszawa"
    static let addressEN = "5th floor, office block off Świętokrzyska, Downtown Warsaw"
    static let windowPL = "Za żaluzją: PKiN w deszczu."
    static let windowEN = "Beyond the blinds: the Palace of Culture in the rain."
    static let domainReal = "okiennicachropot.pl"
    static let domainLookalike = "okiennica-chropot-partners.com"
    static let fictionPL = "Kancelaria, adres i osoby są fikcyjne. Wszelkie podobieństwo do prawdziwych kancelarii jest niezamierzone."
    static let fictionEN = "The firm, address and people are fictional. Any resemblance to a real practice is unintended."
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
        case (.mecenas, .polish): return "Ty — mecenas przy biurku"
        case (.mecenas, .english): return "You — counsel at the desk"
        case (.iglica, .polish): return "Aplikant Filip Iglica"
        case (.iglica, .english): return "Trainee Filip Iglica"
        case (.chropot, .polish): return "Partner Chropot (pociąg)"
        case (.chropot, .english): return "Partner Chropot (on the train)"
        case (.irena, .polish): return "Irena, sekretariat"
        case (.irena, .english): return "Irena, secretariat"
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
