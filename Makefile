# käskyt:
# all:
# 	cp skriptit/playVideo.py /home/pi/Desktop/playVideo.py
# 	cp skriptit/playVideo.desktop /home/pi/.config/autostart/playVideo.desktop

# remove:
#	rm /home/pi/.config/autostart/playVideo.desktop
#	rm /home/pi/Desktop/playVideo.py


src = skriptit/
playskripti = playVideo.py
autostart = playVideo.desktop
skriptipolku = /home/pi/Desktop/
autostartpolku = /home/pi/.config/autostart/

all:
	cp -v $(src)$(playskripti) $(skriptipolku)$(playskripti)
	cp -v $(src)$(autostart) $(autostartpolku)$(autostart)

remove:
	rm -v -f $(skriptipolku)$(playskripti)
	rm -v -f $(autostartpolku)$(autostart)