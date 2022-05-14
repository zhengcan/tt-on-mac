#!/bin/bash

# Prepare dosbox-x
DOSBOX=dosbox-x
if [[ ! -x $(command -v $DOSBOX) ]]; then
	DOSBOX=dosbox-x.app/Contents/MacOS/DosBox
	if [[ ! -e $DOSBOX ]]; then
		DOSBOX_X_VERSION=0.83.25
		DOSBOX_X_BUILDNO=20220501074941
		if [[ "$OSTYPE" != "darwin"* ]]; then
			echo "Unsupported platform"
			exit 1
		fi
		ARCH=$(arch)
		if [[ $ARCH == "i386" ]]; then
			ARCH="x86_64"
		fi
		wget -P tt_temp https://github.com/joncampbell123/dosbox-x/releases/download/dosbox-x-v${DOSBOX_X_VERSION}/dosbox-x-macosx-${ARCH}-${DOSBOX_X_BUILDNO}.zip
		unzip tt_temp/*.zip -d tt_temp
		mv tt_temp/dosbox-x/dosbox-x.app .
		rm -rf tt_temp
	fi
fi

# Prepare TT
if [[ ! -e tt/TT.* ]]; then
	wget -P tt https://raw.githubusercontent.com/zhengcan/tt-on-mac/master/tt.zip
	unzip tt/*.zip -d tt
	rm tt/*.zip
fi

# Download self
if [[ ! -e `pwd`/run.sh ]]; then
	wget https://raw.githubusercontent.com/zhengcan/tt-on-mac/master/run.sh
	chmod +x run.sh
fi

# Run
echo "[autoexec]
mount d $(pwd)/tt
d:
TT
exit" > dosbox.conf
$DOSBOX -fastlaunch > /dev/null 2>&1

