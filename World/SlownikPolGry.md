# Słownik pozycji w grze

Mapa ekranów i pól Czerwonej Teczki. To nie jest poradnik merytoryczny ani porada prawna.

Stan: **02.10.2026** (24 noce, 2 sezony, `storyMode`).

Audyt edukacyjny: `World/AudytWarstwyEdukacyjnej.md`.

---

## Jak idzie sesja

1. **Splash**
2. **Biblia wizualna** — tylko za pierwszym razem
3. **Biurko / wokanda** — 12 nocy; kolejna odblokowana po stemplu poprzedniej
4. **Komiks** — 2 kadry (`NightNNa`, `NightNNb`)
5. **Decyzja** — kontekst, deadline, głos, trzy wybory
6. **Werdykt** — TRAFNE / BŁĘDNE / NIEPEŁNE (splash + tap)
7. **Ratio** — refleks (w fabule bez pełnych liczników i bloku przepisu na ekranie)
8. **Briefing** — obowiązkowy po Ratio (jak to działa → wokanda)
9. powrót na wokandę

---

## Werdykty

| Stempel | Znaczenie |
|---|---|
| **TRAFNE** (`sound`, id `trap`) | Właściwy odruch pod presją |
| **BŁĘDNE** (`unsound`) | Akceptacja pułapki |
| **NIEPEŁNE** (`incomplete`) | Półśrodek, który zostawia lukę |

---

## Briefing (Awareness)

| Pole | Rola |
|---|---|
| **Jak to działa** | Mechanizm oszustwa / błędu — nie powtórka sceny z decyzji |
| **Na co zwracać uwagę** | Czerwone lampki |
| **Jak minimalizować** | Co zrobić w tej scenie |
| **W kancelarii — praktyka** | Zasada ogólniejsza (`minimize ≠ practice`) |

Nie pokazywać Briefingu *przed* decyzją — spoiluje odruch.

---

## Obsada

| Asset | Kim jest |
|---|---|
| SezonMecenas | Gracz, plakat sezonu 0 |
| SezonAplikant | Filip Iglica, plakat sezonu 1 |
| Night04b | Partner Chropot w biblii |
| Night05b | Irena w biblii |
| Gabinet | Miejsce |
| Biurko | Tło wokandy |
| Night01a…Night12b | Panele fabularne sezonu 0 |

---

## Witryna

Publiczny opis nocy i karty procedur: colgante.pl. Sync: `Website` → `npm run sync` z `Lessons.json`.


---

## Terminy kanoniczne (nie tłumaczyć ad hoc)

| Termin | Uwaga |
|---|---|
| **Ratio** | Tytuł ekranu refleksji — zapożyczenie UI (noir/IT), bez lokalizacji. |
| **Briefing** / **Awareness** | Obowiązkowy moduł po Ratio. PL w PDF: *MODUŁ AWARENESS* (świadomy brand, nie *MODUŁ ŚWIADOMOŚCI*). |
| **Wokanda** / **docket** | Biurko z listą nocy. |
| **TRAFNE / BŁĘDNE / NIEPEŁNE** | Stempel PL. EN: SOUND / UNSOUND / INCOMPLETE (rejestr prawniczy/security). |
| **aplikant** | EN kanonicznie **trainee** (Canon Iglica), nie *associate*. |
| **Splash — tytuł** | PL pokazuje *The Red File*, EN *Czerwona Teczka* — świadoma zamiana brandingowa. |

## Fleksja „noc”

Etykiety policzalne (`Copy.nights` / `nightsLabeled`): *1 noc*, *2–4 / 22–24 noce*, *5–21 (w tym 12) nocy*. Pakiet: *Cały pakiet · 24 noce*. Po przyimku *z* dopełniacz *nocy* zostaje.

## ZAMKNIĘTE vs ZABLOKOWANE

| Kontekst | PL | EN |
|---|---|---|
| Sezon niedostępny / ukończony | ZAMKNIĘTE / SEZON ZAMKNIĘTY | CLOSED / SEASON CLOSED |
| Noc jeszcze zablokowana na wokandzie | ZABLOKOWANE | LOCKED |
