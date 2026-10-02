export const site = {
  name: "Czerwona Teczka",
  domain: "colgante.pl",
  firm: "Kancelaria Colgante i Wspólnicy",
  tagline: "Kancelaria nie istnieje. Zagrożenia są prawdziwe.",
  description:
    "Dwadzieścia cztery noce w dwóch sezonach fikcyjnej kancelarii: decyzje pod presją wokandy, logowań, przelewów i narzędzi AI.",
  author: "Grzegorz Napieraj",
  authorRole: "IT Security",
  authorFirm: "Grzegorz Napieraj IT Security",
  authorLinkedIn: "https://www.linkedin.com/in/napieraj-grzegorz/",
  contactEmail: "kontakt@grzegorznapieraj.pl",
  legalState: "28.09.2026",
  administrator: {
    nip: "8321978268",
    nipDisplay: "832-197-82-68",
    street: "Stare Sady 6/19",
    postalCode: "98-300",
    city: "Wieluń",
  },
  appStore: {
    /** Pusty string = jeszcze niepubliczna; wklej URL App Store przy premierze. */
    url: "",
    label: "Pobierz w App Store",
    status:
      "Gra nie jest jeszcze publicznie dostępna. Zapisz się na newsletter, aby dostać sygnał o premierze.",
  },
} as const;

export const navigation = [
  { href: "/wokanda", label: "Wokanda" },
  { href: "/o-projekcie", label: "Poznaj grę" },
  { href: "/raport", label: "Raport" },
  { href: "/materialy", label: "Materiały" },
  { href: "/newsletter", label: "Czerwona lampka" },
  { href: "/jak-czytac-gre", label: "Jak czytać grę" },
  { href: "/autor", label: "Autor / IT Security" },
] as const;

export const lessonWebCopy: Record<
  string,
  {
    slug: string;
    lead: string;
    topic: string;
    practical: string;
    materialSlug?: string;
  }
