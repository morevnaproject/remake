cd %~p0

set PATH=%PATH%;c:\cygwin\bin\;c:\cygwin\usr\bin\;%~p0;%~p0\..\synfig;%~p0\..\blender
c:\cygwin\bin\bash.exe remake %1 stereo

pause
