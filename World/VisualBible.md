# Biblia wizualna — Czerwona Teczka

Akcja: **Kancelaria Okiennica, Chropot i Wspólnicy** (fikcja). **5. piętro, biurowiec od Świętokrzyskiej, Śródmieście, Warszawa.** Za żaluzją: PKiN w deszczu. Nie używamy prawdziwego numeru działki ani nazw istniejących kancelarii.

Styl: Frank Miller / Sin City. Czerń, biel, raster Ben-Day. **Jedyny kolor: krew.**

## Zasada spójności

Nie generuj twarzy w runtime na iPadzie 9 / iPhone SE 3.

Lokalny model na **Mac Studio M2 Ultra, 128 GB**: `tools/macos-studio/generate_noir.py` (mflux / Flux, MLX, offline).

1. Zablokuj prompt stylu (plik `prompts.json`).
2. Img2img z masterów w `World/bible/` (ten sam PNG obsady, niska siła 0.28–0.38).
3. Włóż wynik do `Assets.xcassets`.
4. W kodzie odwołuj się do **nazwy imagesetu**, nie do promptu.

## Prompt stylu (lock)

`Frank Miller Sin City comic, high-contrast black ink, Ben-Day dots, rain, venetian blinds, ONLY blood red as accent, no other chromatic color, fictional Polish law office, grain, not photoreal, not anime, no readable real firm names on plaques`

## Obsada (zawsze te same pliki)

| Rola | Asset | Lock |
|---|---|---|
| Gracz | `MecenasPOV` | Nigdy pełna twarz. Ręce, sygnet, pieczęć. |
| Aplikant Filip Iglica | `AplikantIglica` | Okrągłe okulary, rozczochrane włosy, nerw. Pleading / prompt / memo. |
| Partner Chropot | `PartnerChropot` | Pociąg PKP, płaszcz, czerwony bilet. Presja. |
| Irena, sekretariat | `SekretariatIrena` | Kok, czerwony łańcuszek okularów. USB / HR. |
| Miejsce | `OfficeNight` | 5. piętro, żaluzja, PKiN, deszcz. Bez prawdziwego adresu na szyldzie. |
| Biurko | `DeskFolders` | Trzy teczki 01 / 03 / 04. |

Nie wymyślaj nowej kancelarii ani nowej twarzy „na lekcję 09”.
