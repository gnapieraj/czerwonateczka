# Plan: raport / dyplom ukończenia (Czerwona Teczka)

**Status:** decyzje produktowe zamknięte (2026-10-01); **MVP zaimplementowane w aplikacji** (patrz §0).  
**Produkt:** gra edukacyjna Czerwona Teczka + colgante.pl  
**Cel:** udokumentowana ścieżka szkolenia pracowników (RODO, bezpieczeństwo informacji, ISO 27001 i podobne).

---

## 0. Status implementacji MVP (2026-10-01)

**Wylądowało w kodzie (free build, zero sieci, zero konta):**

| Element | Gdzie | Uwagi |
|--------|-------|-------|
| Pass policy ≥ 90% TRAFNE | `Engine/TrainingReport.swift` → `PassPolicy`, `PassEvaluation` | Arytmetyka całkowita: 12 → 11, 24 → 22. Liczy się **ostatni** werdykt **po przejrzanym briefingu**; NIEPEŁNE i BŁĘDNE = nie-TRAFNE; każda noc w zakresie musi mieć stempel. |
| Stempel z datą i flagą briefingu | `Engine/Models.swift` → `DocketStamp.stampedAt`, `.briefed`; `GameStore.markBriefed` | Nowy stempel ma `briefed=false` do zamknięcia briefingu. Stemple sprzed tej zmiany dekodują się jako `briefed=true` (briefing był już obowiązkową ścieżką). |
| Zakres raportu | `ReportScope` (`.season(id)` / `.pack`) | Domyślnie najszerszy zaliczony zakres (cały pakiet, inaczej pierwszy zaliczony sezon). |
| PDF dyplom (PL domyślnie, EN wg języka gry) | `Engine/ReportPDF.swift` (UIGraphicsPDFRenderer, A4) | Imię i nazwisko, organizacja, data ukończenia (Europe/Warsaw), nazwa sezonu/packa, pełna lista tematów (id + tytuł), status UKOŃCZONO tylko przy pass, ważne do / następne przypomnienie, `reportId`, `contentVersion`, SHA-256 pakietu, disclaimer. **Bez werdyktów per noc.** |
| CSV rejestr szkoleń (§6.2) | `ReportCSV.register` | Dokładnie kolumny z §6.2, separator tematów ` \| `, BOM UTF-8 dla Excela. Dodatkowo `*_lekcje.csv` (per noc, tylko HR). |
| JSON (§6.3) | `ReportJSON` / `TrainingReport` | Ten sam payload + `seasons[].lessons[]` z `lastVerdict`, `stampedAt`, `briefed`; daty ISO 8601; `nextReminderAt`. |
| Share Sheet | `Views/EmployerReportView.swift` → `ShareSheet` (UIActivityViewController) | Podgląd PDF (PDFKit), Udostępnij PDF, Eksport CSV, Eksport JSON, Udostępnij komplet. Pliki w katalogu tymczasowym aplikacji. |
| Settings → „Raport dla pracodawcy” | `Views/SettingsView.swift` → `EmployerReportView` | Imię i nazwisko (wymagane), organizacja, podpowiedź e-maila HR (tylko składnia + „kopiuj”; nigdy odbiorca ani relay). Poniżej progu: lista braków (bez stempla / briefing / brakujące TRAFNE), eksport zablokowany. |
| Persist formularza | `GameStore.reportForm` → UserDefaults `report.form` | Czyszczone przy „Pierwsze uruchomienie”. |
| Ważność | `ReportConfig.free` | `validityMonths = 12`, przypomnienie 30 dni przed (`reminderLeadDays`). Hook pod konfig org. |
| Testy | `CzerwonaTeczkaTests/TrainingReportTests.swift`, rozszerzony `LessonPackTests` | Pass-policy, szablon CSV, escaping, hash (wektor SHA-256 + stabilność/scope), JSON round-trip, daty, legacy stemple, flaga briefingu w przepływie nocy. |

**Odłożone (zgodnie z fazami §12):**

- v2: QR + publiczny verify (wariant A) na colgante.pl, flaga EN per org, `validUntil` z konfigu org.
- v3 / B2B: flavory / Custom Apps, `OrgConfig`, portal HR z logowaniem, przypomnienia z `nextReminderAt` po stronie klienta, ostrzejsza polityka pass per org.
- Nadal **zakazane** w free: SMTP, `mailto` jako relay, automatyczna wysyłka, konta.

