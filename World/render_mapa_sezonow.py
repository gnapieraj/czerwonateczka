from matplotlib.backends.backend_pdf import PdfPages
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, Rectangle, Circle
from matplotlib.lines import Line2D
from matplotlib import rcParams
from textwrap import wrap
from pathlib import Path

out = Path('/Users/AI/src/CzerwonaTeczka/World/mapa-sezonow-biznes.pdf')
W,H = 16,9
bg='#0b0c10'; card='#151820'; blue='#25303a'; line='#39424c'; cream='#f1ecdf'; muted='#b6b8bd'; red='#a62b33'; red2='#d95a5a'; white='#fffaf0'; pale='#f1b6ab'
rcParams['font.family']='DejaVu Sans'
rcParams['pdf.fonttype']=42
fig=plt.figure(figsize=(W,H), facecolor=bg)
ax=fig.add_axes([0,0,1,1]); ax.set_xlim(0,W); ax.set_ylim(0,H); ax.axis('off'); ax.set_facecolor(bg)
# subtle red glow
ax.add_patch(Circle((15.7,8.45), 2.6, color=red, alpha=.06, zorder=0))
ax.add_patch(Circle((15.7,8.45), 1.6, color=red, alpha=.045, zorder=0))

def txt(x,y,s,size=10,color=cream,weight='normal',ha='left',va='top',family=None,alpha=1,linespacing=1.2):
    ax.text(x,y,s,fontsize=size,color=color,fontweight=weight,ha=ha,va=va,alpha=alpha,family=family,linespacing=linespacing,zorder=5)

def box(x,y,w,h,fc=card,ec=line,lw=1,r=0.12,alpha=1):
    p=FancyBboxPatch((x,y),w,h,boxstyle=f'round,pad=0,rounding_size={r}',facecolor=fc,edgecolor=ec,linewidth=lw,alpha=alpha,zorder=2)
    ax.add_patch(p); return p

def wraptext(s,n): return '\n'.join(wrap(s,n,break_long_words=False,replace_whitespace=False))

def label(x,y,s): txt(x,y,s.upper(),6.7,muted,'bold',linespacing=1.1)

def season(x,y,w,title,nights,role,focus,benefit, top=True):
    if not top: ax.add_line(Line2D([x,x+w],[y+.2,y+.2],color=line,lw=.7,zorder=4))
    txt(x,y,title,9.2,white,'bold'); txt(x+w,y,nights.upper(),7.2,red2,'bold',ha='right')
    txt(x,y-0.22,role,6.9,muted)
    txt(x,y-0.52,wraptext(focus,55 if w<4.4 else 62),7.25,cream,linespacing=1.16)
    txt(x,y-1.06,wraptext('Wartość: '+benefit,54 if w<4.4 else 63),6.9,pale,linespacing=1.15)

# Header
label(.72,8.62,'BUSINESS MAP · COLGANTE')
txt(.72,8.31,'Czerwona Teczka',25,cream,'bold'); txt(5.05,8.31,'— mapa sezonów',25,red2,'bold')
txt(.72,7.77,'Od codziennej świadomości do kontroli, gotowości i odpowiedzialnego wdrożenia.',10.8,'#d8d4cb')
txt(15.28,8.58,'STAN DECYZJI · 02.10.2026 PT\nKANCELARIA COLGANTE I WSPÓLNICY\nfikcja / materiał biznesowy',6.5,muted,'normal','right',linespacing=1.45)
ax.add_line(Line2D([.72,15.28],[7.5,7.5],color=line,lw=.8,zorder=3))
# flow
fy=6.63
nodes=[(.72,3.35,blue,line,'FREE · App Store','S0 Wstęp + S1 Aplikant · 24 noce'),(5.0,4.55,red,'#e7aaa9','B2B · COMPLIANCE PACK','S2 Kontrola + S3 AML · 24 noce · pierwszy pack komercyjny'),(10.35,4.93,blue,line,'KOLEJNE PACKI','S4 AI · S5 Cyfryzacja · S6 Etyka / ustrój')]
for i,(x,w,fc,ec,t,s) in enumerate(nodes):
    box(x,fy,w,.62,fc,ec,.8,.10)
    txt(x+.2,fy+.43,t,7.6,white,'bold'); txt(x+.2,fy+.19,s,6.3,'#f0ede4' if fc==red else '#c5cbd0')
    if i<2: txt(x+w+.23,fy+.30,'→',18,red2,'bold',ha='center',va='center')
