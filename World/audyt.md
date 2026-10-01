# Audyt Czerwona Teczka — 2026-09-30

## Metadane (urządzenia, build, scope)

| Pole | Wartość |
|---|---|
| Data | 2026-09-30 (Europa/Warsaw, UTC+2) |
| Build / scheme | Debug, `CzerwonaTeczka`, `generic/platform=iOS Simulator` |
| Bundle | `pl.czerwonateczka.app` |
| Symulatory | iPhone 17 (`E59C2196-A990-4746-8DE9-D5C17C6D39B0`), iPad Air 11" M4 (`ACB6E3B7-5030-4CA7-AF4A-DCCBFEAC8B5C`) — oba Booted |
| Treść | `Lessons.json` — 24 lekcje (`seasonId` `"0"`×12 + `"1"`×12); audyt edukacyjny = **Sezon 0** |
| Witryna | live `https://colgante.pl` + lokalne `Website/` / `sync-content.mjs` / `site.ts` |
| Zrzuty | Mac: `World/audyt-shots/{iphone17,ipadair11}/` (16×2); box: `/workspace/czerwona-teczka/audyt-shots/`; archiwum `audyt-shots-all.tgz` |
| Ograniczenia sim | Brak `Simulator.app` (Xcode DeviceHub) — CoreSimulator headless; **brak live swipe / haptics**; ocenione z kodu + screenshotów |
| Drafty źródłowe | `audyt-draft-ui.md`, `audyt-draft-edukacja.md`, `audyt-draft-www.md`; kontekst: `AudytWarstwyEdukacyjnej.md` (22.09) |
| Uwaga | To **nie jest porada prawna**. Cel: odruch cyber + ochrona informacji (tajemnica zawodowa) pod presją. |

---

## Werdykt wykonawczy (1/2 strony)

**Sezon 0 trzyma się ekspercko.** Dwanaście nocy ma spójne oznaczenia TRAFNE / BŁĘDNE / NIEPEŁNE; brak nocy, w której TRAFNE byłoby szkodliwe. Presja postaci (Iglica, Chropot, Irena) i kategoria NIEPEŁNE (półśrodki) to mocne strony. Niuansy: nazwa JSON `trap` = TRAFNE; etykieta „deepfake” w nocy 09 vs spoofing/vishing; polityka AI kancelarii w nocy 03.

**UI na obu simach startuje i wygląda spójnie (noir).** Flow nocy: Splash → Komiks → Decyzja → Werdykt → Ratio → Briefing → Biurko. Brak crashy przy launchach/zrzutach. Bloker audytu interakcji: brak GUI Simulator — swipe i haptyk tylko z kodu. Do naprawy przed polish: copy „Pierwsze uruchomienie” ≠ zerowanie flag howto/biblii; brak obowiązkowego onboardingu przed nocą 1; iPad landscape — wąska kolumna decyzji/briefingu (~720 pt) w pustce.

**WWW (colgante.pl) jest stylistycznie i disclaimerowo mocna** (fiction-bar, rozdział fikcji/autora), zsynchronizowana tytułami z `Lessons.json`, ale ma **krytyczne rozjazdy**: copy „12 nocy” vs 24 w danych; canonical Astro bez trailing slash vs redirect Apache ze slash; tylko 6/24 nocy z kartą proceduralną; cienkie `/zrodla` (1× SANS OUCH).

**Priorytet premierowy:** (1) slash/canonical WWW, (2) decyzja copy 12↔24, (3) bug copy resetu + onboarding UI, (4) karty AKTA pod lukami (ransomware, makra…), (5) layout iPad decision/briefing.

---

## Część A — Symulatory UI (iPhone 17 + iPad Air 11 M4)

### Metoda i ograniczenia

Instalacja + launch argumenty (`--desk`, `--howto`, `--bible`, `--lesson=`, `--play=`, `--awareness=`; tymczasowe `--audit-*` / `--settings` **cofnięte** po audycie). Gestów palcem na żywo nie odpalono: w instalacji Xcode **brak** `Simulator.app` (DeviceHub); `simctl` + screenshoty działają. **Haptics i swipe** — tylko obecność w kodzie, nie odczucie.

### Mapa ekranów (brak TabView)

Stack tras (`GameStore.route`). Nawigacja na **biurku**: Jak czytać grę · Obsada · Mute · Ustawienia · Sezon 0/1 · TEJ NOCY · WOKANDA · NAWYKI.

