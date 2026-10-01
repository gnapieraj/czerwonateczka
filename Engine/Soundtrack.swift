import AVFoundation
import SwiftUI

@MainActor
final class Soundtrack: ObservableObject {
    static let shared = Soundtrack()

    private let mutedKey = "docket.musicMuted"
    private var player: AVAudioPlayer?
    private var preparing = false
    private var sessionObservers: [NSObjectProtocol] = []

    @Published var isMuted: Bool {
        didSet {
            UserDefaults.standard.set(isMuted, forKey: mutedKey)
            apply()
        }
    }

    private init() {
        isMuted = UserDefaults.standard.bool(forKey: mutedKey)
    }

    func prepare() {
        guard ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil else { return }
        watchSession()
        guard player == nil, !preparing else {
            apply()
            return
        }
        guard let url = Bundle.main.url(forResource: "NightDocket", withExtension: "m4a") else { return }
        do {
            let session = AVAudioSession.sharedInstance()
            // Ambient follows the Ring/Silent switch, so a silenced phone stays quiet.
            try session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            preparing = true
            if #available(iOS 27.0, *) {
                session.activate(options: []) { activated, _ in
                    Task { @MainActor in
                        Soundtrack.shared.finishActivation(activated: activated, url: url)
                    }
                }
            } else {
                try session.setActive(true)
                finishActivation(activated: true, url: url)
            }
        } catch {
            preparing = false
            player = nil
        }
    }

    private func finishActivation(activated: Bool, url: URL) {
        preparing = false
        guard activated, player == nil else { return }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.volume = 0.26
            player.prepareToPlay()
            self.player = player
            apply()
        } catch {
            self.player = nil
        }
    }

    func toggleMuted() {
        isMuted.toggle()
    }

    func pauseForBackground() {
        player?.pause()
    }

    func resumeIfNeeded() {
        let session = AVAudioSession.sharedInstance()
        if #available(iOS 27.0, *) {
            session.activate(options: []) { _, _ in
                Task { @MainActor in
                    Soundtrack.shared.apply()
                }
            }
        } else {
            try? session.setActive(true)
            apply()
        }
    }

    private func apply() {
        guard let player else { return }
        if isMuted {
            if player.isPlaying { player.pause() }
        } else if !player.isPlaying {
            player.play()
        }
    }

    /// iOS 27 retires the old interruption notification. The player no longer resumes by itself.
    private func watchSession() {
        guard sessionObservers.isEmpty, #available(iOS 27.0, *) else { return }
        let center = NotificationCenter.default
        let resume = center.addObserver(
            forName: AVAudioSession.resumptionRecommendationNotification,
            object: nil,
            queue: .main
        ) { note in
            guard
                let context = note.userInfo?[AVAudioSession.resumptionContextKey] as? AVAudioSession.ResumptionContext,
                context.recommendation == .shouldResume
            else { return }
            Task { @MainActor in
                Soundtrack.shared.resumeIfNeeded()
            }
        }
        let active = center.addObserver(
            forName: AVAudioSession.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { _ in
            Task { @MainActor in
                Soundtrack.shared.apply()
            }
        }
        sessionObservers = [resume, active]
    }
}
