export const site = {
  name: "Czerwona Teczka",
  domain: "colgante.pl",
  firm: "Kancelaria Colgante i Wspólnicy",
  tagline: "Kancelaria nie istnieje. Zagrożenia są prawdziwe.",
  description:
    "Dwanaście nocy w fikcyjnej kancelarii: decyzje pod presją wokandy, logowań, przelewów i narzędzi AI.",
  author: "Grzegorz Napieraj",
  authorRole: "IT Security",
  authorFirm: "Grzegorz Napieraj IT Security",
  authorLinkedIn: "https://www.linkedin.com/in/napieraj-grzegorz/",
  contactEmail: "kontakt@grzegorznapieraj.pl",
  legalState: "22.09.2026",
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
  },
  "05-arkusz": {
    slug: "haslo-klienta",
    lead: "Hasło do systemu klienta jest na tablicy w ich sali. Irena chce wpisać je do chronologii „dla kompletności akt” przed kontrolą.",
    topic: "Akta i sekrety",
    practical: "Hasło do systemu klienta nie należy do akt. Trzymaj je w menedżerze haseł dla osób ze sprawy, nie w chronologii.",
  },
  "06-pomoc": {
    slug: "program-w-trakcie-awarii",
    lead: "Twoje zgłoszenie IT mówi: nic nie instalować. Znajomy administrator pisze z numeru spoza telefonu i przysyła „ten sam program co w marcu”.",
    topic: "Awaria i instalacje",
    practical: "W awarii trzymaj się zgłoszenia, które sam otworzyłeś. Programu z nowego numeru nie instaluj — także „na próbę”.",
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
    topic: "Deepfake i przelewy",
    practical: "Numer rachunku do zwrotu bierz z oddzwonienia na numer zapisany w aktach przy przyjęciu sprawy — nie z rozmowy, która sama przyszła.",
    materialSlug: "bec-drugi-kanal",
  },
  "10-okno": {
    slug: "makra-w-pozwie",
    lead: "Pozew z portalu sądu. Word pokazuje żółty pasek „Włącz treść”. W stopce jest telefon „informatyka sądu”.",
    topic: "Makra i dokumenty",
    practical: "Nie klikaj „Włącz treść” i nie dzwoń na numer ze stopki. Tekst bierz z PDF-a zamówionego przez portal.",
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
  },
};

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
    body: "Linki do materiałów startowych: BEC — drugi kanał, MFA — tylko swoje zatwierdzenie, AI — karta dopuszczenia narzędzia.",
  },
  {
    number: "03",
    title: "Rozmowa, jeśli chcesz",
    body: "Jawne zaproszenie do kontaktu o warsztacie lub przeglądzie bezpieczeństwa. Brak presji i brak treści udającej kancelarię.",
  },
] as const;
