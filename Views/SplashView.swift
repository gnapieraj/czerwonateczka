import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        GeometryReader { geo in
            let wide = geo.size.width > geo.size.height + 80
            ZStack {
                Noir.void.ignoresSafeArea()
                Group {
                    if wide {
                        landscape(in: geo.size)
                    } else {
                        portrait(in: geo.size)
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
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

    private func portrait(in size: CGSize) -> some View {
        let width = size.width - 36
        return VStack(spacing: 0) {
            plate.frame(width: width, height: width * 9 / 16)
            titleBlock
                .frame(width: width)
                .background(Noir.paper)
        }
        .overlay(Rectangle().stroke(Noir.blood, lineWidth: 2))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func landscape(in size: CGSize) -> some View {
        let inset: CGFloat = 28
        let availH = size.height - inset * 2
        let availW = size.width - inset * 2
        let plateWidth = min(availW * 0.58, availH * 16 / 9)
        let plateHeight = plateWidth * 9 / 16
        return HStack(alignment: .center, spacing: 0) {
            plate.frame(width: plateWidth, height: plateHeight)
            titleBlock
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .frame(height: plateHeight)
                .background(Noir.paper)
        }
        .overlay(Rectangle().stroke(Noir.blood, lineWidth: 2))
        .padding(inset)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var plate: some View {
        Color.clear
            .overlay {
                Image("Gabinet")
                    .resizable()
                    .scaledToFill()
            }
            .clipped()
    }

    private var titleBlock: some View {
        VStack(spacing: 12) {
            Text("CZERWONA TECZKA")
                .font(Typeface.mono(16))
                .foregroundStyle(Noir.blood)
                .tracking(2)
                .lineLimit(1)
            Text(Copy.s(store.language, pl: "The Red File", en: "Czerwona Teczka"))
                .font(Typeface.display(34))
                .foregroundStyle(Noir.void)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
            Text(Canon.firm(store.language))
                .font(Typeface.display(22))
                .foregroundStyle(Noir.void)
                .multilineTextAlignment(.center)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
            Text(Canon.window(store.language))
                .font(Typeface.body(18))
                .foregroundStyle(Noir.ink)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            Text(Canon.address(store.language))
                .font(Typeface.mono(16))
                .foregroundStyle(Noir.ink)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
            Text(Canon.fiction(store.language))
                .font(Typeface.mono(15))
                .foregroundStyle(Noir.ink)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
    }
}
