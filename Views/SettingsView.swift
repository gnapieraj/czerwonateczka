import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: GameStore
    @EnvironmentObject private var soundtrack: Soundtrack
    @Environment(\.horizontalSizeClass) private var horizontal

    var body: some View {
        ZStack {
            StageBackground()
            VStack(spacing: 0) {
                ScreenChrome(
                    title: Copy.s(store.language, pl: "Ustawienia", en: "Settings"),
                    onBack: { store.back() },
                    backCaption: Copy.s(store.language, pl: "Wstecz", en: "Back")
                ) { EmptyView() }

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                    Picker(Copy.s(store.language, pl: "Język", en: "Language"), selection: $store.language) {
                        Text("Polski").tag(AppLanguage.polish)
                        Text("English").tag(AppLanguage.english)
                    }
                    .pickerStyle(.segmented)
                    .font(Typeface.body(18))
                    .padding(16)
                    .background(Noir.ink)
                    .padding(.horizontal, 16)

                    Toggle(isOn: Binding(
                        get: { !soundtrack.isMuted },
                        set: { soundtrack.isMuted = !$0 }
                    )) {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: soundtrack.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                                .font(.title3)
                                .foregroundStyle(soundtrack.isMuted ? Noir.blood : Noir.paper)
                                .frame(width: 28)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(Copy.s(store.language, pl: "Muzyka biurka", en: "Desk music"))
                                    .font(Typeface.body(20))
                                    .foregroundStyle(.white)
                                Text(Copy.s(
                                    store.language,
                                    pl: "Wolna pętla fortepianu napisana na potrzeby gry. Przełącznik dzwonka na iPhonie też ją wycisza.",
                                    en: "A slow piano loop written for this game. The iPhone Ring/Silent switch also mutes it."
                                ))
                                .font(Typeface.body(18))
                                .foregroundStyle(Noir.paper)
                                .lineSpacing(4)
                                .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    .tint(Noir.blood)
                    .padding(16)
                    .background(Noir.ink)
                    .padding(.horizontal, 16)

                    InkPlate {
                        Text(Copy.s(
                            store.language,
                            pl: "Offline. Bez konta. Bez analityki.",
                            en: "Offline. No account. No analytics."
                        ))
                        .font(Typeface.body(20))
                        .foregroundStyle(Noir.paper)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 16)

                    employerReportSection

                    InkPlate {
                        Text(Copy.s(
                            store.language,
                            pl: "Ilustracje komiksu powstają z pomocą AI. Postaci i kancelaria Colgante są fikcyjne. Gra nie jest poradą prawną.",
                            en: "Comic art is AI-assisted. Characters and Colgante are fiction. This game is not legal advice."
                        ))
                        .font(Typeface.body(18))
                        .foregroundStyle(Noir.paperDim)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 16)

                    Link(destination: URL(string: "https://\(Canon.domainReal)")!) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(Canon.domainReal)
                                .font(Typeface.mono(20))
                                .foregroundStyle(Noir.blood)
                            Text(Copy.s(
                                store.language,
                                pl: "Wokanda, materiały i newsletter poza aplikacją.",
                                en: "Docket, materials and newsletter outside the app."
                            ))
                            .font(Typeface.body(18))
                            .foregroundStyle(Noir.paper)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background(Noir.ink)
                        .overlay(Rectangle().stroke(Noir.blood, lineWidth: 1))
                    }
                    .padding(.horizontal, 16)

                    Button(Copy.s(store.language, pl: "Skąd tematy nocy", en: "Where the nights come from")) {
                        store.openSources()
                    }
                    .font(Typeface.mono(20))
                    .foregroundStyle(Noir.paper)
                    .padding(.horizontal, 16)

                    Button(Copy.s(store.language, pl: "Jak czytać grę", en: "How to read the game")) {
                        store.openHowToPlay()
                    }
                    .font(Typeface.mono(20))
                    .foregroundStyle(Noir.blood)
                    .padding(.horizontal, 16)

                    Button(Copy.s(store.language, pl: "Biblia wizualna (obsada)", en: "Visual bible (cast)")) {
                        store.openBible()
                    }
                    .font(Typeface.mono(20))
                    .foregroundStyle(Noir.blood)
                    .padding(.horizontal, 16)

                    Button(Copy.s(store.language, pl: "Pierwsze uruchomienie", en: "First launch again")) {
                        store.resetFirstLaunch()
                    }
                    .font(Typeface.mono(20))
                    .foregroundStyle(Noir.paper)
                    .padding(.horizontal, 16)

                    Text(Copy.s(
                        store.language,
                        pl: "Czyści stemple, słownik i obsadę, i wraca na ekran startowy.",
                        en: "Clears the stamps, the glossary and the cast, and returns to the opening screen."
                    ))
                    .font(Typeface.body(16))
                    .foregroundStyle(Noir.paperDim)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 16)

                    if !store.stamps.isEmpty {
                        Button(Copy.s(store.language, pl: "Zdejmij stemple z wokandy", en: "Clear stamps from the docket")) {
                            store.clearStamps()
                        }
                        .font(Typeface.mono(20))
                        .foregroundStyle(Noir.paper)
                        .padding(.horizontal, 16)
                    }

                    Color.clear.frame(height: 32)
                    }
                    .frame(maxWidth: ReadingMeasure.column(horizontal))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                }
            }
        }
    }

    /// Plan-raport-dyplom.md §11 — entry point; the full form lives in `EmployerReportView`.
    private var employerReportSection: some View {
        let ready = store.hasPassingReportScope
        return Button {
            store.openReport()
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: ready ? "checkmark.seal.fill" : "doc.text.magnifyingglass")
                        .font(.title3)
                        .foregroundStyle(ready ? Noir.blood : Noir.paperDim)
                        .frame(width: 28)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(Copy.s(store.language, pl: "Raport dla pracodawcy", en: "Report for your employer"))
                            .font(Typeface.body(20))
                            .foregroundStyle(.white)
                        Text(reportStatusLine)
                            .font(Typeface.body(18))
                            .foregroundStyle(Noir.paper)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer(minLength: 0)
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Noir.paperDim)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Noir.ink)
            .overlay(Rectangle().stroke(ready ? Noir.blood : Color.white.opacity(0.28), lineWidth: 1))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
    }

    private var reportStatusLine: String {
        if let scope = store.defaultReportScope {
            let evaluation = store.evaluate(scope)
            return Copy.s(
                store.language,
                pl: "\(scope.title(.polish, lessons: store.lessons)): \(evaluation.soundCount)/\(evaluation.lessonCount) TRAFNE — PDF, CSV i JSON gotowe do udostępnienia.",
                en: "\(scope.title(.english, lessons: store.lessons)): \(evaluation.soundCount)/\(evaluation.lessonCount) SOUND — PDF, CSV and JSON ready to share."
            )
        }
        guard let scope = store.reportScopes.first else {
            return Copy.s(store.language, pl: "Brak lekcji.", en: "No lessons.")
        }
        let evaluation = store.evaluate(scope)
        if !evaluation.unstamped.isEmpty {
            return Copy.s(
                store.language,
                pl: "\(scope.title(.polish, lessons: store.lessons)): bez stempla \(evaluation.unstamped.count) z \(evaluation.lessonCount) nocy. Próg: ≥ \(PassPolicy.thresholdPercent)% TRAFNE.",
                en: "\(scope.title(.english, lessons: store.lessons)): \(evaluation.unstamped.count) of \(evaluation.lessonCount) nights unstamped. Threshold: ≥ \(PassPolicy.thresholdPercent)% SOUND."
            )
        }
        if !evaluation.unbriefed.isEmpty {
            return Copy.s(
                store.language,
                pl: "Briefing do przejrzenia: \(evaluation.unbriefed.count). Potem raport.",
                en: "Briefings to read: \(evaluation.unbriefed.count). Then the report."
            )
        }
        return Copy.s(
            store.language,
            pl: "\(evaluation.soundCount)/\(evaluation.lessonCount) TRAFNE — brakuje \(evaluation.missingSound). Zagraj noce ponownie z wokandy.",
            en: "\(evaluation.soundCount)/\(evaluation.lessonCount) SOUND — \(evaluation.missingSound) short. Replay nights from the docket."
        )
    }
}

