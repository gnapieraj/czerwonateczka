import SwiftUI

struct InkPlate<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Noir.ink)
        .overlay(Rectangle().stroke(Color.white.opacity(0.28), lineWidth: 1))
    }
}

struct MeterBar: View {
    let label: String
    let value: Int

    var body: some View {
        HStack(spacing: 10) {
            Text(label)
                .font(Typeface.mono(11))
                .foregroundStyle(Noir.paper)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .frame(minWidth: 64, maxWidth: 118, alignment: .leading)
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
    var backCaption: String? = nil
    var onTrailing: (() -> Void)? = nil
    var trailingSystemImage: String = "gearshape"
    var onSecondTrailing: (() -> Void)? = nil
    var secondTrailingSystemImage: String = "person.3.sequence"
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                if let onBack {
                    Button(action: onBack) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.title3.weight(.semibold))
                            if let backCaption {
                                Text(backCaption)
                                    .font(Typeface.mono(13))
                            }
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .frame(minWidth: 44, minHeight: 44)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                } else {
                    Image(systemName: "building.columns")
                        .foregroundStyle(Noir.paper)
                        .frame(width: 44, height: 44)
                }
                Spacer()
                if let onSecondTrailing {
                    Button(action: onSecondTrailing) {
                        Image(systemName: secondTrailingSystemImage)
                            .foregroundStyle(Noir.paper)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
                if let onTrailing {
                    Button(action: onTrailing) {
                        Image(systemName: trailingSystemImage)
                            .foregroundStyle(Noir.paper)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 8)
            .background(Noir.ink)
            VStack(alignment: .leading, spacing: 4) {
                Text(kicker)
                    .font(Typeface.mono(11))
                    .foregroundStyle(Noir.blood)
                    .tracking(3)
                Text(title)
                    .font(Typeface.display(28))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.72)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Noir.ink)
            content
        }
    }
}
