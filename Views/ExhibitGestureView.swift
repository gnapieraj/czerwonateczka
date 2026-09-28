import SwiftUI
import UIKit

/// The night’s object. Short verbs on the thing itself. The rule is said after the stamp.
struct ExhibitGestureView: View {
    @EnvironmentObject private var store: GameStore
    let lesson: Lesson
    @State private var flags: Set<String> = []
    @State private var sealed = false
    @State private var contentHeight: CGFloat = 0
    @State private var viewportHeight: CGFloat = 0

    private var movesContinueBelow: Bool { contentHeight > viewportHeight + 12 }

    var body: some View {
        if let scene = ExhibitGesture.scene(for: lesson.id) {
            ViewThatFits(in: .vertical) {
                column(scene, scrolls: false)
                column(scene, scrolls: true)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 12)
            .frame(maxWidth: 720)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }

    private func column(_ scene: ExhibitScene, scrolls: Bool) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                if scrolls {
                    ScrollView {
                        stack(scene)
                    }
                    .background(GeometryReader { proxy in
                        Color.clear.preference(key: ViewportHeightKey.self, value: proxy.size.height)
                    })
                } else {
                    stack(scene)
                }
            }
            if scrolls && movesContinueBelow {
                Text(Copy.s(store.language, pl: "Niżej są dalsze ruchy", en: "More moves below"))
                    .font(Typeface.mono(13))
                    .foregroundStyle(Noir.blood)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            commitButton(scene)
        }
        .onPreferenceChange(ContentHeightKey.self) { contentHeight = $0 }
        .onPreferenceChange(ViewportHeightKey.self) { viewportHeight = $0 }
    }

    private func stack(_ scene: ExhibitScene) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(cue(for: scene).t(store.language))
                .font(Typeface.body(16))
                .foregroundStyle(Noir.paperDim)
                .fixedSize(horizontal: false, vertical: true)
            ForEach(scene.cards) { card in
                cardView(card)
            }
        }
        .background(GeometryReader { proxy in
            Color.clear.preference(key: ContentHeightKey.self, value: proxy.size.height)
        })
    }

    @ViewBuilder
    private func commitButton(_ scene: ExhibitScene) -> some View {
        if let commit = scene.commitTitle {
            Button {
                seal(ExhibitGesture.resolve(lessonId: lesson.id, flags: flags))
            } label: {
                Text(commit.t(store.language))
                    .font(Typeface.mono(18))
                    .foregroundStyle(Noir.void)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 48)
                    .background(Noir.paper)
            }
            .buttonStyle(.plain)
            .disabled(sealed)
        }
    }

    private func cue(for scene: ExhibitScene) -> Loc {
        if scene.commitTitle == nil {
            return Loc(
                pl: "Jeden ruch na przedmiocie kończy tę noc.",
                en: "One move on the object ends this night."
            )
        }
        if scene.lessonId == "01-kod" {
            return Loc(
                pl: "Zaznacz, co robisz z telefonem. Na końcu odłóż go.",
                en: "Mark what you do with the phone. Then put it down."
            )
        }
        return Loc(
            pl: "Zaznacz, co robisz z przedmiotem. Na końcu odłóż.",
            en: "Mark what you do with the object. Then set it down."
        )
    }

    private func cardView(_ card: GestureCard) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(card.title.t(store.language))
                        .font(Typeface.mono(14))
                        .foregroundStyle(Noir.blood)
                        .tracking(0.6)
                    Text(card.note.t(store.language))
                        .font(Typeface.body(15))
                        .foregroundStyle(Noir.paper)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                if card.taps.count == 1, let tap = card.taps.first, !wide(tap) {
                    tapButton(tap, on: card, fills: false)
                }
            }
            if card.taps.count > 1 || card.taps.contains(where: wide) {
                VStack(spacing: 6) {
                    ForEach(card.taps) { tap in
                        tapButton(tap, on: card, fills: true)
                    }
                }
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Noir.ink)
        .overlay(Rectangle().stroke(Noir.line, lineWidth: 1))
    }

    private func wide(_ tap: GestureTap) -> Bool {
        tap.title.pl.count > 14
    }

    private func tapButton(_ tap: GestureTap, on card: GestureCard, fills: Bool) -> some View {
        Button {
            press(tap, on: card)
        } label: {
            Text(tap.title.t(store.language))
                .font(Typeface.body(17))
                .foregroundStyle(isOn(tap) ? Noir.void : Noir.paper)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: fills ? .infinity : nil, alignment: .leading)
                .padding(.horizontal, 12)
                .frame(minHeight: 44)
                .background(isOn(tap) ? Noir.paper : Noir.void)
                .overlay(Rectangle().stroke(Noir.paper.opacity(0.45), lineWidth: 1))
        }
        .buttonStyle(.plain)
        .disabled(sealed)
    }

    private func isOn(_ tap: GestureTap) -> Bool {
        guard let flag = tap.flag else { return false }
        return flags.contains(flag)
    }

    private func press(_ tap: GestureTap, on card: GestureCard) {
        guard !sealed else { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        if let choiceId = tap.choiceId {
            seal(choiceId)
            return
        }
        guard let flag = tap.flag else { return }
        let siblings = Set(card.taps.compactMap(\.flag))
        flags.subtract(siblings)
        flags.insert(flag)
    }

    private func seal(_ choiceId: String) {
        guard !sealed, let choice = lesson.choices.first(where: { $0.id == choiceId }) else { return }
        sealed = true
        store.choose(choice, in: lesson)
    }
}

private struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private struct ViewportHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
