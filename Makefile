src = skriptit/
playskripti = playVideo.sh
servicetiedosto = playVideo.service
skriptipolku = /home/pi/Desktop/
servicepolku = /etc/systemd/system/

all:
	@echo "Aja sudo make install asentaaksesi"
	@echo "Run sudo make install to install"

install:
	mkdir -p $(skriptipolku)
	mkdir -p $(servicepolku)
	cp -vf $(src)$(playskripti) $(skriptipolku)$(playskripti)
	chmod +x $(skriptipolku)$(playskripti)
	cp -vf $(src)$(servicetiedosto) $(servicepolku)$(servicetiedosto)
	systemctl enable $(servicetiedosto)
	systemctl daemon-reload

uninstall:
	systemctl stop $(servicetiedosto)
	systemctl disable $(servicetiedosto)
	rm -v -f $(servicepolku)$(servicetiedosto)
	systemctl daemon-reload
	systemctl reset-failed
	rm -v -f $(skriptipolku)$(playskripti)
