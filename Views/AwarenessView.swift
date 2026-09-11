import SwiftUI

struct AwarenessView: View {
    @EnvironmentObject private var store: GameStore
    let lesson: Lesson

    var body: some View {
        ZStack {
            StageBackground(image: lesson.hero, dim: 0.88)
            VStack(spacing: 0) {
                ScreenChrome(
                    title: Copy.s(store.language, pl: "Briefing kancelaryjny", en: "Firm briefing"),
                    kicker: Copy.s(store.language, pl: "AWARENESS", en: "AWARENESS"),
                    onBack: { store.back() },
                    backCaption: Copy.s(store.language, pl: "Wstecz", en: "Back")
                ) { EmptyView() }

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                    InkPlate {
                        HStack(alignment: .top, spacing: 12) {
                            Image(lesson.hero)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 86)
                                .clipped()
                                .overlay(Rectangle().stroke(Noir.blood, lineWidth: 2))
                            VStack(alignment: .leading, spacing: 6) {
                                Text(String(format: "%02d", lesson.order))
                                    .font(Typeface.mono(11))
                                    .foregroundStyle(Noir.paperDim)
                                Text(lesson.title.t(store.language))
                                    .font(Typeface.display(24))
                                    .foregroundStyle(.white)
                                Text(lesson.subtitle.t(store.language))
                                    .font(Typeface.mono(12))
                                    .foregroundStyle(Noir.paper)
                            }
                        }
                    }
                    .padding(.horizontal, 16)

                    section(
                        kicker: Copy.s(store.language, pl: "ZAGROŻENIE", en: "THREAT"),
                        text: lesson.awareness.threat.t(store.language),
                        blood: true
                    )

                    VStack(alignment: .leading, spacing: 8) {
                        Text(Copy.s(store.language, pl: "NA CO ZWRACAĆ UWAGĘ", en: "WATCH FOR"))
                            .font(Typeface.mono(11))
                            .foregroundStyle(Noir.blood)
                            .tracking(1)
                        ForEach(Array(lesson.awareness.watchFor.enumerated()), id: \.offset) { _, item in
                            HStack(alignment: .top, spacing: 10) {
                                Text("▸")
                                    .font(Typeface.mono(13))
                                    .foregroundStyle(Noir.blood)
                                Text(item.t(store.language))
                                    .font(Typeface.body(16))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Noir.ink)
                    .overlay(Rectangle().stroke(Noir.blood.opacity(0.7), lineWidth: 1))
                    .padding(.horizontal, 16)

                    section(
                        kicker: Copy.s(store.language, pl: "JAK MINIMALIZOWAĆ", en: "HOW TO REDUCE IT"),
                        text: lesson.awareness.minimize.t(store.language)
                    )

                    section(
                        kicker: Copy.s(store.language, pl: "W KANCELARII — PRAKTYKA", en: "IN THE FIRM — PRACTICE"),
                        text: lesson.awareness.practice.t(store.language)
                    )

                    Button {
                        store.closeAwareness()
                    } label: {
                        Text(Copy.s(store.language, pl: "Zamknij briefing", en: "Close briefing"))
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

    private func section(kicker: String, text: String, blood: Bool = false) -> some View {
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
