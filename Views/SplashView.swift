import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        ZStack {
            Image("OfficeNight")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            LinearGradient(
                colors: [Color.black.opacity(0.2), Color.black.opacity(0.85)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing: 18) {
                Text("CZERWONA TECZKA")
                    .font(Typeface.mono(13))
                    .foregroundStyle(Noir.blood)
                    .tracking(4)
                Text(Copy.s(store.language, pl: "The Red File", en: "Czerwona Teczka"))
                    .font(Typeface.display(42))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                Text(Canon.firmPL)
                    .font(Typeface.display(22))
                    .foregroundStyle(Noir.paper)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                Text(Canon.fictionPL)
                    .font(Typeface.mono(11))
                    .foregroundStyle(Noir.mist)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                Text(Canon.windowPL)
                    .font(Typeface.body(15))
                    .foregroundStyle(Noir.paper)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                Text(Canon.addressPL)
                    .font(Typeface.mono(11))
                    .foregroundStyle(Noir.mist)
            }
            .padding()
        }
        .task {
            try? await Task.sleep(for: .milliseconds(1800))
            store.start()
        }
    }
}
