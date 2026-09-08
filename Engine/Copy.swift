import Foundation

enum Copy {
    static func s(_ language: AppLanguage, pl: String, en: String) -> String {
        language == .polish ? pl : en
    }
}
