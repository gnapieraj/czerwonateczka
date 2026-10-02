# Sezon 1 — checklista Midjourney (operacyjna)

Źródło promptów: `tools/macos-studio/komiks-sezony.md` §4. Kolejka: `World/s1-mj-queue.md`. Rejestr: `World/AssetRegistry.md`.

## Zasady stałe

1. **Przed każdym Imagine:** przeczytaj ponownie kontekst nocy + kartę panelu + napis z `komiks-sezony.md`. Jeśli szary blok jest nieaktualny względem karty — przepisz szary blok przed wklejeniem.
2. **Zapis z Create tylko 2×2** — **NIGDY Upscale**. Natywny rozmiar ~1456×816.
3. **Pałac Kultury** tylko gdy karta panelu wyraźnie o niego prosi; w pozostałych: deszcz / korytarz / generyczne warszawskie bloki (i `--no palace of culture` w szarym bloku).
4. **Po wyborze wariantu N przez Grega:**
   - zapisz PNG do `Resources/Assets.xcassets/NightNNx.imageset/NightNNx.png`
   - zaktualizuj `World/AssetRegistry.md` (CDN `…/0_N.png` i job `?index=N`)
   - ustaw `artPending: false` w lekcji, gdy **oba** kadry a+b tej nocy są gotowe
5. **Sesja:** ~6–8 Imagine; paruj a→b.
6. **`paint_caption: no`** — żadnych liter na płycie.
7. **Przy każdej czwórce** pokaż Gregowi pełny kontekst PL + dialogi / napisy z nocy (żeby mógł zatwierdzić wariant świadomie).
8. **Spójność postaci i miejsca:** między kadrami/nocami/sezonami zawsze lead accepted plates tej osoby — Chropot: `Night04b` + `Night12b`; Aplikant: `SezonAplikant` + ręce; nigdy Mecenas dla POV S1. Pilnuj spójności biura i widoku za oknem (biuro Aplikanta vs falisty dach Mecenasa; Śródmieście). Reroll, gdy dryfuje likeness lub lokalizacja.
9. **Propozycja do Grega:** zawsze `Napis A` + `Napis B` + kontekst PL.

## Flow akceptacji (jak Sezon 0)

1. Agent wkleja Imagine (szary blok) na midjourney.com/imagine — Stealth, V8.2.
2. Greg dostaje czwórkę + kontekst PL + dialogi.
3. Greg wybiera indeks wariantu `0`–`3` (albo reject → nowa czwórka).
4. Agent zapisuje wybrany panel i aktualizuje rejestr / `artPending`.

## Parametry stylu (S0 / S1)

- `--sref https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png`
- typowo `--sw 400 --stylize 0 --v 8.2 --stealth --ar 16:9`
- `--iw` według karty (dłonie ~0.35, postać ~0.4)
- Character ref: obraz na początku szarego bloku (aplikant / dłonie / Chropot / Irena). **Iglica nie jako druga osoba** w S1. Mecenas bez twarzy (poza kadrem / plecy / cień), gdy w ogóle pojawia się w tekście.

## Start

Następny panel: **Night13a** → potem Night13b (patrz `World/s1-mj-queue.md`).
