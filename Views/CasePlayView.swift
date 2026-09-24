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

                if lesson.storyMode {
                    storyBody
                } else {
                    classicBody
                }
            }
        }
    }

    private var classicBody: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                headerRow
                    .padding(.horizontal, 16)

                InkPlate {
                    Text(lesson.deadline.t(store.language))
                        .font(Typeface.mono(18))
                        .foregroundStyle(Noir.blood)
                    Text(lesson.context.t(store.language))
                        .font(Typeface.body(22))
                        .foregroundStyle(Noir.paper)
                        .lineSpacing(8)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 16)

                PaperCard {
                    Text(lesson.exhibitLabel.t(store.language))
                        .font(Typeface.mono(16))
                        .foregroundStyle(Noir.blood)
                    Text(lesson.exhibitText.t(store.language))
                        .font(Typeface.mono(20))
                        .lineSpacing(6)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 16)

                InkPlate {
                    Text(Copy.s(store.language, pl: "GŁOS WEWNĘTRZNY", en: "INNER VOICE"))
                        .font(Typeface.mono(16))
                        .foregroundStyle(Noir.blood)
                        .tracking(1)
                    Text(lesson.innerVoice.t(store.language))
                        .font(Typeface.body(22))
                        .foregroundStyle(Noir.paper)
                        .lineSpacing(8)
                        .fixedSize(horizontal: false, vertical: true)
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

    private var storyBody: some View {
        VStack(spacing: 0) {
            Text(Copy.s(store.language, pl: "CO ROBISZ?", en: "WHAT DO YOU DO?"))
                .font(Typeface.mono(16))
                .foregroundStyle(Noir.blood)
                .tracking(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 16)

            if store.needsCoach {
                Text(Copy.s(
                    store.language,
                    pl: "Poprzednia decyzja była zła. Przeczytaj, skąd bierzesz dokument, numer albo plik, zanim wybierzesz.",
                    en: "The last decision was wrong. Read where the document, number, or file comes from before you choose."
                ))
                .font(Typeface.body(20))
                .foregroundStyle(Noir.paper)
                .lineSpacing(6)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    Text(lesson.deadline.t(store.language))
                        .font(Typeface.mono(18))
                        .foregroundStyle(Noir.blood)
                    Text(lesson.context.t(store.language))
                        .font(Typeface.body(22))
                        .foregroundStyle(Noir.paper)
                        .lineSpacing(8)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(lesson.innerVoice.t(store.language))
                        .font(Typeface.body(22))
                        .foregroundStyle(Noir.paper)
                        .lineSpacing(8)
                        .fixedSize(horizontal: false, vertical: true)
                    VStack(spacing: 16) {
                        ForEach(lesson.choices) { choice in
                            Button {
                                store.choose(choice, in: lesson)
                            } label: {
                                Text(choice.title.t(store.language))
                                    .font(Typeface.body(22))
                                    .foregroundStyle(Noir.void)
                                    .lineSpacing(6)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(20)
                                    .background(Noir.paper)
                                    .overlay(Rectangle().stroke(Noir.ink, lineWidth: 1))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .frame(maxWidth: 720)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private var headerRow: some View {
        HStack(spacing: 10) {
            if lesson.tone == .probono {
                Text("PRO BONO")
                    .font(Typeface.mono(16))
                    .foregroundStyle(Noir.paper)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Noir.blood)
            }
            Text(lesson.subtitle.t(store.language))
                .font(Typeface.mono(18))
                .foregroundStyle(Noir.paper)
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
