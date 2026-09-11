import Foundation
import SwiftUI

@MainActor
final class GameStore: ObservableObject {
    @Published var language: AppLanguage = .polish
    @Published var meters: Meters = .full
    @Published var campaignMeters: Bool = false
    @Published var route: Route = .splash
    @Published var lastOutcome: Outcome?
    @Published var stamps: [String: DocketStamp] = [:]
    @Published var loadError: String?
    @Published var seenBible: Bool
    private var stack: [Route] = []
    private let stampsKey = "docket.stamps"
    private let bibleKey = "docket.seenBible"

    let lessons: [Lesson]

    init(lessons: [Lesson]? = nil) {
        if let lessons {
            self.lessons = lessons
        } else {
            do {
                self.lessons = try LessonLoader.load()
            } catch {
                self.lessons = []
                self.loadError = String(describing: error)
            }
        }
        if let raw = ProcessInfo.processInfo.arguments.first(where: { $0.hasPrefix("--play=") }) {
            let id = String(raw.dropFirst("--play=".count))
            if let lesson = self.lessons.first(where: { $0.id == id }) {
                self.route = .play(lesson)
            }
        } else if let raw = ProcessInfo.processInfo.arguments.first(where: { $0.hasPrefix("--lesson=") }) {
            let id = String(raw.dropFirst("--lesson=".count))
            if let lesson = self.lessons.first(where: { $0.id == id }) {
                self.route = .comic(lesson)
            }
        } else if let raw = ProcessInfo.processInfo.arguments.first(where: { $0.hasPrefix("--awareness=") }) {
            let id = String(raw.dropFirst("--awareness=".count))
            if let lesson = self.lessons.first(where: { $0.id == id }) {
                self.route = .awareness(lesson)
            }
        } else if ProcessInfo.processInfo.arguments.contains("--desk") {
            self.route = .desk
        }
        seenBible = UserDefaults.standard.bool(forKey: "docket.seenBible")
        stamps = Self.loadStamps(key: stampsKey)
    }

    var demoLessons: [Lesson] { lessons.filter(\.demo) }
    var allLessons: [Lesson] { lessons }

    func start() {
        stack = []
        if seenBible {
            route = .desk
        } else {
            stack = [.desk]
            route = .bible
        }
    }

    func open(_ lesson: Lesson) {
        if !campaignMeters {
            meters = .full
        }
        stack = [.desk]
        route = .comic(lesson)
    }

    func openDossier(_ lesson: Lesson) {
        push(.play(lesson))
    }

    func choose(_ choice: Choice, in lesson: Lesson) {
        meters = meters.applying(choice.delta)
        let outcome = Outcome(lesson: lesson, choice: choice, meters: meters)
        lastOutcome = outcome
        stamps[lesson.id] = DocketStamp(
            lessonId: lesson.id,
            verdict: choice.verdict,
            kind: choice.kind
        )
        persistStamps()
        push(.ratio(outcome))
    }

    func stamp(for lesson: Lesson) -> DocketStamp? {
        stamps[lesson.id]
    }

    func clearStamps() {
        stamps = [:]
        persistStamps()
    }

    private func persistStamps() {
        let payload = Array(stamps.values)
        if let data = try? JSONEncoder().encode(payload) {
            UserDefaults.standard.set(data, forKey: stampsKey)
        }
    }

    private static func loadStamps(key: String) -> [String: DocketStamp] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let list = try? JSONDecoder().decode([DocketStamp].self, from: data)
        else { return [:] }
        return Dictionary(uniqueKeysWithValues: list.map { ($0.lessonId, $0) })
    }

    func back() {
        if case .bible = route {
            markBibleSeen()
        }
        if let previous = stack.popLast() {
            route = previous
        } else {
            route = .desk
        }
    }

    func markBibleSeen() {
        seenBible = true
        UserDefaults.standard.set(true, forKey: bibleKey)
    }

    func backToDesk() {
        stack = []
        route = .desk
    }

    func openAwareness(_ lesson: Lesson, fromRatio: Bool = false) {
        push(.awareness(lesson))
    }

    func closeAwareness() {
        back()
    }

    func openSources(for lesson: Lesson? = nil) {
        push(.sources(lesson?.sourceIds))
    }
    func openSettings() { push(.settings) }
    func openBible() { push(.bible) }

    private func push(_ next: Route) {
        if route != .splash {
            stack.append(route)
        }
        route = next
    }
}
