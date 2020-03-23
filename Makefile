src = skriptit/
playskripti = playVideo.sh
autostart = playVideo.desktop
skriptipolku = /home/pi/Desktop/
autostartpolku = /home/pi/.config/autostart/

all:
	echo "Aja make install asentaaksesi"
	echo "Run make install to install"

install:
	mkdir -p $(skriptipolku)
	mkdir -p $(autostartpolku)
	cp -vf $(src)$(playskripti) $(skriptipolku)$(playskripti)
	chmod +x $(skriptipolku)$(playskripti)
	cp -vf $(src)$(autostart) $(autostartpolku)$(autostart)

uninstall:
	rm -v -f $(skriptipolku)$(playskripti)
	rm -v -f $(autostartpolku)$(autostart)