**Decyzje z §14 podjęte przy implementacji:** ostatni werdykt (nie najlepszy); NIEPEŁNE w mianowniku jako nie-TRAFNE; `validityMonths` free = 12; raport dostępny dla Sezonu 0, Sezonu 1 i całego pakietu (24).

---

## 1. Werdykt

Raport/dyplom ma sens jako **dowód ukończenia awareness** pod RODO art. 39/32 i ISO 27001:2022 A.6.3, nie jako urzędowy „certyfikat kompetencji”.

- **MVP:** lokalny PDF + Share Sheet + CSV (szablon rejestru) + JSON (automatyzacja przypomnień).
- **Bez** SMTP / otwartego `mailto` z aplikacji jako relay (spam).
- Wersja **free/marketingowa** w App Store: **bez konta**, offline, bez analityki.
- **B2B** (osobne buildy org, portal HR): **poza App Store** — strona + umowa.
- Publiczna weryfikacja QR (v2): **wariant A** — bez imienia i nazwiska na stronie.

---

## 2. Decyzje Grega (zamknięte)

| # | Temat | Decyzja |
|---|--------|---------|
| 1 | Zaliczenie | Wymagane **TRAFNE** / próg **≥ 90%** (polityka pass — szczegóły w §5) |
| 2 | Werdykty per noc | Tylko w eksporcie **dla HR** (CSV/JSON); **nie** na PDF dyplomie |
| 3 | Ważność / refresher | **Konfigurowalne per organizacja** |
| 4 | Verify v2 (QR) | **Wariant A** — bez PII (imię) na stronie publicznej |
| 5 | Org packs / sezony | **Osobny build per organizacja**; w App Store tylko free/marketing |
| 6 | Konta | Gra w store: **bez konta**. Portal B2B z logowaniem — **wyłącznie poza sklepem** |
| 7 | Język dyplomu | **PL domyślnie**; **EN opcjonalnie** (konfig org) |
| 8 | Eksport | **Gotowy szablon CSV** pod rejestr szkoleń + **JSON** pod automatyzację przypomnień |

---

## 3. Best practices (kontekst compliance)

- **ISO 27001:2022 A.6.3** (dawniej A.7.2.2): program awareness + indywidualne rekordy (kto, kiedy, temat, dowód zrozumienia).
- **ISO 7.2 Competence:** udokumentowana kompetencja / ukończenie; retencja często cykl ~3 lata lub polityka org.
- **RODO:** art. 39 ust. 1 lit. b (IOD — szkolenia), art. 32 (środki organizacyjne), art. 5 ust. 2 (rozliczalność).
- Minimalny rekord praktyczny: uczestnik, data, zakres/tematy, forma (e-learning/gra), organizator, status ukończenia, data następnego odświeżenia.
- Częstotliwość de facto: onboarding + refresher ≥ raz/rok (wartość domyślna; u nas **konfig org**).
- PDF sam w sobie jest łatwy do sfałszowania → v2: UUID + publiczny URL/QR **bez zbędnych PII**.

**Disclaimer na każdym dyplomie:** materiał edukacyjny / fikcja Colgante; nie jest poradą prawną; nie zastępuje polityki firmy ani szkoleń role-specific.

---

## 4. Zakres dydaktyczny (katalog lekcji w grze)

Raport zawsze zawiera **dokładną listę tematów** z zakresu ukończonego packa/sezonu. Elastyczność: `seasonIds[]` lub `packId`.

### Sezon 0 — `seasonId=0` „Wstęp · 12 nocy”

| # | id | Tytuł PL | Temat awareness (skrót) |
|---|-----|----------|-------------------------|
| 01 | 01-kod | Drugie zatwierdzenie | MFA / approve ≠ Twoje logowanie |
| 02 | 02-list | Doklejone pismo | PDF „od sądu” vs portal |
| 03 | 03-prompt | Ugoda w asystencie | Wklejanie akt do LLM |
| 04 | 04-haslo | Hasło przed radą | Link + hasło w jednym kanale |
| 05 | 05-arkusz | Hasło klienta | Hasło w aktach / zdjęciu |
| 06 | 06-pomoc | Program w trakcie awarii | Fake IT / remote tool |
| 07 | 07-sms | Druga opłata | Smishing |
| 08 | 08-qr | IBAN po wyroku | BEC / QR na inny rachunek |
| 09 | 09-glos | Numer z pisma | Spoofing głosu / numeru |
| 10 | 10-okno | Makra w pozwie | Makra / „Włącz treść” |
| 11 | 11-konta | Skrzynka po odejściu | Offboarding / MFA |
| 12 | 12-okup | Bitcoin przed rozprawą | Ransomware / lista awaryjna |

