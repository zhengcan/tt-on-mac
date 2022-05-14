#!/bin/bash

# Prepare dosbox-x
DOSBOX=dosbox-x
if [[ ! -x $(command -v $DOSBOX) ]]; then
	DOSBOX=dosbox-x.app/Contents/MacOS/DosBox
	if [[ ! -e $DOSBOX ]]; then
		DOSBOX_X_VERSION=0.83.25
		DOSBOX_X_BUILDNO=20220501074941
		wget -P temp https://github.com/joncampbell123/dosbox-x/releases/download/dosbox-x-v${DOSBOX_X_VERSION}/dosbox-x-macosx-$(arch)-${DOSBOX_X_BUILDNO}.zip
		unzip temp/*.zip -d temp
		mv temp/dosbox-x/dosbox-x.app .
		rm -rf temp
	fi
fi

# Prepare TT
TT=tt/TT.exe
if [[ ! -e $TT ]]; then
	wget -P tt https://raw.githubusercontent.com/zhengcan/tt-on-mac/master/tt.zip
	unzip tt/*.zip -d tt
	rm tt/*.zip
fi

# Run
echo "[autoexec]
mount d $(pwd)/tt
d:
TT
exit" > dosbox.conf
$DOSBOX -fastlaunch > /dev/null 2>&1