**Przepływ nocy:** Splash (tap) → (pierwsza noc od razu) Komiks → Decyzja → Werdykt → Ratio → Briefing → Biurko.

### Pierwsze uruchomienie

1. Splash — gabinet + PKiN; wejście tapem (`SplashView` → `store.start()`).
2. Przy pustych stemplach `start()` **od razu otwiera komiks nocy 01** — bez wymuszenia „Jak czytać” / biblii (**luka onboardingowa**).
3. Wstecz z komiksu przy pustym stacku → biurko (wyjście bez stempla możliwe).
4. **BUG copy vs kod:** „Pierwsze uruchomienie” w UI obiecuje zachowanie howto/biblii; kod **kasuje** `seenBible` / `seenHowToPlay` i wraca na splash.

UserDefaults (m.in.): `docket.stamps` (JSON, nie plist), `streak`, `needsCoach`, `meters`, `seenBible`, `seenHowToPlay`, `season`. Po wstrzyknięciu stempli 01–06: NAWYKI 6/12, TEJ NOCY = 07 — OK.

### Komiks / Decyzja / Werdykt → Briefing

| Obszar | iPhone 17 | iPad Air 11 M4 | Uwagi |
|---|---|---|---|
| Komiks | 2 kadry/strona; osobna strona kontekstu; wskaźnik `01 · 1/2` | Kadry obok siebie; `01 · 1/1`; od razu DECYZJA | `HorizontalPager` = UIPageViewController — swipe w kodzie |
| Decyzja N1 | 3 karty + Odłóż telefon | Kolumna `maxWidth: 720` — **dużo pustego boku** | Ścieżka TRAFNE: first-yes → second-no → call → Odłóż → `trap` |
| Werdykt | Tap / auto ~4,6 s; brak Wstecz | j.w. | TRAFNE / BŁĘDNE / NIEPEŁNE |
| Ratio | Tylko „Dalej — briefing”; `onBack: nil` | j.w. | Świadome |
| Briefing | Wstecz / Zrozumiano / opc. Następna noc | Sekcja „minimalizuj” często poniżej fold | Mandatory path = `finishBriefing` |

Haptics w kodzie: `UIImpactFeedbackGenerator(.light)` przy gestach; `UINotificationFeedbackGenerator` success/warning przy werdykcie. **Sim nie oddaje Taptic Engine.**

### Dźwięk

Muzyka biurka (pętla fortepianu); toggle biurko + Ustawienia; UI informuje, że Silent switch też wycisza. Jakość — weryfikacja na urządzeniu.

### Layout — dobre i ryzyka

**Dobre:** spójny noir; komiks świadomie różny telefon/iPad; chrome Wstecz + a11y labels; blokada S1 do końca S0; stemple/nawyki aktualizują się poprawnie.

**Problemy:**
1. iPad decision/ratio/settings/awareness — wąska kolumna ~720 pt („telefon na tablecie”).
2. iPad biurko — WOKANDA poniżej fold (mocniejszy scroll niż iPhone).
3. iPhone „Jak czytać” — punkt 05 Werdykt ucięty w pierwszym viewportcie.
4. Awareness — „Jak minimalizować” poniżej fold → ryzyko CTA bez przeczytania.
5. Sezon 1 przyciemniony / „ZAMKNIĘTE” — OK; upewnić się, że FolderCard nie otwiera się gestem.

### Checklist przycisków (ćwiczone / zrzuty)

Splash · Biurko (howto/biblia/mute/settings/sezony/TEJ NOCY/wokanda) · Komiks Wstecz/Dalej/Kontekst/Decyzja · Decyzja N1 layout · Werdykt sound/unsound · Ratio → briefing · Briefing · Ustawienia PL/EN · `[~]` swipe · `[~]` haptics.

### Crashe / blokery

Build lokalny OK na obu simach. Crashe przy launchach/zrzutach: **nie zaobserwowano**. Bloker live interakcji: brak `Simulator.app`. Hooki audytowe przywrócone — drzewo bez `--audit-*`.

### Zasięg Season 0 w UI

