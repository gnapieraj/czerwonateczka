# Rejestr assetów wymaganych w aplikacji

Stan: **30.09.2026**. Dotyczy binarki Czerwonej Teczki (iPhone i iPad). Aplikacja tylko odtwarza pliki z bundla. Nie ma w niej wag modelu, sieci ani generowania obrazów.

Jedyny spis i jedyne piksele kadrów: ten plik oraz `Resources/Assets.xcassets`. Prompty: `tools/macos-studio/komiks-sezony.md`. Nie ma drugiej kopii w `World/plates` ani w `mj`.

## Co jest w paczce

| Składnik | Plik w bundlu | Pochodzenie | Licencja |
|---|---|---|---|
| plansze | `Assets.xcassets` → `Assets.car` | Midjourney V8.2, plan Pro, Stealth, 30.09.2026. Sezon 1: nazwane kopie `SezonMecenas.png`, bez własnego joba | [Terms of Service](https://docs.midjourney.com/hc/en-us/articles/32083055291277-Terms-of-Service), wersja z 27.05.2026, §4 |
| Ikona | `AppIcon.appiconset/AppIcon.png` | teczka z pieczęcią, 1024×1024. Cursor GenerateImage, 8.09.2026. Nie Midjourney. Jedyny plik | [Terms of Service](https://cursor.com/terms-of-service) §5.3: Anysphere przekazuje swoje prawa do wyniku, „jeśli jakieś ma”. Bez zakazu użytku komercyjnego. Bez gwarancji braku naruszenia |
| Pismo | `GoboCaps-Regular.otf`, `GoboCaps-Italic.otf`, `OFL.txt` | Terhi Mäkinen, 2025 | SIL OFL 1.1, Reserved Font Name „Gobo Caps” |
| Muzyka | `NightDocket.m4a` | oryginalna pętla fortepianu na tę grę, synteza bez cudzych sampli (`Resources/Audio/README.md`) | prawa autora gry |
| Tekst nocy | `Lessons.json` | własny | prawa autora gry |

OFL jedzie razem z fontem. Fontu nie sprzedajemy osobno i nie wydajemy go pod inną nazwą.

## Kadry Midjourney w grze

Narzędzie: midjourney.com/imagine (Create), nie Discord. Model: V8.2. Plan: Pro (60 USD). Stealth włączony przed pierwszym promptem. Wszystko poniżej jest 1456×816, bez upscale, i leży tylko w `Resources/Assets.xcassets/<nazwa>.imageset/<nazwa>.png`.

| Plik | Rola | Adres przyjętej planszy |
|---|---|---|
| `Gabinet.png` | biblia, ekran tytułowy, tło sceny | `https://cdn.midjourney.com/1d210836-8213-4db1-baf2-ad2f7a6092ff/0_0.png` |
| `Biurko.png` | tło wokandy | `https://cdn.midjourney.com/d456402c-b73e-4bee-9a99-5c137aa09223/0_2.png` |
| `SezonMecenas.png` | lewa połowa wyboru sezonu | `https://cdn.midjourney.com/f921f941-c5ab-40fd-9a2a-24dd6d769a45/0_1.png` |
| `SezonAplikant.png` | prawa połowa wyboru sezonu | `https://cdn.midjourney.com/cc95ba9b-85cd-45dd-8a58-5f2fa1d062ba/0_1.png` |
| `Night01a.png` | dwa puste pytania na telefonie | `https://cdn.midjourney.com/ef30a37c-bd10-4f15-bf02-e30378123228/0_2.png` |
| `Night01b.png` | Iglica w drzwiach | `https://cdn.midjourney.com/daa0c5f7-1e16-40da-aff5-cabee90a1971/0_0.png` |
| `Night02a.png` | dwa pliki w mailu | `https://cdn.midjourney.com/86e027fe-dab6-42d8-8d20-9efac2b5e3fb/0_2.png` |
| `Night02b.png` | Chropot mówi | `https://cdn.midjourney.com/6c7b2b68-606f-4c06-b995-be0b9f195bfc/0_1.png` |
| `Night03a.png` | niejawna ugoda | `https://cdn.midjourney.com/904cdb8e-02be-4a03-b2a5-382ce573cb7f/0_1.png` |
| `Night03b.png` | Iglica namawia | `https://cdn.midjourney.com/fa7823ec-cc24-4e35-81da-85401d48013a/0_0.png` |
| `Night04a.png` | cztery puste pola hasła | `https://cdn.midjourney.com/363006c4-d0c4-40f9-991e-8fc7058a9dca/0_0.png` |
| `Night04b.png` | Chropot w biblii i w nocy 4 | `https://cdn.midjourney.com/38de9569-8904-47df-87e6-616bd5d04cdb/0_2.png` |
| `Night05a.png` | tablica w sali klienta | `https://cdn.midjourney.com/66fead47-31f7-4ec5-bff3-f9aadc6b8041/0_1.png` |
| `Night05b.png` | Irena w biblii i w nocy 5 | `https://cdn.midjourney.com/23a0220c-2f29-4c82-8cff-9d47026bf5a2/0_3.png` |
| `Night06a.png` | plik z nieznanego numeru | `https://cdn.midjourney.com/f661bcaf-f50e-43eb-9479-95e5b4febf09/0_0.png` |
| `Night06b.png` | Chropot każe instalować | `https://cdn.midjourney.com/2008af31-38f1-496c-b9ef-fc03c26292f3/0_0.png` |
| `Night07a.png` | SMS z linkiem | `https://cdn.midjourney.com/0605b5af-ad27-4260-8586-bba13279f372/0_1.png` |
| `Night07b.png` | Irena popędza | `https://cdn.midjourney.com/05868d4b-90aa-4a80-b532-94c3e128c759/0_3.png` |
| `Night08a.png` | laptop, kod i puste pole | `https://cdn.midjourney.com/245f90e6-0452-4961-827d-0cae2e37608e/0_2.png` |
| `Night08b.png` | Chropot wskazuje kod | `https://cdn.midjourney.com/fbf63d92-e776-4774-b0d6-f7ddc20898f1/0_2.png` |
| `Night09a.png` | słuchawka | `https://cdn.midjourney.com/0fd6873a-6313-4b5b-8bd4-4f1583491d84/0_0.png` |
| `Night09b.png` | Iglica o rachunku | `https://cdn.midjourney.com/27a12adf-19e3-4336-9a24-8fc13fee7fe5/0_3.png` |
| `Night10a.png` | puste okno programu | `https://cdn.midjourney.com/a4150d53-094c-4c7d-a4bc-988e04d74b50/0_0.png` |
| `Night10b.png` | Iglica o pozwie | `https://cdn.midjourney.com/f61e0163-337e-4bfa-91cf-8e3dfb0c1e70/0_1.png` |
| `Night11a.png` | Irena o skrzynce | `https://cdn.midjourney.com/3b0a5896-e9e1-4d6e-80cd-357e3746409f/0_0.png` |
| `Night11b.png` | Chropot przy ladzie | `https://cdn.midjourney.com/64a7c4d1-a5cc-4b5d-b3fd-4cc3bfd345ec/0_3.png` |
| `Night12a.png` | laptop z kłódką | `https://cdn.midjourney.com/9cb7b058-4fad-4618-a830-ee32e7a8e865/0_2.png` |
| `Night12b.png` | Chropot, laptop zabierany | `https://cdn.midjourney.com/12ff6522-694b-492e-a12a-2513c8de0bfb/0_1.png` |
| `Night13a.png` | zaakceptowana plansza Aplikant, 1456×816, 1,849,395 bajtów; telefon leży na aktach; job: `https://www.midjourney.com/jobs/3bfc6ba9-533c-4371-96fd-0a3543a4e7a8?index=2` | `https://cdn.midjourney.com/3bfc6ba9-533c-4371-96fd-0a3543a4e7a8/0_2.png` |
| `Night13b.png` | zaakceptowana plansza Chropot, 1456×816, 1,693,903 bajtów; job: `https://www.midjourney.com/jobs/17cc4d96-a584-48e5-b127-4d4f5dbb3276?index=3` | `https://cdn.midjourney.com/17cc4d96-a584-48e5-b127-4d4f5dbb3276/0_3.png` |
| `Night14a.png` | zaakceptowana plansza Chropot kładzie kartkę, 1456×816, 1,167,896 bajtów; job: `https://www.midjourney.com/jobs/5da205cf-982c-492a-8c7a-9ab2b6525137?index=0` | `https://cdn.midjourney.com/5da205cf-982c-492a-8c7a-9ab2b6525137/0_0.png` |
| `Night14b.png` | zaakceptowana plansza dłonie nad pustym logowaniem, 1456×816, 1,376,315 bajtów; job: `https://www.midjourney.com/jobs/c9b2f8ff-4972-4d6f-bdcb-409aaffdf5a4?index=1` | `https://cdn.midjourney.com/c9b2f8ff-4972-4d6f-bdcb-409aaffdf5a4/0_1.png` |
| `Night15a.png` | zaakceptowana plansza pismo i pusty czat, 1456×816, 1,594,683 bajtów; job: `https://www.midjourney.com/jobs/f55ff8e6-2632-4eba-84fd-500b81ce89c0?index=1` | `https://cdn.midjourney.com/f55ff8e6-2632-4eba-84fd-500b81ce89c0/0_1.png` |

`Night15b.png`–`Night24b.png` są w bundlu pod tymi nazwami jako kadry oczekujące; piksele to kopia `SezonMecenas.png` (1 472 079 bajtów), nie nowa generacja. `Night13a.png` i `Night13b.png` są wyjątkiem: zaakceptowane generacje Midjourney (Aplikant index 1; Chropot index 3), obie 1456×816, podmienione powyżej. Pozostałe oczekujące kadry mają flagę „W przygotowaniu”; podmiana później jest podmianą pliku, nie zmianą nazwy.

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

## Strona, nie gra

Te pliki są tylko w `Website/src/assets/` i nie wchodzą do aplikacji:

| Plik | Rola |
|---|---|
| `AutorPortrait.png` | portret autora na colgante.pl |
| `screens/iphone-komiks.jpg` | zrzut |
| `screens/iphone-wokanda.jpg` | zrzut |
| `screens/iphone-teczka.jpg` | zrzut |
| `screens/ipad-wokanda.jpg` | zrzut |
| `screens/ipad-komiks-landscape.jpg` | zrzut |

WebP w `Website/public/assets/` powstaje ze skryptu `npm run sync` i nie jest w gicie.
