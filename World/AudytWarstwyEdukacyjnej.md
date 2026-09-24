# Audyt warstwy edukacyjnej

Stan: **22.09.2026**. Dotyczy gry (12 nocy, `storyMode`) oraz witryny [colgante.pl](https://colgante.pl).

To nie jest porada prawna. Celem dokumentu jest ocena, czy warstwa edukacyjna uczy odruchu pod presją, a nie tylko „oznacza pułapkę”.

---

## Werdykt

Warstwa edukacyjna jest **spójna z obecną wersją gry** i gotowa do dalszego rozwoju. Dwanaście nocy ćwiczy realne dylematy kancelaryjne (MFA, załączniki, AI, hasła, awarie, płatności, BEC, makra, odejścia, ransomware). Witryna lustrzanie opisuje te same noce i daje trzy karty procedur.

**Naprawione (22.09.2026):** pole „Jak to działa” w Briefingu; Briefing **wymuszony** po Ratio przed wokandą.

---

## Zakres audytu

| Obszar | Źródło prawdy |
|---|---|
| Treść nocy | `Resources/Lessons.json` ← `tools/build_lessons.py` |
| Walidacja | `tools/validate_lessons.py`, `LessonPackTests` |
| Briefing w grze | `AwarenessView`, pola `awareness.*` |
| Witryna | `Website/src/data/site.ts`, sync z `Lessons.json` |
| Materiały | BEC, MFA, AI na colgante.pl |

---

## Architektura edukacyjna (obecna)

```
Biurko → Komiks (2 kadry) → Decyzja (3 wybory) → Werdykt → Ratio → [Briefing?] → Biurko
```

- **Przed decyzją:** kontekst, deadline, głos wewnętrzny, trzy odpowiedzi (jedna TRAFNE = `trap`).
- **Po decyzji:** stempel TRAFNE / BŁĘDNE / NIEPEŁNE, refleks; w `storyMode` bez pełnego bloku przepisu/wzorca/liczników na Ratio.
- **Briefing:** zagrożenie, na co uważać, jak minimalizować, praktyka — dziś z Ratio / teczki, nieobowiązkowy.
- **Źródła w aplikacji:** ekran wskazuje SANS OUCH (bez bibliografii per noc; `sourceIds` puste w JSON).

---

## Mapa 12 nocy

| # | Id | Tytuł | Temat | Odruch (skrót) |
|---|---|---|---|---|
| 01 | `01-kod` | Drugie zatwierdzenie | MFA / logowanie | Zatwierdź tylko własne pytanie; oddzwoń z książki |
| 02 | `02-list` | Doklejone pismo | Załączniki | Pismo z portalu, nie z doklejonego PDF |
| 03 | `03-prompt` | Ugoda w asystencie | AI / tajemnica | Układ klauzul bez nazw, kwoty, sygnatury |
| 04 | `04-haslo` | Hasło przed radą | Hasła / kanały | Link i hasło osobno |
| 05 | `05-arkusz` | Hasło klienta | Akta vs sekrety | Hasło w menedżerze, nie w chronologii |
| 06 | `06-pomoc` | Program w trakcie awarii | Instalacje | Zostań przy własnym zgłoszeniu IT |
| 07 | `07-sms` | Druga opłata | SMS / opłaty | Zestaw z nakazem; nie link z SMS |
| 08 | `08-qr` | IBAN po wyroku | BEC / koszty | Numer z wyroku, nie z kodu w PDF |
| 09 | `09-glos` | Numer z pisma | Deepfake / przelew | Oddzwoń na numer z akt |
| 10 | `10-okno` | Makra w pozwie | Dokumenty | Bez „Włącz treść”; PDF z portalu |
| 11 | `11-konta` | Skrzynka po odejściu | Dostęp | Zamknij logowanie tego samego dnia |
| 12 | `12-okup` | Bitcoin przed rozprawą | Ransomware | Odłącz, lista awaryjna, bez okupu |

Każda noc: **1× TRAFNE**, **1× BŁĘDNE**, **1× NIEPEŁNE**; `minimize ≠ practice`; dwa unikalne assety `Night*`.

---

## Witryna colgante.pl

| Element | Status |
|---|---|
| 12 stron wokandy + sync hero `Night*` | OK |
| Karty: BEC, MFA, AI | OK; skróty rozwinięte w leadach, tytuły krótkie |
| `/źródła` | SANS OUCH (zgodnie z grą) |
| Link w Ustawieniach gry → colgante.pl | OK |
| Fikcja vs autor (Napieraj) | OK |

---

## Mocne strony

1. **Presja społeczna zamiast quizu** — Chropot, Iglica, Irena proponują „rozsądne” ruchy.
2. **NIEPEŁNE jako osobna kategoria** — półśrodki („na próbę”, WhatsApp na tym samym telefonie) są uczciwie ukarane.
3. **Język deskowy** — mało żargonu w scenach; BEC/MFA wyjaśnione w materiałach WWW.
4. **Blokada liniowa nocy** — wymusza kolejność bez skipowania.
5. **Spójność gra ↔ witryna** po sync i deployu.

---

## Luki i ryzyka

| Priorytet | Problem | Rekomendacja |
|---|---|---|
| Wysoki | ~~Briefing opcjonalny~~ | Wymuszone po Ratio (22.09.2026) |
| Średni | Brak miękkiej presji czasu na ekranie decyzji | Puls deadline / komunikat postaci bez auto-fail |
| Średni | `SlownikPolGry.md` był nieaktualny względem 12 nocy | Zaktualizowany równolegle z tym audytem |
| Niski | `CutsceneView` / `introVideo` w modelu bez bundlowanego wideo | Zostawione pod rozwój; usunięto orphan `Mission01Intro.mp4` |
| Niski | Materiały WWW nie pokrywają nocy 02, 04–06, 10, 12 kartą proceduralną | Opcjonalne kolejne AKTA (portal, awaria, ransomware) |

---

## Kryteria akceptacji (smoke edukacyjny)

- [ ] `python3 tools/validate_lessons.py` → OK
- [ ] 12 nocy, każda z `storyMode`, 2 beatami, 3 wyborami
- [ ] Trafna odpowiedź nie brzmi jak „wybierz bezpieczną opcję z podręcznika”
- [ ] Briefing jest wymagany *po* decyzji (Ratio → Briefing → wokanda), nie przed
- [ ] colgante.pl pokazuje te same 12 tytułów i trzy karty z rozwinięciem skrótów w treści
- [ ] Gra nie cytuje SANS OUCH ani nie udaje porady prawnej

---

## Co świadomie nie ruszono

- `World/bible/` — mastery postaci do generacji
- `Website/scripts/audit-dist.mjs`, `Website/docs/qa-launch.md` — aktywne narzędzia publikacji
- `CutsceneView.swift` — haczyk pod przyszłe intro (obecnie niewywoływane z `open()`)
- Obsada i `OfficeNight` — nadal w użyciu poza panelami nocy