| Zakres | Status |
|---|---|
| Noc 1 pełny UI (ekrany) | Zrzuty splash→…→briefing; live tap-path nie odpalony |
| Ścieżka N1 w kodzie | Udokumentowana (trap) |
| Noce 2–6 | Odblokowane JSON stamps; biurko 6/12 |
| Noce 7–12 / S1 | Nie grane E2E; komiks N7 zrzut; S1 zablokowany |

---

## Część B — Sezon 0: komiks, decyzje, Ratio, Briefingi + analiza cyber/OIN

**Źródło:** `Lessons.json` (Sezon 0, noce `01`–`12`, `storyMode: true`, tytuł „Wstęp · 12 nocy”). Sezon 1 **nie** oceniany ekspercko w tym audycie.

### Legenda JSON ↔ UI

| Pole | Znaczenie |
|---|---|
| `choices[].id == "trap"` | **TRAFNE** (`verdict: sound`) — mimo nazwy „trap” |
| `decoy-a` | **BŁĘDNE** (`unsound`) |
| `decoy-b` | **NIEPEŁNE** (`incomplete`) |
| `awareness.*` | Briefing po Ratio |
| `ratio.statute` | Tekst Ratio (w storyMode krótki) |

### Tabela 12 nocy — werdykt ekspercki

| # | Id | Tytuł | Temat | Status |
|---|---|---|---|---|
| 01 | `01-kod` | Drugie zatwierdzenie | MFA / push bombing | **Zgoda** |
| 02 | `02-list` | Doklejone pismo | Załączniki / portal | **Zgoda** |
| 03 | `03-prompt` | Ugoda w asystencie | AI / tajemnica | **Zgoda** (+ niuans polityki firmowej) |
| 04 | `04-haslo` | Hasło przed radą | Kanały / hasła | **Zgoda** |
| 05 | `05-arkusz` | Hasło klienta | Akta vs sekrety | **Zgoda** |
| 06 | `06-pomoc` | Program w trakcie awarii | Fake helpdesk | **Zgoda** |
| 07 | `07-sms` | Druga opłata | Smishing / opłaty | **Zgoda** |
| 08 | `08-qr` | IBAN po wyroku | BEC / koszty | **Zgoda** |
| 09 | `09-glos` | Numer z pisma | Vishing / spoofing | **Zgoda** (deepfake nieobowiązkowy) |
| 10 | `10-okno` | Makra w pozwie | Makra Word | **Zgoda** |
| 11 | `11-konta` | Skrzynka po odejściu | Offboarding / MFA | **Zgoda** |
| 12 | `12-okup` | Bitcoin przed rozprawą | Ransomware | **Zgoda** |

**Ogólnie:** oznaczenia spójne z dobrą praktyką i odruchem kancelaryjnym. Brak nocy do odwołania TRAFNE.

### Uwagi wspólne

1. **`trap` = TRAFNE** — mylące dla autorów/testów; w UI OK. Alias w dokumentacji / `validate_lessons`.
2. Presja postaci + NIEPEŁNE za półśrodki — mocna strona sezonu.
3. Ratio w storyMode krótkie; pełna nauka w Briefingu — **utrzymać wymuszenie Briefingu** (naprawione 22.09).
4. `sourceIds` puste; gra wskazuje SANS OUCH ogólnie — niski priorytet per-noc bibliografii.
5. Ambiguity: najwięcej ryzyka „unfair” w nocy 01 (drugi push) i 03 („mamy umowę IT”) — obie sceny fair.

### Skrót nocy (ocena + kluczowy odruch)

