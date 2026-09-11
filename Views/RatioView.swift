import SwiftUI

struct RatioView: View {
    @EnvironmentObject private var store: GameStore
    let outcome: Outcome

    var body: some View {
        ZStack {
            StageBackground()
            VStack(spacing: 0) {
                ScreenChrome(
                    title: "Ratio",
                    kicker: outcome.choice.verdict.label(store.language),
                    onBack: { store.back() },
                    backCaption: Copy.s(store.language, pl: "Wstecz", en: "Back"),
                    onTrailing: { store.openAwareness(outcome.lesson, fromRatio: true) },
                    trailingSystemImage: "info.circle"
                ) { EmptyView() }

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                    InkPlate {
                        Text(outcome.lesson.title.t(store.language))
                            .font(Typeface.display(24))
                            .foregroundStyle(.white)
                        Text(outcome.choice.title.t(store.language) + " — " + outcome.choice.subtitle.t(store.language))
                            .font(Typeface.mono(13))
                            .foregroundStyle(verdictColor)
                    }
                    .padding(.horizontal, 16)

                    InkPlate {
                        MetersColumn(meters: outcome.meters, language: store.language)
                        Text(Copy.s(
                            store.language,
                            pl: "Wskaźniki są symulacją skutków scenariusza, nie oceną prawną ani prognozą odpowiedzialności.",
                            en: "Meters simulate scenario impact; they are neither a legal assessment nor a liability forecast."
                        ))
                        .font(Typeface.body(12))
                        .foregroundStyle(Noir.mist)
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
                    ratioBlock(
                        kicker: Copy.s(store.language, pl: "REFLEKS", en: "REFLEX"),
                        text: outcome.choice.ratio.reflex.t(store.language)
                    )
                    VStack(alignment: .leading, spacing: 10) {
                        Text(Copy.s(store.language, pl: "WZORZEC PUBLICZNY", en: "PUBLIC PATTERN"))
                            .font(Typeface.mono(11))
                            .foregroundStyle(Noir.blood)
                            .tracking(1)
                        Text(outcome.choice.ratio.pattern.t(store.language))
                            .font(Typeface.body(16))
                            .foregroundStyle(.white)
                        if let story = outcome.choice.ratio.patternStory {
                            Text(Copy.s(store.language, pl: "CO SIĘ STAŁO", en: "WHAT HAPPENED"))
                                .font(Typeface.mono(11))
                                .foregroundStyle(Noir.paper)
                                .tracking(1)
                                .padding(.top, 6)
                            Text(story.t(store.language))
                                .font(Typeface.body(16))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Noir.ink)
                    .overlay(Rectangle().stroke(Noir.blood, lineWidth: 1))
                    .padding(.horizontal, 16)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(Copy.s(
                            store.language,
                            pl: "CO POWINNO BYŁO ZAPALIĆ LAMPKĘ",
                            en: "WHAT SHOULD HAVE LIT UP"
                        ))
                        .font(Typeface.mono(11))
                        .foregroundStyle(Noir.blood)
                        .tracking(1)
                        ForEach(Array(outcome.lesson.redFlags.enumerated()), id: \.offset) { _, flag in
                            HStack(alignment: .top, spacing: 10) {
                                Text("▸")
                                    .font(Typeface.mono(13))
                                    .foregroundStyle(Noir.blood)
                                Text(flag.t(store.language))
                                    .font(Typeface.body(16))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Noir.ink)
                    .overlay(Rectangle().stroke(Noir.blood, lineWidth: 1))
                    .padding(.horizontal, 16)

                    Button {
                        store.openAwareness(outcome.lesson, fromRatio: true)
                    } label: {
                        HStack {
                            Image(systemName: "info.circle.fill")
                            Text(Copy.s(
                                store.language,
                                pl: "Briefing — zagrożenie i praktyka",
                                en: "Briefing — threat and practice"
                            ))
                        }
                        .font(Typeface.mono(14))
                        .foregroundStyle(Noir.paper)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(Noir.ink)
                        .overlay(Rectangle().stroke(Noir.blood, lineWidth: 2))
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 16)

                    Button {
                        store.openSources(for: outcome.lesson)
                    } label: {
                        HStack {
                            Image(systemName: "books.vertical")
                            Text(Copy.s(
                                store.language,
                                pl: "Źródła tej teczki",
                                en: "Sources for this file"
                            ))
                        }
                        .font(Typeface.mono(14))
                        .foregroundStyle(Noir.paper)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(Noir.ink)
                        .overlay(Rectangle().stroke(Color.white.opacity(0.35), lineWidth: 1))
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 16)

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
                .font(Typeface.mono(11))
                .foregroundStyle(blood ? Noir.blood : Noir.paper)
                .tracking(1)
            Text(text)
                .font(Typeface.body(16))
                .foregroundStyle(.white)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Noir.ink)
        .overlay(Rectangle().stroke(blood ? Noir.blood : Color.white.opacity(0.35), lineWidth: 1))
        .padding(.horizontal, 16)
    }
}
