srcPath = src/
serviceSrc = service/
service = playVideo.service

executable = playVideo.sh

installationPath = $(HOME)/Desktop/videoPlayer/
servicePath = $(HOME)/.config/systemd/user/

all: install

install:
	mkdir -p $(installationPath)
	cp -vf $(srcPath)* $(installationPath)
	chmod +x $(installationPath)$(executable)
	
	mkdir -p $(servicePath)
	cp -vf $(serviceSrc)$(service) $(servicePath)$(service)
	
	systemctl --user enable $(service)
	systemctl --user daemon-reload

uninstall:
	systemctl --user stop $(service)
	systemctl --user disable $(service)
	rm -vf $(servicePath)$(service)
	systemctl --user daemon-reload
	systemctl --user reset-failed
	
	rm -rvf $(installationPath)

remove:
	rm -vf $(servicePath)$(service)
	rm -rvf $(installationPath)
