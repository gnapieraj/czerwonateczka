import SwiftUI

struct RatioView: View {
    @EnvironmentObject private var store: GameStore
    let outcome: Outcome

    private var storyChrome: Bool { outcome.lesson.storyMode }

    var body: some View {
        ZStack {
            StageBackground()
            VStack(spacing: 0) {
                ScreenChrome(
                    title: "Ratio",
                    kicker: outcome.choice.verdict.label(store.language),
                    onBack: nil,
                    backCaption: nil
                ) { EmptyView() }

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                    InkPlate {
                        Text(outcome.lesson.title.t(store.language))
                            .font(Typeface.display(28))
                            .foregroundStyle(.white)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(Copy.s(store.language, pl: "TWÓJ RUCH", en: "YOUR MOVE"))
                            .font(Typeface.mono(16))
                            .foregroundStyle(Noir.blood)
                            .padding(.top, 8)
                        Text(outcome.choice.title.t(store.language))
                            .font(Typeface.body(22))
                            .foregroundStyle(verdictColor)
                            .lineSpacing(8)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 16)

                    if !storyChrome {
                        InkPlate {
                            MetersColumn(meters: outcome.meters, language: store.language)
                            Text(Copy.s(
                                store.language,
                                pl: "Wskaźniki są symulacją skutków scenariusza, nie oceną prawną ani prognozą odpowiedzialności.",
                                en: "Meters simulate scenario impact; they are neither a legal assessment nor a liability forecast."
                            ))
                            .font(Typeface.body(20))
                            .foregroundStyle(Noir.paper)
                            .lineSpacing(6)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 16)

                        ratioBlock(
                            kicker: Copy.s(store.language, pl: "PRZEPIS", en: "STATUTE"),
                            text: outcome.choice.ratio.statute.t(store.language)
                        )
                        ratioBlock(
                            kicker: Copy.s(store.language, pl: "SKUTEK", en: "CONSEQUENCE"),
                            text: outcome.choice.ratio.consequence.t(store.language)
                        )
                    }

                    ratioBlock(
                        kicker: Copy.s(store.language, pl: "REFLEKS", en: "REFLEX"),
                        text: outcome.choice.ratio.reflex.t(store.language)
                    )

                    if !storyChrome {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(Copy.s(store.language, pl: "WZORZEC PUBLICZNY", en: "PUBLIC PATTERN"))
                                .font(Typeface.mono(16))
                                .foregroundStyle(Noir.blood)
                                .tracking(1)
                            Text(outcome.choice.ratio.pattern.t(store.language))
                                .font(Typeface.body(22))
                                .foregroundStyle(.white)
                                .lineSpacing(8)
                                .fixedSize(horizontal: false, vertical: true)
                            if let story = outcome.choice.ratio.patternStory {
                                Text(Copy.s(store.language, pl: "CO SIĘ STAŁO", en: "WHAT HAPPENED"))
                                    .font(Typeface.mono(16))
                                    .foregroundStyle(Noir.paper)
                                    .tracking(1)
                                    .padding(.top, 6)
                                Text(story.t(store.language))
                                    .font(Typeface.body(22))
                                    .foregroundStyle(.white)
                                    .lineSpacing(8)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Noir.ink)
                        .overlay(Rectangle().stroke(Noir.blood, lineWidth: 1))
                        .padding(.horizontal, 16)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(Copy.s(
                            store.language,
                            pl: "CO POWINNO BYŁO ZAPALIĆ LAMPKĘ",
                            en: "WHAT SHOULD HAVE LIT UP"
                        ))
                        .font(Typeface.mono(16))
                        .foregroundStyle(Noir.blood)
                        .tracking(1)
                        ForEach(Array(outcome.lesson.redFlags.enumerated()), id: \.offset) { _, flag in
                            HStack(alignment: .top, spacing: 12) {
                                Text("▸")
                                    .font(Typeface.mono(18))
                                    .foregroundStyle(Noir.blood)
                                Text(flag.t(store.language))
                                    .font(Typeface.body(22))
                                    .foregroundStyle(.white)
                                    .lineSpacing(8)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Noir.ink)
                    .overlay(Rectangle().stroke(Noir.blood, lineWidth: 1))
                    .padding(.horizontal, 16)

                    Button {
                        store.continueToBriefing(outcome)
                    } label: {
                        HStack {
                            Image(systemName: "info.circle.fill")
                            Text(Copy.s(
                                store.language,
                                pl: "Dalej — briefing kancelaryjny",
                                en: "Next — firm briefing"
                            ))
                        }
                        .font(Typeface.mono(20))
                        .foregroundStyle(Noir.void)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .padding(.horizontal, 16)
                        .background(Noir.paper)
                    }
                    .buttonStyle(.plain)
                    .padding(16)
                    .padding(.bottom, 32)
                    }
                    .frame(maxWidth: 720)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                }
            }
        }
    }

    private var verdictColor: Color {
        switch outcome.choice.verdict {
        case .sound: return Noir.paper
        case .incomplete: return Noir.paperDim
        case .unsound: return Noir.blood
        }
    }

    private func ratioBlock(kicker: String, text: String, blood: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(kicker)
                .font(Typeface.mono(16))
                .foregroundStyle(blood ? Noir.blood : Noir.paper)
                .tracking(1)
            Text(text)
                .font(Typeface.body(22))
                .foregroundStyle(.white)
                .lineSpacing(8)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Noir.ink)
        .overlay(Rectangle().stroke(blood ? Noir.blood : Color.white.opacity(0.35), lineWidth: 1))
        .padding(.horizontal, 16)
    }
}
