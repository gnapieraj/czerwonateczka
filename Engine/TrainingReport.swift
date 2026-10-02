import CryptoKit
import Foundation

// MARK: - Scope

/// What a single report covers: one season or the whole lesson pack.
enum ReportScope: Hashable, Identifiable {
    case season(String)
    case pack

    var id: String {
        switch self {
        case .season(let seasonId): return "season:\(seasonId)"
        case .pack: return "pack"
        }
    }

    func lessons(from all: [Lesson]) -> [Lesson] {
        switch self {
        case .season(let seasonId): return all.filter { $0.seasonId == seasonId }.sorted { $0.order < $1.order }
        case .pack: return all.sorted { $0.order < $1.order }
        }
    }

    func title(_ language: AppLanguage, lessons all: [Lesson]) -> String {
        switch self {
        case .season(let seasonId):
            if let lesson = all.first(where: { $0.seasonId == seasonId }) {
                return lesson.seasonTitle.t(language)
            }
            return Copy.s(language, pl: "Sezon \(seasonId)", en: "Season \(seasonId)")
        case .pack:
            let labeled = Copy.nightsLabeled(all.count, language)
            return Copy.s(language, pl: "Cały pakiet · \(labeled)", en: "Full pack · \(labeled)")
        }
    }
}

// MARK: - Pass policy (plan §5)

struct LessonEvaluation: Equatable, Identifiable {
    var lesson: Lesson
    var stamp: DocketStamp?

    var id: String { lesson.id }
    var isStamped: Bool { stamp != nil }
    var isBriefed: Bool { stamp?.briefed ?? false }
    /// The last verdict counts only after the mandatory briefing was read.
    var countedVerdict: DecisionVerdict? {
        guard let stamp, stamp.briefed else { return nil }
        return stamp.verdict
    }
    var isSound: Bool { countedVerdict == .sound }
}

struct PassEvaluation: Equatable {
    var scope: ReportScope
    var lessons: [LessonEvaluation]

    var lessonCount: Int { lessons.count }
    var soundCount: Int { lessons.filter { $0.countedVerdict == .sound }.count }
    var unsoundCount: Int { lessons.filter { $0.countedVerdict == .unsound }.count }
    var incompleteCount: Int { lessons.filter { $0.countedVerdict == .incomplete }.count }
    var requiredSound: Int { PassPolicy.requiredSound(lessonCount: lessonCount) }
    var missingSound: Int { max(0, requiredSound - soundCount) }

    var unstamped: [Lesson] { lessons.filter { !$0.isStamped }.map(\.lesson) }
    var unbriefed: [Lesson] { lessons.filter { $0.isStamped && !$0.isBriefed }.map(\.lesson) }
    /// Stamped and briefed, but the last verdict is not TRAFNE.
    var belowThreshold: [Lesson] {
        lessons.filter { $0.countedVerdict != nil && $0.countedVerdict != .sound }.map(\.lesson)
    }

    var allStamped: Bool { unstamped.isEmpty }
    var allBriefed: Bool { unbriefed.isEmpty }
    var percentSound: Int { PassPolicy.percent(soundCount, of: lessonCount) }

    var passed: Bool {
        lessonCount > 0 && allStamped && allBriefed && PassPolicy.meetsThreshold(sound: soundCount, of: lessonCount)
    }

    /// Latest stamp date in scope. `nil` when every stamp is legacy (undated).
    var lastStampDate: Date? {
        lessons.compactMap { $0.stamp?.stampedAt }.max()
    }
}

enum PassPolicy {
    /// Share of TRAFNE verdicts required, in percent. Integer math so 12 → 11 and 24 → 22 exactly.
    static let thresholdPercent = 90

    static func meetsThreshold(sound: Int, of lessonCount: Int) -> Bool {
        guard lessonCount > 0 else { return false }
        return sound * 100 >= lessonCount * thresholdPercent
    }

