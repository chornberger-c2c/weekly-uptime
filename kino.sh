#!/bin/bash
#little fun for my website, CHO

INDEX=/var/www/index.html
TMP=/var/www/tmp.html

fortunex() {
    /usr/games/fortune -s | /usr/games/cowsay -s -f $(shuf -n 1 -e $(/usr/games/cowsay -l)) >> $TMP
    [ $? -ne 0 ] && fortunex
}

while [ :: ]  
	do
	echo "<html>" > $TMP
	echo "<head>" >> $TMP
	echo "<meta charset=\"utf-8\">" >> $TMP
	echo "<meta http-equiv=\"refresh\" content=\"5\" >" >> $TMP
	echo "</head>" >> $TMP
	echo "<title>have a fortune cookie ...</title>" >> $TMP
	echo "<pre>" >> $TMP
	fortunex 
	echo "</pre>" >> $TMP
	echo "</html>" >> $TMP
	cp -a $TMP $INDEX
	sleep 4.5 
done
