SetLocal EnableDelayedExpansion
@echo|set /p="Lese die existierenden Netzwerke ein:"
netsh wlan show profile > SavedNetworks.temp
@echo|set /p="Verarbeite die eingelesenen Netzwerke (1):"
@echo off
for /F "tokens=2 delims=:" %%i in (SavedNetworks.temp) do (
call :Trim Actual %%i
netsh wlan show profile "!Actual!" key=clear >> SavedNetworks2.temp 
) 
@echo on
move SavedNetworks2.temp SavedNetworks.temp 
@echo|set /p="Verarbeite die eingelesenen Netzwerke (2):"
findstr "SSID-Name Sicherheitsschlssel Schlsselinhalt" SavedNetworks.temp >> SavedNetworks.txt
::notepad SavedNetworks.temp 
del SavedNetworks.temp 
notepad SavedNetworks.txt
::pause
exit /b

:Trim
::Line below already at the top.
::SetLocal EnableDelayedExpansion
set Params=%*
for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
exit /b
