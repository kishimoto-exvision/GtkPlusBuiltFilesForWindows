rmdir /S /Q C:\gtk-build
mkdir C:\gtk-build
xcopy /E /I /Q /Y "..\gtk-build" "C:\gtk-build\"
cd C:\
C:\gtk-build\github\gtk-win32\build.ps1 -Configuration x64 -Msys2Directory C:\msys64
