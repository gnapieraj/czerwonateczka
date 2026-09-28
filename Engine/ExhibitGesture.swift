import Foundation

/// Named habit on the desk. The player sees these, not the old campaign meters.
struct DocketHabit: Identifiable, Equatable {
    var id: String { lessonId }
    let lessonId: String
    let name: Loc

    static let all: [DocketHabit] = [
        DocketHabit(lessonId: "01-kod", name: Loc(pl: "Logowanie", en: "Sign-in")),
        DocketHabit(lessonId: "02-list", name: Loc(pl: "Pismo", en: "Filing")),
        DocketHabit(lessonId: "03-prompt", name: Loc(pl: "Asystent", en: "Assistant")),
        DocketHabit(lessonId: "04-haslo", name: Loc(pl: "Kanał", en: "Channel")),
        DocketHabit(lessonId: "05-arkusz", name: Loc(pl: "Akta", en: "File")),
        DocketHabit(lessonId: "06-pomoc", name: Loc(pl: "Instalacja", en: "Install")),
        DocketHabit(lessonId: "07-sms", name: Loc(pl: "Opłata", en: "Payment")),
        DocketHabit(lessonId: "08-qr", name: Loc(pl: "Rachunek", en: "Account")),
        DocketHabit(lessonId: "09-glos", name: Loc(pl: "Głos", en: "Voice")),
        DocketHabit(lessonId: "10-okno", name: Loc(pl: "Dokument", en: "Document")),
        DocketHabit(lessonId: "11-konta", name: Loc(pl: "Dostęp", en: "Access")),
        DocketHabit(lessonId: "12-okup", name: Loc(pl: "Okup", en: "Ransom"))
    ]
}

struct GestureTap: Identifiable, Equatable {
    let id: String
    let title: Loc
    /// Marks the object. Other flags on the same card are cleared.
    let flag: String?
    /// Ends the night at once.
    let choiceId: String?

    init(id: String, title: Loc, flag: String? = nil, choiceId: String? = nil) {
        self.id = id
        self.title = title
        self.flag = flag
        self.choiceId = choiceId
    }
}

struct GestureCard: Identifiable, Equatable {
    let id: String
    let title: Loc
    let note: Loc
    let taps: [GestureTap]
}

struct ExhibitScene: Equatable {
    let lessonId: String
    let aside: Loc
    let cards: [GestureCard]
    let commitTitle: Loc?
}

enum ExhibitGesture {
    static func scene(for lessonId: String) -> ExhibitScene? {
        scenes.first { $0.lessonId == lessonId }
    }

    /// Choice id for „Odłóż”. Immediate taps carry their own id and do not come through here.
    static func resolve(lessonId: String, flags: Set<String>) -> String {
        switch lessonId {
        case "01-kod":
            if flags.contains("first-yes"), flags.contains("second-no"), flags.contains("called") {
                return "trap"
            }
            return "decoy-b"
        case "02-list":
            if flags.contains("portal"), !flags.contains("replied") {
                return "trap"
            }
            return "decoy-b"
        case "04-haslo":
            if flags.contains("aloud"), flags.contains("link-only") {
                return "trap"
            }
            return "decoy-b"
        case "07-sms":
            return flags.contains("order") ? "trap" : "decoy-b"
        case "12-okup":
            if flags.contains("unplug"), flags.contains("list") {
                return "trap"
            }
            return "decoy-b"
        default:
            return "decoy-b"
        }
    }