> = {
  "01-kod": {
    slug: "drugie-zatwierdzenie",
    lead: "Hasło wpisałeś raz. Na telefonie pojawia się drugie, identyczne pytanie o zatwierdzenie logowania — „bo Chropot w sali nie może wejść”.",
    topic: "MFA i logowanie",
    practical: "Zatwierdzaj pytanie „Czy zatwierdzić?” tylko wtedy, gdy sam przed chwilą wpisałeś hasło. Drugie odrzuć i oddzwoń na numer z książki firmowej.",
    materialSlug: "mfa-tylko-swoje",
  },
  "02-list": {
    slug: "doklejone-pismo",
    lead: "Partner przesyła mail od sądu i dokłada drugi PDF „dla wygody”. Sygnatura się zgadza, portal „działa wolno”.",
    topic: "Poczta i załączniki",
    practical: "Pismo bierz z portalu, do którego sam wchodzisz. Pliku doklejonego do przesłanego maila nie otwieraj jako dokumentu sądu.",
    materialSlug: "pismo-z-portalu",
  },
  "03-prompt": {
    slug: "ugoda-w-asystencie",
    lead: "Firmowy asystent ma umowę i IT mówi, że „się nie uczy”. W schowku leży niejawny projekt ugody z nazwami, kwotą i sygnaturą.",
    topic: "AI i tajemnica",
    practical: "Do asystenta wklejaj układ klauzul bez nazw, kwoty i sygnatury. Umowa z dostawcą nie jest zgodą na wklejenie sprawy.",
    materialSlug: "karta-dopuszczenia-ai",
  },
  "04-haslo": {
    slug: "haslo-przed-rada",
    lead: "Link do pokoju danych już poszedł mailem. Nowe hasło to cztery słowa na kartce. Partner chce wpisać je w tej samej odpowiedzi, pod linkiem.",
    topic: "Hasła i kanały",
    practical: "Link i hasło nie jadą w jednym mailu. Cztery słowa przekaż osobnym kanałem — rozmową, nie odpowiedzią pod linkiem.",
    materialSlug: "haslo-osobnym-kanalem",
  },
  "05-arkusz": {
    slug: "haslo-klienta",
    lead: "Hasło do systemu klienta jest na tablicy w ich sali. Irena chce wpisać je do chronologii „dla kompletności akt” przed kontrolą.",
    topic: "Akta i sekrety",
    practical: "Hasło do systemu klienta nie należy do akt. Trzymaj je w menedżerze haseł dla osób ze sprawy, nie w chronologii.",
    materialSlug: "haslo-osobnym-kanalem",
  },
  "06-pomoc": {
    slug: "program-w-trakcie-awarii",
    lead: "Twoje zgłoszenie IT mówi: nic nie instalować. Znajomy administrator pisze z numeru spoza telefonu i przysyła „ten sam program co w marcu”.",
    topic: "Awaria i instalacje",
    practical: "W awarii trzymaj się zgłoszenia, które sam otworzyłeś. Programu z nowego numeru nie instaluj — także „na próbę”.",
    materialSlug: "program-ze-zgloszenia",
  },
  "07-sms": {
    slug: "druga-oplata",
    lead: "SMS z linkiem do płatności zna sygnaturę i firmę z marca. Dzieli kwotę na dwie raty, choć w nakazie była jedna.",
    topic: "Opłaty i SMS",
    practical: "Kwotę zestaw z nakazem i księgą opłat. Linku i numeru z SMS-a nie używaj do dopłaty.",
    materialSlug: "bec-drugi-kanal",
  },
  "08-qr": {
    slug: "iban-po-wyroku",
    lead: "W wyroku jest numer rachunku. Godzinę później PDF ze znaną stopką, ale z Gmaila, każe skanować kod „nowego IBAN-u”.",
    topic: "BEC i koszty",
    practical: "Koszty płać na numer z wyroku. Kodu z późniejszego PDF-a nie skanuj telefonem.",
    materialSlug: "bec-drugi-kanal",
  },
  "09-glos": {
    slug: "numer-z-pisma",
    lead: "Dzwoni „komórka Chropota”. Głos zna zaliczkę co do złotówki i dyktuje nowy rachunek przed zamknięciem listy o 16:00.",
    topic: "Spoofing i vishing",
    practical: "Numer rachunku do zwrotu bierz z oddzwonienia na numer zapisany w aktach przy przyjęciu sprawy — nie z rozmowy, która sama przyszła.",
    materialSlug: "bec-drugi-kanal",
  },
  "10-okno": {
    slug: "makra-w-pozwie",
    lead: "Pozew z portalu sądu. Word pokazuje żółty pasek „Włącz treść”. W stopce jest telefon „informatyka sądu”.",
    topic: "Makra i dokumenty",
    practical: "Nie klikaj „Włącz treść” i nie dzwoń na numer ze stopki. Tekst bierz z PDF-a zamówionego przez portal.",
    materialSlug: "makra-w-dokumencie",
  },
  "11-konta": {
    slug: "skrzynka-po-odejsciu",
    lead: "Szanowany aplikant odszedł. Skrzynka nadal dostaje pocztę klienta, a pytania „Czy zatwierdzić?” lecą na jego prywatny telefon.",
    topic: "Odejścia i dostęp",
    practical: "Odejście zamyka logowanie tego samego dnia. Telefon z zatwierdzeniem wraca albo jest czyszczony — także przy porządnym człowieku.",
    materialSlug: "mfa-tylko-swoje",
  },
  "12-okup": {
    slug: "bitcoin-przed-rozprawa",
    lead: "Laptop żąda bitcoinów za pliki na jutrzejszą rozprawę. Partner chce zapłacić po cichu i napisać notatkę „pod termin”.",
    topic: "Ransomware",
    practical: "Odłącz laptop od sieci, zadzwoń na listę awaryjną i powiedz klientowi, że dostępu nie ma. Okupu nie płacisz z żadnego rachunku.",
    materialSlug: "okup-pierwsza-godzina",
  },
  "13-chmura": {
    slug: "akta-w-tramwaju",
    lead: "Poprawka ma być rano na skrzynce partnera. W kancelarii zostaje prywatny telefon i zdanie: zrób zdjęcie akt i jedź.",
    topic: "Prywatny telefon",
    practical: "Akt nie fotografujesz prywatnym telefonem. Poprawkę robisz na miejscu albo zostawiasz teczkę w kancelarii do rana.",
  },
  "14-cudze": {
    slug: "login-partnera",
    lead: "Portal nie ma jeszcze konta aplikanta. Partner kładzie kartkę z własnym hasłem: wejdź jako ja, tylko ten jeden pozew.",
    topic: "Cudze konto",
    practical: "Do portalu wchodzisz własnym kontem. Cudze hasło wraca do partnera, a pozew czeka na wniosek o dostęp.",
    materialSlug: "cudze-konto",
  },
  "15-polecenie": {
    slug: "jedna-strona-na-rano",
    lead: "Mecenas chce rano jedną stronę streszczenia. Polecenie: wrzuć całe pismo do darmowego czatu, firmowy asystent jest wyłączony.",
    topic: "Polecenie i AI",
    practical: "Streszczenie piszesz na papierze kancelarii. Nazwy, kwota i sygnatura nie idą do czatu, którego firma nie prowadzi.",
  },
  "16-link": {
    slug: "rozprawa-na-komunikatorze",
    lead: "Dwanaście minut przed salą na komunikatorze wpada link „od sądu”, przesłany przez koleżankę z aplikacji.",
    topic: "Fałszywy link",
    practical: "Adres rozprawy bierzesz z portalu albo jedziesz na salę. Linku z komunikatora nie otwierasz.",
  },
  "17-wydruk": {
    slug: "wydruk-u-rodzicow",
    lead: "W kancelarii skończył się toner. Sekretariat mówi: zabierz plik do domu i wydrukuj u rodziców.",
    topic: "Wydruk",
    practical: "Pismo zostaje na komputerze kancelarii. Domowa drukarka i pendrive nie są zapasowym sekretariatem.",
    materialSlug: "wydruk-poza-kancelaria",
  },
  "18-odbior": {
    slug: "pokwitowanie-za-partnera",
    lead: "Kurier czeka z pismem za potwierdzeniem odbioru. Partner z sali każe pokwitować za niego, a koperty nikt nie czytał.",
    topic: "Odbiór",
    practical: "Nie podpisujesz odbioru za kogoś innego. Pismo zostaje u adresata albo w sekretariacie, według zasad kancelarii.",
  },
  "19-mandat": {
    slug: "klient-dzwoni-do-ciebie",
    lead: "Klient dzwoni na numer aplikanta: czy podpisać ugodę i czy pewnego pisma nie może jutro nie być w aktach.",
    topic: "Mandat",
    practical: "Nie radzisz, czy podpisać, i nie ruszasz pisma. Rozmowę zapisujesz dla mecenasa.",
  },
  "20-nosnik": {
    slug: "pendrive-protokolanta",
    lead: "Na korytarzu sądu protokolant podaje pendrive z protokołem i czeka. Partner pisze, żeby zgrać plik i nie robić sceny.",
    topic: "Nośnik",
    practical: "Cudzego nośnika nie wkładasz do laptopa kancelarii. Protokół bierzesz z portalu albo na papierze.",
    materialSlug: "cudzy-nosnik",
  },
  "21-termin": {
    slug: "zaproszenie-do-kalendarza",
    lead: "Zaproszenie „sekretariatu sądu” podaje jutrzejszy termin i prosi o hasło do poczty kancelarii.",
    topic: "Kalendarz",
    practical: "Hasła nie wpisujesz w zaproszenie. Termin sprawdzasz w portalu, a maila zgłaszasz.",
  },
  "22-granica": {
    slug: "akta-drugiej-sprawy",
    lead: "Sekretariat prosi o sygnaturę z akt kolegi. Do tej sprawy aplikant nie jest dopisany, a klient czeka.",
    topic: "Cudze akta",
    practical: "Otwierasz tylko sprawy, do których jesteś dopisany. Sygnaturę podaje ten, kto sprawę prowadzi.",
  },
  "23-nagranie": {
    slug: "notatka-z-rozmowy",
    lead: "Klient dyktuje fakty do pisma. Partner każe nagrać to prywatnym telefonem, bo chmura i tak to złapie.",
    topic: "Nagranie",
    practical: "Głos klienta zapisujesz odręcznie w kancelarii. Nie nagrywasz go na prywatny telefon.",
  },
  "24-ekran": {
    slug: "laptop-na-korytarzu",
    lead: "Przed salą partner zostawia otwarty laptop na ławce. Obcy prosi, żeby sprawdzić wokandę, bo jego telefon padł.",
    topic: "Korytarz",
    practical: "Ekran blokujesz, zanim odejdziesz od ławki. Obcemu nie podajesz otwartego laptopa kancelarii.",
  },
};

