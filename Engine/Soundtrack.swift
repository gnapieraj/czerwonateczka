import AVFoundation
import SwiftUI

@MainActor
final class Soundtrack: ObservableObject {
    static let shared = Soundtrack()

    private let mutedKey = "docket.musicMuted"
    private var player: AVAudioPlayer?

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
        guard player == nil else {
            apply()
            return
        }
        guard let url = Bundle.main.url(forResource: "NightDocket", withExtension: "m4a") else { return }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)
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
        apply()
    }

    private func apply() {
        guard let player else { return }
        if isMuted {
            if player.isPlaying { player.pause() }
        } else if !player.isPlaying {
            player.play()
        }
    }
}