# cards
x1,x2,x3=.72,5.0,10.35; y0=1.02; h=5.14
box(x1,y0,3.75,h,card,line,1,.13); box(x2,y0,4.55,h,card,red2,1.5,.13); box(x3,y0,4.93,h,card,line,1,.13)
# free card
label(x1+.24,5.85,'ŚCIEŻKA FREE / APP STORE'); txt(x1+.24,5.55,'Fundament',15.2,white,'bold'); txt(x1+.24,5.18,'Wejście do marki i nawyku. Bez opłaty —\nzanim pojawia się oferta compliance.',7.5,'#d9d7d0',linespacing=1.25)
season(x1+.24,4.55,3.27,'S0 · Wstęp','12 nocy','Rola: Mecenas','Higiena cyfrowa, phishing, MFA, dane i decyzje pod presją.','wspólny język sygnałów ryzyka.')
season(x1+.24,3.12,3.27,'S1 · Aplikant','12 nocy','Rola: Aplikant','Nawyki codziennej pracy, przekazywanie spraw, dostępy i odpowiedzialność.','awareness, który widać w zachowaniu zespołu.',False)
ax.add_patch(Rectangle((x1+.24,1.32),.035,.60,facecolor=red2,edgecolor='none',zorder=4)); txt(x1+.39,1.79,'Nie sprzedajemy ścieżki osobno:',7.2,white,'bold'); txt(x1+.39,1.58,'to wejście do marki i nawyku.',7.2,cream)
# commercial
label(x2+.24,5.85,'PIERWSZA OFERTA KOMERCYJNA / B2B'); txt(x2+.24,5.55,'Compliance pack',15.2,white,'bold'); txt(x2+.24,5.18,'S2 + S3 · 24 NOCE   |   nowa postać: Audytor',7.5,'#f1c8bb','bold')
season(x2+.24,4.55,4.05,'S2 · Kontrola','12 nocy','Rola: Audytor','RODO, tajemnica zawodowa, chmura i AI: co wolno, kto odpowiada i co trzeba umieć wykazać.','zasada, decyzja, właściciel i dowód.')
season(x2+.24,3.12,4.05,'S3 · AML','12 nocy','Rola: Audytor','Klient, beneficjent, źródło środków i sygnały ryzyka — praktyka zamiast wykładu.','mniej ślepych punktów i gotowość do sprawdzenia.',False)
ax.add_patch(Rectangle((x2+.24,1.44),4.07,.36,facecolor=red,edgecolor='none',zorder=4)); txt(x2+.43,1.68,'24 NOCE · JEDEN PACK · PIERWSZY PRODUKT DLA KANCELARII',6.65,white,'bold')
ax.add_patch(Rectangle((x2+.24,1.05),.035,.24,facecolor=red2,edgecolor='none',zorder=4)); txt(x2+.39,1.35,'Nie tylko „wiemy, że ryzyko istnieje”,',7.0,white,'bold'); txt(x2+.39,1.18,'ale „mamy kontrolę nad tym, co robimy dalej”.',7.0,cream)
# roadmap
label(x3+.24,5.85,'PÓŹNIEJ / ROADMAPA'); txt(x3+.24,5.55,'Kolejne pakiety',15.2,white,'bold'); txt(x3+.24,5.18,'Kierunek rozwoju — jeszcze nie sprzedajemy jako packów.',7.5,'#d9d7d0')
season(x3+.24,4.55,4.45,'S4 · AI deployer','12 nocy*','Rola: do ustalenia', 'Wdrażanie AI do pracy: zakres, nadzór, jakość i odpowiedzialność.','z eksperymentu do procesu.')
season(x3+.24,3.18,4.45,'S5 · Cyfryzacja','12 nocy*','Rola: do ustalenia', 'e-Doręczenia, NIS2 i odporność procesów.','sprawna kancelaria mimo awarii kanału lub dostawcy.',False)
season(x3+.24,2.30,4.45,'S6 · Etyka / ustrój','12 nocy*','Rola: do ustalenia', 'Etyka, konflikt ról, ustrój i granice odpowiedzialności.','decyzje obronne także zawodowo.',False)
txt(x3+.24,1.05,'* S4–S6: wariant roboczy 12 nocy — do potwierdzenia przed ofertą.',6.3,muted)
# footer
ax.add_line(Line2D([.72,15.28],[.92,.92],color=line,lw=.8,zorder=3))
for x,head,body in [(.72,'AWARENESS','Dostrzegam sygnał i zatrzymuję automatyzm.'),(5.35,'CONTROL / COMPLIANCE','Mam zasadę, właściciela, dowód i ścieżkę reakcji.'),(10.05,'POZYCJONOWANIE','Free buduje świadomość. B2B sprzedaje działającą kontrolę.')]:
    ax.add_patch(Rectangle((x,.46),.035,.30,facecolor=red,edgecolor='none',zorder=4)); txt(x+.16,.76,head,7.0,white,'bold'); txt(x+.16,.59,body,6.7,'#c2c6c9')
txt(15.28,.18,'Czerwona Teczka · Colgante i Wspólnicy są fikcją · nie jest to porada prawna',5.8,'#69727a','normal','right')
fig.savefig(out,format='pdf',facecolor=bg,bbox_inches=None,pad_inches=0)
print(out, out.stat().st_size)