    private static let scenes: [ExhibitScene] = [
        ExhibitScene(
            lessonId: "01-kod",
            aside: Loc(
                pl: "Iglica: drugie pytanie to Chropot z sali. Bez niego spadamy z wokandy.",
                en: "Iglica: the second question is Chropot in court. Without it we fall off the list."
            ),
            cards: [
                GestureCard(
                    id: "first",
                    title: Loc(pl: "Pytanie sprzed chwili", en: "Question from a moment ago"),
                    note: Loc(
                        pl: "Czy zatwierdzić logowanie? Hasło wpisane przed chwilą.",
                        en: "Approve this sign-in? Password typed a moment ago."
                    ),
                    taps: [
                        GestureTap(id: "yes", title: Loc(pl: "Zatwierdź", en: "Approve"), flag: "first-yes"),
                        GestureTap(id: "no", title: Loc(pl: "Odrzuć", en: "Reject"), flag: "first-no")
                    ]
                ),
                GestureCard(
                    id: "second",
                    title: Loc(pl: "Minutę później", en: "A minute later"),
                    note: Loc(pl: "Czy zatwierdzić logowanie?", en: "Approve this sign-in?"),
                    taps: [
                        GestureTap(id: "yes", title: Loc(pl: "Zatwierdź", en: "Approve"), choiceId: "decoy-a"),
                        GestureTap(id: "no", title: Loc(pl: "Odrzuć", en: "Reject"), flag: "second-no")
                    ]
                ),
                GestureCard(
                    id: "book",
                    title: Loc(pl: "Telefon do partnera", en: "Call the partner"),
                    note: Loc(
                        pl: "Numer Chropota z książki telefonicznej kancelarii. Nie numer, który podaje Iglica.",
                        en: "Chropot’s number from the firm phone book. Not a number Iglica gives you."
                    ),
                    taps: [
                        GestureTap(
                            id: "call",
                            title: Loc(pl: "Zadzwoń do Chropota", en: "Call Chropot"),
                            flag: "called"
                        )
                    ]
                )
            ],
            commitTitle: Loc(pl: "Odłóż telefon", en: "Put the phone down")
        ),
        ExhibitScene(
            lessonId: "02-list",
            aside: Loc(
                pl: "Chropot: otwórz oba. Sygnatura się zgadza, portal działa wolno.",
                en: "Chropot: open both. The case number matches, the portal is slow."
            ),
            cards: [
                GestureCard(
                    id: "court",
                    title: Loc(pl: "Pismo sądu", en: "Court filing"),
                    note: Loc(pl: "PDF z przesłanego maila", en: "PDF from the forwarded mail"),
                    taps: [
                        GestureTap(id: "open", title: Loc(pl: "Otwórz", en: "Open"), flag: "court-file")
                    ]
                ),
                GestureCard(
                    id: "extra",
                    title: Loc(pl: "Uzupełnienie opłaty", en: "Fee supplement"),
                    note: Loc(pl: "PDF doklejony przez Chropota", en: "PDF Chropot attached"),
                    taps: [
                        GestureTap(id: "open", title: Loc(pl: "Otwórz", en: "Open"), choiceId: "decoy-a")
                    ]
                ),
                GestureCard(
                    id: "portal",
                    title: Loc(pl: "Portal sądu", en: "Court portal"),
                    note: Loc(pl: "Adres zapisany w kancelarii", en: "Address saved at the firm"),
                    taps: [
                        GestureTap(id: "enter", title: Loc(pl: "Wejdź", en: "Enter"), flag: "portal")
                    ]
                ),
                GestureCard(
                    id: "reply",
                    title: Loc(pl: "Odpowiedź", en: "Reply"),
                    note: Loc(pl: "Na ten mail", en: "To this mail"),
                    taps: [
                        GestureTap(id: "send", title: Loc(pl: "Odpisz", en: "Reply"), flag: "replied")
                    ]
                )
            ],
            commitTitle: Loc(pl: "Odłóż", en: "Set it down")
        ),
        ExhibitScene(
            lessonId: "03-prompt",
            aside: Loc(
                pl: "IT mówi, że program się nie uczy.",
                en: "IT says the program does not learn."
            ),
            cards: [
                GestureCard(
                    id: "draft",
                    title: Loc(pl: "Projekt ugody", en: "Settlement draft"),
                    note: Loc(
                        pl: "Nazwy stron, kwota, sygnatura, klauzule.",
                        en: "Party names, sum, case number, clauses."
                    ),
                    taps: [
                        GestureTap(id: "all", title: Loc(pl: "Wklej projekt", en: "Paste the draft"), choiceId: "decoy-a"),
                        GestureTap(id: "cut", title: Loc(pl: "Wytnij nazwy", en: "Cut the names"), choiceId: "decoy-b"),
                        GestureTap(id: "clauses", title: Loc(pl: "Tylko klauzule", en: "Clauses only"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "04-haslo",
            aside: Loc(
                pl: "W mailu jest link. Cztery słowa hasła leżą obok.",
                en: "The mail has a link. The four password words sit beside it."
            ),
            cards: [
                GestureCard(
                    id: "mail",
                    title: Loc(pl: "Mail z linkiem", en: "Mail with the link"),
                    note: Loc(pl: "Rada nie czeka.", en: "The board will not wait."),
                    taps: [
                        GestureTap(id: "type", title: Loc(pl: "Wpisz cztery słowa", en: "Type the four words"), choiceId: "decoy-a"),
                        GestureTap(id: "old", title: Loc(pl: "Zostaw zeszłomiesięczne", en: "Keep last month’s"), choiceId: "decoy-b")
                    ]
                ),
                GestureCard(
                    id: "apart",
                    title: Loc(pl: "Osobno", en: "Apart"),
                    note: Loc(pl: "Telefon i drugi mail.", en: "The phone, and a second mail."),
                    taps: [
                        GestureTap(id: "aloud", title: Loc(pl: "Czytaj na głos", en: "Read it aloud"), flag: "aloud"),
                        GestureTap(id: "link", title: Loc(pl: "Mail bez słów", en: "Mail without the words"), flag: "link-only")
                    ]
                )
            ],
            commitTitle: Loc(pl: "Odłóż", en: "Set it down")
        ),
        ExhibitScene(
            lessonId: "05-arkusz",
            aside: Loc(
                pl: "Hasło klienta zostało na tablicy.",
                en: "The client’s password is still on the whiteboard."
            ),
            cards: [
                GestureCard(
                    id: "where",
                    title: Loc(pl: "Na noc", en: "Overnight"),
                    note: Loc(pl: "Kontroler jest jutro.", en: "The auditor is tomorrow."),
                    taps: [
                        GestureTap(id: "chrono", title: Loc(pl: "Chronologia akt", en: "Into the chronology"), choiceId: "decoy-a"),
                        GestureTap(id: "photo", title: Loc(pl: "Zdjęcie tablicy", en: "Photo of the board"), choiceId: "decoy-b"),
                        GestureTap(id: "vault", title: Loc(pl: "Program haseł", en: "Password program"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "06-pomoc",
            aside: Loc(
                pl: "Wiadomość: program naprawi pocztę. Zgłoszenie do IT jest otwarte.",
                en: "A message: this program will fix the mail. The IT ticket is open."
            ),
            cards: [
                GestureCard(
                    id: "install",
                    title: Loc(pl: "Program z wiadomości", en: "Program from the message"),
                    note: Loc(pl: "Logo się zgadza.", en: "The logo matches."),
                    taps: [
                        GestureTap(id: "mine", title: Loc(pl: "Zainstaluj", en: "Install"), choiceId: "decoy-a"),
                        GestureTap(id: "filip", title: Loc(pl: "Laptop Iglicy", en: "Iglica’s laptop"), choiceId: "decoy-b"),
                        GestureTap(id: "ticket", title: Loc(pl: "Zostaw zgłoszenie", en: "Stay with the ticket"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "07-sms",
            aside: Loc(
                pl: "SMS: druga rata. Firma ta z marca, wokanda jest dziś.",
                en: "SMS: a second instalment. The firm from March, the list is today."
            ),
            cards: [
                GestureCard(
                    id: "sms",
                    title: Loc(pl: "SMS", en: "SMS"),
                    note: Loc(pl: "Link i numer telefonu.", en: "A link and a phone number."),
                    taps: [
                        GestureTap(id: "pay", title: Loc(pl: "Link z SMS", en: "Link from the SMS"), choiceId: "decoy-a"),
                        GestureTap(id: "call", title: Loc(pl: "Numer z SMS", en: "Number from the SMS"), choiceId: "decoy-b")
                    ]
                ),
                GestureCard(
                    id: "order",
                    title: Loc(pl: "Akta", en: "The file"),
                    note: Loc(pl: "Nakaz i księga opłat.", en: "The order and the fee book."),
                    taps: [
                        GestureTap(id: "open", title: Loc(pl: "Otwórz nakaz", en: "Open the order"), flag: "order")
                    ]
                )
            ],
            commitTitle: Loc(pl: "Odłóż", en: "Set it down")
        ),
        ExhibitScene(
            lessonId: "08-qr",
            aside: Loc(
                pl: "W PDF-ie jest kod. W wyroku jest numer rachunku.",
                en: "The PDF has a code. The judgment has an account number."
            ),
            cards: [
                GestureCard(
                    id: "pay",
                    title: Loc(pl: "Koszty", en: "Costs"),
                    note: Loc(pl: "Stopka korespondencji się zgadza.", en: "The letterhead matches."),
                    taps: [
                        GestureTap(id: "pdf", title: Loc(pl: "Numer z PDF", en: "Number from the PDF"), choiceId: "decoy-a"),
                        GestureTap(id: "then", title: Loc(pl: "PDF i potwierdzenie", en: "PDF, then a receipt"), choiceId: "decoy-b"),
                        GestureTap(id: "judgment", title: Loc(pl: "Numer z wyroku", en: "Number from the judgment"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "09-glos",
            aside: Loc(
                pl: "Na wyświetlaczu komórka Chropota. Zaliczkę zna co do złotówki.",
                en: "The screen shows Chropot’s mobile. He knows the advance to the złoty."
            ),
            cards: [
                GestureCard(
                    id: "call",
                    title: Loc(pl: "Rozmowa", en: "The call"),
                    note: Loc(pl: "Prosi o zmianę numeru rachunku.", en: "He asks to change the account number."),
                    taps: [
                        GestureTap(id: "list", title: Loc(pl: "Zmień listę", en: "Change the list"), choiceId: "decoy-a"),
                        GestureTap(id: "wa", title: Loc(pl: "WhatsApp", en: "WhatsApp"), choiceId: "decoy-b"),
                        GestureTap(id: "file", title: Loc(pl: "Numer z akt", en: "Number from the file"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "10-okno",
            aside: Loc(
                pl: "Word pokazuje żółty pasek.",
                en: "Word shows a yellow bar."
            ),
            cards: [
                GestureCard(
                    id: "doc",
                    title: Loc(pl: "Pozew", en: "The pleading"),
                    note: Loc(pl: "Przycisk „Włącz treść”.", en: "A button: “Enable content”."),
                    taps: [
                        GestureTap(id: "on", title: Loc(pl: "Włącz treść", en: "Enable content"), choiceId: "decoy-a"),
                        GestureTap(id: "footer", title: Loc(pl: "Numer ze stopki", en: "Number in the footer"), choiceId: "decoy-b"),
                        GestureTap(id: "pdf", title: Loc(pl: "PDF z portalu", en: "PDF from the portal"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "11-konta",
            aside: Loc(
                pl: "Pisma siedzą w niedokończonym mailu. Człowiek wychodzi dziś.",
                en: "The drafts sit in an unfinished mail. The person leaves today."
            ),
            cards: [
                GestureCard(
                    id: "box",
                    title: Loc(pl: "Skrzynka", en: "The mailbox"),
                    note: Loc(pl: "Logowanie jeszcze działa.", en: "The sign-in still works."),
                    taps: [
                        GestureTap(id: "keep", title: Loc(pl: "Zostaw logowanie", en: "Leave the sign-in"), choiceId: "decoy-a"),
                        GestureTap(id: "half", title: Loc(pl: "Nowe hasło, stary telefon", en: "New password, old phone"), choiceId: "decoy-b"),
                        GestureTap(id: "off", title: Loc(pl: "Wyłącz dziś", en: "Switch it off today"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "12-okup",
            aside: Loc(
                pl: "Ekran chce bitcoin przed rozprawą.",
                en: "The screen wants bitcoin before the hearing."
            ),
            cards: [
                GestureCard(
                    id: "pay",
                    title: Loc(pl: "Przelew", en: "The transfer"),
                    note: Loc(pl: "Pisma są zablokowane.", en: "The papers are locked."),
                    taps: [
                        GestureTap(id: "client", title: Loc(pl: "Rachunek klienta", en: "The client’s account"), choiceId: "decoy-a"),
                        GestureTap(id: "firm", title: Loc(pl: "Rachunek kancelarii", en: "The firm’s account"), choiceId: "decoy-b")
                    ]
                ),
                GestureCard(
                    id: "cut",
                    title: Loc(pl: "Laptop", en: "The laptop"),
                    note: Loc(pl: "Lista awaryjna leży w sejfie procedur.", en: "The emergency list is in the procedure safe."),
                    taps: [
                        GestureTap(id: "unplug", title: Loc(pl: "Odłącz", en: "Unplug"), flag: "unplug"),
                        GestureTap(id: "list", title: Loc(pl: "Lista awaryjna", en: "Emergency list"), flag: "list")
                    ]
                )
            ],
            commitTitle: Loc(pl: "Odłóż", en: "Set it down")
        )
    ]
}
