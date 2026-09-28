# Biblia wizualna — Czerwona Teczka

Akcja: **Kancelaria Colgante i Wspólnicy** (fikcja). **5. piętro, biurowiec od Świętokrzyskiej, Śródmieście, Warszawa.** Za żaluzją: PKiN w deszczu. Nie używamy prawdziwego numeru działki ani nazw istniejących kancelarii.

Styl: komiks noir. Czerń, biel, raster gazetowy. **Jedyny kolor w interfejsie: czerwień decyzji i terminu.** Kadry w grze są z Midjourney i leżą w `Resources/Assets.xcassets`. Rejestr: `World/AssetRegistry.md`. `World/reference-colgante/` to zamrożony zestaw Flux z v1.0, nie te same piksele.

Rekwizyty: współczesne (stary smartphone, używany laptop / PC+CRT), funkcje: e-mail, MFA, wideorozmowa, media — bez telefonu tarczowego.

## Zasada spójności

Nie generuj twarzy w runtime na iPadzie 9 / iPhone SE 3.

Płyty w grze: **`Resources/Assets.xcassets`**, spis w `World/AssetRegistry.md`. iPad i iPhone tylko odtwarzają bundel. `World/reference-colgante/` nie wraca do katalogu gry.

W kodzie odwołuj się do **nazwy imagesetu**, nie do promptu. Nowej płyty nie wkłada się do katalogu, dopóki nie jest w `World/AssetRegistry.md`.

## Napisy

Kadry nie zawierają liter. Szyld, adres, Colgante, numery teczek i stemple to **SwiftUI**.

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
