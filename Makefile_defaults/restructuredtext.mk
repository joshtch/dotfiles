OUTPUT_FORMATS = html pdf

$(foreach format,$(OUTPUT_FORMATS),                      \
        $(eval                                           \
                                                         \
        %.$(format): %.rst;                              \
                pandoc -s -o "$$@" "$$^" -t "$(format)"; \
                                                         \
        )                                                \
)
