# Biblia wizualna — Czerwona Teczka

Akcja: **Kancelaria Colgante i Wspólnicy** (fikcja). **5. piętro, biurowiec od Świętokrzyskiej, Śródmieście, Warszawa.** Za żaluzją: PKiN w deszczu. Nie używamy prawdziwego numeru działki ani nazw istniejących kancelarii.

Styl: komiks noir. Czerń, biel, raster gazetowy. **Jedyny kolor: krew.** Kanoniczne piksele, te same co na colgante.pl: `World/reference-colgante/` i `Resources/Assets.xcassets`. Próby Grok / FLUX.2 / Schnell nie zastępują tej bazy.

Rekwizyty: współczesne (stary smartphone, używany laptop / PC+CRT), funkcje: e-mail, MFA, wideorozmowa, media — bez telefonu tarczowego.

## Zasada spójności

Nie generuj twarzy w runtime na iPadzie 9 / iPhone SE 3.

Płyty kanoniczne: **World/reference-colgante/** (kopia pikseli z colgante.pl, commit v1.0). Panele nocy (`Night01a`…`Night12b`) biorą się z tych samych plików w `Assets.xcassets`. iPad tylko odtwarza bundel.

1. Zablokuj prompt stylu (plik `prompts.json`).
2. Img2img z masterów w `World/bible/` (ten sam PNG obsady, niska siła 0.28–0.38).
3. Włóż wynik do `Assets.xcassets`.
4. W kodzie odwołuj się do **nazwy imagesetu**, nie do promptu.

## Napisy

Lokalny Flux **nie maluje liter** — zwłaszcza polskich (ą ę ł ń ó ś ź ż). Na płytach zostaje sałatka (`POLIYIEE`, `ON:OURIER`). Szyld, adres, Colgante, numery teczek i stemple to **SwiftUI**; `LetteringScrim` przykrywa glyph-salad.

W `prompts.json` stoi `lettering_lock`: puste tablice, pieczęcie jako suche szkarłatne dyski, UI abstrakcyjny; Colgante / numery w SwiftUI.

## Obsada (zawsze te same pliki)

| Rola | Asset | Lock (nazwa ≠ echo w opisie; lekki humor OK) |
|---|---|---|
| Ty | `MecenasPOV` | Mecenas przy biurku. Spokojny jak lampa, ostrożny jak stempel; nigdy pełna twarz. |
| Filip Iglica | `AplikantIglica` | Aplikant. Nosiciel akt i nerwowych uśmiechów. Okulary, rozczochrane włosy. |
| Partner Chropot | `PartnerChropot` | Treser deadline’ów. Płaszcz, słuchawka. Monochrom — bez czerwonych plam. |
| Irena, asystentka | `SekretariatIrena` | Władczyni kalendarza. Kok, czerwony łańcuszek. |
| Miejsce | `OfficeNight` | 5. piętro, żaluzja, PKiN, deszcz. Pusty szyld — nazwa w UI. |
| Biurko | `DeskFolders` | Trzy teczki, pieczęcie bez cyfr — numery w UI. |

Nie wymyślaj nowej kancelarii ani nowej twarzy „na lekcję 09”.
Opisy w UI: **kim są + charakter** (lekki humor), bez dublowania roli i bez listy zadań z wokandy.
