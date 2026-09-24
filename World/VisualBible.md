# Biblia wizualna — Czerwona Teczka

Akcja: **Kancelaria Colgante i Wspólnicy** (fikcja). **5. piętro, biurowiec od Świętokrzyskiej, Śródmieście, Warszawa.** Za żaluzją: PKiN w deszczu. Nie używamy prawdziwego numeru działki ani nazw istniejących kancelarii.

Styl: komiks noir. Czerń, biel, raster gazetowy. **Jedyny kolor: krew.**

## Zasada spójności

Nie generuj twarzy w runtime na iPadzie 9 / iPhone SE 3.

Płyty kanoniczne: **World/bible/** (model komercyjny). Panele nocy (`Night01a`…`Night12b`): GenerateImage / Studio z tymi samymi referencjami. iPad tylko odtwarza bundel.

1. Zablokuj prompt stylu (plik `prompts.json`).
2. Img2img z masterów w `World/bible/` (ten sam PNG obsady, niska siła 0.28–0.38).
3. Włóż wynik do `Assets.xcassets`.
4. W kodzie odwołuj się do **nazwy imagesetu**, nie do promptu.

## Napisy

Lokalny Flux **nie maluje liter** — zwłaszcza polskich (ą ę ł ń ó ś ź ż). Na płytach zostaje sałatka (`POLIYIEE`, `ON:OURIER`). Szyld, adres, Colgante, numery teczek i stemple to **SwiftUI**; `LetteringScrim` przykrywa glyph-salad.

W `prompts.json` stoi `lettering_lock`: puste tablice, pieczęcie jako tarcze krwi, koperty i bilety bez napisów.

## Prompt stylu (lock)

`high-contrast black-and-white crime comic, hard black ink, newsprint halftone dots, rain, venetian blinds, ONLY blood red as accent, no other chromatic color, fictional Polish law office, grain, not photoreal, not anime, blank plaques without letters`

## Obsada (zawsze te same pliki)

| Rola | Asset | Lock |
|---|---|---|
| Gracz | `MecenasPOV` | Nigdy pełna twarz. Ręce, sygnet, pieczęć. |
| Aplikant Filip Iglica | `AplikantIglica` | Okrągłe okulary, rozczochrane włosy, nerw. Pleading / prompt / memo. |
| Partner Chropot | `PartnerChropot` | Pociąg PKP, płaszcz, czerwony bilet. Presja. |
| Irena, sekretariat | `SekretariatIrena` | Kok, czerwony łańcuszek okularów. USB / HR. |
| Miejsce | `OfficeNight` | 5. piętro, żaluzja, PKiN, deszcz. Pusty szyld — nazwa w UI. |
| Biurko | `DeskFolders` | Trzy teczki, pieczęcie bez cyfr — numery w UI. |

Nie wymyślaj nowej kancelarii ani nowej twarzy „na lekcję 09”.
