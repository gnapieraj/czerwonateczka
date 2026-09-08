# Czerwona Teczka / The Red File

Gra edukacyjna dla adwokatów, radców, sędziów i aplikantów. Offline, PL + EN. Nie jest poradą prawną.

## Klimat i miejsce

Sin City: czerń, biel, **tylko krew**. Akcja: **Kancelaria Vogel, Kruk i Wspólnicy, ul. Królewska 16, 5. piętro, Śródmieście, Warszawa**. Za żaluzją PKiN w deszczu.

Warstwa komiksowa to **bundlowane PNG** (obsada + biuro), nie generator na iPadzie. iPad 9 (A13) i iPhone SE 3 nie utrzymają tożsamości postaci. Lokalny model (Mac Studio, ComfyUI / Flux) — tylko offline, raz, img2img z `World/VisualBible.md`.

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
