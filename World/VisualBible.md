# Biblia wizualna — Czerwona Teczka

Akcja: **Kancelaria Colgante i Wspólnicy** (fikcja). **5. piętro, biurowiec od Świętokrzyskiej, Śródmieście, Warszawa.** Za żaluzją: PKiN w deszczu. Nie używamy prawdziwego numeru działki ani nazw istniejących kancelarii.

Styl: komiks noir. Czerń, biel, raster gazetowy. **Jedyny kolor w interfejsie: czerwień decyzji i terminu.** Kadry leżą raz, w `Resources/Assets.xcassets`. Jedyny spis: `World/AssetRegistry.md`.

Rekwizyty: współczesne (stary smartphone, używany laptop / PC+CRT), funkcje: e-mail, MFA, wideorozmowa, media — bez telefonu tarczowego.

## Zasada spójności

Nie generuj twarzy w runtime na iPadzie 9 / iPhone SE 3.

Płyty w grze: **`Resources/Assets.xcassets`**, spis w `World/AssetRegistry.md`. iPad i iPhone tylko odtwarzają bundel.

W kodzie odwołuj się do **nazwy imagesetu**, nie do promptu. Nowej płyty nie wkłada się do katalogu, dopóki nie jest w `World/AssetRegistry.md`.

## Napisy

Kadry nie zawierają liter. Szyld, adres, Colgante, numery teczek i stemple to **SwiftUI**.

Napisy (Colgante, numery teczek, stemple) są w SwiftUI. Na płycie zostają puste tablice.

## Obsada (zawsze te same pliki)

| Rola | Asset | Lock (nazwa ≠ echo w opisie; lekki humor OK) |
|---|---|---|
| Ty | `SezonMecenas` | Mecenas przy biurku. Kapelusz, twarz w tuszu — czytelnej twarzy nie ma. |
| Filip Iglica | `SezonAplikant` | Aplikant. Okulary, piegi, rozczochrane włosy, telefon i teczka. |
| Partner Chropot | `Night04b` | Ta sama twarz co w komiksie. Słuchawka, płaszcz, biurko. |
| Irena, asystentka | `Night05b` | Ta sama twarz co w komiksie. Kok, okulary, bez łańcuszka. |
| Miejsce | `Gabinet` | Pusty gabinet, żaluzja, PKiN, deszcz. Szyld bez liter — nazwa w UI. |
| Biurko | `Biurko` | Trzy stosy pustych teczek. Numery w UI. |

Nie wymyślaj nowej kancelarii ani nowej twarzy „na lekcję 09”.
Opisy w UI: **kim są + charakter** (lekki humor), bez dublowania roli i bez listy zadań z wokandy.
