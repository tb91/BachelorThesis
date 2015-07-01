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
#  (erzeugt unnötig RIESIGE EPS-Dateien:) convert pellenz_3d.png pellenz_3d.eps
#
# Entsprechend werden alle in FIGIMGS gelisteten xfig-Bilder
# mittels fig2dev -L umgewandelt. (SuSE Paket 'transfig')
# 'make clean' loescht die so entstandenen Bilder bei Bedarf wieder.

# analog für 
#   PNG-Bilder  (benötigt sam2p, http://www.inf.bme.hu/~pts/sam2p/)
#   TIFF-Bilder (benötigt sam2p, http://www.inf.bme.hu/~pts/sam2p/)
#   PPM-Bilder  (benötigt sam2p, http://www.inf.bme.hu/~pts/sam2p/)
#   PGM-Bilder  (benötigt sam2p, http://www.inf.bme.hu/~pts/sam2p/)
#   SVG-Bilder  (benötigt inkscape, http://www.inkscape.org/)
#   DOT-Bilder  (benötigt dot ais graphviz, http://www.graphviz.org/)
#   GP-Bilder   (benötigt gnuplot, http://www.gnuplot.info )
#   XMI-Bilder  (benötigt umbrello, http://www.graphviz.org/)

.SUFFIXES: .pdf .eps .jpg .fig .png .tif .tiff .svg .dot .gp .ppm .pgm .xmi

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

# "make pdfimages": für pdflatex optional alle (erzeugten) EPS (außer denen aus
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

ALLEPS  = $(ORIGEPS) $(JEPS) $(FEPS) $(PNGS) $(TIFS) $(SVGS) $(DOTS) $(GEPS) \
		$(PGMS) $(PPMS) $(XMIS)
JPGPNG  = $(JEPS) $(PNGS)
EPDFEPS = $(filter-out $(JPGPNG),$(ALLEPS))
EPDF    = $(EPDFEPS:.eps=.pdf)
	
.jpg.eps:
	[ -x "$(JPEG2PS)" ] && "$(JPEG2PS)" $< > $@

.fig.eps:
	fig2dev -L eps $< $@
        
.png.eps::
	# convert to PPM to avoid alpha/transparencey mode of sam2p
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
	dot -Tps $< > $@

.gp.eps:
	gnuplot $<

.eps.pdf:
	epstopdf $<

default: $(JEPS) $(FEPS) $(PNGS) $(TIFS) $(SVGS) $(DOTS) $(GEPS) \
		$(PGMS) $(PPMS) $(XMIS)

pdfimages: default $(EPDF)

clean:
	$(REMOVE) $(JEPS) $(FEPS) $(PNGS) $(TIFS) $(SVGS) $(DOTS) $(GEPS) \
		$(PGMS) $(PPMS) $(XMIS) $(EPDF)

svnadmin    : 
	echo $(JEPS) $(FEPS) $(PNGS) $(TIFS) $(SVGS) $(DOTS) $(GEPS) $(PGMS) $(PPMS) $(XMIS) $(EPDF) | tr ' ' '\012' >> .svnignore
	sort .svnignore | uniq > .si-tmp; mv .si-tmp .svnignore
	svn propset svn:ignore -F .svnignore .
	@echo 'Infos: http://svnbook.red-bean.com/en/1.0/ch07s02.html'
