import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        ZStack(alignment: .bottom) {
            CroppedImage(name: "OfficeNight")
                .ignoresSafeArea()
            LinearGradient(
                colors: [Color.black.opacity(0.15), Color.black.opacity(0.55)],
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
            VStack(spacing: 14) {
                Text("CZERWONA TECZKA")
                    .font(Typeface.mono(16))
                    .foregroundStyle(Noir.blood)
                    .tracking(2)
                    .lineLimit(1)
                Text(Copy.s(store.language, pl: "The Red File", en: "Czerwona Teczka"))
                    .font(Typeface.display(36))
                    .foregroundStyle(Noir.void)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                Text(Canon.firm(store.language))
                    .font(Typeface.display(22))
                    .foregroundStyle(Noir.void)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
                Text(Canon.window(store.language))
                    .font(Typeface.body(20))
                    .foregroundStyle(Noir.ink)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
                Text(Canon.address(store.language))
                    .font(Typeface.mono(18))
                    .foregroundStyle(Noir.ink)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
                Text(Canon.fiction(store.language))
                    .font(Typeface.mono(18))
                    .foregroundStyle(Noir.ink)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(22)
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
