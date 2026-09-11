import SwiftUI

struct RootView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        ZStack {
            Noir.void.ignoresSafeArea()
            switch store.route {
            case .splash:
                SplashView()
            case .desk:
                DeskView()
            case .comic(let lesson):
                ComicIntroView(lesson: lesson)
            case .play(let lesson):
                CasePlayView(lesson: lesson)
            case .ratio(let outcome):
                RatioView(outcome: outcome)
            case .awareness(let lesson):
                AwarenessView(lesson: lesson)
            case .sources(let sourceIds):
                SourcesView(sourceIds: sourceIds)
            case .settings:
                SettingsView()
            case .bible:
                VisualBibleView()
            }
        }
        .tint(Noir.blood)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
    }
}
