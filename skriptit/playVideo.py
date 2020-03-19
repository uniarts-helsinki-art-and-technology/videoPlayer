#!/usr/bin/python -u
#coding=UTF-8

#	Toista USB-tikulta videotiedosto omxplayerilla
#	Play a video file from USB drive with omxplayer

#	Lisenssi: GNU GPL
#	License: GNU GPL

import os
import time


#Polku johon liitettävät mediat liitetään
# Path where removable media is mounted
MEDIAPOLKU = "/media/pi/"
LOKAALI_POLKU = "/home/pi/Desktop/videot/"


# Luokka liitettävän median (eli muistitikun) lukemista varten
# Class for reading USB drive
class c_media:
	liitettyPolku = ""

	# Hae tiedosto liitettävältä medialta. Palauta tiedoston koko polku. Jos ei löytynyt, palauta ""
	# Search removable media for a file. Return full path to file. If not found, return ""
	def haeVideotiedosto(self):
		#luettele mediapolun tiedostot eli USB-tikut ym.
		#list files in the media path, ie. USB drives etc.
		try:
			medialuettelo = os.listdir(MEDIAPOLKU)
			medialuettelo.sort()
		except:
			return ""

		#jos ei löydy kansiota, palauta ""
		#if no folder is found, return ""
		if len(medialuettelo) == 0:
			return ""
		
		#polku jossa videotiedostot ovat:
		#path to video files:
		try:
			videopolku = MEDIAPOLKU + medialuettelo[0] + "/"
			if os.path.isdir(videopolku) == False:
				return ""
		except:
			return ""

		#luetellaan polun tiedostot
		#list files in the path
		tiedostot = os.listdir(videopolku)
		tiedostot.sort()

		#Haetaan luettelosta ensimmäinen tiedosto, joka ei ole kansio eikä pistealkuinen
		#Search from the list the first file that is not a folder or a dot file
		videotiedosto = ""
		for tiedosto in tiedostot:
			if tiedosto[0] == '.':
				continue
			if os.path.isdir(videopolku + tiedosto):
				continue
			else:
				return videopolku + tiedosto
				liitettyPolku = videopolku
				break
		return ""
		

	# Hae tiedosto lokaalista polusta
	# Look for a file in the local path
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
		os.system("umount " + self.liitettyPolku)

# instanssi
# instance
media = c_media()


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
	while yritys < 10:
		videotiedostoMedialta = media.haeVideotiedosto()
		if videotiedostoMedialta != "":
			print "Löydettiin tiedosto " + videotiedostoMedialta
			print "Poistetaan entiset tiedostot muistikortilta"
			os.system("rm -f -v " + LOKAALI_POLKU + "*");
			print "Siirretään tiedosto muistikortille"
			os.system("mkdir -p " + LOKAALI_POLKU + " && cp -v " + videotiedostoMedialta + " " + LOKAALI_POLKU);
			media.irrota()
			break
		else:
			print "Ei löydetty mediaa. Yritetään uudestaan..."
		yritys = yritys + 1
		time.sleep(1)
	if media.haeLokaaliTiedosto() != "":
		break

lokaaliTiedosto = media.haeLokaaliTiedosto()
print "Toistetaan: " + lokaaliTiedosto
os.system("omxplayer --loop " + lokaaliTiedosto)