### Sezon 1 — `seasonId=1` „Sezon 1 · Aplikant”

| # | id | Tytuł PL | Temat (subtitle) |
|---|-----|----------|------------------|
| 13 | 13-chmura | Akta w tramwaju | Prywatny telefon |
| 14 | 14-cudze | Login partnera | Cudze konto |
| 15 | 15-polecenie | Jedna strona na rano | Polecenie |
| 16 | 16-link | Rozprawa na komunikatorze | Link |
| 17 | 17-wydruk | Wydruk u rodziców | Wydruk |
| 18 | 18-odbior | Pokwitowanie za partnera | Odbiór |
| 19 | 19-mandat | Klient dzwoni do ciebie | Mandat |
| 20 | 20-nosnik | Pendrive protokolanta | Nośnik |
| 21 | 21-termin | Zaproszenie do kalendarza | Termin |
| 22 | 22-granica | Akta drugiej sprawy | Granica |
| 23 | 23-nagranie | Notatka z rozmowy | Nagranie |
| 24 | 24-ekran | Laptop na korytarzu | Ekran |

Każda lekcja ma briefing awareness (`threat` / `minimize` / `practice` / `watchFor`).  
Hash integralności: SHA-256 pakietu lekcji faktycznie objętych raportem + `contentVersion` builda.

---

## 5. Zaliczenie (pass policy)

**Decyzja:** wymagane TRAFNE / próg **90%**.

Propozycja precyzji implementacyjnej (do potwierdzenia przy kodzie):

- Zakres = wszystkie lekcje w packu/sezonie objętym raportem.
- Dla każdej lekcji liczy się **ostatni** werdykt (lub najlepszy — do ustalenia przy implementacji; rekomendacja: **ostatni po obowiązkowym briefingu**).
- `pass` ⟺ `(liczba TRAFNE / liczba lekcji w zakresie) ≥ 0,90` **oraz** wszystkie lekcje mają stempel + przejrzany briefing.
- Przy 12 lekcjach: min. **11× TRAFNE** (11/12 ≈ 91,7%); 10/12 ≈ 83% = fail.
- Przy 24 lekcjach: min. **22× TRAFNE**.
- PDF przy fail: brak dyplomu „ukończono”; UI: „Uzupełnij noce poniżej progu” + lista.
- Statystyki TRAFNE/BŁĘDNE/NIEPEŁNE: **tylko CSV/JSON dla HR**, nie na dyplomie PDF.

---

## 6. Forma artefaktów

### 6.1 PDF dyplom (udostępniany Share Sheet)

- Tytuł: potwierdzenie ukończenia modułu edukacyjnego „Czerwona Teczka”.
- Imię i nazwisko (wpis lokalny użytkownika).
- Nazwa organizacji.
- Data ukończenia (Europe/Warsaw, ISO w metadanych).
- Zakres: nazwy sezonów/packa + **pełna lista tematów** (id + tytuł).
- Status: UKOŃCZONO (tylko jeśli pass).
- Ważne do / następne szkolenie przypominające (`validUntil` / `nextReminderAt`) — z **konfigu org**.
- `reportId` (UUID), wersja contentu, skrót hasha pakietu.
- QR (v2) → verify bez PII.
- Język: PL domyślnie; EN jeśli org włączy.
- **Bez** tabeli werdyktów per noc.

### 6.2 CSV — szablon rejestru szkoleń (art. 39 / IOD/HR)

Jedna linia = jedno ukończenie (lub jeden wiersz na osobę × pack). Proponowane kolumny:

| Kolumna | Opis |
|--------|------|
| `data_ukonczenia` | YYYY-MM-DD |
| `imie_i_nazwisko` | |
| `organizacja` | |
| `nazwa_szkolenia` | np. Czerwona Teczka — Sezon 0 |
| `forma` | e-learning / gra edukacyjna |
| `dostawca` | Colgante / colgante.pl |
| `zakres_tematow` | lista id+tytułów (separator `\|` lub `;`) |
| `status` | UKONCZONO / NIEUKONCZONO |
| `procent_trafne` | 0–100 |
| `liczba_lekcji` | |
| `liczba_trafne` | |
| `liczba_bledne` | |
| `liczba_niepelne` | |
| `wazne_do` | YYYY-MM-DD (konfig org) |
| `nastepne_przypomnienie` | YYYY-MM-DD |
| `jezyk_dyplomu` | pl \| en |
| `report_id` | UUID |
| `content_version` | |
| `lessons_pack_hash` | SHA-256 |
| `build_flavor` | free \| org:\<orgId\> |

Opcjonalny drugi arkusz / plik `*_lekcje.csv`: `report_id, lesson_id, tytul, werdykt, data_stempel` — **tylko HR**.

### 6.3 JSON — automatyzacja przypomnień

Ten sam payload co CSV + struktura zagnieżdżona `seasons[].lessons[]` z `lastVerdict`.  
Przykładowe użycie B2B (poza store): job cron czyta `nextReminderAt`, wysyła mail/Teams do pracownika lub HR **z infrastruktury klienta / portalu**, nie z telefonu gracza.

---

## 7. Weryfikacja publiczna (v2) — wariant A

URL: `https://colgante.pl/verify/{reportId}` (lub równoważny).

**Widoczne:** reportId, status ważności, data wydania, zakres (sezony/tematy bez PII), hash pakietu, issuer, ewentualnie nazwa org **jeśli org wyrazi zgodę na publikację nazwy**.

**Niewidoczne:** imię i nazwisko, email pracownika, werdykty per noc, adres HR.

Rejestracja verify: minimalny payload podpisany; retencja wg polityki (np. do `validUntil` + bufor lub 36 mies.); prawo do usunięcia po stronie umowy B2B.

---

## 8. App Store vs buildy organizacyjne

### 8.1 Free / marketing (publiczny App Store)

- Jedna aplikacja publiczna.
- Sezony/packi marketingowe (np. Sezon 0 demo / pełny zakres publiczny — wg strategii contentu).
- Raport: PDF + Share Sheet + lokalny CSV/JSON.
- Brak konta, brak wymuszonego logowania, brak otwartego wysyłania maili z backendu Colgante do dowolnych adresów.
- Copy zgodne z: Offline / bez konta / bez analityki.

### 8.2 Build per organizacja (B2B, poza publicznym listingiem)

**Problem:** App Store nie skaluje się na „osobną publiczną aplikację dla każdej firmy” (review, listing, ASO, utrzymanie).

**Rekomendowany model dystrybucji Apple:**

| Model | Kiedy | Uwagi |
|-------|--------|------|
| **Apple Custom Apps** (ABM/ASM + private distribution) | Główna ścieżka B2B | Org kupuje/przypisuje app przez Business Manager; **nie** wisi publicznie w App Store |
| **Unlisted App** | Gdy potrzebny link bez ABM | Ukryty URL App Store; nadal jedna „app” per bundle lub shared |
| **Apple Business Manager + MDM** | Floty służbowe | Wymuszenie Managed App Config (orgId, validityMonths, hrAllowlist, locale) |
| **TestFlight (external private)** | Pilotaż | Nie produkcja długoterminowa |
| **Apple Developer Enterprise** | Tylko gdy klient ma własny Enterprise | Rzadko; nie „Twój” Enterprise dla obcych firm |

**Jak ogarnąć wiele org bez setek listingów:**

1. **Jeden kod źródłowy**, wiele **flavorów** (Xcode configurations / schemes): `Free`, `Org_Acme`, `Org_BankX`…
2. Każdy flavor: własny **Bundle ID** *albo* wspólny Bundle ID + **Managed App Config** / embedded `OrgConfig.plist` (orgId, packIds, validityMonths, languages, branding).
3. Preferencja długoterminowa: **jeden Custom App B2B** + konfiguracja per org (MDM / kod aktywacyjny org **tylko w buildzie B2B**, nie w free) — mniej review niż N kompletnych aplikacji.
4. Jeśli twarde wymaganie „osobny build per org”: Custom App / Unlisted **per klient**, nie publiczny search App Store; pipeline CI (Fastlane) buduje i uploaduje flavor.
5. Sezony tylko-dla-org: wkompilowane w flavor lub remote config **podpisany**, niedostępne w free.

