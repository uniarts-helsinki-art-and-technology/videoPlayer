# videoPlayer

(english: see below)


Videosoitin Raspberry Pi:lle

ASENNUS

1.
2.
3.
...


KÄYTTÖ


VIDEON EXPORTTAUS

Handbrake
FFMPEG

Käyttöohjeet


Videon laittaminen raspberry pi:lle
***********************************
Laita video muistitikulle. Siellä ei pidä olla muita tiedostoja ja videon ei pidä olla kansion sisällä. (Piilotiedostot ja kansiot ei haittaa. Jos siellä on monta tiedostoa, käytetään aakkosjärjestyksessä ensimmäistä.)
Liitä muistitikku Raspberry Pi:hin ja kytke se päälle. Video siirtyy muistikortille ja lähtee pyörimään.
Muistitikun voi sen jälkeen poistaa. Sammuta kuitenkin Raspberry Pi ennen kuin poistat muistitikun. (Se kylläkin irrotetaan umountilla siirron jälkeen, mutta varmuuden vuoksi kannattaa sammuttaa.)
Video lähtee aina automaattisesti pyörimään kun Raspberry Pi käynnistetään. (Ensin koitetaan 10 kertaa lukea muistitikkua. Silloin ruudulla lukee: "Ei löydetty mediaa. Yritetään uudestaan..." Siinä välissä voi vielä liittää muistitikun.)
Laittaaksesi toisen videon toista sama prosessi. Edellinen video poistetaan silloin.


Huom.
*****
Mikä tahansa muistitikulla oleva tiedosto ladataan. Jos toistaminen ei onnistu, tarkasta että oikea tiedosto ladattiin!
Suositeltu formaatti videolle on:
	H.264 High 1920x1080 60fps


Asentaminen makella
*******************
Tämä on tarkoitettu asennettavaksi Raspbian-järjestelmälle jossa on graafinen tila (LXDE).
Riippuvuudet: omxplayer, python (jotka löytyvät oletuksena)
Mene kansioon videoPlayer:
	$ cd videoPlayer
Aja make:
	$ make


Poistaminen
************
Mene kansioon videoPlayer:
	$ cd videoPlayer
Aja make:
	$ make remove


*****************************************************************************************************


Video player for Raspberry Pi


Instructions


How to insert video on the Raspberry Pi
***************************************
Put the video file on a USB drive. There should be no other files on the drive. The file should not be inside a folder. (Hidden files and folders are ok. If there are many files, the first one is used, in alphanumeric order.)
Connect the USB drive to the Raspberry Pi and turn the Raspberry Pi on.
The video is copied on the SD card of the Raspberry Pi and starts playing.
The USB drive can be removed after this. Turn power off before removing the drive though. (It is unmounted using umount but just to be sure)
The video will play automatically when the Raspberry Pi is started. (Before that it will search for a USB drive 10 times. A drive can be inserted and it will load a video.)
To insert another video, repeat the same process. The previous video will be deleted.


Notes
*****
Any file on the drive will be loaded, whether or not it is a valid video file. If the player fails, make sure the right file was loaded!
Preferred format for video is:
	H.264 High 1920x1080 60fps


How to install using make
*************************
Use a Raspbian system with the LXDE graphical environment - such as the main Raspbian build.
Dependencies: omxplayer, python (which are provided by default)
Go to the videoPlayer_0-2 path:
	$ cd videoPlayer_0-2
Run make:
	$ make


How to remove
*************
Go to the videoPlayer_0-2 path:
	$ cd videoPlayer_0-2
Run make:
	$ make remove
