# Generic pandoc makefile
# Tells GNU Make what to do if there is no Makefile in the directory

# These lists of extensions taken from pandoc source code
#
# From https://github.com/jgm/pandoc/blob/be929bcc80466623462102a39dd98726bb6c7781/src/Text/Pandoc/App.hs#L707-L731
READ_EXTS = db doc docx dokuwiki epub htm html json latex lhs ltx markdown md \
            muse native odt opml org pdf rst t2t tex textile wiki xhtml

# From https://github.com/jgm/pandoc/blob/be929bcc80466623462102a39dd98726bb6c7781/src/Text/Pandoc/App.hs#L740-L773
WRITE_EXTS = adoc asciidoc context ctx db docx epub fb2 icml json latex lhs \
             ltx markdown md ms muse native odt opml org pptx roff rst rtf s5 \
             tei tei.xml tex texi texinfo text textile txt


$(foreach read_ext,$(READ_EXTS),                                              \
        $(foreach write_ext,$(WRITE_EXTS),                                    \
                $(eval                                                        \
                                                                              \
        %.$(out): %.$(in);                                                    \
                # This saves a copy of the most recent version to             \
                # .<filename>~ so you can recover if you overwrite the source \
                @mv -f "$$^" ".$$^~";                                         \
                pandoc -s -o "$$@" "$$^";                                     \
                                                                              \
)))
