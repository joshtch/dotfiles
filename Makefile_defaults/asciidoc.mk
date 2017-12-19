AD ?= asciidoctor
ADFLAGS ?= -a stem -a icons -r asciidoctor-diagram -r asciidoctor-mathematical

.SUFFIXES: .adoc .asciidoc .ad .html .pdf

%.html:

%.html: %.adoc

.html:

.adoc.html:
	$(AD) -b html $(ADFLAGS) $>

.asciidoc.html:
	$(AD) -b html $(ADFLAGS) $>

.ad.html:
	$(AD) -b html $(ADFLAGS) $>

.adoc.pdf:
	asciidoctor -b pdf -r asciidoctor-pdf $(ADFLAGS) $>

.asciidoc.pdf:
	asciidoctor -b pdf -r asciidoctor-pdf $(ADFLAGS) $>

.ad.pdf:
	asciidoctor -b pdf -r asciidoctor-pdf $(ADFLAGS) $>

