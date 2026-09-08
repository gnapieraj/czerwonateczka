import SwiftUI

struct MeterBar: View {
    let label: String
    let value: Int

    var body: some View {
        HStack(spacing: 10) {
            Text(label)
                .font(Typeface.mono(11))
                .foregroundStyle(Noir.paperDim)
                .frame(width: 118, alignment: .leading)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle().fill(Color.white.opacity(0.08))
                    Rectangle()
                        .fill(value < 45 ? Noir.blood : Noir.paper)
                        .frame(width: geo.size.width * CGFloat(value) / 100)
                }
            }
            .frame(height: 6)
            Text("\(value)")
                .font(Typeface.mono(11))
                .foregroundStyle(.white)
                .frame(width: 28, alignment: .trailing)
        }
    }
}

struct MetersColumn: View {
    let meters: Meters
    let language: AppLanguage

    var body: some View {
        VStack(spacing: 8) {
            MeterBar(label: Copy.s(language, pl: "Tajemnica", en: "Secrecy"), value: meters.tajemnica)
            MeterBar(label: Copy.s(language, pl: "Sąd", en: "Court"), value: meters.sad)
            MeterBar(label: Copy.s(language, pl: "Klient", en: "Client"), value: meters.klient)
            MeterBar(label: Copy.s(language, pl: "Rozliczalność", en: "Accountability"), value: meters.rozliczalnosc)
        }
    }
}

struct ChoiceKindLabel {
    static func title(_ kind: ChoiceKind, language: AppLanguage) -> String {
        switch kind {
        case .stamp: return Copy.s(language, pl: "STEMPEL", en: "STAMP")
        case .reject: return Copy.s(language, pl: "ODRZUT", en: "REJECT")
        case .verify: return Copy.s(language, pl: "DRUGI KANAŁ", en: "SECOND CHANNEL")
        }
    }
}

struct StampButton: View {
    let choice: Choice
    let language: AppLanguage
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 4) {
                Text(choice.title.t(language))
                    .font(Typeface.mono(13))
                    .tracking(1)
                Text(choice.subtitle.t(language))
                    .font(Typeface.body(14))
            }
            .foregroundStyle(choice.kind == .stamp ? Color.white : Noir.void)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .background(choice.kind == .stamp ? Noir.blood : Noir.paper)
        }
        .buttonStyle(.plain)
    }
}

struct PaperCard<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Noir.paper)
        .foregroundStyle(Noir.void)
        .overlay(Rectangle().stroke(Noir.blood.opacity(0.8), lineWidth: 2))
    }
}

struct ScreenChrome<Content: View>: View {
    let title: String
    var kicker: String = "CZERWONA TECZKA"
    var onBack: (() -> Void)? = nil
    var onTrailing: (() -> Void)? = nil
    var trailingSystemImage: String = "gearshape"
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                if let onBack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.white)
                            .frame(width: 36, height: 36)
                    }
                    .buttonStyle(.plain)
                } else {
                    Image(systemName: "building.columns")
                        .foregroundStyle(Noir.paper)
                }
                Spacer()
                if let onTrailing {
                    Button(action: onTrailing) {
                        Image(systemName: trailingSystemImage)
                            .foregroundStyle(Noir.paper)
                            .frame(width: 36, height: 36)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            Text(kicker)
                .font(Typeface.mono(11))
                .foregroundStyle(Noir.blood)
                .tracking(3)
                .padding(.horizontal, 16)
                .padding(.top, 8)
            Text(title)
                .font(Typeface.display(34))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            content
        }
    }
}
