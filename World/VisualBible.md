# Biblia wizualna — Czerwona Teczka

Akcja: **Kancelaria Vogel, Kruk i Wspólnicy**, ul. **Królewska 16, 5. piętro**, Śródmieście, Warszawa. Za żaluzją: PKiN w deszczu.

Styl: Frank Miller / Sin City. Czerń, biel, raster Ben-Day. **Jedyny kolor: krew.**

## Zasada spójności

Nie generuj twarzy w runtime na iPadzie 9 / iPhone SE 3. A13/A15 nie utrzyma tożsamości. Nowa sesja modelu = nowa twarz = złamany kanon.

Lokalny model (Mac Studio M2 Ultra, ComfyUI / Flux / SDXL) wolno użyć **raz**, offline:

1. Zablokuj prompt stylu (poniżej).
2. Img2img z tej biblii (ten sam PNG obsady).
3. Włóż wynik do `Assets.xcassets`.
4. W kodzie odwołuj się do **nazwy imagesetu**, nie do promptu.

Master plates (img2img): katalog `World/bible/` — te same twarze, to samo 5. piętro. Nie commituj nowych twarzy „na lekcję”.

## Prompt stylu (lock)

`Frank Miller Sin City comic, high-contrast black ink, Ben-Day dots, rain, venetian blinds, ONLY blood red as accent, no other chromatic color, Polish law office, grain, not photoreal, not anime`

## Obsada (zawsze te same pliki)

| Rola | Asset | Lock |
|---|---|---|
| Gracz | `MecenasPOV` | Nigdy pełna twarz. Ręce, sygnet, pieczęć. |
| Aplikant Tomasz Wilk | `AplikantWilk` | Okrągłe okulary, rozczochrane włosy, nerw. Pleading / prompt / memo. |
| Partner Kruk | `PartnerKruk` | Pociąg PKP, płaszcz, czerwony bilet. Presja. |
| Irena, sekretariat | `SekretariatIrena` | Kok, czerwony łańcuszek okularów. USB / HR. |
| Miejsce | `OfficeNight` | 5. piętro, żaluzja, PKiN, deszcz. |
| Biurko | `DeskFolders` | Trzy teczki 01 / 03 / 04. |

Nie wymyślaj nowej kancelarii ani nowej twarzy „na lekcję 09”.
