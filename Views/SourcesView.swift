import SwiftUI

struct SourceItem: Identifiable {
    let id: String
    let pl: String
    let en: String
}

enum Bibliography {
    static let items: [SourceItem] = [
        .init(id: "bar", pl: "Ustawa z dnia 26 maja 1982 r. — Prawo o adwokaturze (Dz.U. 2024 poz. 1564) — art. 6 (tajemnica). Art. 17 dotyczy izby, nie tajemnicy.",
              en: "Bar Act of 26 May 1982 (Dz.U. 2024 item 1564) — art. 6 (secrecy). Art. 17 is the chamber, not secrecy."),
        .init(id: "radca", pl: "Ustawa o radcach prawnych (Dz.U. 2024 poz. 499) — art. 3 ust. 3.",
              en: "Legal Advisers Act (Dz.U. 2024 item 499) — art. 3(3)."),
        .init(id: "23e", pl: "§ 23e Zbioru Zasad Etyki Adwokackiej, NRA 12 czerwca 2026 r.",
              en: "§ 23e of the Bar Ethics Code, NRA 12 June 2026."),
        .init(id: "kirp", pl: "Rekomendacje KIRP w sprawie AI, 2025 — wskazówka, nie paragraf etyki.",
              en: "KIRP AI recommendations, 2025 — guidance, not an ethics paragraph."),
        .init(id: "rodo", pl: "RODO art. 5, 25, 32, 33/34. Art. 28 tylko gdy jest procesor.",
              en: "GDPR arts. 5, 25, 32, 33/34. Art. 28 only when there is a processor."),
        .init(id: "aiact", pl: "Rozporządzenie (UE) 2024/1689: art. 4 (od 2.02.2025), art. 5 ust. 1 lit. f, art. 99 (7% tylko przy zakazach art. 5). Art. 50 — oznakowanie przez system.",
              en: "Regulation (EU) 2024/1689: art. 4 (from 2 Feb 2025), art. 5(1)(f), art. 99 (7% only for art. 5 bans). Art. 50 — labelling by the system."),
        .init(id: "uodo", pl: "UODO DKN.5131.31.2022 (23 580 zł); WSA Warszawa II SA/Wa 1342/23; Szczecin DKN.5131.12.2020.",
              en: "Polish DPA DKN.5131.31.2022 (PLN 23,580); WSA Warsaw II SA/Wa 1342/23; Szczecin DKN.5131.12.2020."),
        .init(id: "mata", pl: "Mata v. Avianca, S.D.N.Y., 22 czerwca 2023, 5 000 USD; Park v. Kim; Cork v Smith / Pinsent Masons, maj 2026; SRA AI warning, sierpień 2026; U.S. v. Heppner S.D.N.Y. 2026; Thomas v. Corbyn 2025.",
              en: "Mata v. Avianca, S.D.N.Y., 22 June 2023, $5,000; Park v. Kim; Cork v Smith / Pinsent Masons, May 2026; SRA AI warning, Aug 2026; U.S. v. Heppner S.D.N.Y. 2026; Thomas v. Corbyn 2025."),
    ]
}

struct SourcesView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        ZStack {
            StageBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    ScreenChrome(
                        title: Copy.s(store.language, pl: "Źródła", en: "Sources"),
                        onBack: { store.backToDesk() }
                    ) { EmptyView() }

                    Text(Copy.s(
                        store.language,
                        pl: "Gra nie jest poradą prawną. Kancelaria Okiennica, Chropot i Wspólnicy oraz osoby w grze są fikcyjne. Cytaty ustawowe mają być prawdziwe.",
                        en: "This is not legal advice. Okiennica, Chropot & Partners and the people in the game are fictional. The statutory citations are meant to be real."
                    ))
                    .font(Typeface.body(15))
                    .foregroundStyle(Noir.paper)
                    .padding(.horizontal, 16)

                    ForEach(Bibliography.items) { item in
                        Text(store.language == .polish ? item.pl : item.en)
                            .font(Typeface.body(15))
                            .foregroundStyle(.white)
                            .padding(14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.black.opacity(0.55))
                            .overlay(Rectangle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                            .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 32)
                }
                .frame(maxWidth: 720)
                .frame(maxWidth: .infinity)
            }
        }
    }
}
