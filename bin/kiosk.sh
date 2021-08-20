#!/bin/sh
xset dpms
xset s noblank
xset s 0
openbox-session &
unclutter -idle 5.0 -root &
chromium-browser --no-first-run --disable --disable-translate --disable-infobars --disable-suggestions-service --disable-save-password-bubble --start-maximized --kiosk --disable-session-crashed-bubble --incognito $URL
