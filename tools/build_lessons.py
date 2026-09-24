#!/usr/bin/env python3
"""Noir nights for a law firm. Topics follow SANS OUCH; the scenes are original fiction."""
import argparse
import json
from pathlib import Path


def loc(pl, en):
    return {"pl": pl, "en": en}


def beat(asset, pl, en, voice="caption"):
    return {"asset": asset, "caption": loc(pl, en), "voice": voice}


def delta(t=0, s=0, k=0, r=0):
    return {"tajemnica": t, "sad": s, "klient": k, "rozliczalnosc": r}


def ratio(reflex):
    line = loc(*reflex)
    return {
        "statute": line,
        "consequence": line,
        "reflex": line,
        "pattern": loc("Nawyk, nie paragraf.", "A habit, not a statute."),
    }


def choice(cid, kind, verdict, d, title, reflex):
    return {
        "id": cid,
        "kind": kind,
        "verdict": verdict,
        "delta": d,
        "title": loc(*title),
        "subtitle": loc(*reflex),
        "ratio": ratio(reflex),
    }


def awareness(threat, minimize, practice, watch):
    return {
        "threat": loc(*threat),
        "minimize": loc(*minimize),
        "practice": loc(*practice),
        "watchFor": [loc(*w) for w in watch],
    }


def _rotated(order, trap, decoy_a, decoy_b):
    choices = [
        choice("trap", "verify", "sound", delta(r=8), trap[0], trap[1]),
        choice("decoy-a", "stamp", "unsound", delta(t=-12, s=-8), decoy_a[0], decoy_a[1]),
        choice("decoy-b", "reject", "incomplete", delta(k=-6), decoy_b[0], decoy_b[1]),
    ]
    shift = (order - 1) % 3
    return choices[shift:] + choices[:shift]


def night(
    nid, order, exhibit, hero, title, subtitle, deadline, context, voice,
    panels, trap, decoy_a, decoy_b, minimize, practice, watch, red,
):
    return {
        "id": nid,
        "order": order,
        "demo": order <= 3,
        "storyMode": True,
        "exhibit": exhibit,
        "hero": hero,
        "tone": "shadow",
        "title": loc(*title),
        "subtitle": loc(*subtitle),
        "deadline": loc(*deadline),
        "context": loc(*context),
        "beats": [beat(a, p, e, v) for a, p, e, v in panels],
        "exhibitLabel": loc("NA BIURKU", "ON THE DESK"),
        "exhibitText": loc(*context),
        "innerVoice": loc(*voice),
        "redFlags": [loc(*red)],
        "choices": _rotated(order, trap, decoy_a, decoy_b),
        "awareness": awareness(
            context,
            minimize,
            practice,
            watch,
        ),
        "sourceIds": [],
    }


# Each choice is a move a busy partner would actually consider.
# Topics follow SANS OUCH. Scenes and wording are original fiction.
# The sound move costs time. The other two look competent.

