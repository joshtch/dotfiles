#!/bin/bash

/usr/local/bin/gcalcli --color_now_marker=brightred --width=31 --calendar "howejosh@gmail.com"#brightgreen --calendar "Work Schedule"#brightblue --color_date=brightblack --color_border=black calw 3 | sed -f ~/dotfiles/border_fix.sh
