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
        DocketHabit(lessonId: "12-okup", name: Loc(pl: "Okup", en: "Ransom")),
        DocketHabit(lessonId: "13-chmura", name: Loc(pl: "Chmura", en: "Cloud")),
        DocketHabit(lessonId: "14-cudze", name: Loc(pl: "Cudze", en: "Borrowed")),
        DocketHabit(lessonId: "15-polecenie", name: Loc(pl: "Polecenie", en: "Order")),
        DocketHabit(lessonId: "16-link", name: Loc(pl: "Link", en: "Link")),
        DocketHabit(lessonId: "17-wydruk", name: Loc(pl: "Wydruk", en: "Print")),
        DocketHabit(lessonId: "18-odbior", name: Loc(pl: "Odbiór", en: "Receipt")),
        DocketHabit(lessonId: "19-mandat", name: Loc(pl: "Mandat", en: "Retainer")),
        DocketHabit(lessonId: "20-nosnik", name: Loc(pl: "Nośnik", en: "Drive")),
        DocketHabit(lessonId: "21-termin", name: Loc(pl: "Termin", en: "Date")),
        DocketHabit(lessonId: "22-granica", name: Loc(pl: "Granica", en: "Boundary")),
        DocketHabit(lessonId: "23-nagranie", name: Loc(pl: "Nagranie", en: "Recording")),
        DocketHabit(lessonId: "24-ekran", name: Loc(pl: "Ekran", en: "Screen"))
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
                    id: "aloud",
                    title: Loc(pl: "Telefon", en: "The phone"),
                    note: Loc(pl: "Cztery słowa czytasz na osobnej rozmowie.", en: "You read the four words on a separate call."),
                    taps: [
                        GestureTap(id: "aloud", title: Loc(pl: "Czytaj na głos", en: "Read it aloud"), flag: "aloud")
                    ]
                ),
                GestureCard(
                    id: "link",
                    title: Loc(pl: "Mail bez hasła", en: "Mail without the password"),
                    note: Loc(pl: "Link idzie sam. Słów hasła w nim nie ma.", en: "The link goes alone. The password words are not in it."),
                    taps: [
                        GestureTap(id: "link", title: Loc(pl: "Wyślij link", en: "Send the link"), flag: "link-only")
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
                pl: "Ekran chce bitcoin i milczenia. Rozprawa jest jutro.",
                en: "The screen wants bitcoin and silence. The hearing is tomorrow."
            ),
            cards: [
                GestureCard(
                    id: "pay",
                    title: Loc(pl: "Przelew", en: "The transfer"),
                    note: Loc(
                        pl: "Każdy z tych rachunków płaci okup. Noc kończy się od razu.",
                        en: "Either account pays the ransom. The night ends at once."
                    ),
                    taps: [
                        GestureTap(id: "client", title: Loc(pl: "Zapłać z klienta", en: "Pay from the client"), choiceId: "decoy-a"),
                        GestureTap(id: "firm", title: Loc(pl: "Cicho, z kancelarii", en: "Quietly, from the firm"), choiceId: "decoy-a")
                    ]
                ),
                GestureCard(
                    id: "unplug",
                    title: Loc(pl: "Laptop", en: "The laptop"),
                    note: Loc(pl: "Kabel sieci. Zaznacz, jeśli odłączasz.", en: "The network cable. Mark it if you unplug."),
                    taps: [
                        GestureTap(id: "unplug", title: Loc(pl: "Odłącz", en: "Unplug"), flag: "unplug")
                    ]
                ),
                GestureCard(
                    id: "list",
                    title: Loc(pl: "Lista awaryjna", en: "Emergency list"),
                    note: Loc(
                        pl: "Leży w sejfie procedur. Zaznacz, jeśli dzwonisz.",
                        en: "It is in the procedure safe. Mark it if you call."
                    ),
                    taps: [
                        GestureTap(id: "list", title: Loc(pl: "Zadzwoń", en: "Call"), flag: "list")
                    ]
                )
            ],
            commitTitle: Loc(pl: "Odłóż", en: "Set it down")
        ),
        ExhibitScene(
            lessonId: "13-chmura",
            aside: Loc(
                pl: "Akta leżą na biurku. W kieszeni jest prywatny telefon.",
                en: "The file is on the desk. A personal phone is in your pocket."
            ),
            cards: [
                GestureCard(
                    id: "phone",
                    title: Loc(pl: "Telefon", en: "The phone"),
                    note: Loc(pl: "Chropot chce zdjęcie na rano.", en: "Chropot wants a photo by morning."),
                    taps: [
                        GestureTap(id: "send", title: Loc(pl: "Wyślij zdjęcie", en: "Send the photo"), choiceId: "decoy-a"),
                        GestureTap(id: "keep", title: Loc(pl: "Zostaw w telefonie", en: "Leave it on the phone"), choiceId: "decoy-b")
                    ]
                ),
                GestureCard(
                    id: "desk",
                    title: Loc(pl: "Biurko", en: "The desk"),
                    note: Loc(pl: "Papier kancelarii.", en: "The firm’s paper."),
                    taps: [
                        GestureTap(id: "stay", title: Loc(pl: "Zostaw akta", en: "Leave the file"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "14-cudze",
            aside: Loc(
                pl: "Kartka z hasłem partnera. Twojego konta jeszcze nie ma.",
                en: "A slip with the partner’s password. Your account does not exist yet."
            ),
            cards: [
                GestureCard(
                    id: "portal",
                    title: Loc(pl: "Portal", en: "The portal"),
                    note: Loc(pl: "Pozew ma wyjść dziś.", en: "The pleading is due today."),
                    taps: [
                        GestureTap(id: "his", title: Loc(pl: "Hasło Chropota", en: "Chropot’s password"), choiceId: "decoy-a"),
                        GestureTap(id: "draft", title: Loc(pl: "Szkic na jego koncie", en: "A draft on his account"), choiceId: "decoy-b"),
                        GestureTap(id: "wait", title: Loc(pl: "Czekaj na własne", en: "Wait for your own"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "15-polecenie",
            aside: Loc(
                pl: "Mecenas chce jedną stronę. Czat jest poza kancelarią.",
                en: "The lawyer wants one page. The chat is outside the firm."
            ),
            cards: [
                GestureCard(
                    id: "chat",
                    title: Loc(pl: "Czat", en: "The chat"),
                    note: Loc(pl: "Pismo ma nazwy, kwotę i sygnaturę.", en: "The paper has names, a sum and a case number."),
                    taps: [
                        GestureTap(id: "all", title: Loc(pl: "Wklej pismo", en: "Paste the paper"), choiceId: "decoy-a"),
                        GestureTap(id: "cut", title: Loc(pl: "Wytnij nazwiska", en: "Cut the names"), choiceId: "decoy-b"),
                        GestureTap(id: "paper", title: Loc(pl: "Kartka kancelarii", en: "The firm’s paper"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "16-link",
            aside: Loc(
                pl: "Link „od sądu” przyszedł komunikatorem.",
                en: "A link “from the court” arrived in the messenger."
            ),
            cards: [
                GestureCard(
                    id: "link",
                    title: Loc(pl: "Link", en: "The link"),
                    note: Loc(pl: "Sala za dwanaście minut.", en: "The room is in twelve minutes."),
                    taps: [
                        GestureTap(id: "join", title: Loc(pl: "Wejdź", en: "Join"), choiceId: "decoy-a"),
                        GestureTap(id: "again", title: Loc(pl: "Poproś o mail", en: "Ask for an email"), choiceId: "decoy-b")
                    ]
                ),
                GestureCard(
                    id: "portal",
                    title: Loc(pl: "Portal", en: "The portal"),
                    note: Loc(pl: "Adres, który znasz.", en: "The address you know."),
                    taps: [
                        GestureTap(id: "check", title: Loc(pl: "Sprawdź termin", en: "Check the date"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "17-wydruk",
            aside: Loc(
                pl: "Toner pusty. Pismo ma być rano na biurku.",
                en: "The toner is empty. The paper is due on the desk in the morning."
            ),
            cards: [
                GestureCard(
                    id: "print",
                    title: Loc(pl: "Plik", en: "The file"),
                    note: Loc(pl: "Irena wskazuje dom.", en: "Irena points toward home."),
                    taps: [
                        GestureTap(id: "home", title: Loc(pl: "Drukarka u rodziców", en: "The printer at home"), choiceId: "decoy-a"),
                        GestureTap(id: "usb", title: Loc(pl: "Pendrive na potem", en: "A USB stick for later"), choiceId: "decoy-b"),
                        GestureTap(id: "here", title: Loc(pl: "Zostaw w kancelarii", en: "Leave it at the firm"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "18-odbior",
            aside: Loc(
                pl: "Kurier czeka. Koperta jest zamknięta.",
                en: "The courier is waiting. The envelope is sealed."
            ),
            cards: [
                GestureCard(
                    id: "receipt",
                    title: Loc(pl: "Pokwitowanie", en: "The receipt"),
                    note: Loc(pl: "Chropot jest na sali.", en: "Chropot is in the courtroom."),
                    taps: [
                        GestureTap(id: "open", title: Loc(pl: "Podpisz i otwórz", en: "Sign and open"), choiceId: "decoy-a"),
                        GestureTap(id: "sign", title: Loc(pl: "Podpisz, nie otwieraj", en: "Sign, don’t open"), choiceId: "decoy-b"),
                        GestureTap(id: "wait", title: Loc(pl: "Zostaw adresatowi", en: "Leave it for the addressee"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "19-mandat",
            aside: Loc(
                pl: "Klient jest na twoim numerze. Prosi o radę i o pismo.",
                en: "The client is on your number. He wants advice, and a paper."
            ),
            cards: [
                GestureCard(
                    id: "call",
                    title: Loc(pl: "Rozmowa", en: "The call"),
                    note: Loc(pl: "Mecenas oddzwoni wieczorem.", en: "The lawyer calls back this evening."),
                    taps: [
                        GestureTap(id: "advise", title: Loc(pl: "Poradź i wyjmij pismo", en: "Advise, and take the paper"), choiceId: "decoy-a"),
                        GestureTap(id: "hide", title: Loc(pl: "Obiecaj, że nie wypłynie", en: "Promise it will not come up"), choiceId: "decoy-b"),
                        GestureTap(id: "note", title: Loc(pl: "Zapisz dla mecenasa", en: "Note it for the lawyer"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "20-nosnik",
            aside: Loc(
                pl: "Protokolant trzyma pendrive. Laptop jest otwarty.",
                en: "The clerk is holding a USB stick. The laptop is open."
            ),
            cards: [
                GestureCard(
                    id: "stick",
                    title: Loc(pl: "Nośnik", en: "The drive"),
                    note: Loc(pl: "Człowiek czeka.", en: "The man is waiting."),
                    taps: [
                        GestureTap(id: "copy", title: Loc(pl: "Zgraj na laptop", en: "Copy it to the laptop"), choiceId: "decoy-a"),
                        GestureTap(id: "mail", title: Loc(pl: "Wyślij sobie pocztą", en: "Email it to yourself"), choiceId: "decoy-b"),
                        GestureTap(id: "portal", title: Loc(pl: "Poproś o portal", en: "Ask for the portal"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "21-termin",
            aside: Loc(
                pl: "Zaproszenie prosi o hasło skrzynki.",
                en: "The invite asks for the mailbox password."
            ),
            cards: [
                GestureCard(
                    id: "invite",
                    title: Loc(pl: "Zaproszenie", en: "The invite"),
                    note: Loc(pl: "Termin jest jutro.", en: "The date is tomorrow."),
                    taps: [
                        GestureTap(id: "password", title: Loc(pl: "Wpisz hasło", en: "Type the password"), choiceId: "decoy-a"),
                        GestureTap(id: "copy", title: Loc(pl: "Przepisz termin", en: "Copy the date"), choiceId: "decoy-b"),
                        GestureTap(id: "portal", title: Loc(pl: "Sprawdź w portalu", en: "Check the portal"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "22-granica",
            aside: Loc(
                pl: "Irena prosi o akta sprawy, której nie prowadzisz.",
                en: "Irena asks for a file you do not work on."
            ),
            cards: [
                GestureCard(
                    id: "file",
                    title: Loc(pl: "Cudze akta", en: "Someone else’s file"),
                    note: Loc(pl: "Klient czeka na sygnaturę.", en: "The client is waiting for the case number."),
                    taps: [
                        GestureTap(id: "read", title: Loc(pl: "Odczytaj sygnaturę", en: "Read out the number"), choiceId: "decoy-a"),
                        GestureTap(id: "peek", title: Loc(pl: "Tylko zajrzyj", en: "Only have a look"), choiceId: "decoy-b"),
                        GestureTap(id: "note", title: Loc(pl: "Zostaw prowadzącemu", en: "Leave it to counsel"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "23-nagranie",
            aside: Loc(
                pl: "Klient dyktuje. Prywatny telefon leży przy głośniku.",
                en: "The client is dictating. A personal phone lies by the speaker."
            ),
            cards: [
                GestureCard(
                    id: "voice",
                    title: Loc(pl: "Głos", en: "The voice"),
                    note: Loc(pl: "Chropot mówi: nagraj.", en: "Chropot says: record it."),
                    taps: [
                        GestureTap(id: "phone", title: Loc(pl: "Nagraj telefonem", en: "Record on the phone"), choiceId: "decoy-a"),
                        GestureTap(id: "laptop", title: Loc(pl: "Nagraj na laptop", en: "Record on the laptop"), choiceId: "decoy-b"),
                        GestureTap(id: "pen", title: Loc(pl: "Notuj na papierze", en: "Write it on paper"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        ),
        ExhibitScene(
            lessonId: "24-ekran",
            aside: Loc(
                pl: "Laptop jest otwarty na ławce. Obcy prosi o wokandę.",
                en: "The laptop is open on a bench. A stranger asks for the list."
            ),
            cards: [
                GestureCard(
                    id: "bench",
                    title: Loc(pl: "Ławka", en: "The bench"),
                    note: Loc(pl: "Chropot wszedł na salę.", en: "Chropot has gone into the courtroom."),
                    taps: [
                        GestureTap(id: "look", title: Loc(pl: "Sprawdź mu wokandę", en: "Check the list for him"), choiceId: "decoy-a"),
                        GestureTap(id: "lid", title: Loc(pl: "Zamknij bez blokady", en: "Close it, don’t lock"), choiceId: "decoy-b"),
                        GestureTap(id: "lock", title: Loc(pl: "Zablokuj i weź", en: "Lock it and take it"), choiceId: "trap")
                    ]
                )
            ],
            commitTitle: nil
        )
    ]
}