lessons = [
    night(
        "01-kod", 1, "phone", "Night01a",
        ("Drugie zatwierdzenie", "The second approval"),
        ("Logowanie do portalu", "Portal sign-in"),
        ("Rozprawa za cztery minuty", "Hearing in four minutes"),
        ("Wchodzisz do portalu sądu ze swojego telefonu i wpisujesz hasło. Telefon pyta: „Czy zatwierdzić logowanie?”. Zatwierdzasz. Minutę później przychodzi drugie, takie samo pytanie. Iglica mówi, że to Chropot z sali rozpraw: nie może się zalogować i prosi, żebyś zatwierdził też to drugie.",
         "You sign in to the court portal from your own phone and type the password. The phone asks: “Approve this sign-in?”. You approve it. A minute later a second, identical question arrives. Iglica says it is Chropot in the courtroom: he cannot sign in and wants you to approve that one too."),
        ("Które pytanie na telefonie jest twoim logowaniem?", "Which question on the phone is your own sign-in?"),
        [
            ("Night01a", "Hasło wpisane. Na telefonie dwa pytania: „Czy zatwierdzić logowanie?”.",
             "Password entered. Two questions on the phone: “Approve this sign-in?”.", "caption"),
            ("Night01b", "Iglica: „Drugie pytanie to Chropot z sali. Bez niego spadamy z wokandy.”",
             "Iglica: “The second question is Chropot in court. Without it we fall off the list.”", "balloon"),
        ],
        (("Zatwierdzam tylko pierwsze pytanie, to zaraz po moim haśle. Drugie odrzucam i dzwonię do Chropota na numer z książki telefonicznej kancelarii.",
          "I approve only the first question, the one right after my password. I reject the second and call Chropot on the number in the firm phone book."),
         ("Drugie pytanie to czyjeś inne logowanie, nawet gdy Iglica mówi, że słyszy partnera.",
          "The second question is someone else’s sign-in, even if Iglica says he hears the partner.")),
        (("Zatwierdzam oba pytania. Iglica stoi obok i mówi, że drugie to laptop Chropota na sali.",
          "I approve both questions. Iglica is right here and says the second one is Chropot’s laptop in court."),
         ("Pośpiech i zdanie aplikanta nie mówią, czyje to logowanie.",
          "Hurry and the trainee’s sentence do not say whose sign-in it is.")),
        (("Nie zatwierdzam żadnego pytania. W dniu rozprawy wolałbym w ogóle nie ruszać telefonu.",
          "I approve neither question. On a hearing day I would rather not touch the phone at all."),
         ("Pierwsze pytanie trzeba zatwierdzić, bo to twoje logowanie. Drugie sprawdzasz telefonem do partnera, nie odmową wszystkiego.",
          "The first question has to be approved, because it is your sign-in. You check the second by calling the partner, not by refusing everything.")),
        ("Drugie pytanie odrzucasz. Pierwsze zostawiasz, bo sam je wywołałeś hasłem. Potem dzwonisz do Chropota na numer z książki telefonicznej.",
         "You reject the second question. You keep the first, because your password triggered it. Then you call Chropot on the number in the phone book."),
        ("Pytanie „Czy zatwierdzić logowanie?” zatwierdzasz tylko wtedy, gdy sam przed chwilą wpisałeś hasło. Drugie sprawdzasz z partnerem, nie z aplikantem.",
         "You approve “Approve this sign-in?” only when you just typed the password. You check the second question with the partner, not the trainee."),
        [("Drugie pytanie, którego nie wywołałeś swoim hasłem.", "A second question your password did not trigger."),
         ("Odmowa także własnego logowania, bez telefonu do partnera.", "A refusal of your own sign-in too, with no call to the partner.")],
        ("Dwa pytania na telefonie. Hasło wpisałeś raz.", "Two questions on the phone. You typed the password once."),
    ),
    night(
        "02-list", 2, "email", "Night02a",
        ("Doklejone pismo", "The extra filing"),
        ("Poczta · portal", "Mail · portal"),
        ("Termin doręczenia dziś", "Service deadline today"),
        ("Chropot przesyła dalej mail od sądu w twojej sprawie. Do tej wiadomości sam dołączył drugi plik PDF o nazwie „uzupełnienie opłaty”. Mówi, że dopisał go ręcznie, bo portal sądu działa wolno, i że masz otworzyć oba pliki, bo sygnatura się zgadza.",
         "Chropot forwards a court email in your matter. He himself attached a second PDF named “fee supplement”. He says he added it by hand because the court portal is slow, and that you should open both files because the case number matches."),
        ("Który plik otwierasz?", "Which file do you open?"),
        [
            ("Night02a", "Mail od Chropota: pismo sądu i drugi PDF, „uzupełnienie opłaty”.",
             "Mail from Chropot: the court’s paper and a second PDF, “fee supplement”.", "caption"),
            ("Night02b", "Chropot: „Otwórz oba. Sygnatura się zgadza, portal działa wolno.”",
             "Chropot: “Open both. The case number matches. The portal is slow.”", "balloon"),
        ],
        (("Drugiego PDF-a nie otwieram. Wchodzę do portalu sądu przez adres, który mam zapisany, i sprawdzam, czy „uzupełnienie opłaty” tam jest.",
          "I do not open the second PDF. I open the court portal from the address I have saved and check whether “fee supplement” is there."),
         ("Plik dołączony przez partnera nie jest pismem sądu, dopóki nie ma go w portalu, z którego bierzesz doręczenia.",
          "A file the partner attached is not the court’s paper until it is in the portal you take service from.")),
        (("Otwieram oba pliki. To ten sam mail, ten sam partner i ta sama sygnatura.",
          "I open both files. It is the same email, the same partner, and the same case number."),
         ("Partner w dobrej wierze dołącza plik, którego sąd nie wysłał.",
          "A partner in good faith attaches a file the court never sent.")),
        (("Nie otwieram żadnego pliku. Odpisuję na ten mail i proszę, żeby sąd przysłał pismo jeszcze raz.",
          "I open no file. I reply to this email and ask the court to send the paper again."),
         ("Odpowiedź na ten mail nie potwierdza pisma i potrafi zgubić termin.",
          "A reply to this email does not confirm the paper, and it can lose the deadline.")),
        ("Drugiego PDF-a nie otwierasz i nie odpisujesz na ten mail. Termin sprawdzasz w portalu sądu, pod adresem, który masz zapisany.",
         "You do not open the second PDF and you do not reply to this email. You check the deadline in the court portal, at the address you have saved."),
        ("Pismo bierzesz z portalu sądu, do którego sam wchodzisz. Plik dołączony do przesłanego maila sprawdzasz tam, zanim go otworzysz.",
         "You take the paper from the court portal you open yourself. You check a file attached to a forwarded email there before you open it."),
        [("PDF dołączony przez partnera do maila od sądu.", "A PDF the partner attached to a court email."),
         ("Prośba, żeby nie wchodzić do portalu, bo działa wolno.", "A request to skip the portal because it is slow.")],
        ("Dwa pliki w mailu. Sąd wysłał jeden.", "Two files in the email. The court sent one."),
    ),
    night(
        "03-prompt", 3, "prompt", "Night03a",
        ("Ugoda w asystencie", "The settlement in the assistant"),
        ("Firmowy asystent", "The firm assistant"),
        ("Ugoda przed północą", "Settlement before midnight"),
        ("Kancelaria ma firmowego asystenta do pisania pism. Jest umowa z dostawcą, a IT mówi, że program nie uczy się na waszych tekstach. W schowku kopiuj-wklej leży projekt ugody, której klient jeszcze nie widział: nazwy stron, kwota i sygnatura sprawy.",
         "The firm has an assistant for drafting. There is a vendor contract, and IT says the program does not learn from your texts. The copy-paste clipboard holds a draft settlement the client has not seen: party names, the figure, and the case number."),
        ("Co z tej ugody wklejasz do asystenta?", "What from this settlement do you paste into the assistant?"),
        [
            ("Night03a", "Projekt ugody jest jeszcze niejawny. Rada klienta czyta go rano.",
             "The draft settlement is still unreleased. The client’s board reads it in the morning.", "caption"),
            ("Night03b", "Iglica: „IT mówi, że program się nie uczy. Wklej projekt, zdążymy.”",
             "Iglica: “IT says the program does not learn. Paste the draft. We’ll make it.”", "balloon"),
        ],
        (("Proszę tylko o układ klauzul, na zmyślonym przykładzie. Bez nazw stron, bez kwoty i bez sygnatury z tej sprawy.",
          "I ask only for a clause structure, on a made-up example. No party names, no figure, and no case number from this matter."),
         ("To, że program nie uczy się na tekstach, nie robi z projektu ugody czegoś, co wolno wkleić.",
          "The program not learning from texts does not make the draft settlement something you may paste.")),
        (("Wklejam cały projekt ugody. Mamy umowę z dostawcą, a IT mówi, że program się nie uczy.",
          "I paste the whole draft settlement. We have a vendor contract, and IT says the program does not learn."),
         ("Umowa z dostawcą nie zatrzymuje kwoty ugody w pokoju.",
          "A vendor contract does not keep the settlement figure in the room.")),
        (("Wycinam nazwy stron. Zostawiam kwotę i sygnaturę, bo bez nich układ klauzul jest bezużyteczny.",
          "I cut the party names. I leave the figure and the case number, because without them the clause structure is useless."),
         ("Kwota i sygnatura wskazują sprawę tak samo jak nazwa strony.",
          "The figure and the case number point to the matter as surely as a party’s name.")),
        ("Projekt ugody zostaje w akcie. Do asystenta wpisujesz prośbę o układ klauzul, bez nazw, bez kwoty i bez sygnatury.",
         "The draft settlement stays in the file. You ask the assistant for a clause structure, with no names, no figure, and no case number."),
        ("Umowa z dostawcą i zdanie IT, że program się nie uczy, nie są zgodą na wklejenie sprawy. Do asystenta idzie układ klauzul, nie akta.",
         "A vendor contract and IT’s line that the program does not learn are not consent to paste the matter. The assistant gets a clause structure, not the file."),
        [("Cały projekt ugody wklejony, „bo mamy umowę”.", "The whole draft settlement pasted, “because we have a contract”."),
         ("Wycięte nazwy stron przy zostawionej kwocie i sygnaturze.", "Party names cut, the figure and the case number left in.")],
        ("Asystent jest firmowy. Ugoda jeszcze nie wyszła do klienta.", "The assistant is the firm’s. The settlement has not gone to the client yet."),
    ),
    night(
        "04-haslo", 4, "memo", "Night04a",
        ("Hasło przed radą", "The password before the board"),
        ("Pokój danych", "Data room"),
        ("Rada za dwadzieścia minut", "Board in twenty minutes"),
        ("Klient ma wejść do pokoju danych, czyli na stronę, na którą wrzuca dokumenty do sprawy. Link do tej strony już wysłałeś mailem. Nowe hasło to cztery zwykłe słowa, zapisane na kartce na biurku. Klient ich nie zna. Rada siada za dwadzieścia minut i nikt nie odbiera telefonu. Chropot chce, żebyś odpisał w tym samym mailu i wpisał te cztery słowa pod linkiem.",
         "The client has to enter the data room, the site where they upload documents for the matter. You already emailed the link to that site. The new password is four ordinary words, written on a slip on the desk. The client does not know them. The board sits in twenty minutes and nobody is picking up. Chropot wants you to reply in that same email and type the four words under the link."),
        ("Jak przekazać klientowi te cztery słowa?", "How do you give the client these four words?"),
        [
            ("Night04a", "Mail z linkiem już poszedł. Na kartce leżą cztery słowa nowego hasła.",
             "The email with the link has gone. Four words of the new password lie on a slip.", "caption"),
            ("Night04b", "Chropot: „Odpisz w tym mailu i wpisz te cztery słowa pod linkiem.”",
             "Chropot: “Reply in this email and type the four words under the link.”", "balloon"),
        ],
        (("Zostawiam te cztery słowa w programie kancelarii do haseł. Czytam je klientowi na głos w osobnej rozmowie telefonicznej. W mailu z linkiem hasła nie wpisuję.",
          "I keep the four words in the firm’s password program. I read them aloud to the client in a separate phone call. I do not type the password in the email that has the link."),
         ("Link i hasło w jednym mailu otwierają pokój każdemu, kto ten mail przeczyta.",
          "The link and the password in one email open the room to anyone who reads that email.")),
        (("Odpisuję w tym samym mailu, tuż pod linkiem, i wpisuję te cztery słowa. Rada nie będzie czekać, aż ktoś odbierze.",
          "I reply in the same email, just under the link, and type the four words. The board will not wait for someone to pick up."),
         ("Mail, w którym już jest link, nie jest miejscem na hasło.",
          "The email that already carries the link is not a place for the password.")),
        (("Nie podaję nowego hasła. Zostawiam to z zeszłego miesiąca, które klient już dostał mailem. Sam prosił, żeby przed radą nie zmieniać hasła.",
          "I do not give the new password. I keep last month’s, which the client already got by email. He asked us not to change the password before the board."),
         ("Hasło, które już poszło mailem, nie jest sekretem tej rady. Jest zużytym hasłem.",
          "A password that already went by email is not this board’s secret. It is a spent password.")),
        ("Tych czterech słów nie wpisujesz w mailu z linkiem. Czytasz je klientowi na głos w osobnej rozmowie, nawet jeśli rada chwilę poczeka.",
         "You do not type these four words in the email with the link. You read them aloud to the client in a separate call, even if the board waits a moment."),
        ("Link do pokoju i hasło nie jadą w jednym mailu. Starego hasła, które już poszło pocztą, nie zostawiasz tylko dlatego, że rada się spieszy.",
         "The room link and the password do not travel in one email. You do not keep an old password that already went by email just because the board is in a hurry."),
        [("Hasło wpisane w odpowiedzi, pod linkiem do pokoju.", "The password typed in the reply, under the link to the room."),
         ("Zostawione hasło z zeszłego miesiąca, które klient dostał mailem.", "Last month’s password kept, the one the client got by email.")],
        ("Hasło leży na kartce. Mail z linkiem już poszedł.", "The password is on the slip. The email with the link has gone."),
    ),
    night(
        "05-arkusz", 5, "memo", "Night05a",
        ("Hasło klienta", "The client’s password"),
        ("System klienta", "The client’s system"),
        ("Kontrola jutro rano", "Review tomorrow morning"),
        ("We dwóch wchodzicie do starego systemu klienta, tego, w którym trzymają swoje dokumenty. Hasło jest napisane mazakiem na tablicy w ich sali konferencyjnej. Jutro kontroler czyta chronologię sprawy w aktach kancelarii. Irena chce, żebyś wpisał to hasło do chronologii, „żeby akta były kompletne”.",
         "The two of you sign in to the client’s old system, the one where they keep their documents. The password is written in marker on the whiteboard in their conference room. Tomorrow a reviewer reads the matter chronology in the firm’s file. Irena wants you to type that password into the chronology, “so the file is complete”."),
        ("Gdzie zapisujesz to hasło na noc?", "Where do you write this password down for the night?"),
        [
            ("Night05a", "Tablica w sali klienta. Mazakiem napisane hasło do ich systemu.",
             "The whiteboard in the client’s room. Their system password written in marker.", "caption"),
            ("Night05b", "Irena: „Wpisz hasło do chronologii. Kontroler ma widzieć komplet.”",
             "Irena: “Type the password into the chronology. The reviewer must see a complete file.”", "balloon"),
        ],
        (("Wpisuję hasło do programu kancelarii do haseł, tylko dla dwóch osób z tej sprawy. Tablicy nie fotografuję.",
          "I put the password in the firm’s password program, only for the two people on this matter. I do not photograph the board."),
         ("Hasło do systemu klienta zostaje u osób, które mają się tam zalogować, nie w aktach.",
          "The password to the client’s system stays with the people who must sign in there, not in the file.")),
        (("Wpisuję hasło do chronologii w aktach. Bez tego kontroler jutro zobaczy niekompletne akta.",
          "I type the password into the chronology in the file. Without it the reviewer will see an incomplete file tomorrow."),
         ("Chronologię czytają ludzie, którzy nie logują się do systemu klienta.",
          "People who do not sign in to the client’s system read the chronology.")),
        (("Robię zdjęcie tablicy i wrzucam je do zdjęć sprawy. Klient sam napisał hasło na tablicy.",
          "I photograph the board and put it in the matter photos. The client wrote the password on the board."),
         ("Zdjęcie w aktach zostaje dłużej niż napis na tablicy, którą rano zetrą.",
          "A photo in the file outlasts the writing on the board they will wipe in the morning.")),
        ("Tablicy nie fotografujesz i nie przepisujesz hasła do chronologii. Zapisujesz je w programie do haseł, tylko dla dwóch osób ze sprawy.",
         "You do not photograph the board and you do not copy the password into the chronology. You store it in the password program, only for the two people on the matter."),
        ("Hasło do systemu klienta nie jest częścią akt. Kontroler czyta chronologię bez hasła, którym wchodzicie do systemu.",
         "The password to the client’s system is not part of the file. The reviewer reads the chronology without the password you use to sign in."),
        [("Hasło wpisane do chronologii „dla kompletności akt”.", "A password typed into the chronology “for a complete file”."),
         ("Zdjęcie tablicy z hasłem w zdjęciach sprawy.", "A photo of the whiteboard password in the matter photos.")],
        ("Kontroler czyta akta. Hasła tam nie ma.", "The reviewer reads the file. The password is not in it."),
    ),
    night(
        "06-pomoc", 6, "phone", "Night06a",
        ("Program w trakcie awarii", "A program during the outage"),
        ("Zgłoszenie", "The ticket"),
        ("Wokanda za dziesięć minut", "List in ten minutes"),
        ("Poczta nie działa. W zgłoszeniu, które sam założyłeś u informatyków kancelarii, jest napisane: awaria jest na serwerze poczty, laptopy są sprawne, nic nie instalować. Osobno pisze administrator, którego znasz, z numeru, którego nie masz w telefonie. Pisze, że zgubił służbowy telefon i przysyła program do zdalnej naprawy, ten sam co w marcu.",
         "Mail is down. The ticket you opened with the firm’s IT says: the outage is on the mail server, the laptops are fine, install nothing. Separately, an administrator you know writes from a number you do not have in your phone. He says he lost his work phone and sends a remote-repair program, the same one as in March."),
        ("Której instrukcji słuchasz?", "Which instruction do you follow?"),
        [
            ("Night06a", "Zgłoszenie: nic nie instalować. Na telefonie plik z nieznanego numeru.",
             "The ticket: install nothing. On the phone, a file from an unknown number.", "caption"),
            ("Night06b", "Chropot: „W marcu ten program nas podniósł. Instaluj, sala czeka.”",
             "Chropot: “In March that program brought us back. Install it. The court is waiting.”", "balloon"),
        ],
        (("Nie instaluję programu z wiadomości. Zostaję przy zgłoszeniu: awaria jest na serwerze poczty, laptopy są sprawne.",
          "I do not install the program from the message. I stay with the ticket: the outage is on the mail server, the laptops are fine."),
         ("Znajomy administrator na nowym numerze nie unieważnia zgłoszenia, które sam założyłeś.",
          "A familiar administrator on a new number does not overrule the ticket you opened.")),
        (("Instaluję ten program. Logo się zgadza, a w marcu taki plik naprawił nam pocztę.",
          "I install this program. The logo matches, and in March a file like that fixed our mail."),
         ("Plik z marca i plik z nowego numeru to nie ten sam plik.",
          "The file from March and the file from a new number are not the same file.")),
        (("Instaluję ten program tylko na laptopie Iglicy, na próbę, zanim dam go na salę.",
          "I install this program only on Iglica’s laptop, as a test, before I take it into court."),
         ("Laptop „na próbę” jest nadal laptopem kancelarii.",
          "A “test” laptop is still a firm laptop.")),
        ("Programu z nowego numeru nie instalujesz, także na próbę na laptopie Iglicy. Zostajesz przy zgłoszeniu, które sam otworzyłeś.",
         "You do not install the program from the new number, not even as a test on Iglica’s laptop. You stay with the ticket you opened."),
        ("W awarii czytasz zgłoszenie, które sam otworzyłeś. Programu do naprawy nie bierzesz z numeru, którego nie masz w telefonie.",
         "In an outage you read the ticket you opened. You do not take a repair program from a number you do not have in your phone."),
        [("Program do zdalnej naprawy z numeru spoza telefonu.", "A remote-repair program from a number that is not in the phone."),
         ("Instalacja „na próbę” na laptopie aplikanta.", "An install “as a test” on the trainee’s laptop.")],
        ("Awaria jest na serwerze poczty. Program przyszedł skądinąd.", "The outage is on the mail server. The program came from somewhere else."),
    ),
    night(
        "07-sms", 7, "phone", "Night07a",
        ("Druga opłata", "The second fee"),
        ("SMS · wokanda", "SMS · list"),
        ("Wokanda dziś", "The list is today"),
        ("Przychodzi SMS z linkiem do płatności. Podaje sygnaturę sprawy i nazwę firmy, przez którą w marcu płaciłeś opłatę sądową. Kwota jest podobna do tej z nakazu zapłaty kosztów, ale SMS dzieli ją na dwie raty. W nakazie była jedna kwota. Irena mówi, że kasa sądu mogła podzielić wpłatę. Wokanda jest dziś.",
         "An SMS arrives with a payment link. It cites the case number and the name of the firm you paid the court fee through in March. The amount is close to the costs order, but the SMS splits it into two instalments. The order had one amount. Irena says the court cashier may have split the payment. The list is today."),
        ("Czy płacisz tę drugą ratę?", "Do you pay this second instalment?"),
        [
            ("Night07a", "SMS z linkiem do płatności i sygnaturą, którą rano czytałeś w aktach.",
             "An SMS with a payment link and the case number you read in the file this morning.", "caption"),
            ("Night07b", "Irena: „To ta sama firma co w marcu. Zapłać, bo spadniemy z listy.”",
             "Irena: “It is the same firm as in March. Pay, or we fall off the list.”", "balloon"),
        ],
        (("Otwieram nakaz w aktach i księgę opłat kancelarii. Dopóki tej raty nie ma w nakazie, nie płacę i nie otwieram linku z SMS-a.",
          "I open the order in the file and the firm’s fee ledger. Until this instalment is in the order, I do not pay and I do not open the link in the SMS."),
         ("Znana sygnatura i znana firma płatnicza nie tworzą opłaty, której nie ma w nakazie.",
          "A known case number and a known payment firm do not create a fee that is not in the order.")),
        (("Płacę przez link z SMS-a. Firma jest ta z marca, sygnatura się zgadza, wokanda jest dziś.",
          "I pay through the link in the SMS. The firm is the one from March, the case number matches, the list is today."),
         ("Zgodna sygnatura nie znaczy, że ta rata jest w nakazie.",
          "A matching case number does not mean this instalment is in the order.")),
        (("Dzwonię na numer podany w SMS-ie i pytam, czy tej raty brakuje.",
          "I call the number given in the SMS and ask whether this instalment is missing."),
         ("Numer z SMS-a nie jest kasą sądu.",
          "The number in the SMS is not the court’s cashier.")),
        ("Linku z SMS-a nie otwierasz i na numer z SMS-a nie dzwonisz. Kwotę zestawiasz z nakazem w aktach i z księgą opłat.",
         "You do not open the link in the SMS and you do not call the number in the SMS. You compare the amount with the order in the file and with the fee ledger."),
        ("Opłatę porównujesz z nakazem i z księgą opłat. Linku i numeru z SMS-a nie używasz do dopłaty.",
         "You compare the fee with the order and the fee ledger. You do not use the link or the number in the SMS to pay a top-up."),
        [("Rata, której nie ma w nakazie zapłaty kosztów.", "An instalment that is not in the costs order."),
         ("Telefon na numer podany w SMS-ie.", "A call to the number given in the SMS.")],
        ("Sygnatura jest z akt. Rata nie jest z nakazu.", "The case number is from the file. The instalment is not from the order."),
    ),
    night(
        "08-qr", 8, "memo", "Night08a",
        ("IBAN po wyroku", "The IBAN after judgment"),
        ("Koszty", "Costs"),
        ("Przelew dziś", "Transfer today"),
        ("W wyroku jest wpisany numer rachunku do zapłaty kosztów. Godzinę później przychodzi PDF. Ma stopkę kancelarii, z którą latami korespondujesz, ale nadawca to adres Gmail, nie ich domena. W PDF jest kwadratowy kod do zeskanowania telefonem, podpisany „nowy numer rachunku”. Chropot chce, żebyś zeskanował kod, zamiast przepisywać numer z wyroku.",
         "The judgment states the account number for the costs. An hour later a PDF arrives. It has the letterhead of a firm you have dealt with for years, but the sender is a Gmail address, not their domain. The PDF has a square code to scan with a phone, labeled “new account number”. Chropot wants you to scan the code instead of retyping the number from the judgment."),
        ("Na który numer rachunku idą koszty?", "Which account number receives the costs?"),
        [
            ("Night08a", "Wyrok leży otwarty. Obok PDF z kodem do zeskanowania telefonem.",
             "The judgment lies open. Beside it, a PDF with a code to scan with a phone.", "caption"),
            ("Night08b", "Chropot: „Znam tę stopkę. Zeskanuj kod, nie przepisuj numeru z wyroku.”",
             "Chropot: “I know that letterhead. Scan the code. Don’t retype the number from the judgment.”", "balloon"),
        ],
        (("Płacę na numer rachunku wpisany w wyroku. Kodu z PDF-a nie skanuję.",
          "I pay the account number written in the judgment. I do not scan the code in the PDF."),
         ("Numer do kosztów jest w wyroku, nie w pliku, który przyszedł godzinę później.",
          "The costs number is in the judgment, not in a file that arrived an hour later.")),
        (("Skanuję kod telefonem i płacę na numer z PDF-a. Stopka się zgadza, a z tą kancelarią korespondujemy od lat.",
          "I scan the code with the phone and pay the number from the PDF. The letterhead matches, and we have corresponded with that firm for years."),
         ("Znana stopka na pliku z Gmaila nie zmienia numeru rachunku z wyroku.",
          "A familiar letterhead on a Gmail file does not change the account number in the judgment.")),
        (("Płacę na numer z PDF-a, ale potem wysyłam potwierdzenie przelewu na adres z pism w sprawie.",
          "I pay the number from the PDF, but then I send the transfer confirmation to the address on the pleadings."),
         ("Potwierdzenie po przelewie nie cofa pieniędzy.",
          "A confirmation after the transfer does not bring the money back.")),
        ("Kodu z PDF-a nie skanujesz i nie płacisz numeru, który przyszedł godzinę później. Przepisujesz numer rachunku z wyroku.",
         "You do not scan the code in the PDF and you do not pay the number that arrived an hour later. You retype the account number from the judgment."),
        ("Koszty płacisz na numer z wyroku. „Nowego numeru” z pliku, który przyszedł później, nie skanujesz telefonem.",
         "You pay costs to the number in the judgment. You do not scan a “new number” from a file that arrived later."),
        [("Kod do zeskanowania w PDF-ie sprzed godziny.", "A code to scan in a PDF from an hour ago."),
         ("Adres Gmail pod stopką znanej kancelarii.", "A Gmail address under a known firm’s letterhead.")],
        ("Wyrok ma numer rachunku. PDF ma inny.", "The judgment has an account number. The PDF has another."),
    ),
    night(
        "09-glos", 9, "phone", "Night09a",
        ("Numer z pisma", "The number on the letter"),
        ("Zwrot zaliczki", "Returning the retainer"),
        ("Lista przelewów o 16:00", "The payment list at 16:00"),
        ("Dzwoni numer, który masz zapisany jako komórkę Chropota. Rozmówca zna kwotę zaliczki co do złotówki i dyktuje nowy numer rachunku klienta, na który trzeba zwrócić zaliczkę. Lista przelewów, którą księgowość wysyła, zamyka się o szesnastej. Numer Chropota, zapisany przy przyjęciu sprawy, leży w piśmie w aktach.",
         "A call comes from the number you have saved as Chropot’s mobile. The caller knows the retainer to the zloty and dictates a new client account number for the return of the retainer. The payment list the accounts team sends closes at four. Chropot’s number, written down when the matter was opened, is in a letter in the file."),
        ("Skąd bierzesz numer rachunku do zwrotu?", "Where do you take the account number for the return?"),
        [
            ("Night09a", "Słuchawka. Głos jest jego, kwota zaliczki też. Numer rachunku słyszysz pierwszy raz.",
             "The receiver. The voice is his, and so is the retainer. You are hearing the account number for the first time.", "caption"),
            ("Night09b", "Iglica: „To jego numer. Jak nie zmienisz rachunku, przelew wyjdzie na stary.”",
             "Iglica: “It is his number. If you don’t change the account, the transfer goes to the old one.”", "balloon"),
        ],
        (("Nie zmieniam listy przelewów. Oddzwaniam na numer Chropota z pisma w aktach, nawet jeśli zwrot wyjdzie jutro.",
          "I do not change the payment list. I call back Chropot’s number from the letter in the file, even if the return goes tomorrow."),
         ("Numer na wyświetlaczu i znajomość kwoty to nadal jedna rozmowa, ta która sama przyszła.",
          "The number on the display and knowledge of the amount are still one call, the one that came to you.")),
        (("Zmieniam numer rachunku na liście. Wyświetlacz to jego komórka, a zaliczkę zna co do złotówki.",
          "I change the account number on the list. The display is his mobile, and he knows the retainer to the zloty."),
         ("Wyświetlacz da się podstawić. Kwotę zaliczki z akt też już ktoś może znać.",
          "A caller display can be faked. Someone else may already know the retainer from the file.")),
        (("Potwierdzam numer rachunku na WhatsAppie, na tym samym telefonie, z którego właśnie odebrałem tę rozmowę.",
          "I confirm the account number on WhatsApp, on the same phone on which I just took this call."),
         ("Druga aplikacja na tym samym telefonie nie jest osobną rozmową z partnerem.",
          "A second app on the same phone is not a separate conversation with the partner.")),
        ("Listy przelewów o szesnastej nie zmieniasz. Nowy numer rachunku bierzesz z oddzwonienia na numer z pisma w aktach, nie z tej rozmowy i nie z WhatsAppa na tym samym telefonie.",
         "You do not change the four o’clock payment list. You take the new account number from a callback to the number in the letter in the file, not from this call and not from WhatsApp on the same phone."),
        ("Numer rachunku do zwrotu bierzesz z oddzwonienia na numer zapisany w aktach przy przyjęciu sprawy. Nie z rozmowy, która sama przyszła.",
         "You take the return account number from a callback to the number recorded in the file when the matter was opened. Not from a call that came to you."),
        [("Nowy numer rachunku podyktowany w rozmowie, która sama przyszła.", "A new account number dictated on a call that came to you."),
         ("Potwierdzenie na WhatsAppie na tym samym telefonie.", "A confirmation on WhatsApp on the same phone.")],
        ("Głos zna kwotę zaliczki. Numer rachunku bierzesz z akt.", "The voice knows the retainer. You take the account number from the file."),
    ),
    night(
        "10-okno", 10, "pdf", "Night10a",
        ("Makra w pozwie", "Macros in the pleading"),
        ("Portal · Word", "Portal · Word"),
        ("Pozew na jutro", "Pleading due tomorrow"),
        ("Pozew ściągnąłeś z portalu sądu, z którego korzystasz na co dzień. Word pokazuje żółty pasek: tekstu nie widać, dopóki nie klikniesz „Włącz treść”. Ten przycisk uruchamia makra, czyli program zaszyty w pliku, nie sam tekst pozwu. W stopce pliku jest numer telefonu podpisany „informatyk sądu”.",
         "You downloaded the pleading from the court portal you use every day. Word shows a yellow bar: the text stays hidden until you click “Enable content”. That button runs macros, a program embedded in the file, not the text of the pleading itself. The file footer has a phone number labeled “court IT”."),
        ("Jak czytasz ten pozew?", "How do you read this pleading?"),
        [
            ("Night10a", "Plik z portalu. Word czeka, aż klikniesz „Włącz treść”.",
             "A file from the portal. Word is waiting for you to click “Enable content”.", "caption"),
            ("Night10b", "Iglica: „To portal. Włącz treść, inaczej nie złożymy pozwu.”",
             "Iglica: “It is the portal. Enable content, or we do not file the pleading.”", "balloon"),
        ],
        (("Nie klikam „Włącz treść”. Zostawiam żółty pasek i proszę przez portal o ten sam pozew w PDF.",
          "I do not click “Enable content”. I leave the yellow bar and ask through the portal for the same pleading as a PDF."),
         ("Portal, z którego ściągasz plik, nie znaczy, że program zaszyty w Wordzie jest z sądu.",
          "The portal you download from does not mean the program embedded in Word is from the court.")),
        (("Klikam „Włącz treść”. Plik przyszedł z portalu, a bez tego Word nie pokazuje pozwu.",
          "I click “Enable content”. The file came from the portal, and without that Word does not show the pleading."),
         ("Kliknięcie „Włącz treść” uruchamia program w pliku, nie tylko pokazuje tekst.",
          "Clicking “Enable content” runs the program in the file, it does not only show the text.")),
        (("Dzwonię na numer ze stopki pliku i pytam, czy ten przycisk jest ich.",
          "I call the number in the file footer and ask whether that button is theirs."),
         ("Numer wydrukowany w pliku nie jest telefonem do sądu.",
          "A number printed in the file is not the court’s phone.")),
        ("Nie klikasz „Włącz treść” i nie dzwonisz na numer ze stopki pliku. Tekst bierzesz z PDF-a, o który prosisz przez portal.",
         "You do not click “Enable content” and you do not call the number in the file footer. You take the text from a PDF you request through the portal."),
        ("Plik z portalu czytasz bez klikania „Włącz treść”, albo bierzesz PDF. Telefon wydrukowany w dokumencie nie jest sądem.",
         "You read a file from the portal without clicking “Enable content”, or you take a PDF. A phone number printed in the document is not the court."),
        [("Żółty pasek Worda z przyciskiem „Włącz treść”.", "Word’s yellow bar with an “Enable content” button."),
         ("Numer telefonu wydrukowany w stopce pliku.", "A phone number printed in the file footer.")],
        ("Plik jest z portalu. Przycisk „Włącz treść” nie musi być.", "The file is from the portal. The “Enable content” button does not have to be."),
    ),
    night(
        "11-konta", 11, "hr", "Night11a",
        ("Skrzynka po odejściu", "The mailbox after they leave"),
        ("Odejście", "A departure"),
        ("Zestaw pism na jutro", "The bundle for tomorrow"),
        ("Aplikant, którego szanujesz, odszedł dziś. Jego skrzynka wciąż dostaje pocztę klienta. Zestaw pism na jutrzejszą rozprawę leży w niedokończonym mailu, w kopiach roboczych. Przy każdym logowaniu jego prywatny telefon pyta „Czy zatwierdzić?”. Ten telefon został u niego.",
         "An associate you respect left today. Their mailbox still receives client mail. Tomorrow’s hearing papers sit in an unfinished email, in drafts. On every sign-in their personal phone asks “Approve?”. That phone stayed with them."),
        ("Co robisz z tym logowaniem przed nocą?", "What do you do with this login before night?"),
        [
            ("Night11a", "Irena: „Zostaw skrzynkę. Jutro bez tych pism nie wchodzimy.”",
             "Irena: “Leave the mailbox. Without those papers we do not walk in tomorrow.”", "balloon"),
            ("Night11b", "Chropot: „To porządny człowiek. Ciągłość sprawy jest ważniejsza.”",
             "Chropot: “They are a decent person. Continuity of the matter matters more.”", "balloon"),
        ],
        (("Wyłączam logowanie dziś. Skrzynkę kieruję do partnera sprawy. Telefon odbieramy albo czyścimy, zanim wyjdą pisma.",
          "I disable sign-in today. I forward the mailbox to the matter partner. We take the phone back or wipe it before the papers go out."),
         ("Zaufanie do człowieka nie zostawia jego telefonu jako klucza do skrzynki.",
          "Trust in the person does not leave their phone as the key to the mailbox.")),
        (("Zostawiam logowanie. Pisma są w niedokończonym mailu, a człowiek jest nasz.",
          "I leave the login. The papers are in the unfinished email, and the person is ours."),
         ("Odejście zamyka logowanie tego samego dnia, także przy dobrym człowieku.",
          "A departure closes the login the same day, including for a good person.")),
        (("Zmieniam hasło, ale zostawiam jego telefon przy pytaniu „Czy zatwierdzić?”. Niech w nocy wyśle te pisma.",
          "I change the password, but I leave their phone on the “Approve?” question. Let them send the papers tonight."),
         ("Nowe hasło bez odebrania telefonu nadal jest ich logowaniem.",
          "A new password without the phone is still their login.")),
        ("Logowanie wyłączasz dziś, zanim wyjdą pisma. Niedokończony mail przejmuje partner sprawy. Telefon z pytaniem „Czy zatwierdzić?” wraca albo jest czyszczony.",
         "You disable sign-in today, before the papers go out. The matter partner takes the unfinished email. The phone with the “Approve?” question comes back or is wiped."),
        ("Odejście zamyka logowanie tego samego dnia, także gdy człowiek jest porządny i pisma leżą w niedokończonym mailu. Nowe hasło bez odebrania telefonu nadal jest jego kluczem.",
         "A departure closes the login the same day, even when the person is decent and the papers sit in an unfinished email. A new password without the phone is still their key."),
        [("Logowanie zostawione, „bo pisma są w skrzynce”.", "A login left, “because the papers are in the mailbox”."),
         ("Nowe hasło przy telefonie, który został u aplikanta.", "A new password while the phone stayed with the associate.")],
        ("Człowiek odszedł. Telefon do zatwierdzania logowania też.", "The person left. The phone that approves the login goes too."),
    ),
    night(
        "12-okup", 12, "pdf", "Night12a",
        ("Bitcoin przed rozprawą", "Bitcoin before the hearing"),
        ("Incydent", "Incident"),
        ("Rozprawa jutro o 9:00", "Hearing tomorrow at 9:00"),
        ("Na ekranie laptopa jest żądanie: zapłać w bitcoinach, oddamy pliki, nie mów klientowi ani ubezpieczycielowi. Zestaw pism na jutrzejszą rozprawę jest na tym laptopie. Chropot chce zapłacić albo z rachunku klienta, albo po cichu z konta kancelarii, i napisać notatkę tak, żeby rozprawa się odbyła.",
         "The laptop screen demands: pay in bitcoin, we will return the files, do not tell the client or the insurer. Tomorrow’s hearing papers are on this laptop. Chropot wants to pay either from the client account or quietly from the firm account, and to write a note so the hearing still happens."),
        ("Czy płacisz, i z czyjego rachunku?", "Do you pay, and from whose account?"),
        [
            ("Night12a", "Laptop na biurku. Na całym ekranie żądanie zapłaty w bitcoinach.",
             "The laptop on the desk. A demand to pay in bitcoin fills the screen.", "caption"),
            ("Night12b", "Chropot: „Z konta kancelarii, po cichu. Notatkę napiszemy pod rozprawę.”",
             "Chropot: “From the firm account, quietly. We’ll write the note for the hearing.”", "balloon"),
        ],
        (("Odłączam laptop od sieci. Dzwonię do osoby z listy awaryjnej kancelarii. Klientowi mówię, że nie mamy dostępu do pism, bez domysłów i bez przelewu.",
          "I disconnect the laptop from the network. I call the person on the firm’s emergency list. I tell the client we have no access to the papers, with no speculation and no transfer."),
         ("Okup nie jest kosztem rozprawy. Milczenie wobec klienta i ubezpieczyciela też nie.",
          "The ransom is not a cost of the hearing. Silence toward the client and the insurer is not either.")),
        (("Płacę z rachunku klienta. To ich pisma i ich rozprawa.",
          "I pay from the client account. It is their papers and their hearing."),
         ("Rachunek klienta nie służy do okupu.",
          "The client account is not for a ransom.")),
        (("Płacę z konta kancelarii i piszę notatkę, że to dla zachowania terminu. Nikomu nie mówię.",
          "I pay from the firm account and write a note that it was to preserve the hearing. I tell no one."),
         ("Cicha zapłata i notatka pod termin ukrywają to, co jest na ekranie.",
          "A quiet payment and a note about the deadline conceal what is on the screen.")),
        ("Laptopa odłączasz od sieci, zanim ktokolwiek zrobi przelew. Dzwonisz do osoby z listy awaryjnej. Klient słyszy, że dostępu do pism nie ma. Bitcoin nie idzie ani z konta kancelarii, ani z rachunku klienta.",
         "You disconnect the laptop from the network before anyone makes a transfer. You call the person on the emergency list. The client hears that there is no access to the papers. Bitcoin goes neither from the firm account nor from the client account."),
        ("Laptop odłączasz od sieci i dzwonisz do osoby z listy awaryjnej. Klientowi mówisz, że dostępu nie ma. Nie płacisz i nie ukrywasz tego w notatce.",
         "You disconnect the laptop and call the person on the emergency list. You tell the client there is no access. You do not pay, and you do not hide it in a note."),
        [("Okup z rachunku klienta.", "A ransom from the client account."),
         ("Cicha zapłata z konta kancelarii i notatka pod rozprawę.", "A quiet payment from the firm account and a note for the hearing.")],
        ("Ekran żąda bitcoinów i milczenia.", "The screen demands bitcoin and silence."),
    ),
]