**App Store Connect:** free = public listing. Org builds = Custom/Unlisted — użytkownicy free **nie** widzą ich w wyszukiwarce.

---

## 9. Portal B2B (poza sklepem)

- Osobna usługa web (colgante.pl / subdomena), logowanie dla HR/IOD/admin org.
- Umowa powierzenia / role: Colgante jako procesor tylko w zakresie hostowanych metadanych verify / opcjonalnych eksportów.
- Funkcje docelowe: allowlista domen HR, podgląd statusów po `reportId` (bez zbędnych PII lub z PII tylko po uploadie przez org), konfiguracja `validityMonths`, packów, języka EN, webhook/CSV import do przypomnień.
- **Nie** łączy się z narracją App Store „bez konta”.
- Gra free **nie** wymaga portalu do wygenerowania lokalnego PDF.

---

## 10. Wysyłka i anti-spam

| Mechanizm | Status |
|-----------|--------|
| Share Sheet (Mail / Files / Teams) — użytkownik sam wysyła | **MVP #1** |
| Lokalny CSV + JSON | **MVP** |
| QR verify bez PII | **v2** |
| Portal B2B + allowlista + rate limit + App Attest (build org) | **v3 / B2B** |
| SMTP lub otwarty relay z aplikacji free | **Zakazane** |

W Settings (free): nazwa org + imię na dyplomie + opcjonalna **podpowiedź** adresu HR (tylko składnia); brak „Wyślij automatycznie”.  
W buildzie org: można prefill `hr@…` z OrgConfig; nadal preferować Share lub upload do portalu org, nie masowy send z urządzenia.

---

## 11. Settings UX (kierunek)

Sekcja **„Raport dla pracodawcy”** (aktywna gdy pass ≥ 90% w zakresie):

1. Imię i nazwisko (wymagane do PDF).
2. Nazwa organizacji (free: wpis; org build: zablokowana z configu).
3. Podpowiedź email HR (opcjonalnie; free = tylko hint przy Share).
4. Język dyplomu (free: PL; org: PL/EN wg configu).
5. Podgląd PDF → Udostępnij → Eksport CSV → Eksport JSON.

---

## 12. Fazy wdrożenia

### MVP (free + wspólny silnik raportu)
- Pass policy 90% TRAFNE.
- PDF PL (bez werdyktów per noc).
- CSV szablon + JSON.
- Share Sheet.
- `reportId`, hash pakietu, disclaimer.
- Zero auto-mail, zero konta.

### v2
- QR + verify A na colgante.pl.
- EN na dyplomie (flaga).
- `validUntil` z domyślnych 12 mies. (free) / z configu (org).

### v3 / B2B
- Flavory / Custom Apps per org (lub jeden B2B app + MDM).
- Portal z logowaniem.
- Przypomnienia z JSON/`nextReminderAt` po stronie portalu lub SIEM/HR klienta.
- Opcjonalnie polityka pass ostrzejsza per org.

---

## 13. RODO / ryzyka

- Minimalizacja na verify (wariant A).
- Imię na PDF = lokalnie u użytkownika / u pracodawcy po Share; Colgante nie hostuje PII w MVP.
- Scoring na dyplomie: ukryty (decyzja 2).
- Nie nazywać dokumentu „certyfikatem ISO/RODO urzędowym”.
- Retencja i usuwanie: polityka portalu B2B + umowa.

---

## 14. Otwarte szczegóły implementacyjne (nie blokują planu)

- Czy próg 90% liczy **ostatni** czy **najlepszy** werdykt per noc?
- Czy NIEPEŁNE liczy się do mianownika jako nie-TRAFNE (tak — rekomendacja)?
- Domyślne `validityMonths` dla free (propozycja: 12).
- Czy free App Store obejmuje pełny Sezon 0+1, czy tylko subset marketingowy?
- Bundle ID strategy: jeden B2B + config vs N Custom Apps.

---

## 15. Historia decyzji

- 2026-10-01 — analiza + plan; decyzje 1–8 zamknięte przez Grega; plik zapisany w repo (`plan-raport-dyplom.md`). Brak zmian w kodzie gry/strony w tym kroku.
- 2026-10-01 — MVP w aplikacji (§0): pass policy, PDF/CSV/JSON, Share Sheet, sekcja w Ustawieniach, testy. Strona i assety bez zmian.
