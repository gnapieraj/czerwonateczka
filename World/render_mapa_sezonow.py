from matplotlib.backends.backend_pdf import PdfPages
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, Rectangle, Circle
from matplotlib.lines import Line2D
from matplotlib import rcParams
from textwrap import wrap
from pathlib import Path

out = Path('/Users/AI/src/CzerwonaTeczka/World/mapa-sezonow-biznes.pdf')
W, H = 16, 9
bg = '#0b0c10'
card = '#151820'
blue = '#25303a'
line = '#39424c'
cream = '#f1ecdf'
muted = '#b6b8bd'
red = '#a62b33'
red2 = '#d95a5a'
white = '#fffaf0'
pale = '#f1b6ab'
rcParams['font.family'] = 'DejaVu Sans'
rcParams['pdf.fonttype'] = 42


def new_fig():
    fig = plt.figure(figsize=(W, H), facecolor=bg)
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(0, W)
    ax.set_ylim(0, H)
    ax.axis('off')
    ax.set_facecolor(bg)
    # subtle red glow (top-right), same language as page 1
    ax.add_patch(Circle((15.7, 8.45), 2.6, color=red, alpha=.06, zorder=0))
    ax.add_patch(Circle((15.7, 8.45), 1.6, color=red, alpha=.045, zorder=0))
    return fig, ax


def txt(ax, x, y, s, size=10, color=cream, weight='normal', ha='left', va='top',
        family=None, alpha=1, linespacing=1.2):
    ax.text(x, y, s, fontsize=size, color=color, fontweight=weight, ha=ha, va=va,
            alpha=alpha, family=family, linespacing=linespacing, zorder=5)


def box(ax, x, y, w, h, fc=card, ec=line, lw=1, r=0.12, alpha=1):
    p = FancyBboxPatch((x, y), w, h, boxstyle=f'round,pad=0,rounding_size={r}',
                       facecolor=fc, edgecolor=ec, linewidth=lw, alpha=alpha, zorder=2)
    ax.add_patch(p)
    return p


def wraptext(s, n):
    return '\n'.join(wrap(s, n, break_long_words=False, replace_whitespace=False))


def label(ax, x, y, s):
    txt(ax, x, y, s.upper(), 6.7, muted, 'bold', linespacing=1.1)


def season(ax, x, y, w, title, nights, role, focus, benefit, top=True, compact=False):
    """Draw one season block. compact=True: tighter vertical rhythm for 3-up roadmap column."""
    if compact:
        role_dy, focus_dy, ben_dy = 0.17, 0.34, 0.70
        tsz, rsz, fsz, bsz = 8.8, 6.5, 6.85, 6.45
        fw = 52 if w < 4.4 else 60
        bw = 52 if w < 4.4 else 64  # keep long Wartość on one line when possible
        lsp_f, lsp_b = 1.12, 1.12
        # Divider just above this title, in the clear gap under previous block
        div_above = 0.13
    else:
        role_dy, focus_dy, ben_dy = 0.22, 0.52, 1.06
        tsz, rsz, fsz, bsz = 9.2, 6.9, 7.25, 6.9
        fw = 55 if w < 4.4 else 62
        bw = 54 if w < 4.4 else 63
        lsp_f, lsp_b = 1.16, 1.15
        div_above = 0.20
    if not top:
        ax.add_line(Line2D([x, x + w], [y + div_above, y + div_above], color=line, lw=.7, zorder=4))
    txt(ax, x, y, title, tsz, white, 'bold')
    txt(ax, x + w, y, nights.upper(), 7.0 if compact else 7.2, red2, 'bold', ha='right')
    txt(ax, x, y - role_dy, role, rsz, muted)
    txt(ax, x, y - focus_dy, wraptext(focus, fw), fsz, cream, linespacing=lsp_f)
    txt(ax, x, y - ben_dy, wraptext('Wartość: ' + benefit, bw), bsz, pale, linespacing=lsp_b)


