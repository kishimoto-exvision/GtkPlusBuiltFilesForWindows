rmdir /S /Q "C:\gtk-build"
mkdir "C:\gtk-build"
xcopy /E /I /Q /Y "..\gtk-build\github"    "C:\gtk-build\github\"
xcopy /E /I /Q /Y "..\gtk-build\msgfmt"    "C:\gtk-build\msgfmt\"
xcopy /E /I /Q /Y "..\gtk-build\perl-5.20" "C:\gtk-build\perl-5.20\"
cd C:\
powershell Set-ExecutionPolicy RemoteSigned
powershell C:\gtk-build\github\gtk-win32\build.ps1 -Configuration x64 -Msys2Directory C:\msys64
