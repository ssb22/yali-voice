RawParams=-r 44100 -c 1 -s -2

#Unix_To_Dos=flip -m
Unix_To_Dos=unix2dos

yali-voice.exe: wav-syllables setup.bat yali-exe-readme.txt unzipsfx.exe
	mkdir -p partials/zh/yali
	cd wav-syllables ; for N in *.wav ; do sox $$N $(RawParams) ../partials/zh/yali/$$(echo $$N|sed -e s/wav/raw/); done; cd ..
	cp wav-syllables/\!* partials/zh/yali/
	sox -t raw $(RawParams) /dev/null -t wav - 2>/dev/null | cat > partials/header.wav
	$(Unix_To_Dos) setup.bat
	cp yali-exe-readme.txt partials/README.txt
	$(Unix_To_Dos) partials/README.txt
	find setup.bat partials -type f | sort | zip -q -9 yali-voice.zip -@
	echo '$$AUTORUN$$>setup.bat' | zip -z yali-voice.zip
	cat unzipsfx.exe yali-voice.zip > yali-voice.exe
	zip -A yali-voice.exe
	rm -rf partials yali-voice.zip
