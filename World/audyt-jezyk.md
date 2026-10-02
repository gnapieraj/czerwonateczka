# Audyt językowy — Czerwona Teczka (PL / EN)

**Stan:** 02.10.2026 (UTC+2)  
**Branch:** `cursor/raport-dyplom-mvp-6d1a`  
**Zakres:** copy gry (UI, Lessons.json, raport/badge/PDF, Canon, słownik), witryna w repo, komiks (napisy in-app).  
**Tryb:** audyt + **zastosowane poprawki** (sekcja 8). Pierwotnie analiza-only.

---

## 1. Executive answer — „12 Nocy” / „24 Nocy”

### Werdykt

| Forma | Ocena | Komentarz |
|---|---|---|
| **12 nocy** | **POPRAWNE** | Liczebniki 5–21 (w tym „nastolatki” 11–21) łączą się z **dopełniaczem liczby mnogiej**: *nocy*. |
| **12 Nocy** / **12 NOCY** | Gramatyka OK, kapitalizacja z UI | W źródle jest małe **„nocy”** (`Lessons.json`, `Models.swift`). Wielkie litery pochodzą z `.uppercased()` na wokandzie (`DeskView.swift` ~248) → *WSTĘP · 12 NOCY*. To nie jest błąd fleksji. |
| **24 nocy** (mianownik / etykieta policzalna) | **BŁĄD / niespójność** | Dla 22–24 (ostatnia cyfra 2–4, **poza** 12–14) forma liczona to **noce**: *24 noce*. |
| **24 noce** | **POPRAWNE** | Tak też pisze witryna: *„Dwadzieścia cztery noce”* (`Website/src/data/site.ts`, `index.astro`, `wokanda/index.astro`). |
| EN **12 nights** / **24 nights** | **POPRAWNE** | Angielski nie ma paucalu; zawsze *nights* dla n≠1. |

### Reguła (noc, rodzaj żeński)

| Liczba | Forma | Przykład |
|---|---|---|
| 1 | *noc* | 1 noc |
| 2–4 | *noce* | 2 noce, 3 noce, 4 noce |
| 5–21 | *nocy* | 5 nocy … **12 nocy** … 21 nocy |
| 22–24 | *noce* | 22 noce, 23 noce, **24 noce** |
| 25–31 | *nocy* | 25 nocy … |
| (wzór dalej: ostatnia cyfra 2–4 → *noce*, poza 12–14; reszta → *nocy*) |

**Uwaga składniowa:** w konstrukcjach już dopełniaczowych (*komplet nocy*, *% nocy z werdyktem*, *z 24 nocy*) *nocy* bywa poprawne nawet przy 24. Problem Grega dotyczy **etykiet policzalnych** w stylu sezonu / pakietu: *„… · N noun”*.

### Gdzie w kodzie boli „24”

```33:33:Engine/TrainingReport.swift
            return Copy.s(language, pl: "Cały pakiet · \(all.count) nocy", en: "Full pack · \(all.count) nights")
```

Przy 24 lekcjach dyplom/raport dostaje **„Cały pakiet · 24 nocy”** (oraz w `trainingName`: *Czerwona Teczka — Cały pakiet · 24 nocy*). Powinno być **„… · 24 noce”** (albo pełne *dwadzieścia cztery noce*). Brak helpera fleksji — forma *nocy* jest **zahardkodowana**.

Sezon 0: *„Wstęp · 12 nocy”* — **zostawić**.

---

## 2. Źródła przejrzane

| Źródło | Rola |
|---|---|
| `Engine/Copy.swift` | tylko `s(pl:en:)` — brak katalogu stringów |
| `Resources/Lessons.json` | 24 noce, ~816 par PL/EN (tytuły, dialogi, Ratio, briefing) |
| `Engine/Models.swift` | werdykty TRAFNE/…, `prologueSeasonTitle` |
| `Engine/ExhibitGesture.swift` | sceny na przedmiocie + nazwy nawyków |
| `Engine/TrainingReport.swift`, `ReportPDF.swift`, `ReportBadge.swift`, `ReportExporter.swift`, `ReportSharing.swift` | dyplom, badge, CSV/JSON |
| `Views/*` | wokanda, Ratio, briefing, ustawienia, raport pracodawcy, how-to, splash |
| `World/Canon.swift`, `SlownikPolGry.md` | kanon + słownik ekranów |
| `Website/src/**` | PL-only marketing; leady nocy w `site.ts` |
| `tools/macos-studio/komiks-sezony.md` | prompty; napisy in-app = Lessons / SwiftUI |

---

## 3. Findings — severity

### P0 — must-fix (jasny błąd, bezpieczna poprawka)