def draw_page1(ax):
    # Header
    label(ax, .72, 8.62, 'BUSINESS MAP · COLGANTE')
    txt(ax, .72, 8.31, 'Czerwona Teczka', 25, cream, 'bold')
    txt(ax, 5.05, 8.31, '— mapa sezonów', 25, red2, 'bold')
    txt(ax, .72, 7.77, 'Od codziennej świadomości do kontroli, gotowości i odpowiedzialnego wdrożenia.', 10.8, '#d8d4cb')
    txt(ax, 15.28, 8.58, 'STAN DECYZJI · 02.10.2026 PT\nKANCELARIA COLGANTE I WSPÓLNICY\nfikcja / materiał biznesowy',
        6.5, muted, 'normal', 'right', linespacing=1.45)
    ax.add_line(Line2D([.72, 15.28], [7.5, 7.5], color=line, lw=.8, zorder=3))
    # flow
    fy = 6.63
    nodes = [
        (.72, 3.35, blue, line, 'FREE · App Store', 'S0 Wstęp + S1 Aplikant · 24 noce'),
        (5.0, 4.55, red, '#e7aaa9', 'B2B · COMPLIANCE PACK', 'S2 Kontrola + S3 AML · 24 noce · pierwszy pack komercyjny'),
        (10.35, 4.93, blue, line, 'KOLEJNE PACKI', 'S4 AI · S5 Cyfryzacja · S6 Etyka / ustrój'),
    ]
    for i, (x, w, fc, ec, t, s) in enumerate(nodes):
        box(ax, x, fy, w, .62, fc, ec, .8, .10)
        txt(ax, x + .2, fy + .43, t, 7.6, white, 'bold')
        txt(ax, x + .2, fy + .19, s, 6.3, '#f0ede4' if fc == red else '#c5cbd0')
        if i < 2:
            txt(ax, x + w + .23, fy + .30, '→', 18, red2, 'bold', ha='center', va='center')
    # cards
    x1, x2, x3 = .72, 5.0, 10.35
    y0, h = 1.02, 5.14
    box(ax, x1, y0, 3.75, h, card, line, 1, .13)
    box(ax, x2, y0, 4.55, h, card, red2, 1.5, .13)
    box(ax, x3, y0, 4.93, h, card, line, 1, .13)
    # free card
    label(ax, x1 + .24, 5.85, 'ŚCIEŻKA FREE / APP STORE')
    txt(ax, x1 + .24, 5.55, 'Fundament', 15.2, white, 'bold')
    txt(ax, x1 + .24, 5.18, 'Wejście do marki i nawyku. Bez opłaty —\nzanim pojawia się oferta compliance.', 7.5, '#d9d7d0', linespacing=1.25)
    season(ax, x1 + .24, 4.55, 3.27, 'S0 · Wstęp', '12 nocy', 'Rola: Mecenas',
           'Higiena cyfrowa, phishing, MFA, dane i decyzje pod presją.', 'wspólny język sygnałów ryzyka.')
    season(ax, x1 + .24, 3.12, 3.27, 'S1 · Aplikant', '12 nocy', 'Rola: Aplikant',
           'Nawyki codziennej pracy, przekazywanie spraw, dostępy i odpowiedzialność.',
           'awareness, który widać w zachowaniu zespołu.', False)
    ax.add_patch(Rectangle((x1 + .24, 1.32), .035, .60, facecolor=red2, edgecolor='none', zorder=4))
    txt(ax, x1 + .39, 1.79, 'Nie sprzedajemy ścieżki osobno:', 7.2, white, 'bold')
    txt(ax, x1 + .39, 1.58, 'to wejście do marki i nawyku.', 7.2, cream)
    # commercial
    label(ax, x2 + .24, 5.85, 'PIERWSZA OFERTA KOMERCYJNA / B2B')
    txt(ax, x2 + .24, 5.55, 'Compliance pack', 15.2, white, 'bold')
    txt(ax, x2 + .24, 5.18, 'S2 + S3 · 24 NOCE   |   nowa postać: Audytor', 7.5, '#f1c8bb', 'bold')
    season(ax, x2 + .24, 4.55, 4.05, 'S2 · Kontrola', '12 nocy', 'Rola: Audytor',
           'RODO, tajemnica zawodowa, chmura i AI: co wolno, kto odpowiada i co trzeba umieć wykazać.',
           'zasada, decyzja, właściciel i dowód.')
    season(ax, x2 + .24, 3.12, 4.05, 'S3 · AML', '12 nocy', 'Rola: Audytor',
           'Klient, beneficjent, źródło środków i sygnały ryzyka — praktyka zamiast wykładu.',
           'mniej ślepych punktów i gotowość do sprawdzenia.', False)
    ax.add_patch(Rectangle((x2 + .24, 1.44), 4.07, .36, facecolor=red, edgecolor='none', zorder=4))
    txt(ax, x2 + .43, 1.68, '24 NOCE · JEDEN PACK · PIERWSZY PRODUKT DLA KANCELARII', 6.65, white, 'bold')
    ax.add_patch(Rectangle((x2 + .24, 1.05), .035, .24, facecolor=red2, edgecolor='none', zorder=4))
    txt(ax, x2 + .39, 1.35, 'Nie tylko „wiemy, że ryzyko istnieje”,', 7.0, white, 'bold')
    txt(ax, x2 + .39, 1.18, 'ale „mamy kontrolę nad tym, co robimy dalej”.', 7.0, cream)
    # roadmap — three seasons; compact + even gaps so dividers/Wartość never hit next title/role
    label(ax, x3 + .24, 5.85, 'PÓŹNIEJ / ROADMAPA')
    txt(ax, x3 + .24, 5.55, 'Kolejne pakiety', 15.2, white, 'bold')
    txt(ax, x3 + .24, 5.18, 'Kierunek rozwoju — jeszcze nie sprzedajemy jako packów.', 7.5, '#d9d7d0')
    # gap 1.14: content bottom (~y-0.81) clears next title; divider at y_next+0.13 sits in the gap
    season(ax, x3 + .24, 4.54, 4.45, 'S4 · AI deployer', '12 nocy*', 'Rola: do ustalenia',
           'Wdrażanie AI do pracy: zakres, nadzór, jakość i odpowiedzialność.',
           'z eksperymentu do procesu.', compact=True)
    season(ax, x3 + .24, 3.40, 4.45, 'S5 · Cyfryzacja', '12 nocy*', 'Rola: do ustalenia',
           'e-Doręczenia, NIS2 i odporność procesów.',
           'sprawna kancelaria mimo awarii kanału lub dostawcy.', False, compact=True)
    season(ax, x3 + .24, 2.26, 4.45, 'S6 · Etyka / ustrój', '12 nocy*', 'Rola: do ustalenia',
           'Etyka, konflikt ról, ustrój i granice odpowiedzialności.',
           'decyzje obronne także zawodowo.', False, compact=True)
    txt(ax, x3 + .24, 1.05, '* S4–S6: wariant roboczy 12 nocy — do potwierdzenia przed ofertą.', 6.3, muted)
    # footer
    ax.add_line(Line2D([.72, 15.28], [.92, .92], color=line, lw=.8, zorder=3))
    for x, head, body in [
        (.72, 'AWARENESS', 'Dostrzegam sygnał i zatrzymuję automatyzm.'),
        (5.35, 'CONTROL / COMPLIANCE', 'Mam zasadę, właściciela, dowód i ścieżkę reakcji.'),
        (10.05, 'POZYCJONOWANIE', 'Free buduje świadomość. B2B sprzedaje działającą kontrolę.'),
    ]:
        ax.add_patch(Rectangle((x, .46), .035, .30, facecolor=red, edgecolor='none', zorder=4))
        txt(ax, x + .16, .76, head, 7.0, white, 'bold')
        txt(ax, x + .16, .59, body, 6.7, '#c2c6c9')
    txt(ax, 15.28, .18, 'Czerwona Teczka · Colgante i Wspólnicy są fikcją · nie jest to porada prawna',
        5.8, '#69727a', 'normal', 'right')
    txt(ax, .72, .18, 'strona 1 / 2', 5.8, '#69727a')



