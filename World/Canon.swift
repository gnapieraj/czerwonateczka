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

/// Locked setting. Do not invent new offices or faces per lesson.
enum Canon {
    static let firmPL = "Kancelaria Vogel, Kruk i Wspólnicy"
    static let firmEN = "Vogel, Kruk & Partners"
    static let addressPL = "ul. Królewska 16, 5. piętro, Śródmieście, Warszawa"
    static let addressEN = "16 Królewska Street, 5th floor, Downtown Warsaw"
    static let windowPL = "Za żaluzją: PKiN w deszczu."
    static let windowEN = "Beyond the blinds: the Palace of Culture in the rain."
}

enum Cast: String, CaseIterable {
    case mecenas, wilk, kruk, irena

    var asset: String {
        switch self {
        case .mecenas: return "MecenasPOV"
        case .wilk: return "AplikantWilk"
        case .kruk: return "PartnerKruk"
        case .irena: return "SekretariatIrena"
        }
    }

    func name(_ lang: AppLanguage) -> String {
        switch (self, lang) {
        case (.mecenas, .polish): return "Ty — mecenas przy biurku"
        case (.mecenas, .english): return "You — counsel at the desk"
        case (.wilk, .polish): return "Aplikant Tomasz Wilk"
        case (.wilk, .english): return "Trainee Tomasz Wilk"
        case (.kruk, .polish): return "Partner Kruk (pociąg)"
        case (.kruk, .english): return "Partner Kruk (on the train)"
        case (.irena, .polish): return "Irena, sekretariat"
        case (.irena, .english): return "Irena, secretariat"
        }
    }
}

extension ExhibitKind {
    var leadCast: Cast {
        switch self {
        case .pleading, .prompt, .memo: return .wilk
        case .phone, .pdf, .email: return .mecenas
        case .usb, .hr: return .irena
        }
    }

    var secondCast: Cast? {
        switch self {
        case .pleading, .memo: return .kruk
        case .phone: return .kruk
        case .usb: return .mecenas
        default: return nil
        }
    }
}
