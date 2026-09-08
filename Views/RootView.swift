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
            case .play(let lesson):
                CasePlayView(lesson: lesson)
            case .ratio(let outcome):
                RatioView(outcome: outcome)
            case .sources:
                SourcesView()
            case .settings:
                SettingsView()
            case .bible:
                VisualBibleView()
            }
        }
        .tint(Noir.blood)
    }
}
