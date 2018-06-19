EXTS = ad adoc asciidoc

# List of file types to build to
TGT_EXTS = html #pdf

# Build commands for files, by file extension
# Use $$< for prerequisites, $$@ for target
#     See GNU Make manual section on automatic variables for more details
#     Annoyingly, two $'s are necessary because these are interpreted by eval
COMMON_FLAGS = -r asciidoctor-diagram -a stem -a urldata -a icons -a iconsdir=./images/icons/
TO_html = asciidoctor $$< -o $$@ $(COMMON_FLAGS) -b html
TO_pdf  = asciidoctor $$< -o $$@ $(COMMON_FLAGS) -b pdf  -r asciidoctor-pdf -r asciidoctor-mathematical

# Pandoc fallback
$(foreach out,$(TGT_EXTS),\
    $(foreach in,$(EXTS),\
        $(eval %.$(out): %.$(in); pandoc -s -o $$@ $$^ )))

# This is needed to embed the 'if' condition in an eval clause
define RULE_GEN
ifdef TO_$(1)
$(foreach ext,$(EXTS),\
	$(eval %.$(1): %.$(ext); $(TO_$(1))))
endif
endef

$(foreach tgt_ext,$(TGT_EXTS),\
	$(eval $(call RULE_GEN,$(tgt_ext))))
