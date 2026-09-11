import SwiftUI

struct SourceItem: Identifiable {
    let id: String
    let category: Loc
    let title: Loc
    let note: Loc
    let url: URL
    let verifiedOn: String
}

enum Bibliography {
    static let legalState = "10.09.2026"

    static let items: [SourceItem] = [
        source("bar", "Prawo obowiązujące", "Binding law", "Prawo o adwokaturze — art. 6", "Bar Act — art. 6", "Dz.U. 2024 poz. 1564; tajemnica zawodowa adwokata.", "Journal of Laws 2024 item 1564; advocate’s professional secrecy.", "https://eli.gov.pl/api/acts/DU/2024/1564/text.html"),
        source("radca", "Prawo obowiązujące", "Binding law", "Ustawa o radcach prawnych — art. 3 ust. 3–5", "Legal Advisers Act — art. 3(3)–(5)", "Dz.U. 2024 poz. 499 z późn. zm.; tajemnica zawodowa radcy prawnego.", "Journal of Laws 2024 item 499, as amended; legal adviser’s professional secrecy.", "https://eli.gov.pl/api/acts/DU/2024/499/text.html"),
        source("kpc", "Prawo obowiązujące", "Binding law", "Kodeks postępowania cywilnego — art. 3 i 4¹", "Code of Civil Procedure — arts. 3 and 4¹", "Dz.U. 2026 poz. 468 z późn. zm.; rzetelność czynności i nadużycie prawa procesowego.", "Journal of Laws 2026 item 468, as amended; procedural candour and abuse of process.", "https://eli.gov.pl/api/acts/DU/2026/468/text.html"),
        source("criminal", "Prawo obowiązujące", "Binding law", "Kodeks karny — art. 266 § 1", "Criminal Code — art. 266 § 1", "Dz.U. 2025 poz. 383 z późn. zm.; ujawnienie lub wykorzystanie informacji wymaga spełnienia wszystkich znamion.", "Journal of Laws 2025 item 383, as amended; disclosure or use requires every element of the offence.", "https://eli.gov.pl/api/acts/DU/2025/383/text.html"),
        source("civil-code", "Prawo obowiązujące", "Binding law", "Kodeks cywilny — art. 355 i 471", "Civil Code — arts. 355 and 471", "Dz.U. 2026 poz. 795; zawodowa staranność i odpowiedzialność kontraktowa zależna od przesłanek.", "Journal of Laws 2026 item 795; professional care and contractual liability subject to statutory conditions.", "https://eli.gov.pl/api/acts/DU/2026/795/text.html"),
        source("uznk", "Prawo obowiązujące", "Binding law", "Ustawa o zwalczaniu nieuczciwej konkurencji — art. 11 ust. 2", "Unfair Competition Act — art. 11(2)", "Dz.U. 2026 poz. 85; przesłanki tajemnicy przedsiębiorstwa.", "Journal of Laws 2026 item 85; statutory conditions for trade-secret protection.", "https://eli.gov.pl/api/acts/DU/2026/85/text.html"),
        source("labour-code", "Prawo obowiązujące", "Binding law", "Kodeks pracy — art. 22²–22³", "Labour Code — arts. 22²–22³", "Monitoring pracowników wymaga odrębnej podstawy, celu, proporcjonalności i informacji.", "Employee monitoring requires a separate basis, purpose, proportionality and notice.", "https://eli.gov.pl/api/acts/DU/2025/277/text.html"),
        source("gdpr", "Prawo UE", "EU law", "Rozporządzenie (UE) 2016/679 (RODO)", "Regulation (EU) 2016/679 (GDPR)", "W szczególności art. 5, 9, 22, 28 oraz 32–34; każdy przepis ma odrębne przesłanki.", "In particular arts. 5, 9, 22, 28 and 32–34; each provision has distinct conditions.", "https://eur-lex.europa.eu/eli/reg/2016/679/oj"),
        source("aiact", "Prawo UE", "EU law", "Rozporządzenie (UE) 2024/1689 (AI Act)", "Regulation (EU) 2024/1689 (AI Act)", "Art. 3 pkt 39, art. 4, art. 5 ust. 1 lit. f, art. 50 i art. 99; tekst skonsolidowany.", "Arts. 3(39), 4, 5(1)(f), 50 and 99; consolidated text.", "https://eur-lex.europa.eu/legal-content/PL/TXT/?uri=CELEX:02024R1689-20260727"),
        source("polish-ai-act", "Prawo obowiązujące", "Binding law", "Ustawa o systemach sztucznej inteligencji", "Polish AI Systems Act", "Dz.U. 2026 poz. 1003; obowiązuje od 11.08.2026, a rozdziały egzekucyjne i karne od 28.10.2026.", "Journal of Laws 2026 item 1003; applies from 11 Aug 2026, with enforcement and penalty chapters from 28 Oct 2026.", "https://eli.gov.pl/eli/DU/2026/1003/ogl/pol"),
        source("kea", "Etyka zawodowa", "Professional ethics", "Kodeks Etyki Adwokackiej — § 19 ust. 6 i § 23e", "Code of Ethics for Advocates — § 19(6) and § 23e", "Tekst jednolity ogłoszony uchwałą Prezydium NRA nr 174/2026 z 23.06.2026.", "Consolidated text published by NRA Presidium Resolution 174/2026 of 23 June 2026.", "https://www.adwokatura.pl/regulaminy/wykonywanie-zawodu-etyka-i-doskonalenie-zawodowe/"),
        source("kirp-ai", "Wytyczne", "Guidance", "KIRP: AI w pracy radcy prawnego", "KIRP: AI in legal-adviser practice", "Rekomendacje z 2025 r.; dokument pomocniczy, nie przepis prawa.", "2025 recommendations; guidance, not binding legislation.", "https://kirp.pl/rekomendacje-dotyczace-korzystania-z-ai/"),
        source("nra-cyber", "Wytyczne", "Guidance", "NRA: dobre praktyki cyberbezpieczeństwa", "NRA: cybersecurity good practices", "Uchwała NRA nr 25/2025 z 22.11.2025; standard praktyczny, nie ustawa.", "NRA Resolution 25/2025 of 22 Nov 2025; practical guidance, not legislation.", "https://www.adwokatura.pl/regulaminy/wykonywanie-zawodu-etyka-i-doskonalenie-zawodowe/"),
        source("advocate-funds", "Reguły zawodowe", "Professional rules", "Regulamin wykonywania zawodu adwokata — § 6", "Advocate-practice regulations — § 6", "Sposób przyjmowania i dysponowania środkami klienta powinien wynikać z pisemnej umowy i dokumentacji.", "Receipt and disposition of client money should follow a written agreement and records.", "https://nra.pl/szukaj-dokumenty/dokument/1089/"),
        source("kerp-funds", "Reguły zawodowe", "Professional rules", "Kodeks Etyki Radcy Prawnego — art. 37", "Code of Ethics for Legal Advisers — art. 37", "Reguły postępowania radcy prawnego ze środkami klienta.", "Rules governing a legal adviser’s handling of client money.", "https://kirp.pl/wp-content/uploads/2024/02/kodeks-etyki-radcy-prawnego-i-regulamin-wykonywania-zawodu.pdf"),
        source("bec-gov", "Wytyczne", "Guidance", "Gov.pl: oszustwa typu BEC", "Gov.pl: business email compromise", "Operacyjne czerwone flagi i obowiązek niezależnego potwierdzania zmiany rachunku.", "Operational warning signs and independent confirmation of account changes.", "https://www.gov.pl/web/baza-wiedzy/oszustwa-typu-bec"),
        source("csirt-media", "Wytyczne techniczne", "Technical guidance", "CSIRT CeZ: bezpieczne korzystanie z nośników", "CSIRT CeZ: safe use of removable media", "Niezaufanych nośników nie podłącza się do stacji roboczych z dostępem do chronionych zasobów.", "Untrusted media should not be connected to workstations with access to protected resources.", "https://www.cez.gov.pl/sites/default/files/paragraph.attachments.field_attachments/2025-06/Podstawy%20bezpiecze%C5%84stwa%204%20-%20bezpieczne%20korzystanie%20z%20urz%C4%85dze%C5%84%20i%20no%C5%9Bnik%C3%B3w%20danych.pdf"),
        source("isap-disclaimer", "Baza informacyjna", "Information database", "ISAP — informacja o charakterze bazy", "ISAP — database status notice", "ISAP wprost wskazuje, że internetowy system aktów prawnych nie jest źródłem prawa; oficjalnym publikatorom służą dzienniki urzędowe.", "ISAP expressly states that its online database is not a source of law; official journals promulgate legislation.", "https://isap.sejm.gov.pl/isap.nsf/home.xsp"),
        source("uodo-usb", "Orzeczenie polskie", "Polish decision", "Prezes UODO, DKN.5131.31.2022", "Polish DPA, DKN.5131.31.2022", "Decyzja z 20.04.2023: utrata wysłanego, niezaszyfrowanego nośnika; kara 23 580 zł. To nie była sprawa malware.", "Decision of 20 Apr 2023: loss of an unencrypted device in transit; PLN 23,580 fine. It was not a malware case.", "https://orzeczenia.uodo.gov.pl/document/urn:ndoc:gov:pl:uodo:2022:dkn_5131_31/content"),
        source("wsa-uodo-usb", "Orzeczenie polskie", "Polish decision", "WSA w Warszawie, II SA/Wa 1342/23", "Warsaw administrative court, II SA/Wa 1342/23", "Wyrok z 17.04.2024 oddalający skargę; CBOSA oznacza go jako nieprawomocny.", "Judgment of 17 Apr 2024 dismissing the challenge; CBOSA marks it as non-final.", "https://orzeczenia.nsa.gov.pl/doc/30952A118D"),
        source("sn-iii-czp-12-22", "Orzeczenie polskie", "Polish decision", "SN, III CZP 12/22", "Polish Supreme Court, III CZP 12/22", "Uchwała z 6.04.2022 istnieje, ale nie zawiera tezy o prawach autorskich do kodu.", "The resolution of 6 Apr 2022 exists but contains no holding about copyright in source code.", "https://www.sn.pl/orzecznictwo/Biuletyn_IC_SN/Biuletyn%20Izby%20Cywilnej%20S%C4%85du%20Najwy%C5%BCszego%202022_05_06.pdf"),
        source("sn-search", "Baza orzeczeń", "Case-law database", "Sąd Najwyższy — baza orzeczeń i zagadnień prawnych", "Polish Supreme Court — judgments and legal questions", "Sygnatura jest punktem startu; trzeba przeczytać pełny tekst i sprawdzić tezę w kontekście.", "A docket number is only a starting point; read the full text and verify the holding in context.", "https://www.sn.pl/orzecznictwo/SitePages/Baza_orzeczen.aspx"),
        source("sn-iii-czp-7-24", "Orzeczenie polskie", "Polish decision", "SN, III CZP 7/24", "Polish Supreme Court, III CZP 7/24", "Rzeczywista sprawa dotycząca rozliczeń między byłymi konkubentami, nie odpowiedzialności za AI.", "A real case concerning property settlement between former cohabitants, not AI liability.", "https://www.sn.pl/sprawy/SitePages/Zagadnienia_prawne_SN.aspx"),
        source("cjeu-c403-404", "Orzeczenie UE", "EU judgment", "TSUE, sprawy połączone C-403/23 i C-404/23", "CJEU, joined Cases C-403/23 and C-404/23", "Luxone i Sofein przeciwko Consip, ECLI:EU:C:2024:805; zamówienia publiczne, nie obowiązki zarządu wobec AI.", "Luxone and Sofein v Consip, ECLI:EU:C:2024:805; public procurement, not corporate AI duties.", "https://eur-lex.europa.eu/legal-content/PL/TXT/?uri=CELEX:62023CJ0403"),
        source("court-redaction", "Wytyczne techniczne", "Technical guidance", "U.S. Court of Appeals for the D.C. Circuit: redakcja dokumentów", "U.S. Court of Appeals for the D.C. Circuit: document redaction", "Przykład techniczny: czarne pole tylko ukrywa tekst; należy użyć funkcji trwałej redakcji i usunąć ukryte dane.", "Technical illustration: a black box merely hides text; use permanent redaction and remove hidden information.", "https://www.cadc.uscourts.gov/sites/cadc/files/ecfRedactionGuide.pdf"),
        source("openai-privacy", "Warunki dostawcy", "Provider terms", "OpenAI — polityka prywatności dla Europy", "OpenAI — Europe privacy policy", "Usługa konsumencka: dostawca jest administratorem; wykorzystanie treści i transfery zależą od aktualnej polityki i ustawień.", "Consumer service: the provider is a controller; content use and transfers depend on current policy and settings.", "https://openai.com/policies/eu-privacy-policy/"),
        source("openai-dpa", "Warunki dostawcy", "Provider terms", "OpenAI — Data Processing Addendum", "OpenAI — Data Processing Addendum", "DPA dotyczy kwalifikujących się usług biznesowych i ról administrator–procesor; nie należy przenosić go automatycznie na konto konsumenckie.", "The DPA applies to qualifying business services and controller–processor roles; it should not be assumed to cover a consumer account.", "https://openai.com/en-GB/policies/data-processing-addendum/"),
        source("mata", "Przykład zagraniczny", "Foreign illustration", "Mata v. Avianca, 22-cv-1461 (PKC)", "Mata v. Avianca, 22-cv-1461 (PKC)", "S.D.N.Y., 22.06.2023, Doc. 54. Rule 11; niewiążące w Polsce.", "S.D.N.Y., 22 Jun 2023, Doc. 54. Rule 11; not binding in Poland.", "https://law.justia.com/cases/federal/district-courts/new-york/nysdce/1:2022cv01461/575368/54/"),
        source("park", "Przykład zagraniczny", "Foreign illustration", "Park v. Kim, No. 22-2057", "Park v. Kim, No. 22-2057", "2d Cir., 30.01.2024; skierowanie pełnomocniczki do Grievance Panel. Niewiążące w Polsce.", "2d Cir., 30 Jan 2024; counsel referred to the Grievance Panel. Not binding in Poland.", "https://law.justia.com/cases/federal/appellate-courts/ca2/22-2057/22-2057-2024-01-30.html"),
        source("cork", "Przykład zagraniczny", "Foreign illustration", "Cork & Anor v Smith [2026] EWHC 1199 (Ch)", "Cork & Anor v Smith [2026] EWHC 1199 (Ch)", "High Court, 22.05.2026; dwa pisma wprowadzające sąd w błąd przy użyciu firmowego pilota AI. Niewiążące w Polsce.", "High Court, 22 May 2026; two misleading letters produced during a firm AI pilot. Not binding in Poland.", "https://www.bailii.org/ew/cases/EWHC/Ch/2026/1199.html"),
        source("heppner", "Przykład zagraniczny", "Foreign illustration", "United States v. Heppner, No. 25 Cr. 503 (JSR)", "United States v. Heppner, No. 25 Cr. 503 (JSR)", "S.D.N.Y., 17.02.2026; konsumencki Claude, privilege i work product. Nie jest wykładnią polskiej tajemnicy.", "S.D.N.Y., 17 Feb 2026; consumer Claude, privilege and work product. It does not interpret Polish professional secrecy.", "https://jlellis.net/wp-content/uploads/2026/02/USA-v-Heppner-Order-2026-02-17-AI-Not-Privileged.pdf"),
        source("thomas", "Przykład zagraniczny", "Foreign illustration", "Thomas v. Corbyn Restaurant Development Corp., D083655", "Thomas v. Corbyn Restaurant Development Corp., D083655", "California Court of Appeal, 27.05.2025; BEC przy ugodzie 475 000 USD. Niewiążące w Polsce.", "California Court of Appeal, 27 May 2025; BEC involving a $475,000 settlement. Not binding in Poland.", "https://law.justia.com/cases/california/court-of-appeal/2025/d083655.html"),
    ]

