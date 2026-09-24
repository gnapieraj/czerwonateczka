# Szablony maili — Czerwona lampka

Statyczne HTML pod Brevo (Campaigns / Automation / Templates → Import HTML
albo wklejenie kodu). Wspólna kolorystyka z colgante.pl.

## Paleta (wszystkie 4 maile)

| Token | Hex | Użycie |
|---|---|---|
| void | `#09090a` | tło wiadomości |
| ink | `#121214` | karty / bloki |
| paper | `#e8e0cd` | tekst główny |
| paper-dim | `#b8ad98` | tekst poboczny |
| blood | `#b8141a` | eyebrow, przycisk, kreski |
| line | `#ffffff24` | linie |

## Typografia (bezpieczna w mailach)

- Nagłówki: `Georgia, 'Times New Roman', serif` (Gobo Caps nie działa niezawodnie w skrzynkach)
- UI / mono: `'Courier New', Courier, monospace`
- Rozmiary: eyebrow 12px · H1 28px · lead 16px · body 15px · button 14px

## Pliki

| Plik | Krok sekwencji | Kiedy |
|---|---|---|
| `00-doi.html` | 00 potwierdzenie DOI | href musi być `{{ doubleoptin }}` (tag Brevo DOI; nie `{{ double_opt_in_link }}`) |
| `01-czerwona-teczka.html` | 01 kontekst projektu | automatyzacja po DOI |
| `02-trzy-karty.html` | 02 materiały | +1–2 dni po 01 |
| `03-rozmowa.html` | 03 zaproszenie | +kilka dni po 02 |
| `unsubscribe-page.html` | strona wypisu (Brevo) | wzór Design + teksty PL; redirect na colgante.pl |

## Brevo — automatyzacja

1. **Automations → Create** → trigger: kontakt dodany do listy „Czerwona lampka”
   (po DOI).
2. Krok e-mail: wklej HTML z `01-…`, potem Delay, potem `02-…`, Delay, `03-…`.
3. **DOI (00)** zostaje przy formularzu (Settings → Double confirmation template).
4. Strona po kliknięciu DOI:
   `https://colgante.pl/newsletter/?zapis=potwierdzony`
   (`/newsletter/potwierdzony/` przekierowuje na ten sam adres).

## Zasady

- Jeden przycisk CTA na mail.
- Bez dużych hero-obrazów w DOI; w 01–03 CTA-linki wystarczą.
- Zawsze stopka: nadawca Grzegorz Napieraj / wypis Brevo / nie Colgante.
- Wypis: `<a href="{{ unsubscribe }}">Wypisz się</a>` — sam `{{ unsubscribe }}`
  wkleja surowy długi URL do treści maila.

## Brevo — strona wypisu (Unsubscribe pages)

Brevo nie importuje pełnego HTML strony wypisu jak maila — budujesz ją w panelu,
a `unsubscribe-page.html` to **wzór kolorów i tekstów** (otwórz lokalnie w przeglądarce).

1. **Settings → Campaigns → Unsubscribe pages → Create**
   Nazwa: `Wypis — Czerwona lampka`.
2. **Design** — strona ciemna, **karta kremowa** (jak potwierdzenie zapisu na
   colgante.pl). Brevo często zostawia ciemny tekst — na ciemnej karcie znika.
   - tło strony `#09090a`
   - kontener `#e8e0cd`, obramowanie `#b8141a`
   - tytuł i treść `#09090a`
   - przycisk `#b8141a` / tekst `#ffffff`
3. **Build / Messages** — wklej teksty PL z tego samego komentarza
   (tytuł, instrukcja, przycisk, success, error).
4. **Po potwierdzeniu** → redirect:
   `https://colgante.pl/newsletter/wypisano/`
5. W każdym mailu automatyzacji: **Edit settings → custom unsubscribe page**
   → wybierz `Wypis — Czerwona lampka`.
6. Ankietę wypisu ustaw na Polish albo wyłącz.
