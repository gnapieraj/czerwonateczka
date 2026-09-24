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
                    onBack: { store.closeAwareness() },
                    backCaption: Copy.s(store.language, pl: "Wstecz", en: "Back")
                ) { EmptyView() }

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                    InkPlate {
                        HStack(alignment: .top, spacing: 12) {
                            CroppedImage(name: lesson.hero)
                                .frame(width: 64, height: 86)
                                .overlay(Rectangle().stroke(Noir.blood, lineWidth: 2))
                            VStack(alignment: .leading, spacing: 6) {
                                Text(String(format: "%02d", lesson.order))
                                    .font(Typeface.mono(16))
                                    .foregroundStyle(Noir.paperDim)
                                Text(lesson.title.t(store.language))
                                    .font(Typeface.display(26))
                                    .foregroundStyle(.white)
                                    .lineSpacing(4)
                                    .lineLimit(3)
                                    .minimumScaleFactor(0.9)
                                    .fixedSize(horizontal: false, vertical: true)
                                Text(lesson.subtitle.t(store.language))
                                    .font(Typeface.mono(16))
                                    .foregroundStyle(Noir.paper)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    .padding(.horizontal, 16)

                    section(
                        kicker: Copy.s(store.language, pl: "JAK TO DZIAŁA", en: "HOW IT WORKS"),
                        text: lesson.awareness.threat.t(store.language),
                        blood: true
                    )

                    VStack(alignment: .leading, spacing: 8) {
                        Text(Copy.s(store.language, pl: "NA CO ZWRACAĆ UWAGĘ", en: "WATCH FOR"))
                            .font(Typeface.mono(16))
                            .foregroundStyle(Noir.blood)
                            .tracking(1)
                        ForEach(Array(lesson.awareness.watchFor.enumerated()), id: \.offset) { _, item in
                            HStack(alignment: .top, spacing: 10) {
                                Text("▸")
                                    .font(Typeface.mono(18))
                                    .foregroundStyle(Noir.blood)
                                Text(item.t(store.language))
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

                    if store.lesson(after: lesson) != nil {
                        Button {
                            store.finishBriefingAndOpenNext(after: lesson)
                        } label: {
                            Text(Copy.s(store.language, pl: "Następna noc", en: "Next night"))
                                .font(Typeface.mono(20))
                                .foregroundStyle(Noir.void)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .padding(.horizontal, 16)
                                .background(Noir.paper)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 16)
                    }

                    Button {
                        store.finishBriefing()
                    } label: {
                        Text(Copy.s(
                            store.language,
                            pl: "Zrozumiano — na wokandę",
                            en: "Understood — to the docket"
                        ))
                            .font(Typeface.mono(20))
                            .foregroundStyle(Noir.void)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .padding(.horizontal, 16)
                            .background(Noir.blood)
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