**01 · MFA** — Drugie „Czy zatwierdzić?” minutę po własnym = cudza sesja. TRAFNE: tylko pierwsze + oddzwonienie z książki. Zgodne z NIST 800-63B / MFA fatigue.  
**02 · Załączniki** — Źródło prawdy = portal (zapisany URL), nie forward z doklejką PDF. Nawet partner może być wektorem.  
**03 · AI** — Domyslnie nie wklejaj sprawy (nazwy/kwota/sygnatura) do modelu; układ klauzul na zmyślonym przykładzie. *Niuans:* DPA + zakaz treningu + zgoda klienta może iść dalej — Briefing mógłby to jednozdaniowo dopisać.  
**04 · Hasła** — Link i sekret rozdzielone kanały; reuse starego hasła = NIEPEŁNE.  
**05 · Akta vs sekrety** — Credential ≠ treść akt; menedżer, nie chronologia / zdjęcie tablicy.  
**06 · Fake helpdesk** — Trzymaj się własnego ticketu IT; „na próbę” na laptopie kolegi = nadal incydent.  
**07 · Smishing** — Prawda w nakazie/księdze; nie link i nie callback na numer z SMS.  
**08 · BEC** — IBAN z wyroku, nie QR z Gmail-PDF; potwierdzenie *po* przelewie nie cofa środków (doskonałe NIEPEŁNE).  
**09 · Vishing** — Callback na numer z akt; WhatsApp na tym samym telefonie ≠ out-of-band. *Niuans etykiety:* scena działa przy spoofingu CLI + SE; głęboki fake nie jest konieczny.  
**10 · Makra** — Nie „Włącz treść”; PDF z portalu; numer ze stopki = przynęta.  
**11 · Offboarding** — Revoke same day; MFA device ownership; hasło bez zmiany MFA = NIEPEŁNE.  
**12 · Ransomware** — Odłącz + lista awaryjna + prawda dla klienta; bez okupu jako odruch pierwszej godziny (CISA/ENISA/CERT). *Niuans:* realny IR bywa złożony (zarząd/ubezpieczyciel) — gra uczy pierwszej godziny, właściwie.

### Rekomendacje edukacyjne (kolejna iteracja)

1. Zostawić mapę TRAFNE/BŁĘDNE/NIEPEŁNE Sezonu 0.
2. Briefing nocy 03: zdanie o polityce AI kancelarii (minimum vs formuła firmowa).
3. Noc 09: etykieta „spoofing + vishing (+ ewentualny deepfake)”.
4. Utrzymać wymuszenie Briefingu po Ratio.
5. Opcjonalnie karty WWW dla nocy bez procedury (02, 04–06, 10, 12…).
6. Nie zmieniać `trap` w JSON bez migracji testów — alias w docs.

---

## Część C — Witryna colgante.pl

**Źródła:** live colgante.pl, lokalne `Website/` + sync z `Lessons.json`. Sitemap ~38 URL. Severity: Krytyczne / Wysokie / Średnie / Niskie / Pozytyw.

### Werdykt WWW

Witryna **czytelna, stylistycznie spójna z grą, wyjątkowo mocna w rozdzieleniu fikcji od realnego autora**. Briefing + refleks + 3 karty proceduralne merytorycznie OK w zakresie Sezonu 0. Główne problemy: **12 vs 24 w copy**, **cienkie źródła i karty vs 24 teczki**, **canonical bez slash vs redirect ze slash**, **brak wizualnego podziału sezonów**.

### Struktura i nawigacja

Nav: Wokanda · Poznaj grę · Materiały · Czerwona lampka · Jak czytać grę · Autor. Stopka: O projekcie · Źródła · Prywatność · Newsletter + disclaimer fikcji.

| ID | Sev | Finding |
|---|---|---|
| S-01 | **Wysokie** | Home/meta: „Dwanaście nocy”; gra i `/wokanda` = **24**. CTA „Dwa sezony →” przeczy leadowi. |
| S-02 | **Średnie** | `/o-projekcie` nadal „Dwanaście nocy…”. |
| S-03 | **Średnie** | `/zrodla`, `/prywatnosc` tylko w stopce — Źródła warto bliżej wokandy/briefingu. |
| S-04 | **Niskie** | 24 filtry tematów ≈ 1:1 z nocami — słabe grupowanie. |
| S-05 | **Średnie** | Brak nagłówków sezonów na wokandzie (mecenas 01–12 / aplikant 13–24). |
| S-06/07 | **Pozytyw** | Skip-link, aria, breadcrumbs, prev/next, fiction-bar; 404 OK; 24 slugi + 3 materiały = 200. |

Mobile: breakpointy 1120 / 560; brak hamburgera (grid 6 linków); `prefers-reduced-motion` OK. Pełnego Lighthouse na prod nie odpalano.

### Spójność z Lessons.json

Sync: 24 lekcje 1:1 tytuły/kolejność; WWW wstrzykuje `sourceIds: ["sans-ouch"]` (Resources puste) — zamierzone, ryzyko driftu. `artPending` dla 13–24; assety Night13–24a na live 200. Demo: 01–03.

Karty proceduralne: MFA (01, 11), AI (03), BEC (07, 08, 09). **18/24 bez `materialSlug`.** Temat WWW nocy 09 „Deepfake…” — niuans jak w Części B.

