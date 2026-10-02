import Foundation

enum Copy {
    static func s(_ language: AppLanguage, pl: String, en: String) -> String {
        language == .polish ? pl : en
    }

    /// Count noun for *noc* / *night*.
    /// PL: 1 → noc; 2–4 (and 22–24, …) → noce; 5–21 (incl. 12) and the rest → nocy.
    /// EN: 1 → night; else → nights.
    static func nights(_ count: Int, _ language: AppLanguage) -> String {
        if language == .english {
            return abs(count) == 1 ? "night" : "nights"
        }
        let n = abs(count)
        let n100 = n % 100
        let n10 = n % 10
        if n == 1 { return "noc" }
        if (2...4).contains(n10) && !(12...14).contains(n100) { return "noce" }
        return "nocy"
    }

    static func nightsLabeled(_ count: Int, _ language: AppLanguage) -> String {
        "\(count) \(nights(count, language))"
    }
}