export const deskClasses = [
  "Logowanie",
  "Poczta",
  "Hasła",
  "Płatności",
  "AI",
  "Urządzenia",
  "Ludzie",
] as const;

const topicDesk: Record<string, (typeof deskClasses)[number]> = {
  "MFA i logowanie": "Logowanie",
  "Odejścia i dostęp": "Logowanie",
  "Poczta i załączniki": "Poczta",
  "Fałszywy link": "Poczta",
  "Makra i dokumenty": "Poczta",
  "Hasła i kanały": "Hasła",
  "Akta i sekrety": "Hasła",
  "Kalendarz": "Hasła",
  "Opłaty i SMS": "Płatności",
  "BEC i koszty": "Płatności",
  "Spoofing i vishing": "Płatności",
  "Ransomware": "Płatności",
  "AI i tajemnica": "AI",
  "Polecenie i AI": "AI",
  "Awaria i instalacje": "Urządzenia",
  "Prywatny telefon": "Urządzenia",
  "Wydruk": "Urządzenia",
  "Nośnik": "Urządzenia",
  "Korytarz": "Urządzenia",
  "Cudze konto": "Ludzie",
  "Odbiór": "Ludzie",
  "Mandat": "Ludzie",
  "Cudze akta": "Ludzie",
  "Nagranie": "Ludzie",
};

