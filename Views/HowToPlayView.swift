import SwiftUI

struct HowToPlayView: View {
    @EnvironmentObject private var store: GameStore

    private var stages: [(String, String)] {
        [
            (
                Copy.s(store.language, pl: "Wokanda", en: "Docket"),
                Copy.s(
                    store.language,
                    pl: "Lista dwunastu nocy. Kolejna otwiera się dopiero po stemplu poprzedniej.",
                    en: "Twelve nights. The next one opens only after the previous stamp."
                )
            ),
            (
                Copy.s(store.language, pl: "Biblia wizualna", en: "Visual bible"),
                Copy.s(
                    store.language,
                    pl: "Obsada i stały wygląd bohaterów. To orientacja w fabule, nie materiał prawny.",
                    en: "Cast and fixed looks. Story orientation — not legal material."
                )
            ),
            (
                Copy.s(store.language, pl: "Komiks", en: "Comic"),
                Copy.s(
                    store.language,
                    pl: "Dwa kadry budujące sytuację i presję. Nie ujawnia rozwiązania.",
                    en: "Two panels that build the situation and pressure. They do not reveal the answer."
                )
            ),
            (
                Copy.s(store.language, pl: "Teczka", en: "File"),
                Copy.s(
                    store.language,
                    pl: "Kontekst, głos biurka i trzy możliwe decyzje.",
                    en: "Context, the desk voice, and three possible moves."
                )
            ),
            (
                Copy.s(store.language, pl: "Werdykt", en: "Verdict"),
                Copy.s(
                    store.language,
                    pl: "Krótki stempel: TRAFNE, BŁĘDNE albo NIEPEŁNE — z możliwością stuknięcia dalej.",
                    en: "A short stamp: SOUND, UNSOUND, or INCOMPLETE — tap to continue."
                )
            ),
            (
                Copy.s(store.language, pl: "Ratio", en: "Ratio"),
                Copy.s(
                    store.language,
                    pl: "Uzasadnienie wybranego ruchu: refleks i, poza trybem fabularnym, przepis oraz wzorzec.",
                    en: "Why that move: the reflex and, outside story mode, the rule and the pattern."
                )
            ),
            (
                Copy.s(store.language, pl: "Briefing", en: "Briefing"),
                Copy.s(
                    store.language,
                    pl: "Obowiązkowy po Ratio: jak to działa, sygnały, minimalizacja i praktyka — zanim wrócisz na wokandę.",
                    en: "Required after Ratio: how it works, signals, mitigation and practice — before the docket."
                )
            ),
            (
                Copy.s(store.language, pl: "Źródła", en: "Sources"),
                Copy.s(
                    store.language,
                    pl: "Tematy nocy pochodzą z newslettera SANS OUCH; sceny i Colgante są fikcją.",
                    en: "Night topics come from the SANS OUCH newsletter; scenes and Colgante are fiction."
                )
            ),
        ]
    }

    var body: some View {
        ZStack {
            StageBackground()
            VStack(spacing: 0) {
                ScreenChrome(
                    title: Copy.s(store.language, pl: "Jak czytać grę", en: "How to read the game"),
                    kicker: Copy.s(store.language, pl: "SŁOWNIK EKRANÓW", en: "SCREEN GLOSSARY"),
                    onBack: store.stackHasPrior ? { store.dismissHowToPlay() } : nil,
                    backCaption: Copy.s(store.language, pl: "Wstecz", en: "Back")
                ) { EmptyView() }

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        InkPlate {
                            Text(Copy.s(
                                store.language,
                                pl: "Mapa pól Czerwonej Teczki — żeby fabuła, mechanika i warstwa edukacyjna nie zlewały się w jedno.",
                                en: "A map of The Red File — so story, mechanics and the teaching layer stay distinct."
                            ))
                            .font(Typeface.body(22))
                            .foregroundStyle(Noir.paper)
                            .lineSpacing(6)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 16)

                        VStack(spacing: 0) {
                            ForEach(Array(stages.enumerated()), id: \.offset) { index, stage in
                                HStack(alignment: .top, spacing: 12) {
                                    Text(String(format: "%02d", index + 1))
                                        .font(Typeface.mono(16))
                                        .foregroundStyle(Noir.blood)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 6)
                                        .overlay(Rectangle().stroke(Noir.blood, lineWidth: 1.5))
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(stage.0)
                                            .font(Typeface.mono(20))
                                            .foregroundStyle(Noir.paper)
                                            .fixedSize(horizontal: false, vertical: true)
                                        Text(stage.1)
                                            .font(Typeface.body(18))
                                            .foregroundStyle(Noir.paperDim)
                                            .lineSpacing(4)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(.vertical, 12)
                                if index < stages.count - 1 {
                                    Rectangle()
                                        .fill(Color.white.opacity(0.18))
                                        .frame(height: 1)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 4)
                        .background(Noir.ink)
                        .overlay(Rectangle().stroke(Color.white.opacity(0.28), lineWidth: 1))
                        .padding(.horizontal, 16)

                        InkPlate {
                            Text(Copy.s(
                                store.language,
                                pl: "Głos wewnętrzny jest pytaniem przed wyborem, a refleks — nawykiem po wyborze. Briefing służy profilaktyce; Ratio ocenia konkretny ruch.",
                                en: "The inner voice is the question before the choice; the reflex is the habit after. Briefing is prevention; Ratio judges the move you made."
                            ))
                            .font(Typeface.body(18))
                            .foregroundStyle(Noir.paper)
                            .lineSpacing(5)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 16)

                        Button {
                            store.dismissHowToPlay()
                        } label: {
                            Text(ctaLabel)
                                .font(Typeface.mono(20))
                                .foregroundStyle(Color.white)
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

    private var ctaLabel: String {
        if store.stackHasPrior {
            return Copy.s(store.language, pl: "Wróć do wokandy", en: "Back to the docket")
        }
        return Copy.s(store.language, pl: "Do biurka — wokanda", en: "To the desk — the docket")
    }
}
