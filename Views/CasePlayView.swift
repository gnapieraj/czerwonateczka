import SwiftUI

struct CasePlayView: View {
    @EnvironmentObject private var store: GameStore
    @Environment(\.verticalSizeClass) private var vertical
    @Environment(\.horizontalSizeClass) private var horizontal
    let lesson: Lesson

    private var landscapeSplit: Bool {
        horizontal == .regular && vertical == .compact
    }

    var body: some View {
        ZStack {
            StageBackground()
            if landscapeSplit {
                HStack(spacing: 0) {
                    ScrollView {
                        comicColumn
                    }
                    .frame(maxWidth: .infinity)
                    dossier
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.55))
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        comicColumn
                        dossier
                    }
                    .frame(maxWidth: 720)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 40)
                }
            }
        }
    }

    private var comicColumn: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Button { store.backToDesk() } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 36)
                }
                .buttonStyle(.plain)
                Spacer()
            }
            .padding(.horizontal, 12)

            ComicStrip(lesson: lesson, language: store.language)
                .padding(.horizontal, 12)

            Text(lesson.deadline.t(store.language))
                .font(Typeface.mono(12))
                .foregroundStyle(Noir.blood)
                .padding(.horizontal, 12)
            Text(lesson.title.t(store.language))
                .font(Typeface.display(32))
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
            Text(lesson.context.t(store.language))
                .font(Typeface.body(16))
                .foregroundStyle(Noir.paper)
                .padding(.horizontal, 12)
        }
        .padding(.top, 8)
    }

    private var dossier: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                PaperCard {
                    Text(lesson.exhibitLabel.t(store.language))
                        .font(Typeface.mono(11))
                        .foregroundStyle(Noir.blood)
                    Text(lesson.exhibitText.t(store.language))
                        .font(Typeface.mono(13))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 12)

                Text(lesson.innerVoice.t(store.language))
                    .font(Typeface.body(16))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)

                VStack(alignment: .leading, spacing: 6) {
                    Text(Copy.s(store.language, pl: "CZERWONE FLAGI", en: "RED FLAGS"))
                        .font(Typeface.mono(12))
                        .foregroundStyle(Noir.blood)
                    ForEach(Array(lesson.redFlags.enumerated()), id: \.offset) { _, flag in
                        Text("· \(flag.t(store.language))")
                            .font(Typeface.body(14))
                            .foregroundStyle(Noir.blood)
                    }
                }
                .padding(.horizontal, 12)

                actions
                    .padding(.horizontal, 12)
                    .padding(.bottom, 24)
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
