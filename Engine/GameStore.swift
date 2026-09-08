import Foundation
import SwiftUI

@MainActor
final class GameStore: ObservableObject {
    @Published var language: AppLanguage = .polish
    @Published var meters: Meters = .full
    @Published var campaignMeters: Bool = false
    @Published var route: Route = .splash
    @Published var lastOutcome: Outcome?
    @Published var loadError: String?

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
    }

    var demoLessons: [Lesson] { lessons.filter(\.demo) }
    var allLessons: [Lesson] { lessons }

    func start() {
        route = .desk
    }

    func open(_ lesson: Lesson) {
        if !campaignMeters {
            meters = .full
        }
        route = .play(lesson)
    }

    func choose(_ choice: Choice, in lesson: Lesson) {
        meters = meters.applying(choice.delta)
        let outcome = Outcome(lesson: lesson, choice: choice, meters: meters)
        lastOutcome = outcome
        route = .ratio(outcome)
    }

    func backToDesk() {
        route = .desk
    }

    func openSources() { route = .sources }
    func openSettings() { route = .settings }
    func openBible() { route = .bible }
}