    static func requiredSound(lessonCount: Int) -> Int {
        guard lessonCount > 0 else { return 0 }
        return (lessonCount * thresholdPercent + 99) / 100
    }

    static func percent(_ part: Int, of whole: Int) -> Int {
        guard whole > 0 else { return 0 }
        return Int((Double(part) / Double(whole) * 100).rounded())
    }

    static func evaluate(scope: ReportScope, lessons: [Lesson], stamps: [String: DocketStamp]) -> PassEvaluation {
        let scoped = scope.lessons(from: lessons)
        return PassEvaluation(
            scope: scope,
            lessons: scoped.map { LessonEvaluation(lesson: $0, stamp: stamps[$0.id]) }
        )
    }
}

// MARK: - Config

/// Free build defaults. Org builds (v3) will feed these from their own config.
struct ReportConfig: Equatable {
    var validityMonths: Int = 12
    var reminderLeadDays: Int = 30
    var language: AppLanguage = .polish
    var buildFlavor: String = "free"
    var contentVersion: String = ReportConfig.bundleContentVersion
    var trainingForm = Loc(pl: "e-learning / gra edukacyjna", en: "e-learning / educational game")
    var provider = "Colgante / \(Canon.domainReal)"

    static let free = ReportConfig()

    static var bundleContentVersion: String {
        let info = Bundle.main.infoDictionary ?? [:]
        let short = info["CFBundleShortVersionString"] as? String ?? "0"
        let build = info["CFBundleVersion"] as? String ?? "0"
        return "\(short)+\(build)"
    }
}

// MARK: - Report payload (shared by PDF, CSV and JSON)

enum ReportStatus: String, Codable {
    case completed = "UKONCZONO"
    case notCompleted = "NIEUKONCZONO"

    func label(_ language: AppLanguage) -> String {
        switch (self, language) {
        case (.completed, .polish): return "UKOŃCZONO"
        case (.completed, .english): return "COMPLETED"
        case (.notCompleted, .polish): return "NIEUKOŃCZONO"
        case (.notCompleted, .english): return "NOT COMPLETED"
        }
    }
}

struct ReportLesson: Codable, Equatable {
    var lessonId: String
    var order: Int
    var title: String
    var subtitle: String
    /// TRAFNE / BLEDNE / NIEPELNE as stable ASCII tokens; `nil` when not yet counted.
    var lastVerdict: String?
    var stampedAt: Date?
    var briefed: Bool
}

struct ReportSeason: Codable, Equatable {
    var seasonId: String
    var title: String
    var lessons: [ReportLesson]
}

struct ReportScopeDescriptor: Codable, Equatable {
    var kind: String
    var seasonIds: [String]
}

struct TrainingReport: Codable, Equatable {
    var schemaVersion = 1
    var reportId: UUID
    var issuedAt: Date
    var completedAt: Date
    var completionDate: String
    var validUntil: String
    var nextReminderAt: String
    var validityMonths: Int

    var employeeName: String
    var organization: String
    var trainingName: String
    var trainingForm: String
    var provider: String

    var status: ReportStatus
    var passed: Bool
    var thresholdPercent: Int
    var percentSound: Int
    var lessonCount: Int
    var soundCount: Int
    var unsoundCount: Int
    var incompleteCount: Int

    var language: String
    var contentVersion: String
    var lessonsPackHash: String
    var buildFlavor: String
    /// When true, organisation may be shown on public verify (never the employee name).
    var publishOrganization: Bool = false

    var scope: ReportScopeDescriptor
    var seasons: [ReportSeason]
    var disclaimer: String

    var appLanguage: AppLanguage { language == "en" ? .english : .polish }
    var allLessons: [ReportLesson] { seasons.flatMap(\.lessons) }

    /// `id | title` entries for CSV and the PDF topic list.
    var topicLines: [String] {
        allLessons.map { "\($0.lessonId) \($0.title)" }
    }
}

// MARK: - Builder

