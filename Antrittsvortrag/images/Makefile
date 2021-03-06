# Dieses Makefile sorgt beim Aufruf von 'make' dafuer, dass alle
# bei JPEGIMGS aufgelisteten *.jpg Bilder in platzschonender(!)
# Weise zu *.eps Bildern fuer LaTeX gewandelt werden.
#
# Erfordert 'jpeg2ps', kostenlos von http://www.pdflib.de/ zu bekommen.
# (www.pdflib.de, "Produkte", "etc.", "jpeg2ps", fuehrt letztlich zu
#  http://www.pdflib.com/products/more/jpeg2ps.html, Stand Okt 2005)
# bzw. bei SuSE Linux (9.2) als Paket 'jpeg2ps' mit auf den CDs/DVDs
#
# SCHLECHTE Alternative, falls sam2p nicht klappt:
#  (erzeugt unn�tig viel zu gro�e EPS-Dateien:) convert -compress zip pic_3d.png pic_3d.eps
#
# Entsprechend werden alle in FIGIMGS gelisteten xfig-Bilder
# mittels fig2dev -L umgewandelt. (SuSE Paket 'transfig')
# 'make clean' loescht die so entstandenen Bilder bei Bedarf wieder.

# analog f�r
#   PNG-Bilder  (ben�tigt sam2p, http://www.inf.bme.hu/~pts/sam2p/)
#   TIFF-Bilder (ben�tigt sam2p, http://www.inf.bme.hu/~pts/sam2p/)
#   PPM-Bilder  (ben�tigt sam2p, http://www.inf.bme.hu/~pts/sam2p/)
#   PGM-Bilder  (ben�tigt sam2p, http://www.inf.bme.hu/~pts/sam2p/)
#   SVG-Bilder  (ben�tigt inkscape, http://www.inkscape.org/)
#   DOT-Bilder  (ben�tigt dot ais graphviz, http://www.graphviz.org/)
#   GP-Bilder   (ben�tigt gnuplot, http://www.gnuplot.info )
#   XMI-Bilder  (ben�tigt umbrello, http://www.graphviz.org/)
#   DIA-Bilder  (ben�tigt dia, http://projects.gnome.org/dia/)

.SUFFIXES: .pdf .eps .jpg .fig .png .tif .tiff .svg .dot .gp .ppm .pgm .xmi .dia .ps

# HIER alle JPEG-Bilder auflisten, mit Leerzeichen getrennt. Beispiel
# JPEGIMGS =  bild1.jpg nocheinbild.jpg dasDritte.jpg # nicht .JPG oder .jpeg!
# FIGIMGS = 2DBeispiel.fig Interpo.fig BI.fig
# Falls alle vorhandenen jpg- bzw. fig-Bilder bearbeitet werden sollen,
# dann kann man auch $(wildcard *.jpg) bzw. $(wildcard *.fig) angeben.

JPEGIMGS = $(wildcard *.jpg)
TIFFIMGS = $(wildcard *.tiff)
TIFIMGS  = $(wildcard *.tif)
FIGIMGS  = $(wildcard *.fig)
PNGIMGS  = $(wildcard *.png)
SVGIMGS  = $(wildcard *.svg)
DOTIMGS  = $(wildcard *.dot)
GPLIMGS = $(wildcard *.gp)
PGMIMGS = $(wildcard *.pgm)
PPMIMGS = $(wildcard *.ppm)
XMIIMGS = $(wildcard *.xmi)
DIAIMGS = $(wildcard *.dia)
PSIMGS  = $(wildcard *.ps)

# "make pdfimages": f�r pdflatex optional alle (erzeugten) EPS (au�er denen aus
# JPG und PNG) zu PDF konvertieren. epstopdf aus dem 'texlive' Paket kann das gut.
ORIGEPS = $(wildcard *.eps)

# official (?) way to check if we are running on Windows ?
# Dev-Cpp make sets ComSpec, make manual says COMSPEC ...
ifdef ComSpec
 WIN = 1
else
 ifdef COMSPEC
  WIN = 1
 else
  WIN = 0
 endif
endif

ifeq ($(WIN),0)
 JPEG2PS = $(shell which jpeg2ps 2>&1)
 REMOVE = rm -f
else
 # Unter Windows hier den richtigen Pfad zu jpeg2ps.exe angeben
 JPEG2PS = jpeg2ps.exe # oder /path/to/jpeg2ps.exe
 REMOVE = del /q/f
endif

JEPS = $(JPEGIMGS:.jpg=.eps)
FEPS = $(FIGIMGS:.fig=.eps)
PNGS = $(PNGIMGS:.png=.eps)
TIFS = $(TIFIMGS:.tif=.eps) $(TIFFIMGS:.tiff=.eps)
SVGS = $(SVGIMGS:.svg=.eps)
DOTS = $(DOTIMGS:.dot=.eps)
GEPS = $(GPLIMGS:.gp=.eps)
PGMS = $(PGMIMGS:.pgm=.eps)
PPMS = $(PPMIMGS:.ppm=.eps)
XMIS = $(XMIIMGS:.xmi=.eps)
DIAS = $(DIAIMGS:.dia=.eps)
PSS  = $(PSIMGS:.ps=.eps)

GENERATEDEPS = $(JEPS) $(FEPS) $(PNGS) $(TIFS) $(SVGS) $(DOTS) $(GEPS) \
		$(PGMS) $(PPMS) $(XMIS) $(DIAS) $(PSS)
ALLEPS  = $(ORIGEPS) $(GENERATEDEPS)

JPGPNG  = $(JEPS) $(PNGS)
EPDFEPS = $(filter-out $(JPGPNG),$(ALLEPS))
EPDF    = $(EPDFEPS:.eps=.pdf)
	
.jpg.eps:
	[ -x "$(JPEG2PS)" ] && "$(JPEG2PS)" $< > $@

.fig.eps:
	fig2dev -L eps $< $@

.png.eps::
	# convert to PPM to avoid alpha/transparencey mode of sam2p
	# NEVER use ImageMagick's 'convert' program. It's lousy!
	pngtopnm $< | sam2p -2 -c:lzw - $@

.ppm.eps::
	sam2p -2 -c:lzw $< $@

.pgm.eps::
	sam2p -2 -c:lzw $< $@

.tif.eps::
	sam2p -2 -c:lzw $< $@

.tiff.eps::
	sam2p -2 -c:lzw $< $@

.svg.eps::
	inkscape -E $@ $<

.dot.eps::
	dot -Teps $< > $@

.xmi.eps:
	umbrello --export eps $<
	mv Klassendiagramm.eps $@

.dia.eps:
	dia -e $@ -t eps-builtin $<

.gp.eps:
	gnuplot $<

.eps.pdf:
	epstopdf $<

.ps.eps::
	cp $< $@

default: $(GENERATEDEPS)

pdfimages: default $(EPDF)

clean:
	$(REMOVE) $(GENERATEDEPS)

svnadmin :
	echo $(GENERATEDEPS) | tr ' ' '\012' >> .svnignore
	sort .svnignore | uniq > .si-tmp; mv .si-tmp .svnignore
	svn propset svn:ignore -F .svnignore .
	@echo 'Infos: http://svnbook.red-bean.com/en/1.0/ch07s02.html'
