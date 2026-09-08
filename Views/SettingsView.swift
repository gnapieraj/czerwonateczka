import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        ZStack {
            StageBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenChrome(
                        title: Copy.s(store.language, pl: "Ustawienia", en: "Settings"),
                        onBack: { store.backToDesk() }
                    ) { EmptyView() }

                    Picker(Copy.s(store.language, pl: "Język", en: "Language"), selection: $store.language) {
                        Text("Polski").tag(AppLanguage.polish)
                        Text("English").tag(AppLanguage.english)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 16)

                    Toggle(isOn: $store.campaignMeters) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(Copy.s(store.language, pl: "Liczniki kampanii", en: "Campaign meters"))
                                .foregroundStyle(.white)
                            Text(Copy.s(
                                store.language,
                                pl: "Wyłączone na spotkanie: każda teczka startuje od 100. Włączone: stemple zostają na wieczór.",
                                en: "Off for a meeting: each file resets to 100. On: stamps stay for the evening."
                            ))
                            .font(Typeface.body(13))
                            .foregroundStyle(Noir.mist)
                        }
                    }
                    .tint(Noir.blood)
                    .padding(.horizontal, 16)

                    Text(Copy.s(
                        store.language,
                        pl: "Offline. Bez konta. Bez analityki. iPad 9 i iPhone SE 3 — bez Apple Intelligence, bez generatora obrazów w urządzeniu.",
                        en: "Offline. No account. No analytics. iPad 9 and iPhone SE 3 — no Apple Intelligence, no on-device image generator."
                    ))
                    .font(Typeface.body(15))
                    .foregroundStyle(Noir.paper)
                    .padding(.horizontal, 16)

                    Button(Copy.s(store.language, pl: "Biblia wizualna (obsada)", en: "Visual bible (cast)")) {
                        store.openBible()
                    }
                    .font(Typeface.mono(13))
                    .foregroundStyle(Noir.blood)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                }
                .frame(maxWidth: 720)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct VisualBibleView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        ZStack {
            StageBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenChrome(
                        title: Copy.s(store.language, pl: "Biblia wizualna", en: "Visual bible"),
                        kicker: Copy.s(store.language, pl: "NIE GENERUJ TWARZY W LOCIE", en: "DO NOT GENERATE FACES LIVE"),
                        onBack: { store.backToDesk() }
                    ) { EmptyView() }

                    Text(Copy.s(
                        store.language,
                        pl: "Spójność postaci to ten sam plik PNG w każdej teczce — nie nowy prompt. Lokalny model (Mac Studio, ComfyUI / Flux) wolno użyć raz, offline, z img2img tej biblii. iPad 9 / SE 3 nie utrzymują tożsamości Sin City.",
                        en: "Character lock is the same PNG in every file — not a new prompt. A local model (Mac Studio, ComfyUI / Flux) may be used once, offline, img2img against this bible. iPad 9 / SE 3 will not hold a Sin City identity."
                    ))
                    .font(Typeface.body(16))
                    .foregroundStyle(Noir.paper)
                    .padding(.horizontal, 16)

                    ForEach(Cast.allCases, id: \.self) { person in
                        HStack(alignment: .top, spacing: 12) {
                            Image(person.asset)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 96, height: 128)
                                .clipped()
                                .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
                            VStack(alignment: .leading, spacing: 6) {
                                Text(person.name(store.language))
                                    .font(Typeface.display(20))
                                    .foregroundStyle(.white)
                                Text(lockLine(person))
                                    .font(Typeface.body(14))
                                    .foregroundStyle(Noir.mist)
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    Image("OfficeNight")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipped()
                        .overlay(Rectangle().stroke(Noir.blood, lineWidth: 2))
                        .overlay(alignment: .bottomLeading) {
                            Text(Canon.addressPL)
                                .font(Typeface.mono(11))
                                .foregroundStyle(.white)
                                .padding(8)
                        }
                        .padding(16)
                        .padding(.bottom, 32)
                }
                .frame(maxWidth: 720)
                .frame(maxWidth: .infinity)
            }
        }
    }

    private func lockLine(_ person: Cast) -> String {
        switch person {
        case .mecenas:
            return Copy.s(store.language, pl: "Gracz. Nigdy pełna twarz. Sygnet, pieczęć, żaluzja.", en: "The player. Never a full face. Signet, seal, blinds.")
        case .wilk:
            return Copy.s(store.language, pl: "Okrągłe okulary, rozczochrane włosy, nerwowy. Apelacja, prompt, memo.", en: "Round glasses, messy hair, nervous. Appeal, prompt, memo.")
        case .kruk:
            return Copy.s(store.language, pl: "Pociąg PKP, płaszcz, bilet czerwony. Presja z drugiego panelu.", en: "PKP train, overcoat, red ticket. Pressure from the second panel.")
        case .irena:
            return Copy.s(store.language, pl: "Kok, łańcuszek okularów w czerwieni. USB, HR, sekretariat.", en: "Bun, red glasses chain. USB, HR, secretariat.")
        }
    }
}
