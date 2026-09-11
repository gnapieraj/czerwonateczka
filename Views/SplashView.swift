import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        ZStack(alignment: .bottom) {
            Image("OfficeNight")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .clipped()
            LinearGradient(
                colors: [Color.black.opacity(0.15), Color.black.opacity(0.55)],
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
            VStack(spacing: 10) {
                Text("CZERWONA TECZKA")
                    .font(Typeface.mono(13))
                    .foregroundStyle(Noir.blood)
                    .tracking(4)
                Text(Copy.s(store.language, pl: "The Red File", en: "Czerwona Teczka"))
                    .font(Typeface.display(36))
                    .foregroundStyle(Noir.void)
                    .multilineTextAlignment(.center)
                Text(Canon.firm(store.language))
                    .font(Typeface.display(20))
                    .foregroundStyle(Noir.void)
                    .multilineTextAlignment(.center)
                Text(Canon.window(store.language))
                    .font(Typeface.body(15))
                    .foregroundStyle(Noir.ink)
                    .multilineTextAlignment(.center)
                Text(Canon.address(store.language))
                    .font(Typeface.mono(11))
                    .foregroundStyle(Noir.ink.opacity(0.8))
                    .multilineTextAlignment(.center)
                Text(Canon.fiction(store.language))
                    .font(Typeface.mono(11))
                    .foregroundStyle(Noir.ink.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Noir.paper)
            .overlay(Rectangle().stroke(Noir.blood, lineWidth: 2))
            .padding(.horizontal, 20)
            .padding(.bottom, 28)
        }
        .contentShape(Rectangle())
        .onTapGesture { store.start() }
        .task {
            try? await Task.sleep(for: .seconds(7))
            if store.route == .splash {
                store.start()
            }
        }
    }
}
