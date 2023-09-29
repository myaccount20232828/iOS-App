#!/usr/bin/bash
Scheme=$(echo $(xcodebuild -list -json | tr -d "\n") | ruby -e "require 'json'; puts JSON.parse(STDIN.gets)['project']['targets'][0]")
if [ "`ls -A | grep -i \\.xcworkspace\$`" ]; then XCProject="`ls -A | grep -i \\.xcworkspace\$`"; else XCProject="`ls -A | grep -i \\.xcodeproj\$`"; fi
xcodebuild -jobs $(sysctl -n hw.ncpu) -project "$XCProject" -scheme "$Scheme" -configuration Release -arch arm64 -sdk iphoneos -derivedDataPath "$TMPDIR/App" CODE_SIGNING_ALLOWED=NO DSTROOT=$AppTMP/install ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO
mkdir Payload
mv "$(echo $TMPDIR/App/Build/Products/Release-iphoneos/*.app)" Payload
brew install ldid && ldid -Sentitlements.plist "$(echo Payload/*.app)"
zip -r9 "$Scheme.ipa" Payload
rm -rf Payload && rm -rf "$TMPDIR/App"
