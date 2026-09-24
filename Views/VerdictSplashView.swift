import SwiftUI

struct VerdictSplashView: View {
    @EnvironmentObject private var store: GameStore
    let outcome: Outcome

    @State private var stamped = false
    @State private var advanceTask: Task<Void, Never>?

    var body: some View {
        ZStack {
            Noir.void.ignoresSafeArea()
            VStack(spacing: 28) {
                Spacer()
                Text(outcome.choice.verdict.label(store.language))
                    .font(Typeface.display(48))
                    .foregroundStyle(stampColor)
                    .tracking(4)
                    .scaleEffect(stamped ? 1 : 1.35)
                    .opacity(stamped ? 1 : 0)
                    .rotationEffect(.degrees(stamped ? -6 : 12))
                Text(outcome.choice.subtitle.t(store.language))
                    .font(Typeface.body(22))
                    .foregroundStyle(Noir.paper)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 28)
                    .opacity(stamped ? 1 : 0)
                Spacer()
                Text(Copy.s(store.language, pl: "Dotknij, żeby iść dalej", en: "Tap to continue"))
                    .font(Typeface.mono(16))
                    .foregroundStyle(Noir.paperDim)
                    .opacity(stamped ? 1 : 0)
                    .padding(.bottom, 36)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture { advance() }
        .onAppear {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.62)) {
                stamped = true
            }
            advanceTask = Task { @MainActor in
                try? await Task.sleep(nanoseconds: 4_600_000_000)
                guard !Task.isCancelled else { return }
                advance()
            }
        }
        .onDisappear {
            advanceTask?.cancel()
            advanceTask = nil
        }
    }

    private func advance() {
        advanceTask?.cancel()
        advanceTask = nil
        store.finishVerdict(outcome)
    }

    private var stampColor: Color {
        switch outcome.choice.verdict {
        case .sound: return Noir.paper
        case .incomplete: return Noir.paperDim
        case .unsound: return Noir.blood
        }
    }
}
