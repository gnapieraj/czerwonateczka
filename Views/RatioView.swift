import SwiftUI

struct RatioView: View {
    @EnvironmentObject private var store: GameStore
    let outcome: Outcome

    var body: some View {
        ZStack {
            StageBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenChrome(
                        title: "Ratio",
                        kicker: outcome.choice.pass
                            ? Copy.s(store.language, pl: "UTRZYMANO", en: "HELD")
                            : Copy.s(store.language, pl: "UCHYLONO", en: "QUASHED"),
                        onBack: { store.backToDesk() }
                    ) { EmptyView() }

                    Text(outcome.lesson.title.t(store.language))
                        .font(Typeface.display(24))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)

                    Text(outcome.choice.title.t(store.language) + " — " + outcome.choice.subtitle.t(store.language))
                        .font(Typeface.mono(13))
                        .foregroundStyle(outcome.choice.pass ? Noir.paper : Noir.blood)
                        .padding(.horizontal, 16)

                    MetersColumn(meters: outcome.meters, language: store.language)
                        .padding(.horizontal, 16)

                    ratioBlock(
                        kicker: Copy.s(store.language, pl: "PRZEPIS", en: "STATUTE"),
                        text: outcome.choice.ratio.statute.t(store.language)
                    )
                    ratioBlock(
                        kicker: Copy.s(store.language, pl: "SKUTEK", en: "CONSEQUENCE"),
                        text: outcome.choice.ratio.consequence.t(store.language)
                    )
                    ratioBlock(
                        kicker: Copy.s(store.language, pl: "REFLEKS", en: "REFLEX"),
                        text: outcome.choice.ratio.reflex.t(store.language)
                    )
                    ratioBlock(
                        kicker: Copy.s(store.language, pl: "WZORZEC PUBLICZNY", en: "PUBLIC PATTERN"),
                        text: outcome.choice.ratio.pattern.t(store.language),
                        blood: true
                    )

                    Button {
                        store.backToDesk()
                    } label: {
                        Text(Copy.s(store.language, pl: "Wróć do biurka", en: "Back to the desk"))
                            .font(Typeface.mono(14))
                            .foregroundStyle(Noir.void)
                            .frame(maxWidth: .infinity)
                            .padding(14)
                            .background(Noir.paper)
                    }
                    .buttonStyle(.plain)
                    .padding(16)
                    .padding(.bottom, 32)
                }
                .frame(maxWidth: 720)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private func ratioBlock(kicker: String, text: String, blood: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(kicker)
                .font(Typeface.mono(11))
                .foregroundStyle(blood ? Noir.blood : Noir.paperDim)
                .tracking(1)
            Text(text)
                .font(Typeface.body(16))
                .foregroundStyle(.white)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.55))
        .overlay(Rectangle().stroke(blood ? Noir.blood : Color.white.opacity(0.25), lineWidth: 1))
        .padding(.horizontal, 16)
    }
}
