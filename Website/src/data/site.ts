export const site = {
  name: "Czerwona Teczka",
  domain: "colgante.pl",
  firm: "Kancelaria Colgante i Wspólnicy",
  tagline: "Kancelaria nie istnieje. Zagrożenia są prawdziwe.",
  description:
    "Interaktywna wokanda o cyberbezpieczeństwie, AI i odpowiedzialności w pracy prawnika.",
  author: "Grzegorz Napieraj",
  authorRole: "IT Security",
  authorFirm: "Grzegorz Napieraj IT Security",
  contactEmail: "kontakt@grzegorznapieraj.pl",
  legalState: "10.09.2026",
  administrator: {
    nip: "8321978268",
    nipDisplay: "832-197-82-68",
    street: "Stare Sady 6/19",
    postalCode: "98-300",
    city: "Wieluń",
  },
} as const;

export const navigation = [
  { href: "/wokanda", label: "Wokanda" },
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
  "01-sygnatura": {
    slug: "sygnatura-z-niebytu",
    lead: "Apelacja jest gotowa, termin upływa o północy, a trzy mocne tezy brzmią aż zbyt dobrze.",
    topic: "AI i orzecznictwo",
    practical: "Otwórz pełny tekst, potwierdź sąd, datę, tezę i jej kontekst. Sama sygnatura nie jest weryfikacją.",
    materialSlug: "karta-dopuszczenia-ai",
  },
  "02-szept": {
    slug: "szept-w-chmurze",
    lead: "Poufny fragment SPA trafił do konsumenckiego narzędzia AI. Usunięcie rozmowy nie cofa wysłania danych.",
    topic: "Tajemnica i AI",
    practical: "Przed użyciem narzędzia ustal role, retencję, transfery, dostęp i zabezpieczenia — nie tylko ustawienie treningu.",
    materialSlug: "karta-dopuszczenia-ai",
  },
  "03-glos": {
    slug: "glos-z-lotniska",
    lead: "Znajomy głos żąda pilnego przelewu. Presja czasu i autorytet mają wyłączyć zwykłą procedurę.",
    topic: "Deepfake i płatności",
    practical: "Dyspozycję finansową potwierdź wcześniej uzgodnionym, niezależnym kanałem.",
    materialSlug: "bec-drugi-kanal",
  },
  "04-prostokaty": {
    slug: "czerwone-prostokaty",
    lead: "PDF wygląda na zanonimizowany. Czarne prostokąty mogą jednak tylko zasłaniać nadal obecny tekst.",
    topic: "Dokumenty i dane",
    practical: "Użyj trwałej redakcji, usuń warstwy i metadane, a wynik sprawdź przez kopiowanie, wyszukiwanie i ekstrakcję.",
    materialSlug: "pdf-trwala-redakcja",
  },
  "05-pendrive": {
    slug: "pendrive-w-koszulce",
    lead: "Nośnik przyszedł zwykłą przesyłką. Nie wiadomo, gdzie był i czy zawartość jest bezpieczna.",
    topic: "Nośniki i incydenty",
    practical: "Nie podłączaj nieznanego nośnika do stacji z dostępem do chronionych zasobów; uruchom kontrolowaną procedurę.",
  },
  "06-mail": {
    slug: "mail-prawie-od-mecenasa",
    lead: "Wiadomość wygląda znajomo, ale zmienia numer rachunku i prosi o pominięcie dotychczasowej ścieżki.",
    topic: "BEC i poczta",
    practical: "Zmianę rachunku potwierdź na znanym numerze, nie przez dane kontaktowe z podejrzanej wiadomości.",
    materialSlug: "bec-drugi-kanal",
  },
  "07-copilot": {
    slug: "nasz-copilot-tez-klamie",
    lead: "Firmowe narzędzie brzmi pewnie i działa wewnątrz organizacji. To nadal nie czyni jego odpowiedzi źródłem.",
    topic: "Governance AI",
    practical: "Wewnętrzne AI wymaga tych samych kontroli źródła, odpowiedzialności i zatwierdzania co narzędzie publiczne.",
    materialSlug: "karta-dopuszczenia-ai",
  },
  "08-emocje": {
    slug: "kamera-na-minie",
    lead: "System ma oceniać emocje pracowników z obrazu kamery. Etykieta „wellbeing” nie zmienia funkcji technologii.",
    topic: "AI Act i HR",
    practical: "Najpierw sklasyfikuj rzeczywistą funkcję systemu i sprawdź zakazy; dopiero potem rozważ podstawę i wdrożenie.",
    materialSlug: "karta-dopuszczenia-ai",
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
    summary: "Jednostronicowa procedura niezależnego potwierdzania dyspozycji finansowych.",
    useWhen: "Gdy wiadomość zmienia rachunek, osobę kontaktową, termin lub zwykłą ścieżkę akceptacji.",
    warning: "Nie potwierdzaj dyspozycji odpowiedzią na tę samą wiadomość ani numerem podanym w jej treści.",
    sections: [
      {
        title: "Zatrzymaj",
        items: [
          "Nie wykonuj przelewu pod presją czasu.",
          "Zachowaj wiadomość wraz z nagłówkami i załącznikami.",
          "Nie klikaj nowych linków i nie używaj danych kontaktowych z wiadomości.",
        ],
      },
      {
        title: "Potwierdź",
        items: [
          "Zadzwoń na numer zapisany wcześniej w zatwierdzonym źródle.",
          "Poproś o potwierdzenie kwoty, odbiorcy i pełnego numeru rachunku.",
          "Zastosuj zasadę dwóch osób dla zmiany danych płatniczych.",
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
    slug: "pdf-trwala-redakcja",
    number: "AKTA 02",
    title: "PDF — trwała redakcja",
    eyebrow: "Dokumenty i metadane",
    summary: "Kontrola, czy informacja została usunięta, a nie tylko przykryta czarnym prostokątem.",
    useWhen: "Przed wysłaniem lub publikacją PDF zawierającego dane osobowe, tajemnicę zawodową lub informacje klienta.",
    warning: "Czarny kształt nałożony na tekst nie usuwa tekstu, warstw, komentarzy ani metadanych.",
    sections: [
      {
        title: "Pracuj na kopii",
        items: [
          "Zachowaj nienaruszony oryginał w kontrolowanym miejscu.",
          "Użyj funkcji redakcji, nie narzędzia do rysowania.",
          "Zastosuj redakcję i spłaszcz wynik zgodnie z dokumentacją narzędzia.",
        ],
      },
      {
        title: "Usuń dane ukryte",
        items: [
          "Usuń komentarze, załączniki, formularze i historię zmian.",
          "Oczyść tytuł, autora, słowa kluczowe i pozostałe metadane.",
          "Sprawdź OCR oraz tekst poza widocznym kadrem strony.",
        ],
      },
      {
        title: "Test czterech prób",
        items: [
          "Spróbuj zaznaczyć i skopiować zaczerniony obszar.",
          "Wyszukaj w pliku usunięte nazwisko lub frazę.",
          "Wyeksportuj tekst i sprawdź wynik.",
          "Otwórz dokument w drugim czytniku i wykonaj kontrolę przez inną osobę.",
        ],
      },
    ],
  },
  {
    slug: "karta-dopuszczenia-ai",
    number: "AKTA 03",
    title: "AI — karta dopuszczenia narzędzia",
    eyebrow: "Governance i tajemnica",
    summary: "Pytania, które trzeba zamknąć przed wprowadzeniem narzędzia AI do pracy z aktami.",
    useWhen: "Przed zakupem, pilotażem lub zmianą konfiguracji usługi generatywnej albo analitycznej.",
    warning: "DPA i wyłączenie treningu są elementami oceny, ale same nie przesądzają o dopuszczeniu narzędzia.",
    sections: [
      {
        title: "Dane i cel",
        items: [
          "Jakie kategorie danych i tajemnic mogą trafić do systemu?",
          "Jaki konkretny cel biznesowy uzasadnia przetwarzanie?",
          "Czy można osiągnąć go bez danych rzeczywistych albo po skutecznej anonimizacji?",
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
          "Jak użytkownik weryfikuje źródła, wynik i ograniczenia modelu?",
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
    body: "Linki do materiałów startowych: BEC — drugi kanał, PDF — trwała redakcja, AI — karta dopuszczenia narzędzia.",
  },
  {
    number: "03",
    title: "Rozmowa, jeśli chcesz",
    body: "Jawne zaproszenie do kontaktu o warsztacie lub przeglądzie bezpieczeństwa. Brak presji i brak treści udającej kancelarię.",
  },
] as const;
