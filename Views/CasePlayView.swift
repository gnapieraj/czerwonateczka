import SwiftUI

struct CasePlayView: View {
    @EnvironmentObject private var store: GameStore
    @Environment(\.horizontalSizeClass) private var horizontal
    let lesson: Lesson

    var body: some View {
        ZStack {
            Noir.void.ignoresSafeArea()
            VStack(spacing: 0) {
                ScreenChrome(
                    title: lesson.title.t(store.language),
                    onBack: { store.back() },
                    backCaption: Copy.s(store.language, pl: "Wstecz", en: "Back")
                ) { EmptyView() }

                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {

                    HStack(spacing: 10) {
                        if lesson.tone == .probono {
                            Text("PRO BONO")
                                .font(Typeface.mono(10))
                                .foregroundStyle(Noir.paper)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 5)
                                .background(Noir.blood)
                        }
                        Text(lesson.subtitle.t(store.language))
                            .font(Typeface.mono(12))
                            .foregroundStyle(Noir.paper)
                    }
                    .padding(.horizontal, 16)

                    InkPlate {
                        Text(lesson.deadline.t(store.language))
                            .font(Typeface.mono(13))
                            .foregroundStyle(Noir.blood)
                        Text(lesson.context.t(store.language))
                            .font(Typeface.body(16))
                            .foregroundStyle(Noir.paper)
                    }
                    .padding(.horizontal, 16)

                    PaperCard {
                        Text(lesson.exhibitLabel.t(store.language))
                            .font(Typeface.mono(11))
                            .foregroundStyle(Noir.blood)
                        Text(lesson.exhibitText.t(store.language))
                            .font(Typeface.mono(14))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 16)

                    InkPlate {
                        Text(Copy.s(store.language, pl: "GŁOS WEWNĘTRZNY", en: "INNER VOICE"))
                            .font(Typeface.mono(11))
                            .foregroundStyle(Noir.blood)
                            .tracking(1)
                        Text(lesson.innerVoice.t(store.language))
                            .font(Typeface.body(16))
                            .foregroundStyle(Noir.paper)
                    }
                    .padding(.horizontal, 16)

                    actions
                        .padding(.horizontal, 16)
                        .padding(.bottom, 36)
                    }
                    .frame(maxWidth: 720)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 14)
                }
            }
        }
    }

    @ViewBuilder
    private var actions: some View {
        let buttons = ForEach(lesson.choices) { choice in
            StampButton(choice: choice, language: store.language) {
                store.choose(choice, in: lesson)
            }
        }
        if horizontal == .compact {
            VStack(spacing: 8) { buttons }
        } else {
            HStack(alignment: .top, spacing: 8) { buttons }
        }
    }
}
