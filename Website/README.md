# colgante.pl

Statyczna witryna edukacyjna świata „Czerwonej Teczki”. Kancelaria Colgante jest
fikcyjna; newsletter i kontakt biznesowy są prowadzone przez Grzegorza Napieraja.

## Lokalnie

```bash
cd Website
npm install
npm run dev
```

`npm run sync` przed każdym uruchomieniem:

- kopiuje osiem lekcji z `../Resources/Lessons.json`,
- eksportuje 32 pozycje bibliografii z `../Views/SourcesView.swift`,
- kompresuje kanoniczne grafiki do WebP i kopiuje fonty z zasobów aplikacji.

Nie edytuj plików w `src/data/generated/` ani skopiowanych zasobów ręcznie.

## Kontrola

```bash
npm run verify
```

Wynik statyczny powstaje w `dist/`. Skrypt sprawdza typy, testy treści,
wewnętrzne odnośniki (w tym `srcset`), nagłówki bezpieczeństwa i brak trackerów.

Po `npm run preview` można powtórzyć Lighthouse:

```bash
npm run qa:lighthouse
```

Ostatni pomiar (11.09.2026, `astro preview`, strony `/`, `/wokanda`, `/newsletter`, `/autor`):
wydajność 95–99, dostępność 100, dobre praktyki 100, SEO 100. Protokół pilotażu
i bramka publikacji są w `docs/qa-launch.md`.

## Newsletter

Formularz pozostaje bezpiecznie nieaktywny, dopóki nie zostanie ustawione
`PUBLIC_NEWSLETTER_FORM_ACTION`. Skopiuj `.env.example` do `.env` i uzupełnij
publiczny endpoint formularza dostawcy.

Przed aktywacją:

1. włącz double opt-in u dostawcy,
2. ustaw natychmiastowy link wypisania,
3. zawrzyj umowę powierzenia, jeśli jest wymagana,
4. uzupełnij `/prywatnosc` o dane administratora, hosting, dostawcę, retencję i transfery,
5. wyślij testowy zapis, potwierdzenie i wypisanie,
6. skonfiguruj sekwencję powitalną 00–03 (potwierdzenie, historia, trzy karty, zaproszenie do rozmowy).

Sekretnego klucza API nie wolno umieszczać w zmiennej z prefiksem `PUBLIC_`.
Integracja używa wyłącznie publicznego endpointu formularza dostawcy.
Pole `company_website` jest pułapką antyspamową i nie powinno być mapowane na listę.

## Publikacja

Serwis jest przygotowany pod Apache w OVH (`public/.htaccess`) oraz pod
hostingi ze składnią `_headers`. Wgranie na colgante.pl:

```bash
cd Website
npm run build
OVH_FTP_PASSWORD='…' npm run deploy:ovh
```

Katalog na serwerze: `www/` (login `colgane`, host `ftp.cluster129.hosting.ovh.net`).
Hasła nie commituj.

- katalog projektu: `Website`,
- komenda budowania: `npm run build`,
- katalog publikacji: `dist`,
- Node.js 22,
- zmienne: wyłącznie `PUBLIC_NEWSLETTER_*` po akceptacji dostawcy.

Plik `public/_headers` ustawia HSTS, CSP, `nosniff`, `DENY` i ograniczenie
uprawnień na hostingach, które obsługują składnię `_headers`.

GitHub Actions: `.github/workflows/website.yml` uruchamia `npm run verify`.

## Bramka publikacyjna

Nie publikuj produkcyjnie, dopóki:

- domena i DNS nie wskazują zatwierdzonego hostingu,
- endpoint newslettera nie przeszedł testu double opt-in oraz wypisania (lista może zostać wyłączona),
- realny autor zaakceptował tekst oferty i zakres usług.