#### P0-1. Badge: „W TOK” zamiast „W TOKU”
- **Gdzie:** `Engine/ReportBadge.swift:61` — wstęga stylu `.ribbon`: `pl: "W TOK"`.
- **Problem:** urwane *toku*; obok w tym samym pliku poprawne *„W toku — próg jeszcze nieosiągnięty”* (linia 93).
- **Propozycja PL:** `W TOKU`  
- **EN:** `IN PROGRESS` (OK).  
- **Uwaga:** produkcyjny styl badge to `.folder`, więc wstęga może nie być widoczna w buildzie — i tak warto poprawić, bo `Style` jest w `CaseIterable` (preview).

#### P0-2. Pakiet 24: zahardkodowane „nocy”
- **Gdzie:** `Engine/TrainingReport.swift:33` (`ReportScope.pack.title`).
- **Problem:** *24 nocy* zamiast *24 noce* w etykiecie zakresu (PDF, UI raportu, `trainingName`).
- **Propozycja:** helper `Copy.nights(count, language)` / `nocForm(n)`:
  - PL: 1 → *noc*; 2–4, 22–24, 32–34… → *noce*; 5–21 oraz pozostałe → *nocy*
  - EN: 1 → *night*; else → *nights*
- **Propozycja stringu:** `Cały pakiet · \(n) \(nocForm)` → przy 24: **„Cały pakiet · 24 noce”** / **„Full pack · 24 nights”**.

#### P0-3. (Powiązane) Brak fleksji przy innych dynamicznych „nocy”
- **Gdzie:** `Views/SettingsView.swift:221` — *„… z \(lessonCount) nocy”* (przy 24 w dopełniaczu po *z* zwykle OK); ważniejsze: wszelkie przyszłe zakresy 2–4 lekcji (fixture `short-2x3` / `short-2x4`) z tym samym hardcodem w `pack.title` dadzą *„3 nocy”* zamiast *„3 noce”*.
- **Propozycja:** ten sam helper co P0-2; nie espalować ręcznie w każdym stringu.

---

### P1 — should-fix (niespójność / anglicyzm / EN nieidiomatyczny)

#### P1-1. Aplikant ↔ associate ↔ trainee
- **PL** konsekwentnie *aplikant*.
- **EN miesza:**
  - sezon / desk: *Associate* / *The associate* (`Lessons.json` seasonTitle, `DeskView.swift:184`)
  - Canon Iglica: *Trainee* (`Canon.swift:77`)
  - Lessons: raz *trainee*, raz *associate* (np. noc 01 vs noc 11)
- **Problem:** w UK/US *associate* ≠ polski *aplikant* (bliżej *trainee solicitor* / *law trainee*).
- **Propozycja EN (wybrać jedną i trzymać):** preferowane **trainee** (zgodnie z Canon); sezon: *Season 1 · The trainee* (lub *Trainee*). Unikać *associate*, chyba że świadomie US-owy rejestr.

#### P1-2. „MODUŁ AWARENESS” — mieszanka PL+EN
- **Gdzie:** `ReportPDF.swift:47` PL: *„CZERWONA TECZKA · MODUŁ AWARENESS”*; kicker briefingu: *AWARENESS* (`AwarenessView.swift:14`) w obu językach.
- **Propozycja PL:** *MODUŁ ŚWIADOMOŚCI* albo *MODUŁ AWARENESS* jako świadomy brand — wtedy **udokumentować** w słowniku; dziś wygląda na niedomytą lokalizację.
- **EN:** *AWARENESS MODULE* OK.

#### P1-3. „Ratio” / „Briefing” — zapożyczenia UI
- `RatioView` title zawsze `"Ratio"` (bez `Copy.s`).
- How-to i CTA: *briefing kancelaryjny* / *firm briefing*.
- PDF: *komplet nocy i **briefingów*** (`ReportPDF.swift:102`).
- **Ocena:** spójne z noir/IT tonem; nie jest błędem ortograficznym. Dla czystego PL HR: *odprawa* / *szkolenie uzupełniające* — decyzja produktowa, nie „fix gramatyki”.
- **Propozycja:** wpis w `SlownikPolGry.md`: Ratio, Briefing, Wokanda/Docket, TRAFNE/SOUND — **terminy kanoniczne, nie tłumaczyć ad hoc**.

#### P1-4. Werdykty: rejestr PL vs EN
| PL (stempel) | EN | Uwaga |
|---|---|---|
| TRAFNE | SOUND | EN dosłownie „dźwiękowy”; w rejestrze prawniczym/security bywa *sound judgment* — **akceptowalne**, ale obce dla gracza-laika |
| BŁĘDNE | UNSOUND | rzadkie w UI gier; naturalniej *WRONG* / *UNSAFE* / *BAD CALL* |
| NIEPEŁNE | INCOMPLETE | OK |

How-to używa małych form opisowych (*trafny, błędny, niepełny*) vs stempel wielkimi — **OK** (różnica rejestru).

