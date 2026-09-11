# Czerwona Teczka / The Red File

Gra edukacyjna dla adwokatów, radców, sędziów i aplikantów. Offline, PL + EN. Nie jest poradą prawną.

## Klimat i miejsce

Komiks noir: czerń, biel, **tylko krew**. Akcja (fikcja): **Kancelaria Colgante i Wspólnicy**, 5. piętro, biurowiec od Świętokrzyskiej, Śródmieście. Za żaluzją PKiN w deszczu. Nazwy i adres nie wskazują prawdziwej kancelarii.

Warstwa komiksowa to **bundlowane assety**: mastery `World/bible/` plus płyty misji z modelu komercyjnego (GenerateImage). iPad tylko odtwarza gotowe pliki.

## Uruchomienie (Mac Studio, Xcode 26)

1. Otwórz `CzerwonaTeczka.xcodeproj`.
2. Signing & Capabilities → Team: **Personal Team** (nie commituj `DEVELOPMENT_TEAM`).
3. Cel: fizyczny iPad 9 albo iPhone SE 3.
4. ⌘R.

Orientacje: iPhone pion; iPad pion i poziom (w poziomie: komiks | dossier).

## Mechanika

STEMPEL / ODRZUT / DRUGI KANAŁ. Liczniki: Tajemnica, Sąd, Klient, Rozliczalność. Po wyborze — **Ratio**. Wieczór (3 teczki) albo cała wokanda (8).

Tajemnica = **art. 6** Pr. o adwokaturze, nie art. 17. USB: DKN.5131.31.2022. Emotion AI: wyłącznie AI Act art. 5(1)(f); 7% tylko tam.

## Testy

```
python3 tools/validate_lessons.py
```

Na Macu: ⌘U (`LessonPackTests`).

Grafika (tylko Studio): `python3 tools/macos-studio/generate_noir.py --smoke`
