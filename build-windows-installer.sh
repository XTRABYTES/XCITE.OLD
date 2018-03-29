#!/bin/bash

ARCHIVE_DIR="${PWD}/packages/global.xtrabytes.xcite"
VERSION=$(grep -oPm1 "(?<=<Version>)[^<]+" "${ARCHIVE_DIR}/meta/package.xml")
ARCHIVE_PATH="${ARCHIVE_DIR}/data/XCITE-${VERSION}-windows.7z"
INSTALLER_PATH="${PWD}/XCITE-${VERSION}-Windows.exe"

echo -e "\nXCITE windows installer creator\n"

if [[ ! -f ${PWD}/xcite.pro ]]; then
	echo "Run this script from the xcite directory"
	exit 1
fi

for i in gcc.exe windeployqt.exe archivegen.exe binarycreator.exe; do 
	command -v $i >/dev/null 2>&1 || { echo >&2 "${i} is required but is not in your path, aborting."; exit 1; }
done

echo "Building version ${VERSION}..."

rm -f $ARCHIVE_PATH
rm -f $INSTALLER_PATH

pushd . 
cd build/release && \
	mv xcite.exe /tmp/ && \
	rm -rf * && \
	mv /tmp/xcite.exe . && \
	windeployqt.exe --compiler-runtime --release --qmldir ../../frontend xcite.exe && \
	cp ../../support/{lib,ssl}eay32.dll . && \
	archivegen.exe "${ARCHIVE_PATH}" . && \
	popd && \
	binarycreator.exe -c config/config.xml -p packages XCITE-${VERSION}-Windows.exe
	
