# Makefile
# 
# Converts Markdown to other formats (HTML, PDF, DOCX, RTF, ODT, EPUB) using Pandoc
# <http://johnmacfarlane.net/pandoc/>
#
# Run "make" (or "make all") to convert to all other formats
#
# Run "make clean" to delete converted files

MD?=/usr/local/bin/pandoc

MDFLAGS?=--smart --standalone

.SUFFIXES: .md .html .pdf .docx .rtf .odt .epub

.html:

.html.md:
	$(MD) $(MDFLAGS) --to html5 -o $@ $>

.pdf:

.pdf.md:
	$(MD) $(MDFLAGS) -o $@ $<

.docx:

%.docx : %.md
	$(MD) $(MDFLAGS) -o $@ $<

.rtf:

%.rtf : %.md
	$(MD) $(MDFLAGS) -o $@ $<

.odt:

%.odt : %.md
	$(MD) $(MDFLAGS) -o $@ $<

.epub:

%.epub : %.md
	$(MD) $(MDFLAGS) --to epub3 -o $@ $<
