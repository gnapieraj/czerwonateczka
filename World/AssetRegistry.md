# Rejestr assetów graficznych (App Store / AI Act / BFL)

Ilustracje w `Resources/Assets.xcassets` powstają lokalnie na Mac Studio
(`tools/macos-studio/generate_noir.py`, mflux). Aplikacja iOS tylko je odtwarza —
bez wysyłki danych użytkownika do AI.

## Status licencyjny (przed płatną dystrybucją)

| Element | Narzędzie | Model | Uwaga |
|---|---|---|---|
| Night01a…Night12b, obsada | mflux | Flux.1 [dev] (historycznie) | Output BFL: zwykle OK komercyjnie; użycie wag w produkcji — sprawdź [LICENSE BFL](https://huggingface.co/black-forest-labs/FLUX.1-dev/blob/main/LICENSE.md) / licencję komercyjną przed IAP |
| AutorPortrait (witryna) | — | — | Osobny plik w `Website/src/assets/` |
| Gobo Caps | — | — | SIL OFL 1.1, `Resources/Fonts/OFL.txt` |
| NightDocket.m4a | `tools/generate-night-docket.py` | synteza | Oryginał projektu |

Przy regeneracji dopisz wiersz: `asset | data | seed | model | operator`.

## Ujawnienie w produkcie

- How to play / Settings: ilustracje AI-assisted, fikcja Colgante.
- Listing App Store: to samo w opisie.
- Nie przedstawiać kadrów jako zdjęć z prawdziwej kancelarii.
