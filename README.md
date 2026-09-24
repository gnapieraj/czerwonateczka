# Czerwona Teczka / The Red File

Gra edukacyjna dla adwokatów, radców i aplikantów. Offline, PL + EN. Nie jest poradą prawną.

Witryna edukacyjna: [colgante.pl](https://colgante.pl).

## Klimat i miejsce

Komiks noir: czerń, biel, **tylko krew**. Akcja (fikcja): **Kancelaria Colgante i Wspólnicy**, 5. piętro, biurowiec od Świętokrzyskiej, Śródmieście. Za żaluzją PKiN w deszczu.

## Uruchomienie

1. Otwórz `CzerwonaTeczka.xcodeproj`.
2. Signing & Capabilities → Team (nie commituj `DEVELOPMENT_TEAM`).
3. Cel: iPhone (tylko pion) lub iPad (pion i poziom).
4. ⌘R.

## Mechanika (wersja 12 nocy)

- Dwanaście nocy, odblokowywanych liniowo po stemplu poprzedniej.
- Komiks: dwa kadry (`NightNNa` / `NightNNb`).
- Decyzja: trzy wiarygodne odpowiedzi → werdykt **TRAFNE / BŁĘDNE / NIEPEŁNE**.
- Po wyborze: splash werdyktu → Ratio (refleks; w trybie fabularnym bez pełnych liczników na ekranie) → opcjonalny Briefing.
- Tematy z newslettera SANS OUCH; sceny i Colgante są fikcją.

## Lekcje i witryna

```bash
python3 tools/build_lessons.py
python3 tools/validate_lessons.py
cd Website && npm run sync && npm run verify
```

Audyt warstwy edukacyjnej: `World/AudytWarstwyEdukacyjnej.md`.

## Testy

Na Macu: ⌘U (`LessonPackTests`).

Grafika (Studio): `python3 tools/macos-studio/generate_noir.py --smoke`
