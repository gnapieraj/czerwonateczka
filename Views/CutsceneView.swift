import AVKit
import Combine
import SwiftUI

@MainActor
final class CutscenePlayerModel: ObservableObject {
    @Published var player: AVPlayer?
    @Published var didFinish = false
    private(set) var advanced = false

    private var endTask: Task<Void, Never>?

    func load(resource: String) {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "mp4") else {
            didFinish = true
            return
        }
        let item = AVPlayerItem(url: url)
        let av = AVPlayer(playerItem: item)
        av.isMuted = true
        player = av
        endTask?.cancel()
        endTask = Task { [weak self] in
            let notes = NotificationCenter.default.notifications(
                named: .AVPlayerItemDidPlayToEndTime,
                object: item
            )
            for await _ in notes {
                self?.didFinish = true
                break
            }
        }
        av.play()
    }

    func stop() {
        endTask?.cancel()
        endTask = nil
        player?.pause()
        player = nil
    }

    func markAdvanced() -> Bool {
        guard !advanced else { return false }
        advanced = true
        stop()
        return true
    }

}

struct CutsceneView: View {
    @EnvironmentObject private var store: GameStore
    @EnvironmentObject private var soundtrack: Soundtrack
    let lesson: Lesson

    @StateObject private var playback = CutscenePlayerModel()

    var body: some View {
        ZStack {
            Noir.void.ignoresSafeArea()
            if let player = playback.player {
                VideoPlayer(player: player)
                    .disabled(true)
                    .ignoresSafeArea()
            } else {
                ProgressView()
                    .tint(Noir.paper)
            }

            VStack {
                Spacer()
                HStack {
                    Button {
                        finish()
                    } label: {
                        Text(Copy.s(store.language, pl: "Pomiń", en: "Skip"))
                            .font(Typeface.mono(20))
                            .foregroundStyle(Noir.paper)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Noir.ink.opacity(0.85))
                            .overlay(Rectangle().stroke(Noir.paperDim, lineWidth: 1))
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button {
                        finish()
                    } label: {
                        Text(Copy.s(store.language, pl: "Dalej", en: "Continue"))
                            .font(Typeface.mono(20))
                            .foregroundStyle(Noir.void)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Noir.paper)
                    }
                    .buttonStyle(.plain)
                }
                .padding(20)
            }
        }
        .onAppear {
            soundtrack.pauseForBackground()
            if let name = lesson.introVideo {
                playback.load(resource: name)
            } else {
                finish()
            }
        }
        .onChange(of: playback.didFinish) { _, finished in
            if finished { finish() }
        }
        .onDisappear {
            playback.stop()
            soundtrack.resumeIfNeeded()
        }
    }

    private func finish() {
        guard playback.markAdvanced() else { return }
        soundtrack.resumeIfNeeded()
        store.finishCutscene(lesson)
    }
}