enum ReportBuilder {
    static func make(
        evaluation: PassEvaluation,
        allLessons: [Lesson],
        form: ReportForm,
        config: ReportConfig = .free,
        reportId: UUID = UUID(),
        now: Date = Date()
    ) -> TrainingReport {
        // Free v2: PL by default; EN only when the form flag is on (plan §12).
        let language: AppLanguage = form.diplomaEnglish ? .english : .polish
        let scopedLessons = evaluation.lessons.map(\.lesson)
        let completedAt = evaluation.lastStampDate ?? now
        let validUntil = ReportDates.adding(months: config.validityMonths, to: completedAt)
        let reminder = ReportDates.adding(days: -config.reminderLeadDays, to: validUntil)

        var seasons: [ReportSeason] = []
        for item in evaluation.lessons {
            let lesson = item.lesson
            let entry = ReportLesson(
                lessonId: lesson.id,
                order: lesson.order,
                title: lesson.title.t(language),
                subtitle: lesson.subtitle.t(language),
                lastVerdict: item.countedVerdict.map(ReportBuilder.token),
                stampedAt: item.stamp?.stampedAt,
                briefed: item.isBriefed
            )
            if let index = seasons.firstIndex(where: { $0.seasonId == lesson.seasonId }) {
                seasons[index].lessons.append(entry)
            } else {
                seasons.append(ReportSeason(seasonId: lesson.seasonId, title: lesson.seasonTitle.t(language), lessons: [entry]))
            }
        }

        let scopeDescriptor: ReportScopeDescriptor
        switch evaluation.scope {
        case .season(let seasonId): scopeDescriptor = ReportScopeDescriptor(kind: "season", seasonIds: [seasonId])
        case .pack: scopeDescriptor = ReportScopeDescriptor(kind: "pack", seasonIds: seasons.map(\.seasonId))
        }

        return TrainingReport(
            reportId: reportId,
            issuedAt: now,
            completedAt: completedAt,
            completionDate: ReportDates.day(completedAt),
            validUntil: ReportDates.day(validUntil),
            nextReminderAt: ReportDates.day(reminder),
            validityMonths: config.validityMonths,
            employeeName: form.employeeName.trimmingCharacters(in: .whitespacesAndNewlines),
            organization: form.organization.trimmingCharacters(in: .whitespacesAndNewlines),
            trainingName: "Czerwona Teczka — " + evaluation.scope.title(language, lessons: allLessons),
            trainingForm: config.trainingForm.t(language),
            provider: config.provider,
            status: evaluation.passed ? .completed : .notCompleted,
            passed: evaluation.passed,
            thresholdPercent: PassPolicy.thresholdPercent,
            percentSound: evaluation.percentSound,
            lessonCount: evaluation.lessonCount,
            soundCount: evaluation.soundCount,
            unsoundCount: evaluation.unsoundCount,
            incompleteCount: evaluation.incompleteCount,
            language: language == .english ? "en" : "pl",
            contentVersion: config.contentVersion,
            lessonsPackHash: ReportHash.lessonsPackHash(scopedLessons),
            buildFlavor: config.buildFlavor,
            publishOrganization: form.publishOrganizationOnVerify,
            scope: scopeDescriptor,
            seasons: seasons,
            disclaimer: disclaimer(language)
        )
    }

    static func token(_ verdict: DecisionVerdict) -> String {
        switch verdict {
        case .sound: return "TRAFNE"
        case .unsound: return "BLEDNE"
        case .incomplete: return "NIEPELNE"
        }
    }

    static func disclaimer(_ language: AppLanguage) -> String {
        Copy.s(
            language,
            pl: "Materiał edukacyjny. Kancelaria Colgante, postaci i sceny są fikcją. Dokument nie jest poradą prawną, nie zastępuje polityki bezpieczeństwa organizacji ani szkoleń stanowiskowych i nie jest urzędowym certyfikatem RODO/ISO.",
            en: "Educational material. Colgante, its people and scenes are fiction. This document is not legal advice, does not replace the organisation's security policy or role-specific training, and is not an official GDPR/ISO certificate."
        )
    }
}

