# QA i bramka publikacji — colgante.pl

Stan na 11.09.2026. Witryna jest gotowa do pilotażu i wdrożenia statycznego.
Produkcja na domenie pozostaje zamknięta, dopóki nie przejdzie bramki z README.

## Wynik techniczny

| Kontrola | Wynik |
| --- | --- |
| `npm run verify` | typowanie, 5 testów treści, 21 stron, 0 martwych odnośników |
| Lighthouse (`astro preview`, 4 strony) | wydajność 95–99, dostępność 100, dobre praktyki 100, SEO 100 |
| Kontrast | poprawiony eyebrow `AKTA 01/02/03` na ciemnych kartach w pasie papieru |
| iPhone SE (375 px) | brak poziomego overflowu |
| Desktop (1280 px) | nagłówek zawija się, bez overflowu |
| Filtr wokandy | temat BEC pokazuje jedną kartę |
| 404 | strona „Błędna sygnatura” |
| Trackery reklamowe | brak |
| Formularz newslettera | nieaktywny bez `PUBLIC_NEWSLETTER_FORM_ACTION` |
| Nagłówki `_headers` | HSTS, CSP, nosniff, DENY, Permissions-Policy |

Lokalny `astro preview` nie wysyła `_headers`. Nagłówki obowiązują na Cloudflare Pages lub Netlify.

## Protokół pilotażu (5–10 osób)

Odbiorcy: prawnicy, aplikanci, osoby od bezpieczeństwa informacji. Czas: 12–15 minut. Nie zbierać akt klientów.

1. Otwórz stronę główną na telefonie. W 5 sekund: kto jest fikcją, kto jest autorem?
2. Wejdź w jedną teczkę. Czy materiał jest użyteczny bez zagrania w grę i bez spoilera rozwiązania?
3. Otwórz jedną kartę z `/materialy`. Czy da się zastosować jutro?
4. Przeczytaj `/newsletter`. Czy wiadomo, kto będzie nadawcą i że to nie jest kancelaria?
5. Wejdź na `/autor`. Czy oferta IT Security jest oddzielona od Colgante?
6. Spróbuj zapisać się do listy. Czy komunikat o nieaktywnej liście / zgodzie jest jasny?
7. Otwórz `/prywatnosc`. Czego brakuje przed startem listy?
8. Czy cokolwiek sugeruje, że można umówić poradę prawną?

Zapis odpowiedzi: tak / nie / cytat z ekranu. Kryterium przejścia: wszyscy rozumieją fikcję; co najmniej 7/10 widzi wartość teczki lub karty.

## Ponowny pomiar

```bash
cd Website
npm run verify
npm run preview -- --host 127.0.0.1 --port 4323
# w drugim terminalu:
npm run qa:lighthouse
```