def draw_page2(ax):
    # Header — same visual language as page 1
    label(ax, .72, 8.62, 'BUSINESS MAP · COLGANTE · WIZJA')
    txt(ax, .72, 8.31, 'Czerwona Teczka', 25, cream, 'bold')
    txt(ax, 5.05, 8.31, '— dlaczego to działa', 25, red2, 'bold')
    txt(ax, .72, 7.77,
       'Cztery decyzje, które składają się na ofertę dla partnera, HR i compliance: gra, dystrybucja, opłaty, marka.',
       10.8, '#d8d4cb')
    txt(ax, 15.28, 8.58, 'STAN DECYZJI · 02.10.2026 PT\nKANCELARIA COLGANTE I WSPÓLNICY\nfikcja / materiał biznesowy',
        6.5, muted, 'normal', 'right', linespacing=1.45)
    ax.add_line(Line2D([.72, 15.28], [7.5, 7.5], color=line, lw=.8, zorder=3))

    # 2×2 vision cards
    # Layout: left col x=.72 w=7.15; right col x=8.13 w=7.15
    # top row y=4.05 h=3.20; bottom row y=1.05 h=2.80
    lw, rw = 7.15, 7.15
    lx, rx = .72, 8.13
    top_y, top_h = 4.10, 3.15
    bot_y, bot_h = 1.05, 2.85

    # --- 1. Wizja gry (top-left, accent) ---
    box(ax, lx, top_y, lw, top_h, card, red2, 1.5, .13)
    ax.add_patch(Rectangle((lx + .26, top_y + top_h - .55), .04, .30, facecolor=red, edgecolor='none', zorder=4))
    txt(ax, lx + .42, top_y + top_h - .32, '01  ·  WIZJA GRY', 8.2, red2, 'bold')
    txt(ax, lx + .26, top_y + top_h - .72, 'Immersyjny trening noir — nie kolejny e-learning.', 10.2, white, 'bold')

    g_items = [
        ('Sezony = ścieżka.', 'Od awareness (S0–S1) do kontroli i AML (S2–S3).'),
        ('Postacie prowadzą.', 'Mecenas → Aplikant → Audytor — rosnąca odpowiedzialność.'),
        ('12 nocy na sezon.', 'Krótki rytm, który da się domknąć w kalendarzu kancelarii.'),
        ('Mierzalny efekt.', 'TRAFNE ≥ 90% + dyplom PDF z weryfikacją QR — dowód, nie checklista.'),
    ]
    gy = top_y + top_h - 1.10
    for head, body in g_items:
        txt(ax, lx + .26, gy, '▸', 7.4, red2, 'bold')
        txt(ax, lx + .46, gy, head, 7.8, white, 'bold')
        txt(ax, lx + .46, gy - .28, body, 7.35, cream, linespacing=1.2)
        gy -= 0.52

    # --- 2. Wizja dystrybucji (top-right) ---
    box(ax, rx, top_y, rw, top_h, card, line, 1, .13)
    ax.add_patch(Rectangle((rx + .26, top_y + top_h - .55), .04, .30, facecolor=red, edgecolor='none', zorder=4))
    txt(ax, rx + .42, top_y + top_h - .32, '02  ·  WIZJA DYSTRYBUCJI', 8.2, red2, 'bold')
    txt(ax, rx + .26, top_y + top_h - .72, 'Free buduje zaufanie. B2B dostarcza kontrolę.', 10.2, white, 'bold')

    d_items = [
        ('App Store — free.', 'S0 + S1: nawyk, język ryzyka, zerowy próg wejścia.'),
        ('Compliance pack — B2B.', 'S2 + S3 poza sklepem: Custom App / licencja dla kancelarii.'),
        ('Dowody dla HR / IOD.', 'PDF raportu i QR verify — gotowe do teczki szkoleniowej.'),
        ('Skalowanie packami.', 'Kolejne: AI, cyfryzacja, etyka — ta sama marka, nowe kompetencje.'),
    ]
    dy = top_y + top_h - 1.10
    for head, body in d_items:
        txt(ax, rx + .26, dy, '▸', 7.4, red2, 'bold')
        txt(ax, rx + .46, dy, head, 7.8, white, 'bold')
        txt(ax, rx + .46, dy - .28, body, 7.35, cream, linespacing=1.2)
        dy -= 0.52

    # --- 3. Wizja opłat (bottom-left) ---
    box(ax, lx, bot_y, lw, bot_h, card, line, 1, .13)
    ax.add_patch(Rectangle((lx + .26, bot_y + bot_h - .52), .04, .28, facecolor=red, edgecolor='none', zorder=4))
    txt(ax, lx + .42, bot_y + bot_h - .30, '03  ·  WIZJA OPŁAT', 8.2, red2, 'bold')
    txt(ax, lx + .26, bot_y + bot_h - .68, 'Wejście free. Pierwszy produkt płatny = Compliance pack.', 9.4, white, 'bold')

    p_items = [
        ('Model B2B.', 'Licencja organizacji / pack / okres — bez cennika w mapie; rozmowa handlowa.'),
        ('Zakres packa.', '24 noce (S2 Kontrola + S3 AML) jako jeden produkt dla kancelarii.'),
        ('Wartość dla kupującego.', 'Mniej ryzyka reputacyjnego + dowód szkolenia zamiast checklisty.'),
    ]
    py = bot_y + bot_h - 1.02
    for head, body in p_items:
        txt(ax, lx + .26, py, '▸', 7.4, red2, 'bold')
        txt(ax, lx + .46, py, head, 7.7, white, 'bold')
        txt(ax, lx + .46, py - .26, body, 7.25, cream, linespacing=1.2)
        py -= 0.50

    # --- 4. Wizja projektu łącznie (bottom-right, accent) ---
    box(ax, rx, bot_y, rw, bot_h, card, red2, 1.5, .13)
    ax.add_patch(Rectangle((rx + .26, bot_y + bot_h - .52), .04, .28, facecolor=red, edgecolor='none', zorder=4))
    txt(ax, rx + .42, bot_y + bot_h - .30, '04  ·  WIZJA PROJEKTU ŁĄCZNIE', 8.2, red2, 'bold')
    txt(ax, rx + .26, bot_y + bot_h - .68, 'Colgante / Czerwona Teczka — marka szkolenia compliance.', 9.4, white, 'bold')

    t_items = [
        ('Ścieżka marki.', 'Świadomość → kontrola → gotowość regulacyjna.'),
        ('Fikcyjna kancelaria.', 'Realne kompetencje — decyzje, dowody, odpowiedzialność.'),
        ('Zaproszenie.', 'Partner, HR, IOD: to nie kurs o przepisach. To trening, który widać w zachowaniu.'),
    ]
    ty = bot_y + bot_h - 1.02
    for head, body in t_items:
        txt(ax, rx + .26, ty, '▸', 7.4, red2, 'bold')
        txt(ax, rx + .46, ty, head, 7.7, white, 'bold')
        txt(ax, rx + .46, ty - .26, body, 7.25, cream, linespacing=1.2)
        ty -= 0.50

    # footer strip
    ax.add_line(Line2D([.72, 15.28], [.92, .92], color=line, lw=.8, zorder=3))
    ax.add_patch(Rectangle((.72, .42), .035, .32, facecolor=red, edgecolor='none', zorder=4))
    txt(ax, .96, .72, 'PÓJŚĆ W TO', 7.2, white, 'bold')
    txt(ax, .96, .52, 'Free w App Store otwiera drzwi. Compliance pack sprzedaje działającą kontrolę — z dyplomem, który HR i IOD mogą sprawdzić.', 6.8, '#c2c6c9')
    txt(ax, 15.28, .18, 'Czerwona Teczka · Colgante i Wspólnicy są fikcją · nie jest to porada prawna',
        5.8, '#69727a', 'normal', 'right')
    txt(ax, .72, .18, 'strona 2 / 2', 5.8, '#69727a')


def main():
    png1 = out.with_name('mapa-sezonow-biznes.png')
    png2 = out.with_name('mapa-sezonow-biznes-p2.png')

    with PdfPages(out) as pdf:
        fig1, ax1 = new_fig()
        draw_page1(ax1)
        pdf.savefig(fig1, facecolor=bg, bbox_inches=None, pad_inches=0)
        fig1.savefig(png1, format='png', facecolor=bg, dpi=160, bbox_inches=None, pad_inches=0)
        plt.close(fig1)

        fig2, ax2 = new_fig()
        draw_page2(ax2)
        pdf.savefig(fig2, facecolor=bg, bbox_inches=None, pad_inches=0)
        fig2.savefig(png2, format='png', facecolor=bg, dpi=160, bbox_inches=None, pad_inches=0)
        plt.close(fig2)

    print(out, out.stat().st_size)
    print(png1, png1.stat().st_size)
    print(png2, png2.stat().st_size)


if __name__ == '__main__':
    main()