CSV/JSON: `BLEDNE` / `NIEPELNE` bez diakrytyków (`TrainingReport.token`) — **celowe ASCII**; nie mylić z copy UI.

#### P1-5. ZAMKNIĘTE → CLOSED vs LOCKED
- **Gdzie:** `DeskView.swift:301` sezon zamknięty: EN *CLOSED*; `:422` noc zablokowana: EN *LOCKED*; PL w obu *ZAMKNIĘTE*.
- **Propozycja:** rozróżnić PL (*ZABLOKOWANE* vs *ZAMKNIĘTE*) **albo** ujednolicić EN do jednego terminu świadomie. Dziś EN jest precyzyjniejszy niż PL.

#### P1-6. EN „docket” / „the list” / „fall off the list”
- *Wokanda* → *docket* (spójne w UI).
- W Lessons bywa *the list* jako wokanda sądowa (`12-okup`, `24-ekran`) — w EN court slang OK; dla niespecjalisty może być niejasne. Opcjonalnie *court list* / *hearing list* przy pierwszym użyciu.

#### P1-7. PDF EN threshold note
- `ReportPDF.swift:102`: *„sound calls, every night and briefing done”* — kaleczne, jak z checklisty.
- **Propozycja EN:** *„sound decisions, all nights and briefings completed”*  
- **PL** *„trafnych decyzji, komplet nocy i briefingów”* — zrozumiałe; ewentualnie *„… oraz wszystkich briefingów”*.

#### P1-8. Splash: odwrócone tłumaczenie tytułu
- `SplashView.swift:78`: PL pokazuje *„The Red File”*, EN pokazuje *„Czerwona Teczka”*.
- Wygląda na **świadomy zabieg brandingowy**; jeśli nie — P1 do odwrócenia. Udokumentować w Canon/słowniku.

#### P1-9. Witryna: hardkod PL sezonów na kartach
- `Website/src/components/DocketCard.astro:26`: zawsze *SEZON APLIKANTA* / *SEZON MECENASA* (witryna i tak PL-only — OK na dziś). Przy EN locale będzie P0.

---

### P2 — nice-to-fix / styl

#### P2-1. Kapitalizacja ALL CAPS
Kickery (`WOKANDA`, `TEJ NOCY`, `NA BIURKU`, `ZAKRES`, …) + `.uppercased()` na tytułach sezonów. Po polsku Title Case / SCREAMING CASE jest rzadsze niż w EN UI — tu to **konwencja noir**, nie błąd. Greg mógł odczytać *12 NOCY* jako *„12 Nocy”*.

#### P2-2. „Biblia wizualna” / „Visual bible”
Zargon produkcyjny; dla gracza-HR może brzmieć obco. Alternatywy: *Obsada*, *The cast* (już użyte jako title w `VisualBibleView`).

#### P2-3. „Partner Chropot” w PL
Zostawia ang. *Partner*; naturalniej *wspólnik Chropot* / *partner Chropot* (małe p jako zapożyczenie branżowe). Ton fiction — P2.

#### P2-4. „ODRZUT” jako etykieta wyboru
Kolokwialne; pasuje do stempla. Alternatywa: *ODRZUĆ* (tryb rozkazujący jak inne CTA).

#### P2-5. Organisation (BE) vs organization
Raport EN: *Organisation* (`EmployerReportView`); disclaimer: *organisation's*. Spójne BE — OK; nie mieszać z AE bez decyzji.

#### P2-6. Identyczne PL/EN
`Portal · Word` (subtitle noc 10) — nazwy własne, OK.

#### P2-7. Komiks
Napisy w grze = `Lessons.json` / SwiftUI; `komiks-sezony.md` to pipeline Midjourney (często EN w promptach, PL w `caption_pl`). Audyt in-app nie wymaga edycji promptów.

#### P2-8. Drobne EN calques (styl, nie błędy)
- *Open the file* ← *Otwórz teczkę* — świadome.
- *night’s object* — poprawne, nieco sztywne; *the object for this night* płynniejsze.
- *What should have lit up* ← lampka — OK w konwencji.

#### P2-9. „NIEUKOŃCZONO”
Zrost akceptowalny na stemplu dyplomu; naturalniej *NIE UKOŃCZONO*. Świadomy skrót UI — zostawić lub spójnie z badge.

#### P2-10. Lessons — jakość narracji
Próbka nocy 01, 03, 12, 13, 24: PL płynny, interpunkcja polska (*„…”*), EN naturalny, bez oczywistych literówek i bez pustych lokalizacji. **Brak P0 w dialogach próby.** Pełne 816 par nie było line-editowane słowo po słowie — przy masowym passie warto drugi przegląd Ratio/statute pod kątem kalki.

---

## 4. Matryca „noc” w produkcie (stan obecny)

