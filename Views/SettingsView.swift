import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: GameStore
    @EnvironmentObject private var soundtrack: Soundtrack

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

                    Toggle(isOn: $store.campaignMeters) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(Copy.s(store.language, pl: "Liczniki kampanii", en: "Campaign meters"))
                                .font(Typeface.body(20))
                                .foregroundStyle(.white)
                            Text(Copy.s(
                                store.language,
                                pl: "Wyłączone na spotkanie: każda teczka startuje od 100. Włączone: stemple zostają na wieczór.",
                                en: "Off for a meeting: each file resets to 100. On: stamps stay for the evening."
                            ))
                            .font(Typeface.body(18))
                            .foregroundStyle(Noir.paper)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
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
                    .frame(maxWidth: 720)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                }
            }
        }
    }
}

struct VisualBibleView: View {
    @EnvironmentObject private var store: GameStore

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
                            pl: "Zanim otworzysz teczkę — kto stoi na 5. piętrze. Te same twarze wracają w każdej sprawie.",
                            en: "Before you open a file — who stands on the 5th floor. The same faces return in every case."
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
                            caption: person.name(store.language) + " — " + lockLine(person),
                            minHeight: person == .mecenas ? 200 : 280,
                            contentMode: .fit
                        )
                        .padding(.horizontal, 16)
                    }

                    ComicPanel(
                        asset: "OfficeNight",
                        caption: Canon.firm(store.language) + ". " + Canon.window(store.language),
                        bloodCaption: true,
                        minHeight: 180
                    )
                    .padding(.horizontal, 16)

                    Button {
                        store.back()
                    } label: {
                        Text(Copy.s(store.language, pl: "Do biurka — wokanda", en: "To the desk — the docket"))
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

    private func lockLine(_ person: Cast) -> String {
        switch person {
        case .mecenas:
            return Copy.s(store.language, pl: "Gracz. Nigdy pełna twarz. Sygnet, pieczęć, żaluzja.", en: "The player. Never a full face. Signet, seal, blinds.")
        case .iglica:
            return Copy.s(store.language, pl: "Okrągłe okulary, rozczochrane włosy, nerwowy. Apelacja, prompt, memo.", en: "Round glasses, messy hair, nervous. Appeal, prompt, memo.")
        case .chropot:
            return Copy.s(store.language, pl: "Pociąg PKP, płaszcz, bilet czerwony. Presja z drugiego panelu.", en: "PKP train, overcoat, red ticket. Pressure from the second panel.")
        case .irena:
            return Copy.s(store.language, pl: "Kok, łańcuszek okularów w czerwieni. USB, HR, sekretariat.", en: "Bun, red glasses chain. USB, HR, secretariat.")
        }
    }
}