| ID | Sev | Finding |
|---|---|---|
| C-01 | **Krytyczne** | Narracja 12 vs produkt 24 — decyzja: ukryć/oznaczyć S1 albo poprawić copy. |
| C-02 | **Wysokie** | 18 nocy bez karty AKTA. |
| C-03 | **Średnie** | Etykieta deepfake nocy 09. |
| C-04 | **Średnie** | Tylko hero `NightXXa` na kartach; `b` syncowane, nieużywane (koszt CDN). |
| C-05 | **Niskie** | Drift `sourceIds` Resources vs WWW. |
| C-06 | **Pozytyw** | Sync tytułów/briefingów/practical OK; walidacja `lessonCount === 24`. |

### Wartość edukacyjna WWW

Model threat → red flags → refleks → watchFor/minimize/practice — dobry. Karty BEC / MFA / AI zgodne z kanonem; disclaimer „nie porada prawna” właściwy. WWW nie ujawnia wyborów (anti-spoiler) — świadomy podział ról.

| ID | Sev | Finding |
|---|---|---|
| E-01 | **Wysokie** | Zwykle 1 red flag + 2 watchFor — cienko vs scena w grze. |
| E-02 | **Wysokie** | Luki kart: ransomware (12), makra (10), cudze konto (14), USB (20), wydruk (17), mandat (19), nagranie (23), ekran korytarz (24)… |
| E-03 | **Średnie** | `/zrodla` = 1× SANS OUCH — dodać 3–7 „dalszych lektur” (CERT/ENISA/NCSC…) bez udawania cytatu. |
| E-04 | **Średnie** | `legalState` 28.09 vs „stan materiału” MFA 11.09 — niespójne datowanie. |
| E-06/07 | **Pozytyw** | Język praktyczny; nie uczy ataku. |

### a11y / SEO / prywatność

| ID | Sev | Finding |
|---|---|---|
| A-01 | **Średnie** | Pusty `alt` na kadrach nocy — rozważyć opis bez spoilera. |
| A-04/05 | **Pozytyw** | `lang=pl`, skip-link, aria-*, srcset webp, font-display. |
| SEO-01 | **Krytyczne** | Astro `trailingSlash: "never"` vs Apache redirect **ze** `/` — rozcieńczenie SEO. Fix: always+rebuild **lub** wyłączyć slash-redirect. |
| SEO-02 | **Średnie** | Meta home „Dwanaście nocy…”. |
| SEO-05 | **Pozytyw** | robots + sitemap; OG; HSTS, CSP, XFO DENY, Referrer/Permissions-Policy. |
| P-01/02 | **Pozytyw** | `/prywatnosc` jasna; brak trackerów ⇒ brak bannera cookies uzasadniony; Brevo double opt-in. |
| F-01–03 | **Pozytyw** | Fiction-bar + footer FIKCJA/EDUKACJA + `/autor` = Napieraj, nie Colgante — **najmocniejsza strona projektu**. |

### Top 5 WWW + szybkie wins

1. SEO-01 — trailing slash / canonical.  
2. C-01 / S-01 — copy 12↔24.  
3. C-02 / E-02 — karty proceduralne (ransomware, makra, USB, cudze konto, wydruk, mandat…).  
4. E-01 / E-03 — bogatsze red flags + źródła.  
5. S-05 — H2 sezonów + zwinąć filtry do 6–8 klas.

Wins: ujednolicić slash → copy 12/24 → H2 sezonów → 5–8 kart AKTA → filtry + `/zrodla` → daty materiałów → alt kadłów.

---

## Macierz priorytetów (P0/P1/P2)

### P0 — przed premierą / ruchem

| # | Obszar | Item |
|---|---|---|
| P0.1 | WWW | Trailing slash: Astro canonical ↔ Apache (SEO-01) |
| P0.2 | WWW | Decyzja produktowa + poprawa copy **12 vs 24** (home, meta, o-projekcie) |
| P0.3 | UI | Copy „Pierwsze uruchomienie” = zachowanie kodu (albo nie zeruj flag howto/biblii) |
| P0.4 | Edu/UI | Utrzymać wymuszenie Briefingu po Ratio (już naprawione 22.09 — nie cofać) |

### P1 — istotny UX / edukacja