| Miejsce | PL dziś | Ocena |
|---|---|---|
| Sezon 0 title | Wstęp · 12 nocy | OK |
| Pack title (dynamic) | Cały pakiet · \(n\) nocy | **Źle dla 24 i dla 2–4** |
| Desk section header | uppercased sezon title | OK fleksja; caps z UI |
| Website hero | Dwadzieścia cztery noce | OK |
| PDF próg | komplet nocy | OK (dopełniacz) |
| EmployerReport próg | % nocy z werdyktem | OK (dopełniacz) |
| Settings status | z N nocy | zwykle OK przy 12/24 po *z* |
| How-to / desk body | noce / nocy / nocy (odmiana w zdaniu) | OK |

---

## 5. Top 10 issues (skrót dla parent / Greg)

1. **„12 nocy” jest poprawne** — nie zmieniać; wielkie N z ALL CAPS wokandy.  
2. **„24 nocy” w tytule pakietu jest złe** → **„24 noce”** (`TrainingReport.swift:33` + helper fleksji).  
3. **Badge „W TOK”** → **„W TOKU”** (`ReportBadge.swift:61`).  
4. **EN aplikant:** ujednolicić *trainee* vs *associate*.  
5. **„MODUŁ AWARENESS”** — albo pełna PL, albo świadomy brand w słowniku.  
6. **PDF EN** *sound calls, every night and briefing done* — przepisać na naturalny EN.  
7. **ZAMKNIĘTE / CLOSED / LOCKED** — rozjechane mapowanie.  
8. **Ratio** bez lokalizacji tytułu; Briefing/Ratio jako kanoniczne anglicyzmy — opisać w słowniku.  
9. **SOUND / UNSOUND** — idiomatyczność dla laika (opcjonalnie WRONG / BAD CALL).  
10. **Splash PL↔EN title swap** — potwierdzić jako brand albo odwrócić.

---

## 6. Proponowane poprawki (do osobnego PR — nie w tym audycie)

```text
// szkic helpera (nie wdrożony)
func plNoc(_ n: Int) -> String {
  let n100 = abs(n) % 100, n10 = abs(n) % 10
  if n == 1 || n100 == 1 && n != 11 { return "noc" } // uprościć wg reguły wyżej
  if (n10 >= 2 && n10 <= 4) && !(n100 >= 12 && n100 <= 14) { return "noce" }
  return "nocy"
}
```

Minimalny bezpieczny diff (gdy Greg powie „fix”):
1. `ReportBadge`: `W TOK` → `W TOKU`
2. `ReportScope.pack`: użyć `plNoc(all.count)` zamiast literału `nocy`
3. (Opcjonalnie) sezon pack EN bez zmian; PDF threshold EN rewrite
4. Glossary patch w `World/SlownikPolGry.md`

**Nie ruszać** masowo `Lessons.json` bez osobnego passu narracyjnego.

---

## 7. Poza zakresem (z briefu)

- Bez mass-edit copy  
- Bez redesignu ikony / badge layoutu  
- Bez merge  
- Commit dozwolony **tylko** dla tego pliku audytu  

---

*Koniec audytu.*


---

## 8. Zastosowane poprawki (02.10.2026, ten branch)

Wdrożono po decyzji Grega „apply ALL fixes”. Vocabulary noir/IT (Ratio, Briefing, Awareness) **zostawione**.

| ID | Zmiana | Pliki |
|---|---|---|
| P0-1 | Badge `W TOK` → **`W TOKU`** | `Engine/ReportBadge.swift` |
| P0-2 / P0-3 | Helper `Copy.nights` / `nightsLabeled`; pakiet **„Cały pakiet · 24 noce”** | `Engine/Copy.swift`, `Engine/TrainingReport.swift` |
| P1-1 | EN aplikant: **trainee** (Desk + sezon + narracja Lessons) | `Views/DeskView.swift`, `tools/build_lessons.py`, `Resources/Lessons.json` |
| P1-2 | `MODUŁ AWARENESS` **zostaje** jako brand | udokumentowane w `World/SlownikPolGry.md` |
| P1-3 | Ratio / Briefing **bez zmian** | słownik |
| P1-5 | Noc zablokowana: PL **ZABLOKOWANE** (EN LOCKED); sezon: ZAMKNIĘTE / CLOSED | `Views/DeskView.swift` |
| P1-7 | PDF EN threshold: *sound decisions, all nights and briefings completed* | `Engine/ReportPDF.swift` |
| P1-8 | Splash PL↔EN title swap **zostaje** jako brand | słownik |
| P2 | Bez masowej edycji stylu / Lessons narracji poza trainee | — |

**CI (osobno):** `Website/src/pages/verify/[reportId].astro` — dodano `getStaticPaths()` → `[]` (rejestr nieżywy); landing `verify/index.astro`.

*Koniec sekcji zastosowań.*
