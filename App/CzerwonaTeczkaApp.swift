import SwiftUI

@main
@MainActor
struct CzerwonaTeczkaApp: App {
    @StateObject private var store = GameStore()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .environmentObject(Soundtrack.shared)
                .preferredColorScheme(.dark)
                .onAppear { Soundtrack.shared.prepare() }
                .onChange(of: scenePhase) { _, phase in
                    switch phase {
                    case .active:
                        Soundtrack.shared.resumeIfNeeded()
                    case .inactive, .background:
                        Soundtrack.shared.pauseForBackground()
                    @unknown default:
                        break
                    }
                }
        }
    }
}