| # | Obszar | Item |
|---|---|---|
| P1.1 | UI | Obowiązkowy onboarding („Jak czytać”) przed nocą 1 *lub* świadomy skrót udokumentowany |
| P1.2 | UI | iPad landscape: szerszy maxWidth / 2-kolumnowy układ decyzji i briefingu |
| P1.3 | WWW | 5–8 kolejnych kart AKTA (priorytet: ransomware, makra, USB, cudze konto, wydruk, kanały haseł) |
| P1.4 | WWW | H2 sezonów na `/wokanda` + badge sezonu |
| P1.5 | WWW | Rozszerzyć `/zrodla` (3–7 dalszych lektur) + bogatsze red flags na kartach nocy |
| P1.6 | Edu | Briefing nocy 03: zdanie o polityce AI; etykieta nocy 09 bez obiecywania wyłącznie deepfake |
| P1.7 | UI | Awareness: „minimalizuj” widoczne przed CTA (fold) |

### P2 — polish / dług

| # | Obszar | Item |
|---|---|---|
| P2.1 | UI | WOKANDA powyżej fold na iPadzie; howto punkt 05 nieucięty w viewport |
| P2.2 | UI | Weryfikacja haptics + dźwięk + swipe na urządzeniu fizycznym / GUI Simulator |
| P2.3 | UI | Auto-advance werdyktu 4,6 s — opcjonalnie dłuższy / pauza dla szybkości czytania |
| P2.4 | WWW | Zwinąć 24 filtry do 6–8 klas; ujednolicić daty materiałów; alt kadłów |
| P2.5 | WWW/Edu | Alias dokumentacyjny `trap`→TRAFNE; single source `sourceIds`; decyzja o publikacji `NightXXb` |
| P2.6 | WWW | JSON-LD LearningResource (opcjonalne); spot-check Brevo trackers; EN WWW (świadomy scope?) |
| P2.7 | Edu | Karty WWW dla pozostałych nocy S0 bez procedury; Sezon 1 — osobny audyt ekspercki |

### Świadomie OK / nie ruszać teraz

- Mapa TRAFNE/BŁĘDNE/NIEPEŁNE Sezonu 0.  
- Anti-spoiler WWW (bez wyborów/stempli).  
- Fiction-bar i rozdział autor/fikcja.  
- Blokada Sezonu 1 do końca S0.  
- Brak cookie bannera przy braku trackerów.  
- Nazwa pola `trap` w JSON (bez migracji).

---

## Załączniki (ścieżki do screenshotów)

### Indeks zrzutów (oba urządzenia, 16 ekranów)

`01-splash` · `02-desk` · `03-howto` · `04-bible` · `05-comic-n1-p1` · `06-comic-n1-p2` · `07-decision-n1` · `08-awareness-n1` · `09-comic-n2` · `10-decision-n2` · `11-verdict-sound` · `12-ratio-sound` · `13-verdict-unsound` · `14-settings` · `15-desk-after-6nights` · `16-comic-n7`

### Ścieżki

| Lokalizacja | Ścieżka |
|---|---|
| Mac iPhone 17 | `/Users/AI/src/CzerwonaTeczka/World/audyt-shots/iphone17/` |
| Mac iPad Air 11 | `/Users/AI/src/CzerwonaTeczka/World/audyt-shots/ipadair11/` |
| Box iPhone 17 | `/workspace/czerwona-teczka/audyt-shots/iphone17/` |
| Box iPad Air 11 | `/workspace/czerwona-teczka/audyt-shots/ipadair11/` |
| Archiwum | `/workspace/czerwona-teczka/audyt-shots-all.tgz` |
| Ten dokument (box) | `/workspace/czerwona-teczka/audyt.md` |
| Ten dokument (Mac) | `/Users/AI/src/CzerwonaTeczka/audyt.md` oraz `World/audyt.md` |

### Drafty źródłowe (box)

- `/workspace/czerwona-teczka/audyt-draft-ui.md`
- `/workspace/czerwona-teczka/audyt-draft-edukacja.md`
- `/workspace/czerwona-teczka/audyt-draft-www.md`
- Kontekst: `/workspace/czerwona-teczka/AudytWarstwyEdukacyjnej.md` (22.09.2026)

### Status sekcji WWW

**Część C kompletna** — scalona z `audyt-draft-www.md` (gotowy 2026-09-30).