# Briefing after the decision: how the tactic works — not a retell of the scene.
BRIEFS = {
    "01-kod": (
        "Drugie pytanie „Czy zatwierdzić?” nie należy do twojego logowania. Hasło wpisałeś raz — pierwsze pytanie to ty. Drugie może być czyimś wejściem do portalu (kradzież sesji albo podszywanie się). Zatwierdzając je, otwierasz drzwi obcej osobie, nawet gdy Iglica mówi, że to Chropot z sali.",
        "The second “Approve this sign-in?” is not your login. You typed the password once — the first prompt is you. The second may be someone else’s portal sign-in (session theft or impersonation). Approving it opens the door for a stranger, even if Iglica says it is Chropot in court.",
    ),
    "02-list": (
        "Sąd doręcza przez portal albo własnym kanałem — nie przez PDF, który partner dokleił „dla wygody”. Taki plik może być szkodliwy albo fałszywy, nawet przy zgodnej sygnaturze. Presja terminu ma sprawić, że otworzysz załącznik zamiast wejść pod zapisany adres portalu.",
        "The court serves through the portal or its own channel — not through a PDF a partner attached “for convenience”. That file may be malicious or fake even when the case number matches. Deadline pressure is meant to make you open the attachment instead of opening the portal at the address you saved.",
    ),
    "03-prompt": (
        "Tekst wklejony do asystenta opuszcza pokój: trafia do dostawcy, logów, czasem ludzi po drugiej stronie. Umowa i zdanie IT, że model „się nie uczy”, nie cofają wycieku nazw, kwoty i sygnatury. Wystarczy układ klauzul na zmyślonym przykładzie.",
        "Text pasted into an assistant leaves the room: it goes to the vendor, to logs, sometimes to people on the other side. A contract and IT’s line that the model “does not learn” do not undo a leak of names, figures and case numbers. A clause structure on a made-up example is enough.",
    ),
    "04-haslo": (
        "Link i hasło w jednym mailu dają pełny dostęp każdemu, kto ten mail przechwyci albo odziedziczy w wątku. Osobny kanał (rozmowa, menedżer haseł) rozdziela „gdzie” od „jak wejść”. Stare hasło z poprzedniego maila jest już zużyte — nie chroni rady.",
        "A link and a password in one email give full access to anyone who intercepts that mail or inherits the thread. A separate channel (a call, a password manager) splits “where” from “how to enter”. Last month’s password from an earlier email is already spent — it does not protect the board.",
    ),
    "05-arkusz": (
        "Hasło w chronologii albo na zdjęciu w aktach zostaje u ludzi, którzy nigdy nie logują się do systemu klienta: kontroler, sekretariat, kolejni pełnomocnicy. To nie jest „komplet akt” — to kopia klucza w szufladzie, którą ktoś inny może otworzyć później.",
        "A password in the chronology or in a matter photo stays with people who never sign in to the client’s system: the reviewer, the secretariat, later counsel. That is not a “complete file” — it is a spare key in a drawer someone else can open later.",
    ),
    "06-pomoc": (
        "W awarii atakujący podszywa się pod znanego administratora i wysyła program z nowego numeru. Znajome imię i wspomnienie marca mają wyłączyć ostrożność. Twoje zgłoszenie IT („nic nie instalować”) jest jedyną instrukcją, którą sam otworzyłeś — plik z SMS-a jej nie unieważnia.",
        "In an outage an attacker impersonates a known administrator and sends a program from a new number. A familiar name and a March memory are meant to switch off caution. Your own IT ticket (“install nothing”) is the only instruction you opened — a file from an SMS does not overrule it.",
    ),
    "07-sms": (
        "SMS z sygnaturą i nazwą znanej firmy płatniczej wygląda jak dopłata sądowa, ale tworzy ratę, której nie ma w nakazie. Link i numer z wiadomości należą do oszusta. Porównanie z nakazem i księgą opłat oddziela prawdziwą kwotę od przynęty pod wokandę.",
        "An SMS with a case number and a known payment firm looks like a court top-up, but it invents an instalment that is not in the order. The link and the number in the message belong to the scammer. Comparing with the order and the fee ledger separates the real amount from bait under list pressure.",
    ),
    "08-qr": (
        "To klasyczny BEC na kosztach: znana stopka, ale nadawca spoza domeny kancelarii, i kod QR prowadzący na inny rachunek. Wyrok jest źródłem numeru. Plik sprzed godziny ma sprawić, że skanujesz telefonem zamiast przepisać IBAN z orzeczenia.",
        "This is classic BEC on costs: familiar letterhead, but a sender outside the firm’s domain, and a QR code that leads to another account. The judgment is the source of the number. A file from an hour ago is meant to make you scan with the phone instead of retyping the IBAN from the ruling.",
    ),
    "09-glos": (
        "Numer na wyświetlaczu da się podstawić (spoofing): telefon pokazuje „Chropot”, bo atakujący udaje zapisany numer, nie dlatego, że dzwoni jego komórka. Głos i znajomość zaliczki budują zaufanie; nowy rachunek ma wyjść przed listą o 16:00. Prawdziwy numer partnera leży w piśmie w aktach — oddzwaniasz tam, zamiast ufać rozmowie, która sama przyszła.",
        "A caller display can be faked (spoofing): the phone shows “Chropot” because the attacker mimics the saved number, not because his mobile is calling. Voice and knowledge of the retainer build trust; the new account is meant to go out before the 16:00 list. The partner’s real number is in the letter in the file — you call that back instead of trusting a call that came to you.",
    ),
    "10-okno": (
        "„Włącz treść” uruchamia makra — program w pliku Word, nie sam tekst pozwu. Plik może przyjść z portalu i nadal być złośliwy albo podmieniony. Numer „informatyka sądu” w stopce jest częścią przynęty. Bezpieczny odczyt to PDF bez makr, zamówiony przez portal.",
        "“Enable content” runs macros — a program inside the Word file, not the pleading text itself. A file can come from the portal and still be malicious or swapped. A “court IT” number in the footer is part of the bait. Safe reading is a macro-free PDF requested through the portal.",
    ),
    "11-konta": (
        "Dopóki prywatny telefon byłego aplikanta zatwierdza logowanie, skrzynka klienta jest nadal jego kluczem — także po zmianie hasła. Presja jutrzejszych pism ma odroczyć wyłączenie dostępu. Odejście zamyka konto tego samego dnia; ciągłość sprawy robi się przejęciem skrzynki, nie zostawieniem MFA u kogoś spoza firmy.",
        "As long as a former associate’s personal phone approves sign-in, the client mailbox is still their key — even after a password change. Tomorrow’s papers are meant to delay cutting access. A departure closes the account the same day; continuity is a mailbox hand-over, not leaving MFA with someone outside the firm.",
    ),
    "12-okup": (
        "Ransomware żąda okupu i milczenia, żebyś zapłacił zanim ktoś z listy awaryjnej zobaczy ekran. Płatność z konta klienta albo „po cichu” z kancelarii nie przywraca pewnych plików i ukrywa incydent. Pierwszy ruch to odłączenie od sieci i telefon na listę awaryjną — potem jasna informacja dla klienta, bez bitcoinów.",
        "Ransomware demands payment and silence so you pay before anyone on the emergency list sees the screen. Paying from the client account or “quietly” from the firm does not restore trustworthy files and hides the incident. The first move is disconnecting from the network and calling the emergency list — then a clear notice to the client, with no bitcoin.",
    ),
}