    static func selected(ids: [String]?) -> [SourceItem] {
        guard let ids else { return items }
        return items.filter { ids.contains($0.id) }
    }

    private static func source(
        _ id: String,
        _ categoryPL: String,
        _ categoryEN: String,
        _ titlePL: String,
        _ titleEN: String,
        _ notePL: String,
        _ noteEN: String,
        _ url: String
    ) -> SourceItem {
        SourceItem(
            id: id,
            category: Loc(pl: categoryPL, en: categoryEN),
            title: Loc(pl: titlePL, en: titleEN),
            note: Loc(pl: notePL, en: noteEN),
            url: URL(string: url)!,
            verifiedOn: legalState
        )
    }
}

struct SourcesView: View {
    @EnvironmentObject private var store: GameStore
    var sourceIds: [String]? = nil

    var body: some View {
        ZStack {
            StageBackground()
            VStack(spacing: 0) {
                sourcesHeader

                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                    InkPlate {
                        Text(Copy.s(
                            store.language,
                            pl: "Gra nie jest poradą prawną. Stan prawa i źródeł: \(Bibliography.legalState). Przykłady zagraniczne są ilustracjami i nie stanowią polskiego precedensu.",
                            en: "This game is not legal advice. Law and sources checked on \(Bibliography.legalState). Foreign cases are illustrations, not Polish precedent."
                        ))
                        .font(Typeface.body(15))
                        .foregroundStyle(Noir.paper)
                    }
                    .padding(.horizontal, 16)

                    ForEach(Bibliography.selected(ids: sourceIds)) { item in
                        InkPlate {
                            Text(item.category.t(store.language).uppercased())
                                .font(Typeface.mono(10))
                                .foregroundStyle(Noir.blood)
                                .tracking(1)
                            Link(destination: item.url) {
                                HStack(alignment: .firstTextBaseline) {
                                    Text(item.title.t(store.language))
                                        .font(Typeface.body(16))
                                    Spacer(minLength: 8)
                                    Image(systemName: "arrow.up.right.square")
                                }
                                .foregroundStyle(Noir.paper)
                            }
                            Text(item.note.t(store.language))
                                .font(Typeface.body(14))
                                .foregroundStyle(Noir.paperDim)
                            Text(Copy.s(
                                store.language,
                                pl: "Zweryfikowano: \(item.verifiedOn)",
                                en: "Verified: \(item.verifiedOn)"
                            ))
                            .font(Typeface.mono(10))
                            .foregroundStyle(Noir.mist)
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 32)
                    }
                    .frame(maxWidth: 720)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                }
            }
        }
    }

    private var sourcesHeader: some View {
        HStack(spacing: 12) {
            Button {
                store.back()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.title3.weight(.semibold))
                    Text(Copy.s(store.language, pl: "Wstecz", en: "Back"))
                        .font(Typeface.mono(13))
                }
                .foregroundStyle(Noir.paper)
                .frame(minWidth: 88, minHeight: 44, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 2) {
                Text("CZERWONA TECZKA")
                    .font(Typeface.mono(10))
                    .foregroundStyle(Noir.blood)
                    .tracking(2)
                Text(Copy.s(store.language, pl: "Źródła", en: "Sources"))
                    .font(Typeface.display(24))
                    .foregroundStyle(Noir.paper)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Noir.ink)
    }
}
