#!/usr/bin/python -u
#coding=UTF-8

#	Toista USB-tikulta videotiedosto omxplayerilla
#	Play a video file from USB drive with omxplayer

#	Lisenssi: GNU GPL
#	License: GNU GPL

import os
import time


MEDIAPOLKU = "/media/pi/"
LOKAALI_POLKU = "/home/pi/Desktop/videot/"
MAX_YRITYKSIA = 10

def onPiilotiedostoTaiKansio(polku, tiedosto):
	try:
		if os.path.isdir(polku+tiedosto):
			return True
		if tiedosto[0] == ".":
			return True
		return False
	except:
		print "Tiedostoa \"" + polku + "\" ei voitu lukea!"
		return True


class c_mediaLataaja:
	liitettyPolku = ""


	# Palauta koko polku tiedostoon
	# Return full path to file
	def haeTiedostoMedialta(self):
		medialuettelo = os.listdir(MEDIAPOLKU)
		medialuettelo.sort()
		if len(medialuettelo) == 0:
			return ""
		for media in medialuettelo:
			polku = MEDIAPOLKU + media + "/"
			try:
				if os.path.isdir(polku) == False:
					continue
				tiedostot = os.listdir(polku)
			except:
				continue
			if len(tiedostot) == 0:
				continue
			tiedostot.sort()
			for tiedosto in tiedostot:
				if onPiilotiedostoTaiKansio(polku, tiedosto):
					continue
				else:
					self.liitettyPolku = polku
					return polku + tiedosto
					break
		return ""
		

	# Palauta koko polku tiedostoon
	# Return full path to file
	def haeLokaaliTiedosto(self):
		try:
			if os.path.isdir(LOKAALI_POLKU) == False:
				return ""
			tiedostot = os.listdir(LOKAALI_POLKU)
			if len(tiedostot) == 0:
				return ""
		except:
			return ""
		tiedostot.sort()
		return LOKAALI_POLKU + tiedostot[0]


	def irrota(self):
		if self.liitettyPolku == "":
			return
		os.system("umount \"" + self.liitettyPolku + "\"")


mediaLataaja = c_mediaLataaja()


##########################################################################################


#Jos USB-tikulta löytyy tiedosto:
#	poista lokaalista polusta kaikki tiedostot
#	kopioi tiedosto USB-tikulta lokaaliin polkuun
#	toista tiedosto lokaalista polusta
#Jos USB-tikulta ei löydy tiedostoa:
#	yritä uudestaan 10 kertaa
#	jos lokaalissa polussa on tiedosto:
#		toista tiedosto lokaalista polusta
#	jos ei:
#		yritä uudelleen hakea mediaa loputtomasti



#If a file is found on a USB drive:
#	remove all files in the local path
#	copy the file from the drive to the local path
#	play the file from the local path
#If no file is found on the USB drive:
#	Try again 10 times
#	If there is a file at the local path:
#		play the file from the local path
#	Else:
#		look for media forever



while True:
	yritys = 0
	while yritys < MAX_YRITYKSIA:
		videotiedostoMedialta = mediaLataaja.haeTiedostoMedialta()
		if videotiedostoMedialta != "":
			print "Löydettiin tiedosto " + videotiedostoMedialta
			print "Found file " + videotiedostoMedialta

			print "Poistetaan entiset tiedostot muistikortilta"
			print "Removing previous files from the local storage"
			os.system("rm -rf -v " + LOKAALI_POLKU);
			print "Kopioidaan tiedosto muistikortille"
			print "Copying file to the local storage"
			os.system("mkdir -p " + LOKAALI_POLKU + " && cp -v \"" + videotiedostoMedialta + "\" " + LOKAALI_POLKU);
			mediaLataaja.irrota()
			break
		else:
			print "Ei löydetty mediaa. Yritetään uudestaan...", \
				yritys+1, "/", MAX_YRITYKSIA
			print "No media found. Trying again..."
		yritys = yritys + 1
		time.sleep(1)
	if mediaLataaja.haeLokaaliTiedosto() != "":
		break

lokaaliTiedosto = mediaLataaja.haeLokaaliTiedosto()
print "Toistetaan: " + lokaaliTiedosto + "..."

# argumentti -o: käytetään audiolaitteena analogista ulostuloa
# argument -o: using analog audio output
os.system("omxplayer --loop -o alsa --no-osd \"" + lokaaliTiedosto + "\"")

