# Rejestr assetów wymaganych w aplikacji

Stan: **28.09.2026**. Dotyczy binarki Czerwonej Teczki (iPhone i iPad). Aplikacja tylko odtwarza pliki z bundla. Nie ma w niej wag modelu, sieci ani generowania obrazów.

Źródło prawdy dla kadrów Midjourney: `tools/macos-studio/midjourney-base.md`. Kopii z `World/plates/mj/` i z `World/reference-colgante/` projekt Xcode nie wciąga.

## Co jest w paczce

| Składnik | Plik w bundlu | Pochodzenie | Licencja |
|---|---|---|---|
| 30 plansz komiksu | `Assets.xcassets` → `Assets.car` | Midjourney V8.2, plan Pro, Stealth, 28.09.2026 | [Terms of Service](https://docs.midjourney.com/hc/en-us/articles/32083055291277-Terms-of-Service), wersja z 27.05.2026, §4 |
| Ikona | `AppIcon` | teczka z pieczęcią, 1024×1024. Cursor GenerateImage, 8.09.2026, kopia z `World/bible/app-icon.png` (11.09). Nie Midjourney i nie Flux | [Terms of Service](https://cursor.com/terms-of-service) §5.3: Anysphere przekazuje swoje prawa do wyniku, „jeśli jakieś ma”. Bez zakazu użytku komercyjnego. Bez gwarancji braku naruszenia |
| Pismo | `GoboCaps-Regular.otf`, `GoboCaps-Italic.otf`, `OFL.txt` | Terhi Mäkinen, 2025 | SIL OFL 1.1, Reserved Font Name „Gobo Caps” |
| Muzyka | `NightDocket.m4a` | oryginalna pętla fortepianu na tę grę, synteza bez cudzych sampli (`Resources/Audio/README.md`) | prawa autora gry |
| Tekst nocy | `Lessons.json` | własny | prawa autora gry |

OFL jedzie razem z fontem. Fontu nie sprzedajemy osobno i nie wydajemy go pod inną nazwą.

## Kadry Midjourney w grze

Narzędzie: midjourney.com/imagine (Create), nie Discord. Model: V8.2. Plan: Pro (60 USD). Stealth włączony przed pierwszym promptem. Data przyjęcia serii: 28.09.2026. Każdy wiersz to jeden plik w `Resources/Assets.xcassets/<nazwa>.imageset/` i kopia w `World/plates/mj/`.

| Plik | Rola | Adres przyjętej planszy |
|---|---|---|
| `OfficeNight.png` | gabinet, hero witryny | `https://cdn.midjourney.com/f378dd5f-7ff5-4aba-88ab-fb346a8dba19/0_3.png` |
| `MecenasPOV.png` | ręce przy biurku | `https://cdn.midjourney.com/c6ef5425-6d4e-4317-9fb3-66b8b34d05ba/0_1.png` |
| `AplikantIglica.png` | aplikant | `https://cdn.midjourney.com/f934b806-d849-422d-b14d-a0f77d2df4cd/0_0.png` |
| `PartnerChropot.png` | partner | `https://cdn.midjourney.com/6d9d9b6f-29c0-4c4a-bcf4-16dba87de3cf/0_2.png` |
| `SekretariatIrena.png` | asystentka | `https://cdn.midjourney.com/0725ad0c-4b63-43e3-890c-d1f2a1b6c4b4/0_2.png` |
| `DeskFolders.png` | tło wokandy | `https://cdn.midjourney.com/477d7a9a-a40b-4938-8a04-39c42c232f73/0_3.png` |
| `Night01a.png` | telefon na biurku | `https://cdn.midjourney.com/0ff29cc5-3b18-413a-b21e-d0ad5cde0ae8/0_0.png` |
| `Night01b.png` | Iglica mówi | `https://cdn.midjourney.com/b0b1cb1e-44a2-4630-be51-b51573820d89/0_0.png` |
| `Night02a.png` | dwa pliki w mailu | `https://cdn.midjourney.com/1ff47333-d0a3-4862-8141-b0c79205a6a6/0_3.png` |
| `Night02b.png` | Chropot mówi | `https://cdn.midjourney.com/45b1b222-ac4d-439e-97f6-683669c487d4/0_0.png` |
| `Night03a.png` | niejawna ugoda | `https://cdn.midjourney.com/ce153e03-0b08-411d-9f79-d9e8c3238609/0_0.png` |
| `Night03b.png` | Iglica namawia | `https://cdn.midjourney.com/2c50c54f-26f3-44e3-b252-0405b9fd3ba9/0_0.png` |
| `Night04a.png` | cztery puste pola hasła | `https://cdn.midjourney.com/f73d383e-bbac-4c73-b3e9-a97d82247b49/0_0.png` |
| `Night04b.png` | Chropot wskazuje mail | `https://cdn.midjourney.com/6c1913fe-eaca-4c0d-8997-886dbd988c4d/0_1.png` |
| `Night05a.png` | tablica w sali klienta | `https://cdn.midjourney.com/b2a193ec-8540-428a-8304-430190fe2d36/0_3.png` |
| `Night05b.png` | Irena w sali | `https://cdn.midjourney.com/dde3be83-74b5-4de1-96b2-467eb5180461/0_0.png` |
| `Night06a.png` | plik z nieznanego numeru | `https://cdn.midjourney.com/f41d4b63-98ab-4253-aecd-d415242207cd/0_0.png` |
| `Night06b.png` | Chropot każe instalować | `https://cdn.midjourney.com/352ce8b0-2663-4071-b8b9-55827a67c5ce/0_2.png` |
| `Night07a.png` | SMS z linkiem | `https://cdn.midjourney.com/7a08de68-baab-4131-802a-e90f52fe3e58/0_0.png` |
| `Night07b.png` | Irena popędza | `https://cdn.midjourney.com/d7f43400-d47a-4484-9177-451f6cf13a66/0_0.png` |
| `Night08a.png` | wyrok i pusty kod | `https://cdn.midjourney.com/24cc6c8e-d4e7-4d37-803c-773818255ff2/0_3.png` |
| `Night08b.png` | Chropot wskazuje kod | `https://cdn.midjourney.com/c055c32b-86cc-411f-9f9c-e14650045dc9/0_0.png` |
| `Night09a.png` | słuchawka | `https://cdn.midjourney.com/09f76005-6a46-4c23-9b1d-85725c42f39f/0_0.png` |
| `Night09b.png` | Iglica o rachunku | `https://cdn.midjourney.com/7766d5da-338a-44c1-b0a1-6e56add8d7de/0_1.png` |
| `Night10a.png` | puste okno programu | `https://cdn.midjourney.com/a70533d2-4599-47ca-944c-3cba6a91b5ea/0_2.png` |
| `Night10b.png` | Iglica o pozwie | `https://cdn.midjourney.com/d6b8cfcb-3043-4bd3-8e39-63ff2c1a3ac6/0_2.png` |
| `Night11a.png` | Irena o skrzynce | `https://cdn.midjourney.com/166e8f04-5a13-48e7-9540-b22184152994/0_0.png` |
| `Night11b.png` | Chropot o ciągłości | `https://cdn.midjourney.com/d2db4c3a-518c-46b0-bb16-cd07a4fd2b10/0_1.png` |
| `Night12a.png` | ekran żądania | `https://cdn.midjourney.com/05a3b7d0-1459-4afb-9abe-8a080d61312a/0_1.png` |
| `Night12b.png` | Chropot o zapłacie | `https://cdn.midjourney.com/abb011b8-a918-4ac4-b203-e7a78d93e8f9/0_0.png` |

## Licencja Midjourney

Tekst obowiązujący: [Terms of Service](https://docs.midjourney.com/hc/en-us/articles/32083055291277-Terms-of-Service), data wejścia w życie 27.05.2026, §4.

- Autor kadrów jest ich właścicielem w takim zakresie, w jakim pozwala prawo. Własność zostaje także po późniejszym obniżeniu albo rezygnacji z planu.
- Wyjątki z §4: własność podlega warunkom umowy i prawom osób trzecich; firma albo jej pracownik przy przychodzie powyżej 1 000 000 USD rocznie musi być na planie Pro albo Mega; powiększenie cudzej planszy zostaje przy jej twórcy. Te kadry powstały na planie Pro, ze Stealth, jako własne generacje, nie jako upscale cudzych obrazów.
- Midjourney dostaje niewyłączną, nieodwołalną licencję do treści wprowadzonych do usługi i do powstałych assetów. Stealth oznacza staranie, żeby nie publikować plansz zrobionych przy włączonym Stealth. Kadry nie szły przez publiczny kanał Discorda.
- Usługa i assety są „as is”: bez gwarancji tytułu, braku naruszenia cudzych praw, przydatności handlowej i bez odszkodowania od Midjourney, gdy ktoś zakwestionuje obraz.
- §4 każe samemu sprawdzić stan prawa autorskiego we własnym kraju. W Polsce ochrona samego wyniku automatu, bez wkładu twórczego człowieka, nie jest przesądzona. Ujawnienie, że kadry powstały z pomocą AI, jest w Ustawieniach i na colgante.pl.

## Ujawnienie

- Ustawienia: „Ilustracje komiksu powstają z pomocą AI. Postaci i kancelaria Colgante są fikcyjne. Gra nie jest poradą prawną.”
- Jak czytać grę: kadry są ilustracją tej historii, nie dokumentacją z kancelarii.
- colgante.pl `/o-projekcie`: to samo, plus granica fikcji.
- Opis App Store, gdy powstanie listing: fikcja, AI, brak porady prawnej.

## Czego paczka nie zawiera

Pięć przyjętych wnętrz zostaje w `World/plates/mj/` i nie ma ich w `Assets.xcassets`: gabinet partnera (`045bcb08/0_3`), pokój aplikanta (`fcfdd2be/0_1`), sekretariat (`4e94c6cf/0_1`), korytarz (`73e52afa/0_3`), sala klienta (`e89bfce3/0_1`). Ta sama licencja Midjourney, ten sam zakaz wkładania ich do gry bez osobnej decyzji.

`World/reference-colgante/` to zamrożone płytki v1.0 z 24.09.2026: mflux, Flux.1 [dev], 8 bitów, 28 kroków, guidance 4.0. Przepis: `tools/macos-studio/prompts.json` z commita `01c8925`. Nie są w aplikacji. [Licencja modelu](https://github.com/black-forest-labs/flux/blob/main/model_licenses/LICENSE-FLUX1-dev) jest niekomercyjna dla wag; samych wag w grze nie ma. Tych PNG nie kopiować z powrotem do `Assets.xcassets`. Generator Flux w `tools/macos-studio/generate_noir.py` nie jest źródłem kadrów obecnej wersji.