// MARK: - Dates (Europe/Warsaw)

enum ReportDates {
    static let zone = TimeZone(identifier: "Europe/Warsaw") ?? .current

    static var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = zone
        return calendar
    }

    private static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = zone
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static func day(_ date: Date) -> String {
        dayFormatter.string(from: date)
    }

    static func iso8601(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = zone
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.string(from: date)
    }

    static func adding(months: Int, to date: Date) -> Date {
        calendar.date(byAdding: .month, value: months, to: date) ?? date
    }

    static func adding(days: Int, to date: Date) -> Date {
        calendar.date(byAdding: .day, value: days, to: date) ?? date
    }
}

// MARK: - Hash

enum ReportHash {
    static func sha256Hex(_ data: Data) -> String {
        SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
    }

    /// SHA-256 over the canonical JSON of the lessons actually covered by the report,
    /// in `order`. Any edit to a covered lesson changes the hash; other lessons do not.
    static func lessonsPackHash(_ lessons: [Lesson]) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        let sorted = lessons.sorted { $0.order < $1.order }
        let data = (try? encoder.encode(sorted)) ?? Data(sorted.map(\.id).joined(separator: "\n").utf8)
        return sha256Hex(data)
    }
}

// MARK: - CSV (plan §6.2)

enum ReportCSV {
    static let registerColumns = [
        "data_ukonczenia", "imie_i_nazwisko", "organizacja", "nazwa_szkolenia", "forma", "dostawca",
        "zakres_tematow", "status", "procent_trafne", "liczba_lekcji", "liczba_trafne", "liczba_bledne",
        "liczba_niepelne", "wazne_do", "nastepne_przypomnienie", "jezyk_dyplomu", "report_id",
        "content_version", "lessons_pack_hash", "build_flavor",
    ]
    static let lessonColumns = ["report_id", "lesson_id", "tytul", "werdykt", "data_stempel"]
    static let topicSeparator = " | "
    /// Byte order mark so Excel opens Polish diacritics correctly.
    static let bom = "\u{FEFF}"

    static func register(_ report: TrainingReport) -> String {
        let row: [String] = [
            report.completionDate,
            report.employeeName,
            report.organization,
            report.trainingName,
            report.trainingForm,
            report.provider,
            report.topicLines.joined(separator: topicSeparator),
            report.status.rawValue,
            String(report.percentSound),
            String(report.lessonCount),
            String(report.soundCount),
            String(report.unsoundCount),
            String(report.incompleteCount),
            report.validUntil,
            report.nextReminderAt,
            report.language,
            report.reportId.uuidString,
            report.contentVersion,
            report.lessonsPackHash,
            report.buildFlavor,
        ]
        return bom + lines([registerColumns, row])
    }

    /// Per-night verdicts for HR only — never printed on the diploma.
    static func lessons(_ report: TrainingReport) -> String {
        var rows = [lessonColumns]
        for lesson in report.allLessons {
            rows.append([
                report.reportId.uuidString,
                lesson.lessonId,
                lesson.title,
                lesson.lastVerdict ?? "",
                lesson.stampedAt.map(ReportDates.day) ?? "",
            ])
        }
        return bom + lines(rows)
    }

    static func lines(_ rows: [[String]]) -> String {
        rows.map { $0.map(escape).joined(separator: ",") }.joined(separator: "\n") + "\n"
    }

    static func escape(_ field: String) -> String {
        guard field.contains(where: { $0 == "," || $0 == "\"" || $0 == "\n" || $0 == "\r" }) else { return field }
        return "\"" + field.replacingOccurrences(of: "\"", with: "\"\"") + "\""
    }
}

// MARK: - JSON (plan §6.3)

enum ReportJSON {
    static func encode(_ report: TrainingReport) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(report)
    }

    static func decode(_ data: Data) throws -> TrainingReport {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(TrainingReport.self, from: data)
    }
}