struct VisualBibleView: View {
    @EnvironmentObject private var store: GameStore
    @Environment(\.horizontalSizeClass) private var horizontal

    var body: some View {
        ZStack {
            StageBackground()
            VStack(spacing: 0) {
                ScreenChrome(
                    title: Copy.s(store.language, pl: "Obsada", en: "The cast"),
                    kicker: Copy.s(store.language, pl: "BIBLIA WIZUALNA", en: "VISUAL BIBLE"),
                    onBack: { store.back() },
                    backCaption: Copy.s(store.language, pl: "Wstecz", en: "Back")
                ) { EmptyView() }

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                    InkPlate {
                        Text(Copy.s(
                            store.language,
                            pl: "Zanim otworzysz teczkę — kto stoi na piątym piętrze Colgante. Te same twarze wracają w każdej sprawie.",
                            en: "Before you open a file — who stands on Colgante’s fifth floor. The same faces return in every matter."
                        ))
                        .font(Typeface.body(22))
                        .foregroundStyle(Noir.paper)
                        .lineSpacing(6)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 16)

                    ForEach(Cast.allCases, id: \.self) { person in
                        ComicPanel(
                            asset: person.asset,
                            caption: person.name(store.language) + " — " + person.lockLine(store.language),
                            plateRatio: 16 / 9
                        )
                        .padding(.horizontal, 16)
                    }

                    ComicPanel(
                        asset: "Gabinet",
                        caption: Canon.firm(store.language) + ". " + Canon.window(store.language),
                        bloodCaption: true,
                        plateRatio: 16 / 9
                    )
                    .padding(.horizontal, 16)

                    Button {
                        store.back()
                    } label: {
                        Text(bibleCtaLabel)
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
                    .frame(maxWidth: ReadingMeasure.column(horizontal))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                }
            }
        }
    }

    private var bibleCtaLabel: String {
        if store.stackHasPrior {
            return Copy.s(store.language, pl: "Wróć do wokandy", en: "Back to the docket")
        }
        return Copy.s(store.language, pl: "Do biurka — wokanda", en: "To the desk — the docket")
    }
}
