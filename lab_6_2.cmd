magick convert logo.svg -background none -flatten logo.png
magick convert logo.png -fuzz 5% -transparent white logo_no_background.png
pause