export function deskClass(topic: string): string {
  return topicDesk[topic] ?? "Ludzie";
}

export type MaterialSection = {
  title: string;
  intro?: string;
  items: string[];
};

export type Material = {
  slug: string;
  number: string;
  title: string;
  eyebrow: string;
  summary: string;
  useWhen: string;
  warning: string;
  sections: MaterialSection[];
};

export const materials: Material[] = [
  {
    slug: "bec-drugi-kanal",
    number: "AKTA 01",
    title: "BEC — drugi kanał",
    eyebrow: "Płatności i zmiana rachunku",
    summary:
      "BEC (Business Email Compromise) to oszustwo na poczcie firmowej: wiadomość wygląda znajomo, a celem jest zmiana rachunku albo pilny przelew. Poniżej — procedura niezależnego potwierdzenia dyspozycji.",
    useWhen:
      "Gdy SMS, PDF, telefon lub mail zmienia rachunek, ratę, osobę kontaktową albo zwykłą ścieżkę akceptacji — zwłaszcza przy typowym scenariuszu BEC.",
    warning:
      "Nie potwierdzaj dyspozycji odpowiedzią na tę samą wiadomość, numerem z SMS-a ani kodem z PDF-a, który przyszedł później.",
    sections: [
      {
        title: "Zatrzymaj",
        items: [
          "Nie wykonuj przelewu pod presją wokandy ani listy o 16:00.",
          "Zachowaj wiadomość, SMS albo PDF wraz z nadawcą i załącznikami.",
          "Nie skanuj „nowego numeru rachunku” i nie otwieraj linku płatności spoza nakazu.",
        ],
      },
      {
        title: "Potwierdź",
        items: [
          "Oddzwoń na numer zapisany wcześniej w aktach lub książce firmowej.",
          "Poproś o potwierdzenie kwoty, odbiorcy i pełnego numeru rachunku.",
          "Zestaw kwotę z nakazem, wyrokiem albo umową — nie z treścią podejrzanej wiadomości.",
        ],
      },
      {
        title: "Udokumentuj i eskaluj",
        items: [
          "Zapisz kto, kiedy i jak potwierdził dyspozycję.",
          "Przekaż podejrzenie do osoby odpowiedzialnej za bezpieczeństwo.",
          "Jeżeli płatność wyszła, natychmiast skontaktuj się z bankiem i uruchom procedurę incydentową.",
        ],
      },
    ],
  },
  {
    slug: "mfa-tylko-swoje",
    number: "AKTA 02",
    title: "MFA — tylko swoje zatwierdzenie",
    eyebrow: "Logowanie i odejścia",
    summary:
      "MFA (Multi-Factor Authentication) to dodatkowe zatwierdzenie logowania — zwykle pytanie na telefonie po haśle. Reguła: zatwierdzasz je wyłącznie po własnym haśle.",
    useWhen:
      "Gdy pojawia się drugie pytanie MFA, prośba o zatwierdzenie „dla partnera” albo skrzynka po odejściu nadal pyta prywatny telefon.",
    warning:
      "Znajomy głos, sala rozpraw i „porządny człowiek” nie czynią cudzego logowania twoim.",
    sections: [
      {
        title: "Zatwierdzaj tylko swoje",
        items: [
          "Zatwierdź pytanie tylko wtedy, gdy sam przed chwilą wpisałeś hasło.",
          "Drugie, identyczne pytanie odrzuć — to może być czyjeś inne logowanie.",
          "Oddzwoń na numer z książki firmowej, nie na numer z rozmowy, która sama przyszła.",
        ],
      },
      {
        title: "Po odejściu",
        items: [
          "Wyłącz logowanie tego samego dnia, także gdy w skrzynce leżą jutrzejsze pisma.",
          "Przekieruj skrzynkę do partnera sprawy.",
          "Odbierz albo wyczyść telefon, który odpowiada na „Czy zatwierdzić?”.",
        ],
      },
      {
        title: "Ślad",
        items: [
          "Zapisz, że drugie pytanie odrzucono i do kogo oddzwoniono.",
          "Nie zostawiaj prywatnego telefonu byłego pracownika jako klucza do poczty klienta.",
        ],
      },
    ],
  },
  {
    slug: "karta-dopuszczenia-ai",
    number: "AKTA 03",
    title: "AI — karta dopuszczenia narzędzia",
    eyebrow: "Governance i tajemnica",
    summary:
      "Pytania, które trzeba zamknąć przed wklejeniem sprawy do asystenta AI (sztucznej inteligencji).",
    useWhen:
      "Przed użyciem firmowego lub publicznego asystenta do pisania pism, ugód albo streszczeń akt.",
    warning:
      "Umowa z dostawcą i zapewnienie IT, że model „się nie uczy”, nie są zgodą na wklejenie nazw, kwot i sygnatur.",
    sections: [
      {
        title: "Dane i cel",
        items: [
          "Jakie kategorie danych i tajemnic mogą trafić do systemu?",
          "Czy wystarczy układ klauzul bez nazw stron, kwoty i sygnatury?",
          "Czy klient i partner sprawy wiedzą, że treść idzie do narzędzia?",
        ],
      },
      {
        title: "Dostawca i przepływ",
        items: [
          "Kto jest administratorem, procesorem i dalszym procesorem?",
          "Gdzie dane są przechowywane, jak długo i do jakich państw trafiają?",
          "Czy treści służą treningowi, kontroli jakości lub wsparciu przez ludzi?",
        ],
      },
      {
        title: "Kontrola i odpowiedzialność",
        items: [
          "Kto zatwierdza przypadki użycia i uprawnienia?",
          "Jak użytkownik weryfikuje wynik przed wysłaniem do klienta lub sądu?",
          "Jak działa logowanie, usuwanie, reakcja na incydent i wyjście z usługi?",
        ],
      },
    ],
  },
  {
    slug: "pismo-z-portalu",
    number: "AKTA 04",
    title: "Pismo z portalu, nie z załącznika",
    eyebrow: "Poczta i doręczenia",
    summary:
      "Dokument sądu bierzesz z portalu, pod adresem zapisanym w kancelarii. Plik doklejony do przesłanego maila nie staje się pismem tylko dlatego, że sygnatura się zgadza.",
    useWhen:
      "Gdy ktoś przesyła mail „od sądu” i dokłada drugi plik dla wygody, a portal „działa wolno”.",
    warning:
      "Znana stopka i zgodna sygnatura nie zastępują wejścia, które sam otwierasz.",
    sections: [
      {
        title: "Zatrzymaj",
        items: [
          "Nie otwieraj doklejonego PDF-a jako pisma sądu.",
          "Nie odpowiadaj na ten mail treścią sprawy.",
        ],
      },
      {
        title: "Weź źródło",
        items: [
          "Wejdź na portal pod adresem zapisanym w kancelarii, nie pod linkiem z maila.",
          "Porównaj sygnaturę i datę z tym, co jest na portalu.",
        ],
      },
      {
        title: "Ślad",
        items: [
          "Zachowaj mail z załącznikiem i przekaż go osobie od bezpieczeństwa, jeśli plik wyglądał na pilny.",
        ],
      },
    ],
  },
  {
    slug: "haslo-osobnym-kanalem",
    number: "AKTA 05",
    title: "Hasło osobnym kanałem",
    eyebrow: "Hasła i akta",
    summary:
      "Link i sekret nie jadą razem. Hasło klienta nie ląduje w chronologii ani na zdjęciu tablicy.",
    useWhen:
      "Gdy ktoś chce wpisać nowe hasło pod linkiem w mailu albo „dla kompletności” włożyć je do akt.",
    warning:
      "Stare hasło, które już poszło pocztą, nie jest sekretem tej rozmowy.",
    sections: [
      {
        title: "Rozdziel",
        items: [
          "Link może iść mailem. Słów hasła w tym mailu nie ma.",
          "Hasło czytasz na osobnej rozmowie albo bierzesz z programu haseł kancelarii.",
        ],
      },
      {
        title: "Nie do akt",
        items: [
          "Hasła klienta nie wpisujesz do chronologii, notatki ani zdjęcia.",
          "Dostęp do menedżera mają osoby ze sprawy, nie cała kancelaria „na wszelki wypadek”.",
        ],
      },
    ],
  },
  {
    slug: "program-ze-zgloszenia",
    number: "AKTA 06",
    title: "Program ze zgłoszenia, nie z wiadomości",
    eyebrow: "Awaria i instalacje",
    summary:
      "W awarii obowiązuje zgłoszenie, które sam otworzyłeś. Program z nowego numeru, nawet „ten sam co w marcu”, nie jest poleceniem IT.",
    useWhen:
      "Gdy w trakcie awarii ktoś przysyła plik do instalacji i powołuje się na znajomego administratora.",
    warning:
      "Instalacja „na próbę” na cudzym laptopie jest tym samym plikiem.",
    sections: [
      {
        title: "Zatrzymaj",
        items: [
          "Nie instaluj programu z SMS-a, komunikatora ani nowego numeru.",
          "Nie podawaj haseł osobie, która sama napisała w trakcie awarii.",
        ],
      },
      {
        title: "Wróć do zgłoszenia",
        items: [
          "Trzymaj się instrukcji z własnego zgłoszenia IT.",
          "Nowy kontakt zgłoś w tym samym zgłoszeniu, zamiast iść na skróty.",
        ],
      },
    ],
  },
  {
    slug: "makra-w-dokumencie",
    number: "AKTA 07",
    title: "Makra zostają wyłączone",
    eyebrow: "Dokumenty",
    summary:
      "„Włącz treść” uruchamia program schowany w pliku, nie sam tekst pisma. Numer ze stopki jest częścią tej samej wiadomości.",
    useWhen:
      "Gdy Word prosi o włączenie treści, a w stopce jest telefon „informatyka” sądu albo kancelarii.",
    warning:
      "Plik może przyjść z portalu i nadal prosić o makra. To nie czyni paska żółtego bezpiecznym.",
    sections: [
      {
        title: "Nie włączaj",
        items: [
          "Nie klikaj „Włącz treść”.",
          "Nie dzwoń na numer ze stopki tego pliku.",
        ],
      },
      {
        title: "Poproś o tekst",
        items: [
          "Tekst bierz z PDF-a bez makr, zamówionego przez portal.",
          "Jeśli plik jest potrzebny, oddajesz go IT, zamiast otwierać go „tylko do odczytu” z włączoną treścią.",
        ],
      },
    ],
  },
  {
    slug: "okup-pierwsza-godzina",
    number: "AKTA 08",
    title: "Okup — pierwsza godzina",
    eyebrow: "Ransomware",
    summary:
      "Ekran, który żąda bitcoinów i milczenia, nie dostaje przelewu. Pierwsza godzina to odłączenie, telefon na listę awaryjną i prawda dla klienta.",
    useWhen:
      "Gdy laptop pokazuje żądanie zapłaty za zablokowane pisma, a ktoś chce zapłacić po cichu, żeby zdążyć na rozprawę.",
    warning:
      "Zapłata z konta klienta i cicha zapłata z kancelarii są tą samą zapłatą. Notatka „pod termin” jej nie ukrywa.",
    sections: [
      {
        title: "Odłącz i zadzwoń",
        items: [
          "Odłącz laptop od sieci.",
          "Zadzwoń do osoby z listy awaryjnej kancelarii. Samo odłączenie albo sam telefon to półśrodek.",
        ],
      },
      {
        title: "Nie płać",
        items: [
          "Nie rób przelewu z rachunku klienta ani z konta kancelarii.",
          "Nie obiecuj klientowi, że pisma są, skoro dostępu nie ma.",
        ],
      },
      {
        title: "Powiedz wprost",
        items: [
          "Klient słyszy, że dostępu do pism nie ma. Bez domysłów i bez bitcoinów.",
        ],
      },
    ],
  },
  {
    slug: "cudze-konto",
    number: "AKTA 09",
    title: "Własne konto, nie cudze hasło",
    eyebrow: "Dostęp",
    summary:
      "Do portalu wchodzisz kontem, które jest twoje. Cudze hasło zostawia w systemie cudze nazwisko pod twoim ruchem.",
    useWhen:
      "Gdy ktoś kładzie kartkę z własnym hasłem, „tylko ten jeden raz”, bo twojego konta jeszcze nie ma.",
    warning:
      "Szkic na cudzym koncie jest tym samym wejściem. Dopisek, że to było polecenie, nie cofa śladu.",
    sections: [
      {
        title: "Nie wchodź",
        items: [
          "Nie wpisuj hasła partnera ani kolegi.",
          "Nie zostawiaj szkicu na cudzym koncie „na rano”.",
        ],
      },
      {
        title: "Poproś o własne",
        items: [
          "Wniosek o własne konto idzie tego samego dnia.",
          "Pismo czeka. Termin nie tworzy ci konta.",
        ],
      },
    ],
  },
  {
    slug: "wydruk-poza-kancelaria",
    number: "AKTA 10",
    title: "Wydruk zostaje w kancelarii",
    eyebrow: "Wynoszenie akt",
    summary:
      "Brak tonera nie przenosi pisma do domu. Domowa drukarka i pendrive nie są zapasowym sekretariatem.",
    useWhen:
      "Gdy ktoś każe zabrać plik do rodziców, na uczelnię albo „na chwilę” na własny nośnik.",
    warning:
      "Plik na pendrive „na potem” jest tym samym wyniesieniem, co wydruk poza kancelarią.",
    sections: [
      {
        title: "Zostaw",
        items: [
          "Pismo zostaje na komputerze kancelarii.",
          "Nie kopiujesz go na prywatny nośnik, żeby wydrukować później.",
        ],
      },
      {
        title: "Druk w miejscu",
        items: [
          "Czekasz na toner albo drukujesz na urządzeniu kancelarii.",
          "Jeśli termin goni, mówisz o braku wydruku, zamiast wynosić akta.",
        ],
      },
    ],
  },
  {
    slug: "cudzy-nosnik",
    number: "AKTA 11",
    title: "Cudzego nośnika nie wkładasz",
    eyebrow: "Nośniki",
    summary:
      "Pendrive z korytarza sądu nie wchodzi do laptopa kancelarii. Protokół bierzesz z portalu albo na papierze.",
    useWhen:
      "Gdy ktoś podaje nośnik „z protokołem” i czeka, aż go włożysz.",
    warning:
      "Wysłanie tego pliku do siebie z cudzego komputera jest tym samym plikiem.",
    sections: [
      {
        title: "Nie wkładaj",
        items: [
          "Nie podłączasz cudzego USB do komputera kancelarii.",
          "Nie kopiujesz zawartości „tylko żeby sprawdzić”.",
        ],
      },
      {
        title: "Weź inną drogę",
        items: [
          "Protokół bierzesz z portalu albo prosisz o papier.",
          "Nośnik oddajesz. Nie zostawiasz go w kieszeni „na później”.",
        ],
      },
    ],
  },
];

export function materialBySlug(slug?: string) {
  return materials.find((material) => material.slug === slug);
}

export const newsletterSequence = [
  {
    number: "00",
    title: "Potwierdzenie zapisu",
    body: "Krótki mail z linkiem double opt-in. Dopiero po kliknięciu adres trafia na listę. Nadawca: Grzegorz Napieraj, nie Colgante.",
  },
  {
    number: "01",
    title: "Skąd się wzięła Czerwona Teczka",
    body: "Historia projektu, granica fikcji i to, czego gra nie robi: nie jest poradą prawną ani audytem konkretnej kancelarii.",
  },
  {
    number: "02",
    title: "Trzy karty na biurko",
    body: "Na start trzy karty: BEC — drugi kanał, MFA — tylko swoje zatwierdzenie, AI — karta dopuszczenia. Reszta leży w Materiałach.",
  },
  {
    number: "03",
    title: "Rozmowa, jeśli chcesz",
    body: "Jawne zaproszenie do kontaktu o warsztacie lub przeglądzie bezpieczeństwa. Brak presji i brak treści udającej kancelarię.",
  },
] as const;
