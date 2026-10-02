# Midjourney — proces Compliance pack (Sezon 2–3)

Stan: 02.10.2026. To nie jest porada prawna. Robocza checklista przy generacji kadrów Audytora.  
Pełne szare bloki: `tools/macos-studio/komiks-compliance-pack.md`. Konwencje bazowe: `tools/macos-studio/komiks-sezony.md` (Sezon 0).

**Nie generuj jeszcze obrazów w tym zadaniu.** Ten plik jest pod pierwszą sesję Imagine.

---

## 1. Stałe reguły (jak Sezon 0)

| Reguła | Wartość |
|--------|---------|
| Create | https://midjourney.com/imagine · Stealth ON · V8.2 |
| Format | jeden prompt, jeden `--no` |
| Save | **2×2**, bez Upscale; docelowo ~**1456×816** (16:9) |
| Palace | **tylko** gdy karta `pass`/`where` mówi o Palace / oknie mecenasa |
| Przed Imagine | przeczytaj **kontekst nocy + panel + caption** z karty |
| Liter | zero na płycie (SwiftUI maluje napisy) |
| Reject | litery, cyfry, logo, czerwień, pieczęć, krew, tarcza zegara, telefon tarczowy, zlane palce, łańcuszek przy okularach, mozaika, pasek cenzury |
| Asset | po akceptacji → `Resources/Assets.xcassets/<nazwa>.imageset/` + wpis w `World/AssetRegistry.md` (**osobne zadanie sync**) |

Style seed z Sezonu 0 (dopóki Audytor nie ma własnego zaakceptowanego sref):

`--sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png --sw 400 --stylize 0 --v 8.2 --stealth`

Po zaakceptowaniu plakatu `SezonAudytor` podmień `--sref` / `--iw` na ten plakat dla kadrów z twarzą Audytora.

---

## 2. Postać: Audytor (nowa)

**Nie** Chropot (ciężkie brwi, płaszcz, rozkaz). **Nie** Iglica (młody, piegi, panika). **Nie** Irena (kok, asysta).

| Cecha | Lock |
|-------|------|
| Wiek | późne 40. / wczesne 50. |
| Energia | spokojniejsza, obserwująca; checklista i teczka |
| Wygląd | krótkie siwe skronie, cienkie okulary do czytania (nie okrągłe Iglicy), ciemny garnitur, biała koszula, krawat zapięty |
| Gest | folder / checklista w dłoni; rzadko telefon; nigdy „wskazuje palcem jak Chropot” |
| Twarz | **czytelna** (gracz = Audytor; nie tusz jak mecenas) |
| Plakat | `SezonAudytor.png` — stojący, lekko na prawo od środka; biuro kontroli / pusty stół kontrolny; **bez** Palace jako tematu (wschodnie okno na dachy OK) |

Głosy w dymkach (B): Audytor milczy w komiksie (gracz); nacisk robią Chropot, Irena, Iglica, klient albo „kontrola z zewnątrz” (fikcja). Kwestie krótkie, bez zdradzania werdyktu.

---

## 3. Zasada pary A/B

- **A** = rzecz i gest do powstrzymania (blat, ekran, teczka, gotówka, lista).
- **B** = człowiek, który naciska, **w innym miejscu** niż A.
- Nie powtarzaj tego samego biurka + Palace w dziewięciu kadrach A z rzędu (lekcja Sezonu 0).
- Ogon nocy: `--sw 400` (twarz/gest); gdy kreska zmięknie → `500`, nie dokładaj drugiego obrazu.

---

## 4. Batching (proponowany porządek sesji)

1. **Plakat** `SezonAudytor` — 2–3 czwórki, wybierz lock, zapisz CDN URL do kart.
2. **Refs postaci wspierających** — reuse CDN z Sezonu 0 (Iglica `…/f934b806…`, Chropot `…/6d9d9b6f…`, Irena z `Night05b`).
3. **Sezon 2** noce 25–36: najpierw wszystkie **a**, potem wszystkie **b** (albo para po parze — jedna para = jedna sesja mentalna).
4. **Sezon 3** 37–48 — to samo.
5. Po każdej zaakceptowanej czwórce: zapisz 2×2, nazwij `NightNNa` / `NightNNb`, **nie** Upscale.

Maksymalnie ~6–8 Imagine na sesję (zmęczenie oka = akceptacja liter).

---

## 5. Auto-check przed wklejeniem szarego bloku

- [ ] Przeczytany `context_pl` nocy + `caption_pl` panelu
- [ ] `paint_caption: no` — caption nie jest w prompcie jako tekst do namalowania
- [ ] Palace: tylko jeśli `pass` wymaga / `where` mówi; inaczej `--no palace of culture…`
- [ ] Audytor: nie ma okrągłych okularów Iglicy, nie ma płaszcza Chropota na ramionach jako default
- [ ] Props puste (blank folder, flat grey screen) — bez sygnatur, IBAN, CRBR numerów
- [ ] `--ar 16:9` · `--stealth` · `--v 8.2` · jeden ciąg `--no`
- [ ] Po Imagine: reject jeśli litery / czerwień / zlane palce / zegar / rotary

---

## 6. Consistency tricks

| Problem | Fix |
|---------|-----|
| Audytor wygląda jak Chropot | obniż `--iw` twarzy Chropota; wzmocnij „reading glasses, grey temples, calm, checklist” |
| Pokój zjada twarz | `--iw 0.35–0.4` na refie Audytora; nie dokładaj drugiego sref mebla |
| Sezon 3 „za bardzo bank” | zostań w kancelarii Colgante (gabinet, lada, sala akt); gotówka = teczka na biurku, nie vault |
| AML props z literami | blank stamp strip, empty columns — numery w SwiftUI |

---

## 7. Po generacji (nie ten PR)

1. Imagesety `Night25a`…`Night48b` + `SezonAudytor`
2. `World/AssetRegistry.md`
3. Wpięcie lekcji z `tools/build_compliance_pack.py` do silnika / `Lessons.json` (asserty sezonów)
4. Website `npm run sync` — **osobne zadanie**, nie równolegle z deployem