for lesson in lessons:
    pl, en = BRIEFS[lesson["id"]]
    lesson["awareness"]["threat"] = loc(pl, en)

parser = argparse.ArgumentParser()
parser.add_argument("--output", type=Path)
args = parser.parse_args()
out = args.output or (Path(__file__).resolve().parents[1] / "Resources" / "Lessons.json")
out.write_text(json.dumps(lessons, ensure_ascii=False, indent=2), encoding="utf-8")
print("lessons", len(lessons), "bytes", out.stat().st_size)

assert len(lessons) == 12
assert all(len(x["choices"]) == 3 for x in lessons)
assert all(sum(c["verdict"] == "sound" for c in x["choices"]) == 1 for x in lessons)
assert any(x["choices"][0]["id"] != "trap" for x in lessons)
assert all(len(x["beats"]) == 2 for x in lessons)
assert all(x["innerVoice"]["pl"].endswith("?") for x in lessons)
assert all(not x["sourceIds"] for x in lessons)
assert all(x["awareness"]["minimize"]["pl"] != x["awareness"]["practice"]["pl"] for x in lessons)
assert all(x["awareness"]["threat"]["pl"] != x["context"]["pl"] for x in lessons)
assert all(len(x["awareness"]["threat"]["pl"]) >= 120 for x in lessons)
assert all("aplikantk" not in json.dumps(x, ensure_ascii=False).lower() for x in lessons)
assert all(x["storyMode"] is True for x in lessons)
assert all("introVideo" not in x for x in lessons)
for lesson in lessons:
    for beat in lesson["beats"]:
        assert len(beat["caption"]["pl"]) <= 140, (lesson["id"], beat["caption"]["pl"])
print("ok")
