# Plan: Compliance pack (Sezon 2 + Sezon 3)

**Status:** treść robocza 2026-10-02 — draft PR, **bez merge**, **bez generacji Midjourney**, **bez deployu Website**.  
**Produkt:** Czerwona Teczka · Colgante  
**Zakres:** B2B-only pack = **Sezon 2 · Audytorka · Kontrola** + **Sezon 3 · Audytorka · AML** (24 noce). Protagonistka: **Sylwia Szczelińska**.

---

## 1. Decyzje produktowe (locked)

| Decyzja | Wartość |
|--------|---------|
| Sezon 1 (Aplikant) | **zostaje free** (razem z Sezonem 0 w App Store) |
| Pierwszy pack B2B | **Sezon 2 + Sezon 3** razem = „**Compliance pack**” (24 noce) |
| Gracz | **Audytorka Sylwia Szczelińska** — nowa postać (nie redo Chropota/Aplikanta); subtekst: szczelność systemów / no leaks |
| Ton | thriller kancelaria Colgante; noir/IT OK; **nie** corporate e-learning |
| Obrazy | dopiero po akceptacji promptów; `assets.md` / AssetRegistry sync = osobne zadanie |
| Raport HR | te same CSV/JSON co free; zakres = pack Compliance (24) lub sezon 2 / sezon 3 |

---

## 2. Identyfikatory

| Sezon | `seasonId` | Tytuł PL / EN | Noce (order) | Lesson id | Assets |
|------|------------|---------------|--------------|-----------|--------|
| 2 | `"2"` | Sezon 2 · Audytorka · Kontrola / Season 2 · Auditor · Control | 25–36 | `25-…` … `36-…` | `Night25a`–`Night36b` |
| 3 | `"3"` | Sezon 3 · Audytorka · AML / Season 3 · Auditor · AML | 37–48 | `37-…` … `48-…` | `Night37a`–`Night48b` |
| Plakat | — | wybór sezonu | — | — | `SezonAudytor` |

Pakiet raportu B2B: `ReportScope.pack` (lub nowy scope `compliance`) obejmujący order 25–48. Pass ≥ 90% → min. **22× TRAFNE** z 24 + stempel + briefing.

---

## 3. Mapa tematów

### Sezon 2 · Kontrola (RODO / tajemnica / IT)

| # | id | Tytuł | Temat edukacyjny |
|---|----|-------|------------------|
| 25 | `25-cel` | Cel poza umową | ograniczenie celu / RODO art. 5 |
| 26 | `26-tajemnica` | Lista dla „partnera” | tajemnica zawodowa vs udostępnienie |
| 27 | `27-chmura` | Model w chmurze | chmura/AI bez DPA i bez zgody |
| 28 | `28-dpia` | DPIA „później” | ocena skutków (DPIA) |
| 29 | `29-dpa` | Umowa bez DPA | umowa powierzenia (DPA) |
| 30 | `30-retencja` | Szafa po terminie | retencja / usuwanie |
| 31 | `31-wyciek` | 72 godziny | zgłoszenie naruszenia |
| 32 | `32-podmiot` | Żądanie z maila | prawa podmiotu danych |
| 33 | `33-shadow` | Shadow SaaS | niezatwierdzone SaaS |
| 34 | `34-transfer` | Serwer poza EOG | transfer poza EOG |
| 35 | `35-dostep` | Uprawnienia po odejściu | upoważnienia / RBAC |
| 36 | `36-rejestr` | Pusty rejestr | rozliczalność / rejestr czynności |

### Sezon 3 · AML

| # | id | Tytuł | Temat edukacyjny |
|---|----|-------|------------------|
| 37 | `37-kyc` | KYC „na później” | identyfikacja klienta (KYC) |
| 38 | `38-crbr` | CRBR się nie zgadza | beneficjent rzeczywisty / CRBR |
| 39 | `39-giif` | Zawiadomienie GIIF | zgłoszenie podejrzenia |
| 40 | `40-gotowka` | Gotówka na biurku | limity gotówki |
| 41 | `41-nieruchomosc` | Akt przed screeningiem | nieruchomości / ML red flags |
| 42 | `42-tajemnica-aml` | Tajemnica vs zgłoszenie | tajemnica zawodowa × AML |
| 43 | `43-pep` | Klient z listy PEP | osoby zajmujące eksponowane stanowiska |
| 44 | `44-zrodlo` | Źródło środków | source of funds |
| 45 | `45-split` | Przelewy w kawałkach | structuring |
| 46 | `46-sankcje` | Lista bez sprawdzenia | sankcje / screening |
| 47 | `47-tipoff` | „Nie mów klientowi” | tipping-off |
| 48 | `48-monitoring` | Przegląd za rok | monitoring bieżący |

---

## 4. Artefakty w repo (ten PR)

| Plik | Rola |
|------|------|
| `plan-compliance-pack.md` | ten plan |
| `tools/macos-studio/komiks-compliance-pack.md` | 24 noce: kontekst, decyzje, Ratio, Briefing, evidence/register, szare bloki MJ |
| `tools/build_compliance_pack.py` | źródło danych + emitter markdown/JSON (nie nadpisuje `Lessons.json` free) |
| `World/compliance-pack-mj-process.md` | proces MJ dla packa (refs Szczelińska / Audytorka, batch, checklist) |

**Świadomie poza tym PR:** wpięcie do `build_lessons.py` / `Lessons.json`, imagesety, Website sync, unlock sezonów w UI, OrgConfig / Custom Apps.

---

## 5. Evidence / rejestr (pod HR CSV)

Każda noc ma pole **evidence** (osobno od briefingu fabularnego), pod przyszły `*_lekcje.csv` / rejestr art. 39:

- `topicCode` — krótki kod HR (np. `RODO-CEL`, `AML-KYC`)
- `registerLine` — jedna linia PL: „id · tytuł · temat” do sklejenia w `zakres_tematow`
- `controlHint` — co Audytorka **zostawia w aktach kontroli** (notatka, mail, ticket) — nie quiz

---

## 6. Kryteria akceptacji treści

1. Ton = Colgante noir; zero „moduł e-learningowy / quiz z paragrafu”.
2. TRAFNE kosztuje czas; BŁĘDNA = pułapka; NIEPEŁNA = kuszący półśrodek.
3. Briefing ≠ retell sceny; `minimize ≠ practice`; threat ≥ ~120 znaków PL.
4. Kaptiony A/B ≤ 140 znaków PL (limit silnika).
5. MJ: Palace tylko gdy karta każe; bez liter na płycie; Szczelińska ≠ Chropot/Iglica/Irena.
6. Season 1 free nietknięty.

---

## 7. Open questions (nie blokują draftu)

1. ~~Imię własne Audytora~~ **LOCKED:** Sylwia Szczelińska (Audytorka); plakat asset id nadal `SezonAudytor`.
2. Czy pack B2B odblokowuje się po Sezonie 1, czy osobny entry w Custom App.
3. Czy `ReportScope` dostaje osobny case `.compliance` vs reuse `.pack` z filtrem seasonId ∈ {2,3}.
4. Ref CDN Midjourney dla Szczelińskiej — po pierwszej zaakceptowanej czwórce plakatu.

