@echo ON

@call phonegap build android
@echo "------------------------ build done ------------------------------"

@call platforms\android\cordova\build.bat --release
@echo "------------------------ release done ------------------------------"

@xcopy platforms\android\ant-build\Application-release-unsigned.apk out\Application-release-unsigned.apk /y /s /i 

@call jarsigner -storepass s3cr3tp@ss -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore Application.keystore out\Application-release-unsigned.apk Application
@echo "------------------------ app signed done ------------------------------"

@call del C:\dare-me2\out\Application-release-signed-aligned.apk
@echo "------------------------ delete old aligned file ------------------------------"

@call zipalign -v 4 out\Application-release-unsigned.apk out\Application-release-signed-aligned.apk
@echo "------------------------ app zipaligning done ------------------------------"

@pause
