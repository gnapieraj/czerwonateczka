import Foundation
import SwiftUI
import UIKit

@MainActor
final class GameStore: ObservableObject {
    @Published var language: AppLanguage = .polish
    @Published var meters: Meters = .full
    @Published var campaignMeters: Bool = false
    @Published var route: Route = .splash
    @Published var lastOutcome: Outcome?
    @Published var stamps: [String: DocketStamp] = [:]
    @Published var streak: Int
    @Published var needsCoach: Bool
    @Published var loadError: String?
    @Published var seenBible: Bool
    @Published var seenHowToPlay: Bool
    private var stack: [Route] = []
    private let stampsKey = "docket.stamps"
    private let bibleKey = "docket.seenBible"
    private let howToPlayKey = "docket.seenHowToPlay"
    private let metersKey = "docket.meters"
    private let streakKey = "docket.streak"
    private let coachKey = "docket.needsCoach"

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
        } else if ProcessInfo.processInfo.arguments.contains("--bible") {
            self.route = .bible
        } else if ProcessInfo.processInfo.arguments.contains("--howto") {
            self.route = .howToPlay
        }
        seenBible = UserDefaults.standard.bool(forKey: bibleKey)
        seenHowToPlay = UserDefaults.standard.bool(forKey: howToPlayKey)
        stamps = Self.loadStamps(key: stampsKey)
        streak = UserDefaults.standard.integer(forKey: streakKey)
        needsCoach = UserDefaults.standard.bool(forKey: coachKey)
        if let data = UserDefaults.standard.data(forKey: metersKey),
           let saved = try? JSONDecoder().decode(Meters.self, from: data) {
            meters = saved
        }
        campaignMeters = true
    }

    var demoLessons: [Lesson] { lessons.filter(\.demo) }
    var allLessons: [Lesson] { lessons }
    var stackHasPrior: Bool { !stack.isEmpty }

    /// Seasons in first-seen order (continuous night numbering under each header).
    var seasonSections: [(id: String, title: Loc, lessons: [Lesson])] {
        var sections: [(id: String, title: Loc, lessons: [Lesson])] = []
        for lesson in lessons {
            if let index = sections.firstIndex(where: { $0.id == lesson.seasonId }) {
                sections[index].lessons.append(lesson)
            } else {
                sections.append((id: lesson.seasonId, title: lesson.seasonTitle, lessons: [lesson]))
            }
        }
        return sections
    }

    var nextNight: Lesson? {
        lessons.first { stamps[$0.id] == nil }
    }

    func isCurrentNight(_ lesson: Lesson) -> Bool {
        nextNight?.id == lesson.id
    }

    /// Current night, or an already stamped one (replay). Later nights stay locked.
    func canPlay(_ lesson: Lesson) -> Bool {
        if stamps[lesson.id] != nil { return true }
        return isCurrentNight(lesson)
    }

    func lesson(after lesson: Lesson) -> Lesson? {
        lessons.first { $0.order == lesson.order + 1 }
    }

    func start() {
        stack = []
        if !seenHowToPlay {
            route = .howToPlay
            return
        }
        if !seenBible {
            route = .bible
            return
        }
        route = .desk
    }

    func open(_ lesson: Lesson) {
        guard canPlay(lesson) else { return }
        stack = [.desk]
        route = .comic(lesson)
    }

    func finishCutscene(_ lesson: Lesson) {
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
        if choice.verdict == .sound {
            streak += 1
            needsCoach = false
        } else {
            streak = 0
            needsCoach = true
        }
        UserDefaults.standard.set(streak, forKey: streakKey)
        UserDefaults.standard.set(needsCoach, forKey: coachKey)
        if let data = try? JSONEncoder().encode(meters) {
            UserDefaults.standard.set(data, forKey: metersKey)
        }
        UINotificationFeedbackGenerator().notificationOccurred(
            choice.verdict == .sound ? .success : .warning
        )
        push(.verdict(outcome))
    }

    func finishVerdict(_ outcome: Outcome) {
        guard case .verdict = route else { return }
        route = .ratio(outcome)
    }

    /// After Ratio the firm briefing is required before the desk (or next night).
    func continueToBriefing(_ outcome: Outcome) {
        stack = [.desk]
        route = .awareness(outcome.lesson)
    }

    func finishBriefing() {
        stack = []
        route = .desk
    }

    func finishBriefingAndOpenNext(after lesson: Lesson) {
        stack = []
        if let next = self.lesson(after: lesson), canPlay(next) {
            open(next)
        } else {
            route = .desk
        }
    }

    func stamp(for lesson: Lesson) -> DocketStamp? {
        stamps[lesson.id]
    }

    func clearStamps() {
        stamps = [:]
        streak = 0
        needsCoach = false
        meters = .full
        persistStamps()
        UserDefaults.standard.set(0, forKey: streakKey)
        UserDefaults.standard.set(false, forKey: coachKey)
        if let data = try? JSONEncoder().encode(Meters.full) {
            UserDefaults.standard.set(data, forKey: metersKey)
        }
    }

    /// Full onboarding again: clears progress and returns to splash (for multi-user testing).
    func resetFirstLaunch() {
        clearStamps()
        lastOutcome = nil
        seenBible = false
        seenHowToPlay = false
        UserDefaults.standard.set(false, forKey: bibleKey)
        UserDefaults.standard.set(false, forKey: howToPlayKey)
        stack = []
        route = .splash
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
        if case .howToPlay = route {
            markHowToPlaySeen()
            if stack.isEmpty {
                continueOnboarding()
                return
            }
        }
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

    func markHowToPlaySeen() {
        seenHowToPlay = true
        UserDefaults.standard.set(true, forKey: howToPlayKey)
    }

    func dismissHowToPlay() {
        markHowToPlaySeen()
        if let previous = stack.popLast() {
            route = previous
        } else {
            continueOnboarding()
        }
    }

    /// After mandatory intro screens — never auto-open a night.
    private func continueOnboarding() {
        stack = []
        if !seenBible {
            route = .bible
        } else {
            route = .desk
        }
    }

    func backToDesk() {
        stack = []
        route = .desk
    }

    func openAwareness(_ lesson: Lesson, fromRatio: Bool = false) {
        guard canPlay(lesson) || fromRatio || stamps[lesson.id] != nil else { return }
        push(.awareness(lesson))
    }

    func closeAwareness() {
        // Mandatory path stacks only `.desk`; optional opens push the prior screen.
        if stack.count == 1, case .desk = stack.first {
            finishBriefing()
        } else {
            back()
        }
    }

    func openSources(for lesson: Lesson? = nil) {
        push(.sources(lesson?.sourceIds))
    }
    func openSettings() { push(.settings) }
    func openBible() { push(.bible) }
    func openHowToPlay() { push(.howToPlay) }

    private func push(_ next: Route) {
        if route != .splash {
            stack.append(route)
        }
        route = next
    }
}
