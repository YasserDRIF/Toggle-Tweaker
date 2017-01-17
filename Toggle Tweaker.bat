@echo off
Color 1F
Title Windows 10 Toggle Tweaker V3.5 By Yasser Da Silva
set CurV=3.5

SetLocal EnableDelayedExpansion
set "WAaction=1"

mode con:cols=55 lines=2
:: BatchGotAdmin
:-------------------------------------
REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
exit /B

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0" 




::============================================================
::Checking For Updates
::============================================================
cls
echo  Checking For Updates ...
ping -n 1 dl.dropbox.com >nul
if errorlevel 1	 (
  cls
   echo  Check your Internet So you can check for updates...
   ping 127.0.0.1 -n 3 > NUL 2>&1
  goto Main
)

echo strFileURL = "https://dl.dropbox.com/s/buqhs674085kcap/TWV.txt?dl=1" > TWV.vbs
echo     strHDLocation = "%CD%\TWV.TXT" >> TWV.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> TWV.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> TWV.vbs
echo objXMLHTTP.send() >> TWV.vbs
echo If objXMLHTTP.Status = 200 Then >> TWV.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> TWV.vbs
echo objADOStream.Open>> TWV.vbs
echo objADOStream.Type = 1 >> TWV.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> TWV.vbs
echo objADOStream.Position = 0    >> TWV.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> TWV.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> TWV.vbs
echo Set objFSO = Nothing >> TWV.vbs
echo objADOStream.SaveToFile strHDLocation >> TWV.vbs
echo objADOStream.Close >> TWV.vbs
echo Set objADOStream = Nothing >> TWV.vbs
echo End if >> TWV.vbs
echo Set objXMLHTTP = Nothing >> TWV.vbs
cscript TWV.vbs >nul 2>&1
del TWV.vbs


set content=
for /F "delims=" %%i in (TWV.TXT) do set content=!content! %%i
set NewV=%content%
del TWV.txt
if %NewV% GTR %CurV% (Goto New)
if %CurV% == %NewV% (Goto Main)
:New

echo Update=MsgBox ("New version (V%NewV%) for Toggle Tweaker is available. Would you like to download it?",vbyesno,"Toggle Tweaker Updater") > Download.vbs
echo if Update="6" then >> Download.vbs
echo Dim wsh >> Download.vbs
echo Set wsh=WScript.CreateObject("WScript.Shell") >> Download.vbs
echo wsh.Run "http://goo.gl/KZqoyt" >> Download.vbs
echo end if >> Download.vbs
echo if Update="7" then >> Download.vbs
echo MSgbox ("Ok, :( No problem.") >> Download.vbs
echo end if >> Download.vbs
cscript Download.vbs >nul 2>&1

del Download.vbs
goto Main

echo ษอหอป ฺฤยฤฟ
echo บ บ บ ณ ณ ณ
echo ฬอฮอน รฤลฤด
echo บ บ บ ณ ณ ณ
echo ศอสอผ ภฤมฤู

:Main
mode con:cols=87 lines=28

cls
echo **************************************************************************************
echo *   ____  __    ___   ___  __    ____    ____  _  _  ____   __   __ _  ____  ____    *
echo *  (_  _)/  \  / __) / __)(  )  (  __)  (_  _)/ )( \(  __) / _\ (  / )(  __)(  _ \   *
echo *    )( (  O )( (_ \( (_ \/ (_/\ ) _)     )(  \ /\ / ) _) /    \ )  (  ) _)  )   /   *
echo *   (__) \__/  \___/ \___/\____/(____)   (__) (_/\_)(____)\_/\_/(__\_)(____)(__\_)   *
echo *                                                                                    *
echo **************************************************************************************
echo                                                       ษอออออออออออออออออออออออออออออป
echo   1. Windows / Office KMS activation                  บ         New Features        บ
echo   2. User Interface Tweaks                          ษอฮอออออออออออออออออออออออออออออน
echo   3. Enable/Disable stuff In Windows 10             บAบ     Customize Options in    บ
echo   4. Speed Up PC Performance                        ศอน        File Explorer        บ
echo   5. Manage Microsoft Edge browser                    บ            2=^>16            บ
echo   6. Manage Updates                                 ษอฮอออออออออออออออออออออออออออออน
echo   7. Manage Windows Features                        บBบ   Added new Redstone apps   บ
echo   8. Manage User Accounts                           ศอน     to Uninstall section    บ
echo   9. Manage Built-in apps and restore old ones        บ            9=^>1             บ
echo  10. Manage TELEMETRY and Data collection Settings    ศอออออออออออออออออออออออออออออผ
echo  11. Internet Tweaks and Fixes                      
echo  12. Convert Pro/Home version to LTSB 
echo.                                                        
echo  000. Toggle Tweaker Actions                    
echo  00. More.. (Coming soon...)    0. Exit           S. Search for options in the script 
echo.
set /p input=* Write the option number here:
IF "%input%"=="A" (GOTO FE)
IF "%input%"=="a" (GOTO FE)
IF "%input%"=="B" (GOTO Awamenu)
IF "%input%"=="b" (GOTO Awamenu)



IF "%input%"=="1" (Goto KMSActivation)
IF "%input%"=="2" (Goto UI)
IF "%input%"=="3" (GOTO E/D)
IF "%input%"=="4" (GOTO Performance)
IF "%input%"=="5" (GOTO Edge)
IF "%input%"=="6" (GOTO Update)
IF "%input%"=="7" (GOTO Features)
IF "%input%"=="8" (GOTO Users)
IF "%input%"=="9" (GOTO WAmenu)
IF "%input%"=="10" (GOTO TM0)
IF "%input%"=="11" (GOTO NETWORK)
IF "%input%"=="12" (GOTO LTSB)

IF "%input%"=="s" (GOTO Search)
IF "%input%"=="S" (GOTO Search)
IF "%input%"=="00" (start http://goo.gl/KZqoyt
GOTO Main)
IF "%input%"=="0" (Exit)
IF "%input%"=="000" (Goto Settings)

if %input% GTR 20 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO Main



:Settings
mode con:cols=87 lines=28

cls
echo **************************************************************************************
echo *   ____  __    ___   ___  __    ____    ____  _  _  ____   __   __ _  ____  ____    *
echo *  (_  _)/  \  / __) / __)(  )  (  __)  (_  _)/ )( \(  __) / _\ (  / )(  __)(  _ \   *
echo *    )( (  O )( (_ \( (_ \/ (_/\ ) _)     )(  \ /\ / ) _) /    \ )  (  ) _)  )   /   *
echo *   (__) \__/  \___/ \___/\____/(____)   (__) (_/\_)(____)\_/\_/(__\_)(____)(__\_)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1. Create a restore point
echo   2. Undo all changes
echo.
echo   3. Send Feedback (Reply to MDL thread)
echo   4. Send Feedback via eMail
echo.
echo   0. Go back to Main page
echo.
set /p input=* Write the option number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="1" (Start systempropertiesprotection & GOTO Settings)
IF "%input%"=="2" (Goto UndoALL)
IF "%input%"=="3" (Start www.goo.gl/BNjTJG & GOTO Settings)
IF "%input%"=="4" (start mailto:yasserdrif007@gmail.com?subject="Win 10 Toggle Tweaker" & GOTO Main)
if %input% GTR 4 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO Settings



:UI
cls

echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo   1. Dark Theme For Apps                   
echo   2. Taskview button in Taskbar            
echo   3. Volume Control UI                     
echo   4. Notification center UI                
echo   5. Battery Status UI  
echo   6. Change Cortana size in Taskbar
echo   7. Transparency and Blur in : Taskbar-Notification center-Clock...
echo   8. Replace Logon screen Background Image with your accent color
echo   9. Enable/Disable Thumbnail Previews in File explorer
echo   10. Change OEM Information
echo   11. Context Menu Tweaks
echo   12. Alt-Tab Screen UI
echo   13. Increase Taskbar Thumbnail size to 0x190/400
echo   14. Colourise or Decolourise (Start Menu + Taskbar) and (Title bars + Borders)
echo   15. Customize Delete Confirmation Dialog Prompt Details
echo   16. Customize File Explorer Options
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="1" (Goto 1)
IF "%input%"=="2" (GOTO 2)
IF "%input%"=="3" (GOTO 3)
IF "%input%"=="4" (GOTO 4)
IF "%input%"=="5" (GOTO 5)
IF "%input%"=="6" (GOTO 11)
IF "%input%"=="7" (GOTO 17)
IF "%input%"=="8" (GOTO 26)
IF "%input%"=="9" (GOTO 27)
IF "%input%"=="10" (GOTO OEM)
IF "%input%"=="11" (GOTO CM)
IF "%input%"=="12" (GOTO 44)
IF "%input%"=="13" (GOTO 45)
IF "%input%"=="14" (GOTO 46)
IF "%input%"=="15" (GOTO 47)
IF "%input%"=="16" (GOTO FE)
if %input% GTR 10 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO UI




:E/D
cls

echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1. Enable/Disable Windows Defender Real-Time protection              
echo   2. Enable/Disable Lockscreen            
echo   3. Enable/Disable Hibernation      
echo   4. Remove shortcut arrow
echo   5. Enable/Disable Windows Smart Screen Filter   
echo   6. Disable default Quick Access view in Explorer
echo   7. Enable/Disable Snap Assist 
echo   8. Enable/Disable "You have new app that can open this file." Notification
echo   9. Enable/Disable Windows Firewall
echo   10. Manage Folders In "This PC"
echo   11. Force .net apps to always use the latest Framework version installed 
echo   12. Disable Cortana
echo   13. Hide Safely Remove Hardware Tray Icon

echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="1" (Goto 38)
IF "%input%"=="2" (GOTO 12)
IF "%input%"=="3" (GOTO 13)
IF "%input%"=="4" (GOTO 40)
IF "%input%"=="5" (GOTO 18)
IF "%input%"=="6" (GOTO 24)
IF "%input%"=="7" (GOTO 30)
IF "%input%"=="8" (GOTO 31)
IF "%input%"=="9" (GOTO 32)
IF "%input%"=="10" (GOTO This-PC)
IF "%input%"=="11" (GOTO 39)
IF "%input%"=="12" (GOTO 41)
IF "%input%"=="13" (GOTO 48)


if %input% GTR 11 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO E/D



:CM
cls

echo **************************************************************************************
echo *           ___  __   __ _  ____  ____  _  _  ____    _  _  ____  __ _  _  _         *
echo *          / __)/  \ (  ( \(_  _)(  __)( \/ )(_  _)  ( \/ )(  __)(  ( \/ )( \        *
echo *         ( (__(  O )/    /  )(   ) _)  )  (   )(    / \/ \ ) _) /    /) \/ (        *
echo *          \___)\__/ \_)__) (__) (____)(_/\_) (__)   \_)(_/(____)\_)__)\____/        *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1. Add "Grant Admin Full Control" to Files and Folders
echo   2. Add Select Context menu
echo   3. Remove Pin to Quick access
echo   4. Add classic Personalize to Desktop
echo   5. Remove Screen Resolution from Desktop
echo   6. Add Power Options to Desktop
echo   7. Add Bluetooth to Desktop
echo   8. Add Open with Notepad to Files
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (GOTO 25)
IF "%input%"=="2" (GOTO 33)
IF "%input%"=="3" (GOTO 34)
IF "%input%"=="4" (GOTO 35)
IF "%input%"=="5" (GOTO 36)
IF "%input%"=="6" (GOTO 37)
IF "%input%"=="7" (GOTO 42)
IF "%input%"=="8" (GOTO 43)


if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO CM



:FE
cls

echo **************************************************************************************
echo *        ____  __  __    ____    ____  _  _  ____  __     __  ____  ____  ____       *
echo *       (  __)(  )(  )  (  __)  (  __)( \/ )(  _ \(  )   /  \(  _ \(  __)(  _ \      *
echo *        ) _)  )( / (_/\ ) _)    ) _)  )  (  ) __// (_/\(  O ))   / ) _)  )   /      *
echo *       (__)  (__)\____/(____)  (____)(_/\_)(__)  \____/ \__/(__\_)(____)(__\_)      *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1. Manage Folders In "This PC"
echo   2. Disable the " - Shortcut" text from Shortcuts
echo   3. Add "Install" Command for CAB Files
echo   4. Enable Old Breifcase option in Folders Context menu
echo   5. 
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (GOTO This-PC)
IF "%input%"=="2" (GOTO 50)
IF "%input%"=="3" (GOTO 49)
IF "%input%"=="4" (GOTO 51)

if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO FE





:Performance
cls
echo **************************************************************************************
echo *    ____   ___    ____  ____  ____  ____  __  ____  _  _   __   __ _   ___  ____    *
echo *   (  _ \ / __)  (  _ \(  __)(  _ \(  __)/  \(  _ \( \/ ) / _\ (  ( \ / __)(  __)   *
echo *    ) __/( (__    ) __/ ) _)  )   / ) _)(  O ))   // \/ \/    \/    /( (__  ) _)    *
echo *   (__)   \___)  (__)  (____)(__\_)(__)  \__/(__\_)\_)(_/\_/\_/\_)__) \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo   ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo   บ                                                                                บ
echo   บ        Download this script and run it to measure your PC restart time:        บ
echo   บ       www.mediafire.com/download/udc678qo92m6c7x  (Enter 10 to download)       บ
echo   บ                                                                                บ
echo   ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo   1. Disable CPU Core Parking For more CPU Performance
echo   2. Speed up apps and services End Tasks
echo   3. Disable Some unnecessary services to speed up restart time
echo   4. Boost SSD Performance (Not recommended for HHD)
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="1" (GOTO 20)
IF "%input%"=="2" (GOTO 21)
IF "%input%"=="3" (GOTO 22)
IF "%input%"=="4" (GOTO 23)

IF "%input%"=="10" (Start www.mediafire.com/download/udc678qo92m6c7x
Goto Performance)
if %input% GTR 4 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO Performance



:functsuccess
cls
echo CreateObject("WScript.Shell").Popup "Operation Completed successfully.", 1.5, "Toggle Tweaker"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
GOTO :eof
GOTO Main

:1
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Dark Theme For Apps (including MicroSoft EDGE browser)
echo   2.Enable Light Theme For Apps 
echo.
echo   0.Go back to User Interface page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 1E)
IF "%input%"=="2" (GOTO 1D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 1

:1E
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "1" /f

Call :functsuccess
GOTO UI

:1D
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "0" /f

Call :functsuccess

GOTO UI



:2
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Taskview button in Taskbar   บAutomatic explorer.exe restartบ
echo   2.Disable Taskview button in Taskbar  บAutomatic explorer.exe restartบ
echo.
echo   0.Go back to User Interface page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 2E)
IF "%input%"=="2" (GOTO 2D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 2


:2E
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "1" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess

GOTO UI

:2D
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess

GOTO UI



:3
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Previous Volume Control UI
echo   2.Enable New Volume Control UI
echo.
echo   0.Go back to User Interface page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 3E)
IF "%input%"=="2" (GOTO 3D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 3

:3E
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v "EnableMtcUvc" /t REG_DWORD /d "0" /f

Call :functsuccess

GOTO UI

:3D
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v "EnableMtcUvc" /t REG_DWORD /d "1" /f

Call :functsuccess

GOTO UI


:4
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Previous Notification center UI   บAutomatic explorer.exe restart บ
echo   2.Enable new Notification center UI        บAutomatic explorer.exe restart บ
echo.
echo   0.Go back to User Interface page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 4E)
IF "%input%"=="2" (GOTO 4D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 4


:4E
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseActionCenterExperience" /t REG_DWORD /d "0" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess

GOTO UI

:4D
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseActionCenterExperience" /t REG_DWORD /d "1" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess

GOTO UI



:5
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Previous Battery Status UI
echo   2.Enable New Battery Status UI
echo.
echo   0.Go back to User Interface page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 5E)
IF "%input%"=="2" (GOTO 5D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 5

:5E
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseWin32BatteryFlyout" /t REG_DWORD /d "1" /f

Call :functsuccess

GOTO UI

:5D
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseWin32BatteryFlyout" /t REG_DWORD /d "0" /f

Call :functsuccess
GOTO UI


:6
reg add "HKCR\Applications\photoviewer.dll\shell\open" /v "MuiVerb" /t REG_SZ /d "@photoviewer.dll,-3043" /f
reg add "HKCR\Applications\photoviewer.dll\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\Applications\photoviewer.dll\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKCR\PhotoViewer.FileAssoc.Bitmap" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f
reg add "HKCR\PhotoViewer.FileAssoc.Bitmap" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f
reg add "HKCR\PhotoViewer.FileAssoc.Bitmap\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-70" /f
reg add "HKCR\PhotoViewer.FileAssoc.Bitmap\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.Bitmap\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKCR\PhotoViewer.FileAssoc.JFIF" /v "EditFlags" /t REG_DWORD /d "65536" /f
reg add "HKCR\PhotoViewer.FileAssoc.JFIF" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f
reg add "HKCR\PhotoViewer.FileAssoc.JFIF" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f
reg add "HKCR\PhotoViewer.FileAssoc.JFIF\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-72" /f
reg add "HKCR\PhotoViewer.FileAssoc.JFIF\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
reg add "HKCR\PhotoViewer.FileAssoc.JFIF\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.JFIF\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg" /v "EditFlags" /t REG_DWORD /d "65536" /f
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-72" /f
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKCR\PhotoViewer.FileAssoc.Png" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f
reg add "HKCR\PhotoViewer.FileAssoc.Png" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3057" /f
reg add "HKCR\PhotoViewer.FileAssoc.Png\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-71" /f
reg add "HKCR\PhotoViewer.FileAssoc.Png\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.Png\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKCR\PhotoViewer.FileAssoc.Gif" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f
reg add "HKCR\PhotoViewer.FileAssoc.Gif" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3057" /f
reg add "HKCR\PhotoViewer.FileAssoc.Gif\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-83" /f
reg add "HKCR\PhotoViewer.FileAssoc.Gif\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.Gif\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKCR\PhotoViewer.FileAssoc.Wdp" /v "EditFlags" /t REG_DWORD /d "65536" /f
reg add "HKCR\PhotoViewer.FileAssoc.Wdp" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f
reg add "HKCR\PhotoViewer.FileAssoc.Wdp\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\wmphoto.dll,-400" /f
reg add "HKCR\PhotoViewer.FileAssoc.Wdp\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
reg add "HKCR\PhotoViewer.FileAssoc.Wdp\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.Wdp\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationDescription" /t REG_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3069" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationName" /t REG_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3009" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".wdp" /t REG_SZ /d "PhotoViewer.FileAssoc.Wdp" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jfif" /t REG_SZ /d "PhotoViewer.FileAssoc.JFIF" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".dib" /t REG_SZ /d "PhotoViewer.FileAssoc.Bitmap" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d "PhotoViewer.FileAssoc.Png" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jxr" /t REG_SZ /d "PhotoViewer.FileAssoc.Wdp" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d "PhotoViewer.FileAssoc.Bitmap" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpe" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".gif" /t REG_SZ /d "PhotoViewer.FileAssoc.Gif" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tiff" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
Call :functsuccess

GOTO E/D

:Edge

cls

echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1. Disable Ads
echo   2. Dark/Light Theme
echo   3. Change Browser Home Button page
echo   4. Change default download directory
echo   5. Ask to close all tabs ?
echo   6. Enable Cortana inside the browser
echo   7. Enable/Disable Adobe Flash Player
echo   8. Enable/Disable Favorites Bar 
echo   9. Change NewTab Page (Limited)
echo  10. Manage Edge Data collection
echo  11. Completely uninstall MS Edge + the ability to restore it
echo  12. Disable Javascript in Edge
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="1" (Goto E1)
IF "%input%"=="2" (GOTO E2)
IF "%input%"=="3" (GOTO E3)
IF "%input%"=="4" (GOTO E4)
IF "%input%"=="5" (GOTO E5)
IF "%input%"=="6" (GOTO E6)
IF "%input%"=="7" (GOTO E7)
IF "%input%"=="8" (GOTO E8)
IF "%input%"=="9" (GOTO E9)
IF "%input%"=="10" (GOTO TM2)
IF "%input%"=="11" (GOTO E11)
IF "%input%"=="12" (GOTO E12)
if %input% GTR 9 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO Edge

:E1 

cls

echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   *-Downlod this file from this link : mediafire.com/download/a1bggsqe3fz6tpo/HOSTS
echo   *-Put the file in the same folder with this script
echo.
echo   1.Open link
echo   2.Remove ads from all your programmes including MS Edge
echo   3.Recover your old Hosts file (Enable ads)
echo.
echo   0.Go back to Edge page
echo.  
set /p input=* Write the number here:
IF "%input%"=="1" (start http://www.mediafire.com/download/a1bggsqe3fz6tpo/HOSTS
GOTO E1)
IF "%input%"=="2" (Goto DAds)
IF "%input%"=="3" (Goto EAds)
IF "%input%"=="0" (Goto Edge)
if %input% GTR 3 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO E1


:DAds
echo.
:: ------------EXTRA CODE TO CHANGE DIRECTORY-------------
echo %~n0%~x0 started from Directory: %~d0%~p0
%~d0
cd %~d0%~p0
:: -------------------------------------------------------

IF NOT EXIST HOSTS GOTO noHostsFile
IF "%OS%"=="Windows_NT" GOTO HostsFile
IF EXIST %winbootdir%\HOSTS*.* ATTRIB +A -H -R -S %winbootdir%\HOSTS*.*>NUL
IF EXIST %winbootdir%\HOSTS.MVP DEL %winbootdir%\HOSTS.MVP>NUL
IF EXIST %winbootdir%\HOSTS REN %winbootdir%\HOSTS HOSTS.MVP>NUL
IF EXIST %winbootdir%\NUL COPY /Y HOSTS %winbootdir%>NUL
GOTO noHostsFile
:HostsFile
IF EXIST %windir%\SYSTEM32\DRIVERS\ETC\HOSTS*.* ATTRIB +A -H -R -S %windir%\SYSTEM32\DRIVERS\ETC\HOSTS*.*>NUL
IF EXIST %windir%\SYSTEM32\DRIVERS\ETC\HOSTS.MVP DEL %windir%\SYSTEM32\DRIVERS\ETC\HOSTS.MVP>NUL
IF EXIST %windir%\SYSTEM32\DRIVERS\ETC\HOSTS REN %windir%\SYSTEM32\DRIVERS\ETC\HOSTS HOSTS.MVP>NUL
IF EXIST %windir%\SYSTEM32\DRIVERS\ETC\NUL COPY /Y HOSTS %windir%\SYSTEM32\DRIVERS\ETC>NUL
	color 1F
   cls
	echo.
	echo                    ษอออออออออออออออออออออออออออออออออออออออออออออออÜ
	echo                    บ                                          ษอออปบ
	echo                    บ  THE HOSTS FILE IS NOW UPDATED           บ ๛ บบ
	echo                    บ                                          ศอออผบ
	echo.                   ศอออออออออออออออออออออออออออออออออออออออออออออออผ
	echo.
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DnsCache\Parameters" /v "MaxCacheTtl" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DnsCache\Parameters" /v "MaxNegativeCacheTtl" /t REG_DWORD /d "0" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL


if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect. Previous version saved and renamed to HOSTS.MVP"> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully. Previous version saved and renamed to HOSTS.MVP"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1 >nul 2>&1
del msgbox.vbs
GOTO Edge
:noHostsFile
echo MsgBox "There is no HOSTS file in the same directory with this script."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1 >nul 2>&1
Del msgbox.vbs

Goto Edge

:EAds
if exist %WINDIR%\system32\drivers\etc\hosts.MVP (
    attrib -r "%WINDIR%\system32\drivers\etc\hosts"
    del /F /Q "%WINDIR%\system32\drivers\etc\hosts"
    ren "%WINDIR%\system32\drivers\etc\hosts.MVP" "hosts"
    attrib +r "%WINDIR%\system32\drivers\etc\hosts"
Call :functsuccess
) else (
    echo MsgBox "There is no Hosts.MVP file in this directory :  %WINDIR%\system32\drivers\etc\ "> msgbox.vbs
    cscript msgbox.vbs >nul 2>&1
    Del msgbox.vbs)
Goto Edge


:E2
Cls
echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Dark Theme
echo   2.Enable Light Theme
echo.
echo   0.Go back to Edge page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Edge)
IF "%input%"=="1" (Goto E2E)
IF "%input%"=="2" (GOTO E2D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO E2

:E2E
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "1" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge

:E2D
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "0" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge


:E3
Cls
echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   0.Go back to Edge page
echo.
set /p HomePage=* Paste your link here to make it Edge Home Button Page:
IF "%HomePage%"=="0" (Goto Edge)
Else if
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "HomeButtonPage" /t REG_SZ /d "%HomePage%" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge

:E4
Cls
echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   0.Go back to Edge page
echo   1.Bring back default Download directory
echo.
set /p Download=* Or paste your Path here to make it Edge Download irectory:
IF "%Download%"=="0" (Goto Edge)
IF "%Download%"=="1" (Goto DefaultDown)
Else if
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Default Download Directory" /t REG_SZ /d "%Download%" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge

:DefaultDown
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Default Download Directory" /t REG_SZ /d "shell:Downloads" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge


:E5
Cls
echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Asking before closing all tabs
echo   2.Disable Asking before closing all tabs
echo.
echo   0.Go back to Edge page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Edge)
IF "%input%"=="1" (Goto E5E)
IF "%input%"=="2" (GOTO E5D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO E5

:E5E
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "AskToCloseAllTabs" /t REG_DWORD /d "1" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL


cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge

:E5D
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "AskToCloseAllTabs" /t REG_DWORD /d "0" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge



:E6
Cls
echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Cortana inside the Edge browser
echo   2.Disable Cortana inside the Edge browser
echo.
echo   0.Go back to Edge page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Edge)
IF "%input%"=="1" (Goto E6E)
IF "%input%"=="2" (GOTO E6D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO E2

:E6E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "EnableCortana" /t REG_DWORD /d "1" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL


cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge

:E6D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "EnableCortana" /t REG_DWORD /d "0" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge


:E7
Cls
echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable Adobe Flash Player inside MS Edge
echo   2.Enable Adobe Flash Player inside MS Edge
echo.
echo   0.Go back to Edge page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Edge)
IF "%input%"=="1" (Goto E7D)
IF "%input%"=="2" (GOTO E7E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO E7

:E7E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Addons" /v "FlashPlayerEnabled" /t REG_DWORD /d "1" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge

:E7D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Addons" /v "FlashPlayerEnabled" /t REG_DWORD /d "0" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge


:E8
Cls
echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable Favorites Bar 
echo   2.Enable Favorites Bar
echo.
echo   0.Go back to Edge page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Edge)
IF "%input%"=="1" (Goto E8D)
IF "%input%"=="2" (GOTO E8E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO E8

:E8E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\LinksBar" /v "Enabled" /t REG_DWORD /d "1" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge

:E8D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\LinksBar" /v "Enabled" /t REG_DWORD /d "0" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge



:E9
Cls
echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Top sites and suggested content in New tab
echo   2.Top sites in New tab
echo   3.Blank page in New tab
echo.
echo   0.Go back to Edge page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Edge)
IF "%input%"=="1" (Goto E9E1)
IF "%input%"=="2" (GOTO E8E2)
IF "%input%"=="3" (GOTO E8E3)
if %input% GTR 3 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO E9

:E9E1
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "NewTabPageDisplayOption" /t REG_DWORD /d "0" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge

:E9E2
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "NewTabPageDisplayOption" /t REG_DWORD /d "1" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge

:E9E3
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "NewTabPageDisplayOption" /t REG_DWORD /d "2" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge


:E11
REM Thanks to "SuperBubble" "abbodi1406" From MDL
Cls
echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo   ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo   บ 1.ณUninstall Microsoft Edge                                                     บ
echo   บ      ฬอThis will remove Microsoft Edge completely using "install_wim_tweak"     บ
echo   บ      บ but the script will first backup all packages to restore them when neded.บ
echo   บ      ฬอIf you uninstall MS Edge twice then the packages will be removed.        บ
echo   บ      ฬอMicrosoft .NET Framework 3.5 shoold be installed.                        บ
echo   บ      ศอYou should be connected to Internet to download necessary files.         บ
echo   ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
echo   ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo   บ 2.ณRestore Microsoft Edge                                                       บ
echo   บ      ฬอThis will restore Microsoft Edge using backed up packages.If the restore บ
echo   บ      บ operation didn't work try it again then Contact Yasser Da Sila in MDL.   บ
echo   บ      ศอIf you uninstalled Edge twice you won't be able to restore it.           บ
echo   ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo   0.Go back to Edge page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Edge)
IF "%input%"=="1" (Goto E11U)
IF "%input%"=="2" (GOTO E11I)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO E11

:E11U
cls
echo Downloading necessary files... 
cd /d "%~dp0"
Set CurCD=%CD%
MKDIR "%HOMEDRIVE%\TW\"
attrib +h %HOMEDRIVE%\TW
cd %HOMEDRIVE%\TW

ping -n 1 drive.google.com >nul
if errorlevel 1 (
  cls
   echo  Check your Internet so that the script can download necessary files...
   ping 127.0.0.1 -n 3 > NUL 2>&1
  goto Edge
)
REM EDGETW.zip
echo strFileURL = "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiMXVVeklkeU8wcEk" > EDGETW.vbs
echo     strHDLocation = "%CD%\EDGETW.zip" >> EDGETW.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> EDGETW.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> EDGETW.vbs
echo objXMLHTTP.send() >> EDGETW.vbs
echo If objXMLHTTP.Status = 200 Then >> EDGETW.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> EDGETW.vbs
echo objADOStream.Open>> EDGETW.vbs
echo objADOStream.Type = 1 >> EDGETW.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> EDGETW.vbs
echo objADOStream.Position = 0    >> EDGETW.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> EDGETW.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> EDGETW.vbs
echo Set objFSO = Nothing >> EDGETW.vbs
echo objADOStream.SaveToFile strHDLocation >> EDGETW.vbs
echo objADOStream.Close >> EDGETW.vbs
echo Set objADOStream = Nothing >> EDGETW.vbs
echo End if >> EDGETW.vbs
echo Set objXMLHTTP = Nothing >> EDGETW.vbs
cscript EDGETW.vbs >nul 2>&1
del EDGETW.vbs

REM This script upzip's files...

    > j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO ' UnZip a file script
    >> j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO ' It's a mess, I know!!!
    >> j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO ' Dim ArgObj, var1, var2
    >> j_unzip.vbs ECHO Set ArgObj = WScript.Arguments
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If (Wscript.Arguments.Count ^> 0) Then
    >> j_unzip.vbs ECHO. var1 = ArgObj(0)
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. var1 = ""
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If var1 = "" then
    >> j_unzip.vbs ECHO. strFileZIP = "example.zip"
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. strFileZIP = var1
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO 'The location of the zip file.
    >> j_unzip.vbs ECHO REM Set WshShell = CreateObject("Wscript.Shell")
    >> j_unzip.vbs ECHO REM CurDir = WshShell.ExpandEnvironmentStrings("%%cd%%")
    >> j_unzip.vbs ECHO Dim sCurPath
    >> j_unzip.vbs ECHO sCurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
    >> j_unzip.vbs ECHO strZipFile = sCurPath ^& "\" ^& strFileZIP
    >> j_unzip.vbs ECHO 'The folder the contents should be extracted to.
    >> j_unzip.vbs ECHO outFolder = sCurPath ^& "\"
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracting file " ^& strFileZIP)
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO Set objShell = CreateObject( "Shell.Application" )
    >> j_unzip.vbs ECHO Set objSource = objShell.NameSpace(strZipFile).Items()
    >> j_unzip.vbs ECHO Set objTarget = objShell.NameSpace(outFolder)
    >> j_unzip.vbs ECHO intOptions = 256
    >> j_unzip.vbs ECHO objTarget.CopyHere objSource, intOptions
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracted." )
    >> j_unzip.vbs ECHO.

cscript /B j_unzip.vbs EDGETW.zip
del j_unzip.vbs



cd %CurCD%
for /f "tokens=2 delims==" %%A in ('wmic path Win32_Processor Get AddressWidth /format:list') do (set OA=%%A)
net start trustedinstaller

"%HOMEDRIVE%\TW\runassystem%OA%" "%HOMEDRIVE%\TW\runfromtoken%OA% trustedinstaller.exe 1 %HOMEDRIVE%\TW\Packages.cmd"

Goto Edge


:E11I
cls
sc stop wuauserv >nul 2>&1
dism /online /add-package /packagepath:%HOMEDRIVE%\EdgeTW
dism /online /add-package /packagepath:%HOMEDRIVE%\EdgeTW
echo CreateObject("WScript.Shell").Popup "Microsoft Edge should be installed, If not try reinstalling it again.", 3.5, "Toggle Tweaker"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto Edge


:E12
Cls
echo **************************************************************************************
echo *     _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____     *
echo *    ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)    *
echo *    / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)     *
echo *    \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable Javascript in Edge
echo   2.Enable Javascript in Edge
echo.
echo   0.Go back to Edge page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Edge)
IF "%input%"=="1" (Goto E12D)
IF "%input%"=="2" (GOTO E12E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO E12

:E12E
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Internet Settings\Zones\3" /v "1400" /t REG_DWORD /d "0" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL


cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge

:E12D
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Internet Settings\Zones\3" /v "1400" /t REG_DWORD /d "2" /f
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL

cls
if "%ERRORLEVEL%"=="0" echo MsgBox "MS Edge is running, you need to restart it so that changes takes effect."> msgbox.vbs
if "%ERRORLEVEL%"=="1" echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
del msgbox.vbs
GOTO Edge




:Update

cls

echo **************************************************************************************
echo *     _  _  __  __ _  ____   __   _  _  ____    _  _  ____  ____   __  ____  ____    *
echo *    / )( \(  )(  ( \(    \ /  \ / )( \/ ___)  / )( \(  _ \(    \ / _\(_  _)(  __)   *
echo *    \ /\ / )( /    / ) D ((  O )\ /\ /\___ \  ) \/ ( ) __/ ) D (/    \ )(   ) _)    *
echo *    (_/\_)(__)\_)__)(____/ \__/ (_/\_)(____/  \____/(__)  (____/\_/\_/(__) (____)   *
echo *                                                                                    *
echo **************************************************************************************
echo   1. Clean Windows Update Junk (Highly Recommended)                 00.Disable all
echo   2. Disable Automatic Windows Updates
echo   3. Enable Automatic Windows Updates (Recommended)
echo   4. Disable Automatic Windows Apps Updates
echo   5. Enable Automatic Windows Apps Updates
echo   6. Disable Notifications about new Preview Builds
echo   7. Enable Notifications about new Preview Builds
echo   8. Disable Automatic Driver updates through Windows Update
echo   9. Enable Automatic Driver updates through Windows Update
echo  10. Enable/Disable Windows Delivery Optimization (Update sharing)
echo  11. Enable deferring of upgrades
echo  12. Disable deferring of upgrades
echo  13. Disable Windows Updates for other MS products (MS Office)
echo  14. Enable Windows Updates for other MS products (MS Office)
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="00" (Goto U00)
IF "%input%"=="1" (Goto U0)
IF "%input%"=="2" (Goto U1)
IF "%input%"=="3" (GOTO U2)
IF "%input%"=="4" (GOTO U3)
IF "%input%"=="5" (GOTO U4)
IF "%input%"=="6" (GOTO U5)
IF "%input%"=="7" (GOTO U6)
IF "%input%"=="8" (GOTO U8)
IF "%input%"=="9" (GOTO U9)
IF "%input%"=="10" (GOTO U10)
IF "%input%"=="11" (GOTO U11)
IF "%input%"=="12" (GOTO U12)
IF "%input%"=="13" (GOTO U13)
IF "%input%"=="14" (GOTO U14)
if %input% GTR 7 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO Update

:U0
cls

set Dir="%Windir%\SoftwareDistribution\Download"
for /f "tokens=1,3" %%a in ('dir /w /s /-c %Dir% ^| findstr "File(s)"') do set bytes=%%b
set /a KB=(%bytes% /1024)
set /a MB=(%KB% /1024)
set /a GB=(%MB% /1024)

echo MsgBox "You have %MB% Mb (%GB% GB) Update Junk need to be cleaned."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

:startclean
net stop wuauserv
net stop bits

PUSHD %Windir%\SoftwareDistribution\Download

if not '%cd%'=='%Windir%\SoftwareDistribution\Download' (
goto startclean
)

RMDIR /S /Q "%Windir%\SoftwareDistribution\Download\"
MKDIR "%Windir%\SoftwareDistribution\Download\"

POPD

Dism.exe /online /Cleanup-Image /StartComponentCleanup

net start wuauserv
net start bits

for /f "tokens=1,3" %%a in ('dir /w /s /-c %Dir% ^| findstr "File(s)"') do set bytes2=%%b
set /a KB2=(%bytes2% /1024)
set /a MB2=(%KB2% /1024)
set /a GB2=(%MB2% /1024)

set /a SIZEMB=%MB%-%MB2%
set /a SIZEGB=%GB%-%GB2%

cls
echo MsgBox "You have cleaned %SIZEMB% Mb (%SIZEGB% GB)."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update

:U1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update

:U2
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "0" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update

:U3
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d "2" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update

:U4
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d "4" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update

:U5
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "EnablePreviewBuilds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "ThresholdFlightsDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "Ring" /t REG_SZ /d "Disabled" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update

:U6
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "EnablePreviewBuilds" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "ThresholdFlightsDisabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "Ring" /t REG_SZ /d "Enabled" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update


:U8
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d "1" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update


:U9
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d "0" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update



:U10
Cls
echo **************************************************************************************
echo *     _  _  __  __ _  ____   __   _  _  ____    _  _  ____  ____   __  ____  ____    *
echo *    / )( \(  )(  ( \(    \ /  \ / )( \/ ___)  / )( \(  _ \(    \ / _\(_  _)(  __)   *
echo *    \ /\ / )( /    / ) D ((  O )\ /\ /\___ \  ) \/ ( ) __/ ) D (/    \ )(   ) _)    *
echo *    (_/\_)(__)\_)__)(____/ \__/ (_/\_)(____/  \____/(__)  (____/\_/\_/(__) (____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable Windows Update Sharing
echo   2.Enable Windows Update Sharing For PCs on my local network
echo   3.Enable Windows Update Sharing For PCs on the Internet and on my local network
echo.
echo   0.Go back to Update page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Update)
IF "%input%"=="1" (Goto U10D)
IF "%input%"=="2" (GOTO U10E)
IF "%input%"=="3" (GOTO U10I)
if %input% GTR 3 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO U10

:U10D
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "0" /f

sc config DoSvc start= disabled

Call :functsuccess
GOTO Update

:U10E
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "1" /f
sc config DoSvc start= auto

Call :functsuccess
GOTO Update

:U10I
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "3" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "1" /f
sc config DoSvc start= auto

Call :functsuccess
GOTO Update

:U11
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgrade" /t REG_DWORD /d "1" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update


:U12
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgrade" /t REG_DWORD /d "0" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update

:U13
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\7971f918-a847-4430-9279-4a52d1efe18d" /v "RegisteredWithAU" /t REG_DWORD /d "0" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update


:U14
Reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\7971f918-a847-4430-9279-4a52d1efe18d" /v "RegisteredWithAU" /f

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update


:U00
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "EnablePreviewBuilds" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "ThresholdFlightsDisabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "Ring" /t REG_SZ /d "Disabled" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgrade" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\7971f918-a847-4430-9279-4a52d1efe18d" /v "RegisteredWithAU" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "0" /f
sc config DoSvc start= disabled


cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Update


:This-PC

cls

echo **************************************************************************************
echo *  ____  _  _  __  ____      ____   ___    ____  __   __    ____  ____  ____  ____   *
echo * (_  _)/ )( \(  )/ ___) ___(  _ \ / __)  (  __)/  \ (  )  (    \(  __)(  _ \/ ___)  *
echo *   )(  ) __ ( )( \___ \(___)) __/( (__    ) _)(  O )/ (_/\ ) D ( ) _)  )   /\___ \  *
echo *  (__) \_)(_/(__)(____/    (__)   \___)  (__)  \__/ \____/(____/(____)(__\_)(____/  *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo    บบบAutomatic explorer.exe restart บบบ
echo.
echo   *. Downloads  (Enter 1 to Remove Or 2 to add)
echo   *. Pictures   (Enter 3 to Remove Or 4 to add)
echo   *. Music      (Enter 5 to Remove Or 6 to add)
echo   *. Desktop    (Enter 7 to Remove Or 8 to add)
echo   *. Documents  (Enter 9 to Remove Or 10 to add)
echo   *. Videos     (Enter 11 to Remove Or 12 to add)
echo.
echo   *. Enter 13 to Remove All Folders From This PC
echo   *. Enter 14 to Add All Folders to This PC
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto FE)
IF "%input%"=="1" (Goto F1)
IF "%input%"=="2" (GOTO F2)
IF "%input%"=="3" (GOTO F3)
IF "%input%"=="4" (GOTO F4)
IF "%input%"=="5" (GOTO F5)
IF "%input%"=="6" (GOTO F6)
IF "%input%"=="7" (GOTO F7)
IF "%input%"=="8" (GOTO F8)
IF "%input%"=="9" (GOTO F9)
IF "%input%"=="10" (GOTO F10)
IF "%input%"=="11" (GOTO F11)
IF "%input%"=="12" (GOTO F12)
IF "%input%"=="13" (GOTO F13)
IF "%input%"=="14" (GOTO F14)
if %input% GTR 14 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO This-PC

:F1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F2
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F3
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F4
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F5
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F6
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F7
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F8
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F9
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F10
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F11
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC

:F12
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC


:F13
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f


taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC


:F14
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f

taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO This-PC





:11
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Cortana SerchBox in Taskbar  บAutomatic explorer.exe restart บ
echo   2.Enable Cortana icon in Taskbar      บAutomatic explorer.exe restart บ
echo   3.Disable Cortana in Taskbar          บAutomatic explorer.exe restart บ
echo.
echo   0.Go back to User Interface page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 11E)
IF "%input%"=="2" (GOTO 11O)
IF "%input%"=="3" (GOTO 11D)
if %input% GTR 3 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 11

:11E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "2" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO UI

:11O
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "1" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO UI

:11D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO UI

:12
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable lock screen
echo   2.Enable lock screen
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 12D)
IF "%input%"=="2" (GOTO 12E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 12

:12E
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d "0" /f

Call :functsuccess
GOTO E/D

:12D
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d "1" /f

Call :functsuccess
GOTO E/D


:13
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Hibernation
echo   2.Disable Hibernation
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 13E)
IF "%input%"=="2" (GOTO 13D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 13

:13E
powercfg -h on

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO E/D

:13D
powercfg -h off

cls
echo MsgBox "Operation Completed successfully, you need to restart so that changes takes effect."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO E/D


:OD
Cls
echo **************************************************************************************
echo * _  _   __   __ _   __    ___  ____     __   __ _  ____  ____  ____  __  _  _  ____ *
echo *( \/ ) / _\ (  ( \ / _\  / __)(  __)   /  \ (  ( \(  __)(    \(  _ \(  )/ )( \(  __)*
echo */ \/ \/    \/    //    \( (_ \ ) _)   (  O )/    / ) _)  ) D ( )   / )( \ \/ / ) _) *
echo *\_)(_/\_/\_/\_)__)\_/\_/ \___/(____)   \__/ \_)__)(____)(____/(__\_)(__) \__/ (____)*
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable Onedrive
echo   2.Enable Onedrive
echo   3.Remove Onedrive/Dropbox Icon in File explorer
echo   4.Disable and delete Ondrive ...
echo   *This feature can't be Enable again from this script if you Disable it
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto OD1)
IF "%input%"=="2" (GOTO OD2)
IF "%input%"=="3" (GOTO OD3)
IF "%input%"=="4" (GOTO OD4)
if %input% GTR 4 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO OD

:OD1
TASKKILL /F /IM OneDrive.exe /T 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f 
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f


Call :functsuccess
GOTO OD


:OD2
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" / v "DisableFileSyncNGSC" / f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" / v "DisableLibrariesDefaultSaveToOneDrive" / f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" / v "DisableMeteredNetworkFileSync" / f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" / v "DisableFileSyncNGSC" / f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" / v "DisableLibrariesDefaultSaveToOneDrive" / f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" / v "DisableMeteredNetworkFileSync" / f 
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" / v "System.IsPinnedToNameSpaceTree" / t REG_DWORD / d 1 / f 
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" / v "System.IsPinnedToNameSpaceTree" / t REG_DWORD / d 1 / f 
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" / v "System.IsPinnedToNameSpaceTree" / t REG_DWORD / d 1 / f 
reg add "HKEY_CURRENT_USER\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" / v "System.IsPinnedToNameSpaceTree" / t REG_DWORD / d 1 / f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" / v "OneDrive" / t REG_SZ / d "\"% USERPROFILE% \ AppData \ Local \ Microsoft \ OneDrive \ OneDrive.exe \ "/ background" / f

Call :functsuccess
GOTO OD

:OD3
Cls
echo **************************************************************************************
echo * _  _   __   __ _   __    ___  ____     __   __ _  ____  ____  ____  __  _  _  ____ *
echo *( \/ ) / _\ (  ( \ / _\  / __)(  __)   /  \ (  ( \(  __)(    \(  _ \(  )/ )( \(  __)*
echo */ \/ \/    \/    //    \( (_ \ ) _)   (  O )/    / ) _)  ) D ( )   / )( \ \/ / ) _) *
echo *\_)(_/\_/\_/\_)__)\_/\_/ \___/(____)   \__/ \_)__)(____)(____/(__\_)(__) \__/ (____)*
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Remove Onedrive Icon From Windows Explorer
echo   2.Remove Dropbox Icon From Windows Explorer
echo   3.Add Onedrive Icon To Windows Explorer
echo   4.Add Dropbox Icon To Windows Explorer
echo.
echo   0.Go back to Onedrive page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto OD)
IF "%input%"=="1" (Goto 14OD)
IF "%input%"=="2" (GOTO 14DD)
IF "%input%"=="3" (Goto 14OE)
IF "%input%"=="4" (GOTO 14DE)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO OD3

:14OD
Reg.exe add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f


Call :functsuccess
GOTO OD

:14DD
Reg.exe add "HKCR\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f

Call :functsuccess
GOTO OD

:14OE
Reg.exe add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f


Call :functsuccess
GOTO OD

:14DE
Reg.exe add "HKCR\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f

Call :functsuccess
GOTO OD


:OD4
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
echo.
echo Closing OneDrive process.
echo.
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 1,5 > NUL 2>&1

echo Uninstalling OneDrive.
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 1,5 > NUL 2>&1

echo Removing OneDrive leftovers.
echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "%systemroot%/Users/%username%/OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 
rd "%Windir%\SysWOW64" /Q /S > NUL 2>&1 
TASKKILL /F /IM OneDrive.exe /T 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f 
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f
takeown /F %Windir%\SysWOW64\OneDriveSetup.exe
icacls %Windir%\SysWOW64\OneDriveSetup.exe /grant Administrators:F
del %Windir%\SysWOW64\OneDriveSetup.exe
takeown /F %Windir%\SysWOW64\OneDriveSettingSyncProvider.dll
icacls %Windir%\SysWOW64\OneDriveSettingSyncProvider.dll /grant Administrators:F
del %Windir%\SysWOW64\OneDriveSettingSyncProvider.dll
Del %AppData%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk 

echo Removeing OneDrive from the Explorer Side Panel.
echo.
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1

Call :functsuccess
GOTO OD



:17
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo    บบบAutomatic explorer.exe restart บบบ
echo.
echo   1.Enable Transparency and Blur in : Taskbar-Notification center-Clock...
echo   2.Disable Transparency and Blur
echo.
echo   0.Go back to User Interface page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 17D)
IF "%input%"=="2" (GOTO 17E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 17

:17E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableBlurBehind" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO UI

:17D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableBlurBehind" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "1" /f
taskkill /IM explorer.exe /F & explorer.exe

Call :functsuccess
GOTO UI




:18
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Windows/Store Smart Screen Filter
echo   2.Disable Windows/Store Smart Screen Filter
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 18E)
IF "%input%"=="2" (GOTO 18D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 18


:18E
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Prompt" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "1" /f

Call :functsuccess
GOTO E/D


:18D
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f

Call :functsuccess
GOTO E/D



:20
Cls
echo **************************************************************************************
echo *    ____   ___    ____  ____  ____  ____  __  ____  _  _   __   __ _   ___  ____    *
echo *   (  _ \ / __)  (  _ \(  __)(  _ \(  __)/  \(  _ \( \/ ) / _\ (  ( \ / __)(  __)   *
echo *    ) __/( (__    ) __/ ) _)  )   / ) _)(  O ))   // \/ \/    \/    /( (__  ) _)    *
echo *   (__)   \___)  (__)  (____)(__\_)(__)  \__/(__\_)\_)(_/\_/\_/\_)__) \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo   ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo   บ                                                                                บ
echo   บ        Core parking is when a core of a CPU is stopped to save power,          บ
echo   บ However, if it's not managed correctly so game performance can degrade though. บ
echo   บ                                                                                บ
echo   ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
echo   1.Show Performance Benchmark 
echo   2.Disable Core parking
echo   3.50% of available cores always remain unparked
echo   4.only 25% of available cores remain active at all times
echo.
echo   0.Go back to Performance page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Performance)
IF "%input%"=="1" (Goto 20S)
IF "%input%"=="2" (GOTO 20D)
IF "%input%"=="3" (Goto 20E50)
IF "%input%"=="4" (GOTO 20E75)
if %input% GTR 4 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 20

:20S
start http://www.xtremehardware.com/images/stories/Intel/CPU_Parking_MOD/winrar_4.01.jpg

GOTO 20

:20D
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100
powercfg -setactive scheme_current

Call :functsuccess
GOTO Performance

:20E50

powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 50
powercfg -setactive scheme_current

Call :functsuccess
GOTO Performance

:20E75

powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 25
powercfg -setactive scheme_current

Call :functsuccess
GOTO Performance

:21
Cls
echo **************************************************************************************
echo *    ____   ___    ____  ____  ____  ____  __  ____  _  _   __   __ _   ___  ____    *
echo *   (  _ \ / __)  (  _ \(  __)(  _ \(  __)/  \(  _ \( \/ ) / _\ (  ( \ / __)(  __)   *
echo *    ) __/( (__    ) __/ ) _)  )   / ) _)(  O ))   // \/ \/    \/    /( (__  ) _)    *
echo *   (__)   \___)  (__)  (____)(__\_)(__)  \__/(__\_)\_)(_/\_/\_/\_)__) \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Speed up App Services End Tasks
echo   2.Restore Default settings
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 21D)
IF "%input%"=="2" (GOTO 21E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 21

:21D
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d "0" /f
Call :functsuccess
GOTO Performance

:21E
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "5000" /f
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "10000" /f
reg add "HKLM\System\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "10000" /f
Call :functsuccess
GOTO Performance

:22
Cls
echo **************************************************************************************
echo *    ____   ___    ____  ____  ____  ____  __  ____  _  _   __   __ _   ___  ____    *
echo *   (  _ \ / __)  (  _ \(  __)(  _ \(  __)/  \(  _ \( \/ ) / _\ (  ( \ / __)(  __)   *
echo *    ) __/( (__    ) __/ ) _)  )   / ) _)(  O ))   // \/ \/    \/    /( (__  ) _)    *
echo *   (__)   \___)  (__)  (____)(__\_)(__)  \__/(__\_)\_)(_/\_/\_/\_)__) \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo   ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo   บ        WARNING: playing with Windows Services is for advanced user only        บ
echo   ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo   ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo                                                           ษออออออออออออออออออออออออป
echo                                                           บ                        บ
echo   *.Files related services:(BitLocker ,Encrypting         บ  1=Disable _ 2=Enable  บ
echo     ,Offline Files  ,Network Shared Folders)              บ                        บ  
echo   *.Network related                                       บ  3=Disable _ 4=Enable  บ
echo   *.Windows WIFI service                                  บ  5=Disable _ 6=Enable  บ
echo   *.Other unnecessary services                            บ  7=Disable _ 8=Enable  บ
echo   *.All services in this section (except WIFI)            บ  9=Disable _ 10=Enable บ
echo                                                           บ                        บ
echo                                                           ศออออออออออออออออออออออออผ
echo   0.Go back to Performance page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Performance)
IF "%input%"=="1" (Goto S1f)
IF "%input%"=="2" (GOTO S2F)
IF "%input%"=="3" (Goto S3N)
IF "%input%"=="4" (GOTO S4N)
IF "%input%"=="5" (Goto S5W)
IF "%input%"=="6" (GOTO S6W)
IF "%input%"=="7" (Goto S7O)
IF "%input%"=="8" (GOTO S8O)
IF "%input%"=="9" (Goto S9A)
IF "%input%"=="10" (GOTO S10A)
if %input% GTR 10 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 22

:S1f
sc config BDESVC start= disabled
sc config EFS start= disabled
sc config CscService start= disabled
sc config LanmanServer start= disabled

Call :functsuccess
GOTO Performance

:S2f
sc config BDESVC start= auto
sc config EFS start= auto
sc config CscService start= auto
sc config LanmanServer start= auto

Call :functsuccess
GOTO Performance

:S3N
sc config ALG start= disabled
sc config IKEEXT start= disabled
sc config SstpSvc start= disabled
sc config SSDPSRV start= disabled 
sc config WebClient start= disabled 
sc config WMPNetworkSvc start= disabled 
Call :functsuccess
GOTO Performance

:S4N
sc config ALG start= auto
sc config IKEEXT start= auto
sc config SstpSvc start= auto
sc config SSDPSRV start= auto 
sc config WebClient start= auto 
sc config WMPNetworkSvc start= auto 
Call :functsuccess
GOTO Performance

:S5W
sc config WlanSvc start= disabled
Call :functsuccess
GOTO Performance

:S6W
sc config WlanSvc start= auto
Call :functsuccess
GOTO Performance


:S7O
sc config dmwappushservice start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config TrkWks start= disabled
sc config CertPropSvc start= disabled
sc config DPS start= disabled
sc config iphlpsvc start= disabled
sc config PcaSvc start= disabled
sc config RemoteRegistry start= disabled
sc config WinHttpAutoProxySvc start= disabled
sc config WPDBusEnum start= disabled
sc config AJRouter start= disabled
sc config XboxNetApiSvc start= disabled
sc config KeyIso start= disabled
sc config MSDTC start= disabled
sc config PolicyAgent start= disabled
sc config WbioSrvc start= disabled
Call :functsuccess
GOTO Performance


:S8O
sc config dmwappushservice start= auto
sc config diagnosticshub.standardcollector.service start= auto
sc config TrkWks start= auto
sc config CertPropSvc start= auto
sc config DPS start= auto
sc config iphlpsvc start= auto
sc config PcaSvc start= auto
sc config RemoteRegistry start= auto
sc config WinHttpAutoProxySvc start= auto
sc config WPDBusEnum start= auto
sc config AJRouter start= auto
sc config XboxNetApiSvc start= auto
sc config KeyIso start= auto
sc config MSDTC start= auto
sc config PolicyAgent start= auto
sc config WbioSrvc start= auto
Call :functsuccess
GOTO Performance

:S9A
sc config BDESVC start= disabled
sc config EFS start= disabled
sc config CscService start= disabled
sc config LanmanServer start= disabled
sc config ALG start= disabled
sc config IKEEXT start= disabled
sc config SstpSvc start= disabled
sc config SSDPSRV start= disabled 
sc config WebClient start= disabled 
sc config WMPNetworkSvc start= disabled 
sc config dmwappushservice start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config TrkWks start= disabled
sc config CertPropSvc start= disabled
sc config DPS start= disabled
sc config iphlpsvc start= disabled
sc config PcaSvc start= disabled
sc config RemoteRegistry start= disabled
sc config WinHttpAutoProxySvc start= disabled
sc config WPDBusEnum start= disabled
sc config AJRouter start= disabled
sc config XboxNetApiSvc start= disabled
sc config KeyIso start= disabled
sc config MSDTC start= disabled
sc config PolicyAgent start= disabled
sc config WbioSrvc start= disabled
Call :functsuccess
GOTO Performance

:S10A
sc config BDESVC start= auto
sc config EFS start= auto
sc config CscService start= auto
sc config LanmanServer start= auto
sc config ALG start= auto
sc config IKEEXT start= auto
sc config SstpSvc start= auto
sc config SSDPSRV start= auto 
sc config WebClient start= auto 
sc config WMPNetworkSvc start= auto 
sc config dmwappushservice start= auto
sc config diagnosticshub.standardcollector.service start= auto
sc config TrkWks start= auto
sc config CertPropSvc start= auto
sc config DPS start= auto
sc config iphlpsvc start= auto
sc config PcaSvc start= auto
sc config RemoteRegistry start= auto
sc config WinHttpAutoProxySvc start= auto
sc config WPDBusEnum start= auto
sc config AJRouter start= auto
sc config XboxNetApiSvc start= auto
sc config KeyIso start= auto
sc config MSDTC start= auto
sc config PolicyAgent start= auto
sc config WbioSrvc start= auto
Call :functsuccess
GOTO Performance


:23
Cls
echo **************************************************************************************
echo *    ____   ___    ____  ____  ____  ____  __  ____  _  _   __   __ _   ___  ____    *
echo *   (  _ \ / __)  (  _ \(  __)(  _ \(  __)/  \(  _ \( \/ ) / _\ (  ( \ / __)(  __)   *
echo *    ) __/( (__    ) __/ ) _)  )   / ) _)(  O ))   // \/ \/    \/    /( (__  ) _)    *
echo *   (__)   \___)  (__)  (____)(__\_)(__)  \__/(__\_)\_)(_/\_/\_/\_)__) \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo   ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo   บ                  For SSD users Only ! Not recommended for HDD                   บ
echo   ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo                                     ษออออออออออออออออออออออออป
echo                                     บ                        บ
echo   *.Superfetch and Prefetch         บ  1=Disable _ 2=Enable  บ
echo   *.ReadyBoot                       บ  3=Disable _ 4=Enable  บ
echo   *.Bing on Search                  บ  5=Disable _ 6=Enable  บ
echo   *.Disk Defragmentation            บ  7=Disable _ 8=Enable  บ
echo   *.System files compression        บ  9=Disable _ 10=Enable บ
echo   *.All services in this section    บ 11=Disable _ 12=Enable บ
echo                                     บ                        บ
echo                                     ศออออออออออออออออออออออออผ
echo   0.Go back to Performance page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Performance)
IF "%input%"=="1" (Goto S1)
IF "%input%"=="2" (GOTO S2)
IF "%input%"=="3" (Goto S3)
IF "%input%"=="4" (GOTO S4)
IF "%input%"=="5" (Goto S5)
IF "%input%"=="6" (GOTO S6)
IF "%input%"=="7" (Goto S7)
IF "%input%"=="8" (GOTO S8)
IF "%input%"=="9" (GOTO S9)
IF "%input%"=="10" (GOTO S10)
IF "%input%"=="11" (Goto S11)
IF "%input%"=="12" (GOTO S12)
if %input% GTR 10 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 23

:S1
sc config SysMain start= disabled
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f

cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23

:S2
sc config SysMain start= auto
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "3" /f

cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23

:S3
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d "0" /f      
cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23

:S4
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d "1" /f      
cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23


:S5
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23

:S6
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f
cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23

:S7
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "OptimizeComplete" /t REG_SZ /d "No" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "Enable" /t REG_SZ /d "N" /f
cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23

:S8
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "OptimizeComplete" /t REG_SZ /d "Yes" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "Enable" /t REG_SZ /d "Y" /f
cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23

:S9
compact /CompactOs:never
cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23

:SS10
compact /CompactOs:always
cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23

:S11
sc config SysMain start= disabled
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d "0" /f      
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "OptimizeComplete" /t REG_SZ /d "No" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "Enable" /t REG_SZ /d "N" /f
compact /CompactOs:never

cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23

:S12
sc config SysMain start= auto
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "3" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d "1" /f      
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "OptimizeComplete" /t REG_SZ /d "Yes" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "Enable" /t REG_SZ /d "Y" /f
compact /CompactOs:always

cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
Goto 23


:24
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable default Quick Access view in Explorer
echo   2.Enable default Quick Access view in Explorer
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 24D)
IF "%input%"=="2" (GOTO 24E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 24

:24D
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "LaunchTo" /t REG_DWORD /d 1
Call :functsuccess
GOTO E/D

:24E
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "LaunchTo" /t REG_DWORD /d 2
Call :functsuccess
GOTO E/D



:25
Cls
echo **************************************************************************************
echo *           ___  __   __ _  ____  ____  _  _  ____    _  _  ____  __ _  _  _         *
echo *          / __)/  \ (  ( \(_  _)(  __)( \/ )(_  _)  ( \/ )(  __)(  ( \/ )( \        *
echo *         ( (__(  O )/    /  )(   ) _)  )  (   )(    / \/ \ ) _) /    /) \/ (        *
echo *          \___)\__/ \_)__) (__) (____)(_/\_) (__)   \_)(_/(____)\_)__)\____/        *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Add "Grant Admin Full Control" in files context menu
echo   2.Remove "Grant Admin Full Control" From files context menu
echo.
echo   0.Go back to Context menu page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto CM)
IF "%input%"=="1" (Goto 25E)
IF "%input%"=="2" (GOTO 25D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 25

:25E
Reg.exe add "HKCR\*\shell\runas" /ve /t REG_SZ /d "Grant Admin Full Control" /f
Reg.exe add "HKCR\*\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
Reg.exe add "HKCR\*\shell\runas" /v "icon" /t REG_SZ /d "%SystemRoot%\system32\imageres.dll ,73" /f
Reg.exe add "HKCR\*\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
Reg.exe add "HKCR\*\shell\runas\command" /v "IsolatedCommand" /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
Reg.exe add "HKCR\exefile\shell\runas2" /ve /t REG_SZ /d "Grant Admin Full Control" /f
Reg.exe add "HKCR\exefile\shell\runas2" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
Reg.exe add "HKCR\exefile\shell\runas2" /v "icon" /t REG_SZ /d "%SystemRoot%\system32\imageres.dll ,73" /f
Reg.exe add "HKCR\exefile\shell\runas2\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
Reg.exe add "HKCR\exefile\shell\runas2\command" /v "IsolatedCommand" /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
Reg.exe add "HKCR\Directory\shell\runas" /ve /t REG_SZ /d "Grant Admin Full Control" /f
Reg.exe add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
Reg.exe add "HKCR\Directory\shell\runas" /v "icon" /t REG_SZ /d "%SystemRoot%\system32\imageres.dll ,73" /f
Reg.exe add "HKCR\Directory\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
Reg.exe add "HKCR\Directory\shell\runas\command" /v "IsolatedCommand" /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
Call :functsuccess
GOTO CM

:25D
Reg.exe delete "HKCR\*\shell\runas" /f
Reg.exe delete "HKCR\exefile\shell\runas2" /f
Reg.exe delete "HKCR\Directory\shell\runas" /f
Call :functsuccess
GOTO CM

:26
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable Logon screen Background Image and replace it with your accent color
echo   2.Enable Logon screen Background Image
echo.
echo   0.Go back to User Interface page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 26D)
IF "%input%"=="2" (GOTO 26E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 26

:26D
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "DisableLogonBackgroundImage" /t REG_DWORD /d "1" /f

Call :functsuccess
GOTO UI

:26E
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "DisableLogonBackgroundImage" /t REG_DWORD /d "0" /f

Call :functsuccess
GOTO UI


:27
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Thumbnail Previews in File explorer   บAutomatic explorer.exe restartบ
echo   2.Disable Thumbnail Previews in File explorer  บAutomatic explorer.exe restartบ
echo.
echo   0.Go back to User Interface page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 27E)
IF "%input%"=="2" (GOTO 27D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 27

:27E
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V IconsOnly /T REG_DWORD /D 0 /F
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO UI

:27D
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V IconsOnly /T REG_DWORD /D 1 /F
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO UI  


:28
Cls
echo **************************************************************************************
echo *    ____   ___    ____  ____  ____  ____  __  ____  _  _   __   __ _   ___  ____    *
echo *   (  _ \ / __)  (  _ \(  __)(  _ \(  __)/  \(  _ \( \/ ) / _\ (  ( \ / __)(  __)   *
echo *    ) __/( (__    ) __/ ) _)  )   / ) _)(  O ))   // \/ \/    \/    /( (__  ) _)    *
echo *   (__)   \___)  (__)  (____)(__\_)(__)  \__/(__\_)\_)(_/\_/\_/\_)__) \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo   ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo   บ                                                                                บ
echo   บ  Fast startup  is a setting that helps your PC start up faster after shutdown. บ
echo   บ Windows does this by saving system info to a file (hiberfil.sys) upon shutdown บ
echo   บ    so when you start your PC again, Windows uses that system info to resume    บ
echo   บ                         your PC instead of restarting it.                      บ
echo   บ                                                                                บ
echo   ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
echo   1.Show Performance Benchmark 
echo   2.Enable Fast Startup
echo   3.Disable Fast Startup
echo.
echo   0.Go back to Performance page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Performance)
IF "%input%"=="1" (Goto 28S)
IF "%input%"=="2" (GOTO 28E)
IF "%input%"=="3" (Goto 28D)
if %input% GTR 3 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 28

:28S
start http://www.tenforums.com/attachments/tutorials/12681d1424033491-fast-startup-turn-off-windows-10-a-cold_hybridboot.png

GOTO 28

:28D
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f
Call :functsuccess
GOTO Performance

:28E

Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "1" /f

Call :functsuccess
GOTO Performance


:30
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable Snap Assist   บAutomatic explorer.exe restartบ
echo   2.Enable Snap Assist    บAutomatic explorer.exe restartบ
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 30D)
IF "%input%"=="2" (GOTO 30E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 30

:30E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssist" /t REG_DWORD /d "1" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO E/D

:30D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssist" /t REG_DWORD /d "0" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO E/D


:31
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable "You have new app that can open this file." Notification
echo   2.Enable "You have new app that can open this file." Notification
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 31D)
IF "%input%"=="2" (GOTO 31E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 31

:31E
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d "0" /f
Call :functsuccess
GOTO E/D

:31D
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d "1" /f
Call :functsuccess
GOTO E/D


:Features
cls
echo **************************************************************************************
echo *         ____         __                     __  ___                                *
echo *        / __/__ ___ _/ /___ _________ ___   /  \/  /__ ____  ___ ____ ____ ____     *
echo *       / _// -_) _ `/ __/ // / __/ -_)_-   / /\_/ / _ `/ _ \/ _ `/ _ `/ -_) __/     *
echo *      /_/  \__/\_,_/\__/\_,_/_/  \__/___/ /_/  /_/\_,_/_//_/\_,_/\_, /\__/_/        *
echo *                                                           /___/                    *
echo **************************************************************************************
echo.
echo   1. Show Windows features list
echo   2. Enable a feature
echo   3. Disable a feature
echo   4. Disable and Remove feature Payload (clean feature files)
echo   5. Show "Turn Windows features on or off" window
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="1" (Goto FT1)
IF "%input%"=="2" (GOTO FT2)
IF "%input%"=="3" (GOTO FT3)
IF "%input%"=="4" (GOTO FT4)
IF "%input%"=="5" (GOTO start OptionalFeatures.exe
goto Features)
if %input% GTR 5 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO Features

:FT1
cls
dism /online /get-features | more
Call :functsuccess

:confirm
set /p input=* Write 1 here to continue :
IF "%input%"=="1" (Goto Features)
IF "%input%"=="" (Goto confirm)
IF "%input%"==" " (Goto confirm)

:FT2
cls
echo **************************************************************************************
echo *         ____         __                     __  ___                                *
echo *        / __/__ ___ _/ /___ _________ ___   /  \/  /__ ____  ___ ____ ____ ____     *
echo *       / _// -_) _ `/ __/ // / __/ -_)_-   / /\_/ / _ `/ _ \/ _ `/ _ `/ -_) __/     *
echo *      /_/  \__/\_,_/\__/\_,_/_/  \__/___/ /_/  /_/\_,_/_//_/\_,_/\_, /\__/_/        *
echo *                                                           /___/                    *
echo **************************************************************************************
echo -------------------------------------------------------------------------------------
echo  *Note: Please go to windows feature list and copy the exact name of the feature
echo.
echo  0.Go back to Features page 
echo --------------------------------------------------------------------------------
set /p input=* Paste the name of the feature that you copied:
IF "%input%"=="0" (Goto Features)
dism /online /enable-feature /featurename:%input%

cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Features


:FT3
cls
echo **************************************************************************************
echo *         ____         __                     __  ___                                *
echo *        / __/__ ___ _/ /___ _________ ___   /  \/  /__ ____  ___ ____ ____ ____     *
echo *       / _// -_) _ `/ __/ // / __/ -_)_-   / /\_/ / _ `/ _ \/ _ `/ _ `/ -_) __/     *
echo *      /_/  \__/\_,_/\__/\_,_/_/  \__/___/ /_/  /_/\_,_/_//_/\_,_/\_, /\__/_/        *
echo *                                                           /___/                    *
echo **************************************************************************************
echo -------------------------------------------------------------------------------------
echo  *Note: Please go to windows feature list and copy the exact name of the feature
echo.
echo  0.Go back to Features page 
echo --------------------------------------------------------------------------------
set /p input=* Paste the name of the feature that you copied:
IF "%input%"=="0" (Goto Features)
dism /online /disable-feature /featurename:%input%

cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Features



:FT4
cls
echo **************************************************************************************
echo *         ____         __                     __  ___                                *
echo *        / __/__ ___ _/ /___ _________ ___   /  \/  /__ ____  ___ ____ ____ ____     *
echo *       / _// -_) _ `/ __/ // / __/ -_)_-   / /\_/ / _ `/ _ \/ _ `/ _ `/ -_) __/     *
echo *      /_/  \__/\_,_/\__/\_,_/_/  \__/___/ /_/  /_/\_,_/_//_/\_,_/\_, /\__/_/        *
echo *                                                           /___/                    *
echo **************************************************************************************
echo -------------------------------------------------------------------------------------
echo  *Note: Please go to windows feature list and copy the exact name of the feature
echo.
echo  0.Go back to Features page 
echo --------------------------------------------------------------------------------
set /p input=* Paste the name of the feature that you copied:
IF "%input%"=="0" (Goto Features)
dism /online /disable-feature /featurename:%input% /remove

cls
echo MsgBox "Operation Completed successfully"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

GOTO Features



:Users
cls
echo **************************************************************************************
echo *      _  _  ____  ____  ____  ____    _  _   __   __ _   __    ___  ____  ____      *
echo *     / )( \/ ___)(  __)(  _ \/ ___)  ( \/ ) / _\ (  ( \ / _\  / __)(  __)(  _ \     *
echo *     ) \/ (\___ \ ) _)  )   /\___ \  / \/ \/    \/    //    \( (_ \ ) _)  )   /     *
echo *     \____/(____/(____)(__\_)(____/  \_)(_/\_/\_/\_)__)\_/\_/ \___/(____)(__\_)     *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1. Show me my User accounts
echo   2. Change specific user account Password
echo   3. Add NEW user account 
echo   4. Delete a user account 
echo.
echo  0.Go back to Main page 
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="1" (Goto US1)
IF "%input%"=="2" (GOTO US2)
IF "%input%"=="3" (GOTO US3)
IF "%input%"=="4" (GOTO US4)
if %input% GTR 4 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO Users

:US1
cls
echo **************************************************************************************
echo *      _  _  ____  ____  ____  ____    _  _   __   __ _   __    ___  ____  ____      *
echo *     / )( \/ ___)(  __)(  _ \/ ___)  ( \/ ) / _\ (  ( \ / _\  / __)(  __)(  _ \     *
echo *     ) \/ (\___ \ ) _)  )   /\___ \  / \/ \/    \/    //    \( (_ \ ) _)  )   /     *
echo *     \____/(____/(____)(__\_)(____/  \_)(_/\_/\_/\_)__)\_/\_/ \___/(____)(__\_)     *
echo *                                                                                    *
echo **************************************************************************************
echo.
net user
echo Press any key to go Back . . .
pause >nul 2>&1
GOTO Users

:US2
cls
echo **************************************************************************************
echo *      _  _  ____  ____  ____  ____    _  _   __   __ _   __    ___  ____  ____      *
echo *     / )( \/ ___)(  __)(  _ \/ ___)  ( \/ ) / _\ (  ( \ / _\  / __)(  __)(  _ \     *
echo *     ) \/ (\___ \ ) _)  )   /\___ \  / \/ \/    \/    //    \( (_ \ ) _)  )   /     *
echo *     \____/(____/(____)(__\_)(____/  \_)(_/\_/\_/\_)__)\_/\_/ \___/(____)(__\_)     *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo  0.Go back to Users manager page 
echo.
set /p name=* Write the name of the desired account:
IF "%name%"=="0" (Goto Users)
echo.
set /p PWD=* Write the new password:
IF "%PWD%"=="0" (Goto Users)
echo.
set /p PWDC=* Confirm the new password:
IF "%PWDC%"=="0" (Goto Users)
if %PWD%==%PWDC% (GOTO CPWD) Else GOTO PWDNC

:CPWD
net user "%name%" "%PWD%"
if ERRORLEVEL 0 call :CPWD0
if ERRORLEVEL 1 Call :functsuccess

:CPWD0
echo MsgBox "Something happend. Please check if the User-name you entred is correct..."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
GOTO US2

:PWDNC
echo MsgBox "Please check the Password you entred again..."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
GOTO US2

:US3
cls
echo **************************************************************************************
echo *      _  _  ____  ____  ____  ____    _  _   __   __ _   __    ___  ____  ____      *
echo *     / )( \/ ___)(  __)(  _ \/ ___)  ( \/ ) / _\ (  ( \ / _\  / __)(  __)(  _ \     *
echo *     ) \/ (\___ \ ) _)  )   /\___ \  / \/ \/    \/    //    \( (_ \ ) _)  )   /     *
echo *     \____/(____/(____)(__\_)(____/  \_)(_/\_/\_/\_)__)\_/\_/ \___/(____)(__\_)     *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo  0.Go back to Users manager page 
echo.
set /p name=* Write the name of the desired new account:
IF "%name%"=="0" (Goto Users)
net user %name% /add
Call :functsuccess
GOTO Users

:US4
cls
echo **************************************************************************************
echo *      _  _  ____  ____  ____  ____    _  _   __   __ _   __    ___  ____  ____      *
echo *     / )( \/ ___)(  __)(  _ \/ ___)  ( \/ ) / _\ (  ( \ / _\  / __)(  __)(  _ \     *
echo *     ) \/ (\___ \ ) _)  )   /\___ \  / \/ \/    \/    //    \( (_ \ ) _)  )   /     *
echo *     \____/(____/(____)(__\_)(____/  \_)(_/\_/\_/\_)__)\_/\_/ \___/(____)(__\_)     *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo  0.Go back to Users manager page 
echo.
set /p name=* Write the name of the desired new account:
IF "%name%"=="0" (Goto Users)
echo.
choice /c yn /m "Are you sure you want to delete this account"
echo.
if %errorlevel% equ 2 Goto Users
if %errorlevel% equ 1 GOTO US4Y
:US4Y

net user "%name%" /delete
if ERRORLEVEL 0 call :UNM0
if ERRORLEVEL 1 Call :functsuccess & GOTO Users

:UNM0
echo MsgBox "Something happend. Please check if the User-name you entred is correct..."> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs
GOTO US4


:OEM
cls
echo **************************************************************************************
echo *     __  ____  _  _    __  __ _  ____  __  ____  _  _   __  ____  __  __   __ _     *
echo *    /  \(  __)( \/ )  (  )(  ( \(  __)/  \(  _ \( \/ ) / _\(_  _)(  )/  \ (  ( \    *
echo *   (  O )) _) / \/ \   )( /    / ) _)(  O ))   // \/ \/    \ )(   )((  O )/    /    *
echo *    \__/(____)\_)(_/  (__)\_)__)(__)  \__/(__\_)\_)(_/\_/\_/(__) (__)\__/ \_)__)    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.ADD MANUFACTURER OPTION 
echo   2.ADD MODEL OPTION        
echo   3.ADD SUPPORT HOURS OPTION 
echo   4.ADD SUPPORT PHONE OPTION 
echo   5.ADD SUPPORT URL OPTION   
echo   6.ADD YOUR OWN LOGO       
echo.
echo   0.Go back to User Interface page
echo.
CHOICE /C 1234560 /M "Enter your Choice Please ! "
IF ERRORLEVEL 7 goto UI
IF ERRORLEVEL 6 goto LOGO
IF ERRORLEVEL 5 goto URL
IF ERRORLEVEL 4 goto PHONE
IF ERRORLEVEL 3 goto HOURS
IF ERRORLEVEL 2 goto MODEL
IF ERRORLEVEL 1 goto MANUFACTURER
:MANUFACTURER
set /p name=ENTER NAME OF ANY MANUFACTURER:       
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Manufacturer /f /t REG_SZ /d %name%
Call :functsuccess
GOTO OEM

:MODEL
set /p model=ENTER MODEL THAT YOU WANT:
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Model /f /t REG_SZ /d %model%
Call :functsuccess
GOTO OEM

:HOURS
set /p hours=ENTER HOURS THAT YOU WANT :
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportHours /f /t REG_SZ /d %hours%
Call :functsuccess
GOTO OEM

:PHONE
set /p phone=ENTER YOUR PHONE :
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportPhone /f /t REG_SZ /d %phone%
Call :functsuccess
GOTO OEM

:URL
set /p url=ENTER URL THAT YOU WANT :
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportURL /f /t REG_SZ /d %url%
Call :functsuccess
GOTO OEM

:LOGO
set /p source=ENTER SOURCE OF YOUR LOGO :
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v logo /f /t REG_SZ /d %source%
Call :functsuccess
GOTO OEM

:32
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable Windows Firewall 
echo   2.Enable Windows Firewall 
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 32D)
IF "%input%"=="2" (GOTO 32E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 32

:32D
netsh advfirewall set allprofiles state off
Call :functsuccess
GOTO E/D

:32E
netsh advfirewall set allprofiles state on
Call :functsuccess
GOTO E/D

:33
Cls
echo **************************************************************************************
echo *           ___  __   __ _  ____  ____  _  _  ____    _  _  ____  __ _  _  _         *
echo *          / __)/  \ (  ( \(_  _)(  __)( \/ )(_  _)  ( \/ )(  __)(  ( \/ )( \        *
echo *         ( (__(  O )/    /  )(   ) _)  )  (   )(    / \/ \ ) _) /    /) \/ (        *
echo *          \___)\__/ \_)__) (__) (____)(_/\_) (__)   \_)(_/(____)\_)__)\____/        *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Add Select Context menu
echo   2.Remove Select Context menu
echo.
echo   0.Go back to Context menu page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto CM)
IF "%input%"=="1" (Goto 33E)
IF "%input%"=="2" (GOTO 33D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 33

:33E
Reg.exe add "HKCR\*\shell\Select" /v "MUIVerb" /t REG_SZ /d "Select" /f
Reg.exe add "HKCR\*\shell\Select" /v "icon" /t REG_SZ /d "imageres.dll,-5308" /f
Reg.exe add "HKCR\*\shell\Select" /v "SubCommands" /t REG_SZ /d "Windows.selectall;Windows.selectnone;Windows.invertselection" /f
Reg.exe add "HKCR\Folder\shell\Select" /v "MUIVerb" /t REG_SZ /d "Select" /f
Reg.exe add "HKCR\Folder\shell\Select" /v "icon" /t REG_SZ /d "imageres.dll,-5308" /f
Reg.exe add "HKCR\Folder\shell\Select" /v "SubCommands" /t REG_SZ /d "Windows.selectall;Windows.selectnone;Windows.invertselection" /f
Reg.exe add "HKCR\Directory\Background\shell\Select" /v "MUIVerb" /t REG_SZ /d "Select" /f
Reg.exe add "HKCR\Directory\Background\shell\Select" /v "icon" /t REG_SZ /d "imageres.dll,-5308" /f
Reg.exe add "HKCR\Directory\Background\shell\Select" /v "SubCommands" /t REG_SZ /d "Windows.selectall" /f
Reg.exe add "HKCR\LibraryFolder\Background\shell\Select" /v "MUIVerb" /t REG_SZ /d "Select" /f
Reg.exe add "HKCR\LibraryFolder\Background\shell\Select" /v "icon" /t REG_SZ /d "imageres.dll,-5308" /f
Reg.exe add "HKCR\LibraryFolder\Background\shell\Select" /v "SubCommands" /t REG_SZ /d "Windows.selectall;Windows.selectnone;Windows.invertselection" /f
Call :functsuccess
Goto CM

:33D
Reg.exe delete "HKCR\*\shell\Select" /f
Reg.exe delete "HKCR\Folder\shell\Select" /f
Reg.exe delete "HKCR\Directory\Background\shell\Select" /f
Reg.exe delete "HKCR\LibraryFolder\Background\shell\Select" /f
Call :functsuccess
Goto CM

:34
Cls
echo **************************************************************************************
echo *           ___  __   __ _  ____  ____  _  _  ____    _  _  ____  __ _  _  _         *
echo *          / __)/  \ (  ( \(_  _)(  __)( \/ )(_  _)  ( \/ )(  __)(  ( \/ )( \        *
echo *         ( (__(  O )/    /  )(   ) _)  )  (   )(    / \/ \ ) _) /    /) \/ (        *
echo *          \___)\__/ \_)__) (__) (____)(_/\_) (__)   \_)(_/(____)\_)__)\____/        *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Remove Pin to Quick access 
echo   2.Add Pin to Quick access 
echo.
echo   0.Go back to Context menu page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto CM)
IF "%input%"=="1" (Goto 34D)
IF "%input%"=="2" (GOTO 34E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 34

:34E
Reg.exe delete "HKCR\Folder\shell\pintohome" /f
Reg.exe add "HKCR\Folder\shell\pintohome" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-51377" /f
Reg.exe add "HKCR\Folder\shell\pintohome" /v "AppliesTo" /t REG_SZ /d "System.ParsingName:<>\"::{679f85cb-0220-4080-b29b-5540cc05aab6}\"" /f
Reg.exe add "HKCR\Folder\shell\pintohome\command" /v "DelegateExecute" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-51377" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /v "AppliesTo" /t REG_SZ /d "System.ParsingName:<>\"::{679f85cb-0220-4080-b29b-5540cc05aab6}\"" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome\command" /v "DelegateExecute" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f
Call :functsuccess
Goto CM

:34D
Reg.exe delete "HKCR\Folder\shell\pintohome" /f
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f
Call :functsuccess
Goto CM

:35
Cls
echo **************************************************************************************
echo *           ___  __   __ _  ____  ____  _  _  ____    _  _  ____  __ _  _  _         *
echo *          / __)/  \ (  ( \(_  _)(  __)( \/ )(_  _)  ( \/ )(  __)(  ( \/ )( \        *
echo *         ( (__(  O )/    /  )(   ) _)  )  (   )(    / \/ \ ) _) /    /) \/ (        *
echo *          \___)\__/ \_)__) (__) (____)(_/\_) (__)   \_)(_/(____)\_)__)\____/        *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Add classic Personalize to Desktop
echo   2.Remove classic Personalize From Desktop
echo.
echo   0.Go back to Context menu page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto CM)
IF "%input%"=="1" (Goto 35E)
IF "%input%"=="2" (GOTO 35D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 35

:35E
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "MUIVerb" /t REG_SZ /d "Personalize (classic)" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "Position" /t REG_SZ /d "Bottom" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization" /v "SubCommands" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\001flyout" /v "MUIVerb" /t REG_SZ /d "Theme Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\001flyout" /v "ControlPanelName" /t REG_SZ /d "Microsoft.Personalization" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\001flyout" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\001flyout\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\002flyout" /v "Icon" /t REG_SZ /d "imageres.dll,-110" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\002flyout" /v "MUIVerb" /t REG_SZ /d "Desktop Background" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\002flyout" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\002flyout\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,@desktop" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\003flyout" /v "MUIVerb" /t REG_SZ /d "Change Text Size" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\003flyout" /v "ControlPanelName" /t REG_SZ /d "Microsoft.Display" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\003flyout" /v "Icon" /t REG_SZ /d "display.dll,-1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\003flyout\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\004flyout" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\004flyout" /v "MUIVerb" /t REG_SZ /d "Color and Appearance" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\004flyout\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,Advanced,@Advanced" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\005flyout" /v "Icon" /t REG_SZ /d "SndVol.exe,-101" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\005flyout" /v "MUIVerb" /t REG_SZ /d "Sounds" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\005flyout\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,2" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\006flyout" /v "Icon" /t REG_SZ /d "PhotoScreensaver.scr" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\006flyout" /v "MUIVerb" /t REG_SZ /d "Screen Saver Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\006flyout\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\007flyout" /v "Icon" /t REG_SZ /d "desk.cpl" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\007flyout" /v "MUIVerb" /t REG_SZ /d "Desktop Icon Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\007flyout" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\007flyout\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\008flyout" /v "Icon" /t REG_SZ /d "main.cpl" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\008flyout" /v "MUIVerb" /t REG_SZ /d "Mouse Pointers" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Personalization\shell\008flyout\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL main.cpl,,1" /f
Call :functsuccess
Goto CM

:35D
Reg.exe delete "HKCR\DesktopBackground\Shell\Personalization" /f
Call :functsuccess
Goto CM


:36
Cls
echo **************************************************************************************
echo *           ___  __   __ _  ____  ____  _  _  ____    _  _  ____  __ _  _  _         *
echo *          / __)/  \ (  ( \(_  _)(  __)( \/ )(_  _)  ( \/ )(  __)(  ( \/ )( \        *
echo *         ( (__(  O )/    /  )(   ) _)  )  (   )(    / \/ \ ) _) /    /) \/ (        *
echo *          \___)\__/ \_)__) (__) (____)(_/\_) (__)   \_)(_/(____)\_)__)\____/        *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Remove Screen Resolution from Desktop
echo   2.Add Screen Resolution to Desktop
echo.
echo   0.Go back to Context menu page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto CM)
IF "%input%"=="1" (Goto 36D)
IF "%input%"=="2" (GOTO 36E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 36

:36E
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "ControlPanelName" /t REG_SZ /d "Microsoft.Display" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "ControlPanelPage" /t REG_SZ /d "Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "Icon" /t REG_SZ /d "%%SystemRoot%%\System32\display.dll,-1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "Position" /t REG_SZ /d "Bottom" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /ve /t REG_SZ /d "@%%SystemRoot%%\system32\Display.dll,-300" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
Call :functsuccess
Goto CM

:36D
Reg.exe delete "HKCR\DesktopBackground\Shell\Screen resolution" /f
Call :functsuccess
Goto CM


:37
Cls
echo **************************************************************************************
echo *           ___  __   __ _  ____  ____  _  _  ____    _  _  ____  __ _  _  _         *
echo *          / __)/  \ (  ( \(_  _)(  __)( \/ )(_  _)  ( \/ )(  __)(  ( \/ )( \        *
echo *         ( (__(  O )/    /  )(   ) _)  )  (   )(    / \/ \ ) _) /    /) \/ (        *
echo *          \___)\__/ \_)__) (__) (____)(_/\_) (__)   \_)(_/(____)\_)__)\____/        *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Add Power Options to Desktop
echo   2.Remove Power Options from Desktop
echo.
echo   0.Go back to Context menu page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto CM)
IF "%input%"=="1" (Goto 37E)
IF "%input%"=="2" (GOTO 37D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 37

:37E
Reg.exe add "HKCR\DesktopBackground\Shell\Power" /v "MUIVerb" /t REG_SZ /d "Power" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Power" /v "SubCommands" /t REG_SZ /d "Lock;SwitchUser;SignOut;Sleep;Hibernate;HybridShutdown;ShutDown;SlideToShutdown;Restart;BootOptions" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Power" /v "icon" /t REG_SZ /d "shell32.dll,-221" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Power" /v "Position" /t REG_SZ /d "bottom" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Lock" /ve /t REG_SZ /d "Lock" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Lock" /v "icon" /t REG_SZ /d "shell32.dll,-48" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Lock\command" /ve /t REG_SZ /d "rundll32.exe user32.dll, LockWorkStation" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SwitchUser" /ve /t REG_SZ /d "Switch User" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SwitchUser" /v "icon" /t REG_SZ /d "imageres.dll,-88" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SwitchUser\command" /ve /t REG_SZ /d "tsdiscon.exe" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SignOut" /ve /t REG_SZ /d "Sign out" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SignOut" /v "icon" /t REG_SZ /d "shell32.dll,-45" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SignOut\command" /ve /t REG_SZ /d "shutdown.exe -L" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ShutDown" /ve /t REG_SZ /d "Full Shut down" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ShutDown" /v "icon" /t REG_SZ /d "shell32.dll,-28" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ShutDown\command" /ve /t REG_SZ /d "shutdown.exe -s -f -t 00" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\HybridShutdown" /ve /t REG_SZ /d "Hybrid Shut down" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\HybridShutdown" /v "icon" /t REG_SZ /d "shell32.dll,-28" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\HybridShutdown\command" /ve /t REG_SZ /d "Shutdown -s -f -hybrid -t 00" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SlideToShutdown" /ve /t REG_SZ /d "Slide to Shut down" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SlideToShutdown" /v "icon" /t REG_SZ /d "shell32.dll,-28" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SlideToShutdown\command" /ve /t REG_SZ /d "SlideToShutDown.exe" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Restart" /ve /t REG_SZ /d "Restart" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Restart" /v "icon" /t REG_SZ /d "shell32.dll,-290" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Restart\command" /ve /t REG_SZ /d "shutdown.exe -r -f -t 00" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\sleep" /ve /t REG_SZ /d "Sleep" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\sleep" /v "icon" /t REG_SZ /d "powercpl.dll,-514" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\sleep\command" /ve /t REG_SZ /d "rundll32.exe powrprof.dll,SetSuspendState Sleep" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\hibernate" /ve /t REG_SZ /d "Hibernate" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\hibernate" /v "icon" /t REG_SZ /d "imageres.dll,-101" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\hibernate\command" /ve /t REG_SZ /d "Shutdown -h" /f

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\BootOptions" /ve /t REG_SZ /d "Restart to Boot Options" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\BootOptions" /v "icon" /t REG_SZ /d "RelPost.exe" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\BootOptions\command" /ve /t REG_SZ /d "Shutdown -r -o -f -t 00" /f
Call :functsuccess
Goto CM

:37D
Reg.exe delete "HKCR\DesktopBackground\Shell\Power" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Lock" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SwitchUser" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SignOut" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\sleep" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\hibernate" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ShutDown" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\HybridShutdown" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SlideToShutdown" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Restart" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\BootOptions" /f
Call :functsuccess
Goto CM

:38
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable Windows Defender Real-Time protection 
echo   2.Enable Windows Defender Real-Time protection 
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 38D)
IF "%input%"=="2" (GOTO 38E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 38

:38D
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 0 /f 
Call :functsuccess
Goto E/D

:38E
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 1 /f 
Call :functsuccess
Goto E/D




:WAmenu
cls
echo **************************************************************************************
echo *         _  _  __  __ _  ____   __   _  _  ____       __   ____  ____  ____         *
echo *        / )( \(  )(  ( \(    \ /  \ / )( \/ ___)     / _\ (  _ \(  _ \/ ___)        *
echo *        \ /\ / )( /    / ) D ((  O )\ /\ /\___ \    /    \ ) __/ ) __/\___ \        *
echo *        (_/\_)(__)\_)__)(____/ \__/ (_/\_)(____/    \_/\_/(__)  (__)  (____/        *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1. Remove/restore the majority of Windows built-in apps from current User/All Users
echo.
echo   2. Uninstall Cortana - "sfc /scannow" to restore
echo   3. Uninstall/restore Microsoft Edge
echo   4. Restore Legacy Calculator (Classic Win32)
echo   5. Install Windows DVD Player app
echo   6. Enable/Disable/Uninstall Onedrive
echo   7. Restore Old Windows photo viewer
echo   8. Restore Win 7 Task manager
echo   9. Uninstall Contact Support App
echo  10. Uninstall Windows Feedback App
echo  11. Uninstall Candy Crush Saga Built-in app
echo.
echo   0.Go back to Main menu
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="1" (Goto Awamenu)
IF "%input%"=="2" (GOTO DelCortana)
IF "%input%"=="3" (GOTO E11)
IF "%input%"=="4" (GOTO CALC32)
IF "%input%"=="5" (GOTO DVDapp)
IF "%input%"=="6" (GOTO OD)
IF "%input%"=="7" (GOTO 6)
IF "%input%"=="sfc /scannow" (sfc /scannow & GOTO WAmenu)
IF "%input%"=="8" (GOTO 7TASKM)
IF "%input%"=="9" (GOTO ContactSuppo)
IF "%input%"=="10" (GOTO WFeedbackApp)
IF "%input%"=="11" (powershell.exe -command "Get-AppxPackage -Name *CandyCrushSaga* | Remove-AppxPackage" > NUL 2>&1 & GOTO WAmenu)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO WAmenu




:ContactSuppo
cd /d "%~dp0"
REM install_wim_tweak.exe
echo strFileURL = "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiWTNGYXdiRU9SNVU" > IWT.vbs
echo     strHDLocation = "%CD%\install_wim_tweak.exe" >> IWT.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> IWT.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> IWT.vbs
echo objXMLHTTP.send() >> IWT.vbs
echo If objXMLHTTP.Status = 200 Then >> IWT.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> IWT.vbs
echo objADOStream.Open>> IWT.vbs
echo objADOStream.Type = 1 >> IWT.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> IWT.vbs
echo objADOStream.Position = 0    >> IWT.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> IWT.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> IWT.vbs
echo Set objFSO = Nothing >> IWT.vbs
echo objADOStream.SaveToFile strHDLocation >> IWT.vbs
echo objADOStream.Close >> IWT.vbs
echo Set objADOStream = Nothing >> IWT.vbs
echo End if >> IWT.vbs
echo Set objXMLHTTP = Nothing >> IWT.vbs
cscript IWT.vbs
Del IWT.vbs

echo Uninstalling Contact Support...
CLS
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c Microsoft-Windows-ContactSupport /r
install_wim_tweak.exe /h /o /l
del Packages.txt
del install_wim_tweak.exe
echo Windows Contact Support should be uninstalled.
pause

GOTO WAmenu

:WFeedbackApp
cd /d "%~dp0"

echo strFileURL = "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiWTNGYXdiRU9SNVU" > IWT.vbs
echo     strHDLocation = "%CD%\install_wim_tweak.exe" >> IWT.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> IWT.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> IWT.vbs
echo objXMLHTTP.send() >> IWT.vbs
echo If objXMLHTTP.Status = 200 Then >> IWT.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> IWT.vbs
echo objADOStream.Open>> IWT.vbs
echo objADOStream.Type = 1 >> IWT.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> IWT.vbs
echo objADOStream.Position = 0    >> IWT.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> IWT.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> IWT.vbs
echo Set objFSO = Nothing >> IWT.vbs
echo objADOStream.SaveToFile strHDLocation >> IWT.vbs
echo objADOStream.Close >> IWT.vbs
echo Set objADOStream = Nothing >> IWT.vbs
echo End if >> IWT.vbs
echo Set objXMLHTTP = Nothing >> IWT.vbs
cscript IWT.vbs
Del IWT.vbs

echo Uninstalling Windows Feedback...
CLS
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c Microsoft-WindowsFeedback /r
install_wim_tweak.exe /h /o /l
del Packages.txt
del install_wim_tweak.exe
echo Windows Feedback should be uninstalled.
pause

GOTO WAmenu







:Awamenu
REM Thanks to "johnye_pt" From MDL
cls
echo **************************************************************************************
echo *         _  _  __  __ _  ____   __   _  _  ____       __   ____  ____  ____         *
echo *        / )( \(  )(  ( \(    \ /  \ / )( \/ ___)     / _\ (  _ \(  _ \/ ___)        *
echo *        \ /\ / )( /    / ) D ((  O )\ /\ /\___ \    /    \ ) __/ ) __/\___ \        *
echo *        (_/\_)(__)\_)__)(____/ \__/ (_/\_)(____/    \_/\_/(__)  (__)  (____/        *
echo *                                                                                    *
echo **************************************************************************************
echo                       ษอออออออออออออออออออออออออออออออออออออออป
echo.                      บ REBOOT RECOMMENDED AFTER EVERY CHANGE บ
echo  Select action...     ศอออออออออออออออออออออออออออออออออออออออผ
if [%WAaction%]==[1] (
  echo    a. [x] Remove App from current User
  echo    b. [ ] Remove App from All Users
  echo    c. [ ] Restore App to current User
)
if [%WAaction%]==[2] (
  echo    a. [ ] Remove App from current User
  echo    b. [x] Remove App from All Users
  echo    c. [ ] Restore App to current User
)
if [%WAaction%]==[3] (
  echo    a. [ ] Remove App from current User
  echo    b. [ ] Remove App from All Users
  echo    c. [x] Restore App to current User
)
echo.
echo  ... and select App
echo   1.3D Builder          8.Get Started         15.OneNote         22.Xbox    
echo   2.Alarms and Clocks   9.Groove Music        16.People          23.Messaging 
echo   3.Calculator         10.Maps                17.Phone Companion 24.Microsoft Wi-Fi
echo   4.Calendar and Mail  11.Microsoft Solitaire 18.Photos          25.Phone        
echo   5.Camera             12.Money               19.Sports          26.Office Sway  
echo   6.Get Office         13.Movies and TV       20.Voice Recorder  27.Paid Wifi/cellular
echo   7.Skype Preview      14.News                21.Weather         28.Sticky notes
echo              29.Store บNo Restoreบ                30.ALL, but store
echo.
echo   0. Go back to Main page 
echo.
set /p input=* Type your choice here: 

if %input% EQU 0 goto WAmenu
if %input% GEQ 1 (
  IF %input% LEQ 30 goto WAfunction
)
if /i [%input%]==[a] set WAaction=1
if /i [%input%]==[b] set WAaction=2
if /i [%input%]==[c] set WAaction=3

cls
goto Awamenu



:WAfunction
cls
echo.

rem === the "WAaction" variable defines what action will be taken
rem === the "input" variable from the menu is used below, it equals the order in the "AppStrings" variable
set "AppStrings=3DBuilder_8wekyb3d8bbwe WindowsAlarms_8wekyb3d8bbwe WindowsCalculator_8wekyb3d8bbwe windowscommunicationsapps_8wekyb3d8bbwe WindowsCamera_8wekyb3d8bbwe MicrosoftOfficeHub_8wekyb3d8bbwe SkypeApp_kzf8qxf38zg5c Getstarted_8wekyb3d8bbwe ZuneMusic_8wekyb3d8bbwe WindowsMaps_8wekyb3d8bbwe MicrosoftSolitaireCollection_8wekyb3d8bbwe BingFinance_8wekyb3d8bbwe ZuneVideo_8wekyb3d8bbwe BingNews_8wekyb3d8bbwe Office.OneNote_8wekyb3d8bbwe People_8wekyb3d8bbwe WindowsPhone_8wekyb3d8bbwe Windows.Photos_8wekyb3d8bbwe BingSports_8wekyb3d8bbwe WindowsSoundRecorder_8wekyb3d8bbwe BingWeather_8wekyb3d8bbwe XboxApp_8wekyb3d8bbwe Messaging_8wekyb3d8bbwe ConnectivityStore_8wekyb3d8bbwe CommsPhone_8wekyb3d8bbwe Office.Sway_8wekyb3d8bbwe oneconnect_8wekyb3d8bbwe microsoftstickynotes_8wekyb3d8bbwe WindowsStore_8wekyb3d8bbwe"

rem === initialize App position
set /a AppNum=0

rem === cicle through all Apps
for %%a in (%AppStrings%) do (

  rem === increment App position by 1
  set /a AppNum+=1

  rem === get App Name without underscore
  set "AppName=%%a"
  set "AppName=!AppName:~0,-14!"

  rem === if chosen action is remove App from user/system
  if %WAaction% LEQ 2 (

    rem === if chosen option is remove all Apps but store
    if [%input%]==[30] (

      rem === remove all Apps except the store
      if NOT [!AppNum!]==[29] (

        rem === remove from user
        if [%WAaction%]==[1] (
          echo  Removing "!AppName!" from user...
          powershell.exe -command "Get-AppxPackage Microsoft.!AppName! | Remove-AppxPackage" > NUL 2>&1

        rem === remove from system
        ) else (
          echo  Removing "!AppName!" from system...
          powershell.exe -command "Get-AppxPackage -AllUsers Microsoft.!AppName! | Remove-AppxPackage" > NUL 2>&1
          powershell.exe -command "Get-appxprovisionedpackage –Online | Where-Object {$_.DisplayName –eq 'Microsoft.!AppName!'} | Remove-AppxProvisionedPackage –Online" | find "HideOutputFromUser"
        )

      )
    ) else (

      rem === remove chosen App
      if [%input%]==[!AppNum!] (

        rem === remove from user
        if [%WAaction%]==[1] (
          echo  Removing "!AppName!" from user...
          powershell.exe -command "Get-AppxPackage Microsoft.!AppName! | Remove-AppxPackage" > NUL 2>&1

        rem === remove from system
        ) else (

          rem === make sure user wants to remove Store App
          set "removeApp=0"
          if [%input%]==[29] (
            echo  If Store is removed from system, it cannot be restored^^!
            set /p removeApp=* If you are really SURE, type "store" to continue: 
            if /i [!removeApp!]==[store] set "removeApp=1"
          ) else (
            set "removeApp=1"
          )
          if [!removeApp!]==[1] (
            echo  Removing "!AppName!" from system...
            powershell.exe -command "Get-AppxPackage -AllUsers Microsoft.!AppName! | Remove-AppxPackage" > NUL 2>&1
            powershell.exe -command "Get-appxprovisionedpackage –Online | Where-Object {$_.DisplayName –eq 'Microsoft.!AppName!'} | Remove-AppxProvisionedPackage –Online" | find "HideOutputFromUser"
          )
        )
      )
    )

  rem === if chosen action is restore app
  ) else (

    rem === if chosen option is restore all Apps but store
    if [%input%]==[30] (

      rem === restore all Apps except the store
      if NOT [!AppNum!]==[29] (

        rem === restore app with Get-AppxPackage
        echo  Restoring "!AppName!" to user...
        powershell.exe -command "Get-AppxPackage -AllUsers Microsoft.!AppName! | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register ($_.InstallLocation + '\AppXManifest.xml')}" > NUL 2>&1
        
      )
    ) else (

      rem === restore chosen App
      if [%input%]==[!AppNum!] (

        rem === restore app with Get-AppxPackage
        echo  Restoring "!AppName!" to user...
        powershell.exe -command "Get-AppxPackage -AllUsers Microsoft.!AppName! | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register ($_.InstallLocation + '\AppXManifest.xml')}" > NUL 2>&1
        
      )
    )
  )
)

set /p input=* Reboot to apply changes (y/n)? 
if /i [%input%]==[y] shutdown -r -t 5 -c "Windows will restart in 5 seconds"
goto Awamenu



:39
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Force .net apps to always use the latest Framework version installed 
echo   *This saves space by not having to install older dotnet versions like DotNetF 3.5)
echo                 #### Not recommended : may break some apps ####
echo.
echo   2.Restore default settings
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 39E)
IF "%input%"=="2" (GOTO 39D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 39

:39E
reg add hklm\software\microsoft\.netframework /v OnlyUseLatestCLR /t REG_DWORD /d 1
reg add hklm\software\wow6432node\microsoft\.netframework /v OnlyUseLatestCLR /t REG_DWORD /d 1
Call :functsuccess
Goto E/D

:39D
reg add hklm\software\microsoft\.netframework /v OnlyUseLatestCLR /t REG_DWORD /d 0
reg add hklm\software\wow6432node\microsoft\.netframework /v OnlyUseLatestCLR /t REG_DWORD /d 0
Call :functsuccess
Goto E/D



:KMSActivation
cls
echo **************************************************************************************
echo *   ____  __    ___   ___  __    ____    ____  _  _  ____   __   __ _  ____  ____    *
echo *  (_  _)/  \  / __) / __)(  )  (  __)  (_  _)/ )( \(  __) / _\ (  / )(  __)(  _ \   *
echo *    )( (  O )( (_ \( (_ \/ (_/\ ) _)     )(  \ /\ / ) _) /    \ )  (  ) _)  )   /   *
echo *   (__) \__/  \___/ \___/\____/(____)   (__) (_/\_)(____)\_/\_/(__\_)(____)(__\_)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo      1. Check Windows Activation Status
echo      2. Check Office (2016/2013/2010) Activation Status
echo.
echo      3. Activate Windows/Office Using KMSPico (Network nedded)
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="1" (GOTO CheckWin)
IF "%input%"=="2" (GOTO CheckOffice)
IF "%input%"=="3" (GOTO Activate)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO KMSActivation

:CheckWin
cls
cd /d %~dp0
setLocal EnableDelayedExpansion
if exist "%Windir%\Sysnative\sppsvc.exe" set SysPath=%Windir%\Sysnative
if exist "%Windir%\System32\sppsvc.exe"  set SysPath=%Windir%\System32

echo  Windows Status:
echo =================
ver
cscript //nologo %SysPath%\slmgr.vbs /dli
cscript //nologo %SysPath%\slmgr.vbs /xpr

echo.
echo.
pause
GOTO KMSActivation

:CheckOffice
cls
cd /d %~dp0
setLocal EnableDelayedExpansion
if exist "%Windir%\Sysnative\sppsvc.exe" set SysPath=%Windir%\Sysnative
if exist "%Windir%\System32\sppsvc.exe"  set SysPath=%Windir%\System32

echo  Office 2016 Status:
echo =====================
set office=
set installed=0
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Common\InstallRoot" /v "Path" 2^>nul') do (SET office=%%b)
if exist "%office%\OSPP.VBS" (
	set installed=1
	cd /d "%office%"
	cscript //nologo ospp.vbs /dstatus
	cd /d %~dp0
)
set office=
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Common\InstallRoot" /v "Path" 2^>nul') do (SET office=%%b)
if exist "%office%\OSPP.VBS" (
	set installed=1
	cd /d "%office%"
	cscript //nologo ospp.vbs /dstatus
	cd /d %~dp0
)
if %installed%==1 goto end2016
if exist "C:\Program Files\Microsoft Office\Office16\OSPP.VBS" (
	set installed=1
	cd /d "C:\Program Files\Microsoft Office\Office16"
	cscript //nologo ospp.vbs /dstatus
	cd /d %~dp0
)
if exist "C:\Program Files (x86)\Microsoft Office\Office16\OSPP.VBS" (
	set installed=1
	cd /d "C:\Program Files (x86)\Microsoft Office\Office16"
	cscript //nologo ospp.vbs /dstatus
	cd /d %~dp0
)
:end2016
if %installed%==0 echo Not installed

echo.
echo  Office 2013 Status:
echo =====================
set office=
set installed=0
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\Common\InstallRoot" /v "Path" 2^>nul') do (SET office=%%b)
if exist "%office%\OSPP.VBS" (
	set installed=1
	cd /d "%office%"
	cscript //nologo ospp.vbs /dstatus
	cd /d %~dp0
)
set office=
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Common\InstallRoot" /v "Path" 2^>nul') do (SET office=%%b)
if exist "%office%\OSPP.VBS" (
	set installed=1
	cd /d "%office%"
	cscript //nologo ospp.vbs /dstatus
	cd /d %~dp0
)
if %installed%==0 echo Not installed
echo.
echo  Office 2010 Status:
echo =====================
set office=
set installed=0
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\14.0\Common\InstallRoot" /v "Path" 2^>nul') do (SET office=%%b)
if exist "%office%\OSPP.VBS" (
	set installed=1
	cd /d "%office%"
	cscript //nologo ospp.vbs /dstatus
	cd /d %~dp0
)
set office=
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\14.0\Common\InstallRoot" /v "Path" 2^>nul') do (SET office=%%b)
if exist "%office%\OSPP.VBS" (
	set installed=1
	cd /d "%office%"
	cscript //nologo ospp.vbs /dstatus
	cd /d %~dp0
)
if %installed%==0 echo Not installed


pause
GOTO KMSActivation


:Activate
mode con:cols=56 lines=2
Set CurCD=%CD%
cd %temp%
Del TWKMS.ZIP
Del TWKMS.exe

cls
echo  Downloading and installing KMSpico ...
ping -n 1 www.google.com >nul
if errorlevel 1 (
  cls
   echo  Check your Internet So you can download the necessary file ...
   ping 127.0.0.1 -n 3 > NUL 2>&1
  goto Main
)
REM TWKMS.ZIP
echo strFileURL = "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfibDZ1RWRtUzViMGc" > KMS.vbs
echo     strHDLocation = "%CD%\TWKMS.ZIP" >> KMS.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> KMS.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> KMS.vbs
echo objXMLHTTP.send() >> KMS.vbs
echo If objXMLHTTP.Status = 200 Then >> KMS.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> KMS.vbs
echo objADOStream.Open>> KMS.vbs
echo objADOStream.Type = 1 >> KMS.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> KMS.vbs
echo objADOStream.Position = 0    >> KMS.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> KMS.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> KMS.vbs
echo Set objFSO = Nothing >> KMS.vbs
echo objADOStream.SaveToFile strHDLocation >> KMS.vbs
echo objADOStream.Close >> KMS.vbs
echo Set objADOStream = Nothing >> KMS.vbs
echo End if >> KMS.vbs
echo Set objXMLHTTP = Nothing >> KMS.vbs
cscript KMS.vbs >nul 2>&1
del KMS.vbs

REM This script upzip's files...

    > j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO ' UnZip a file script
    >> j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO ' It's a mess, I know!!!
    >> j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO ' Dim ArgObj, var1, var2
    >> j_unzip.vbs ECHO Set ArgObj = WScript.Arguments
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If (Wscript.Arguments.Count ^> 0) Then
    >> j_unzip.vbs ECHO. var1 = ArgObj(0)
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. var1 = ""
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If var1 = "" then
    >> j_unzip.vbs ECHO. strFileZIP = "example.zip"
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. strFileZIP = var1
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO 'The location of the zip file.
    >> j_unzip.vbs ECHO REM Set WshShell = CreateObject("Wscript.Shell")
    >> j_unzip.vbs ECHO REM CurDir = WshShell.ExpandEnvironmentStrings("%%cd%%")
    >> j_unzip.vbs ECHO Dim sCurPath
    >> j_unzip.vbs ECHO sCurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
    >> j_unzip.vbs ECHO strZipFile = sCurPath ^& "\" ^& strFileZIP
    >> j_unzip.vbs ECHO 'The folder the contents should be extracted to.
    >> j_unzip.vbs ECHO outFolder = sCurPath ^& "\"
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracting file " ^& strFileZIP)
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO Set objShell = CreateObject( "Shell.Application" )
    >> j_unzip.vbs ECHO Set objSource = objShell.NameSpace(strZipFile).Items()
    >> j_unzip.vbs ECHO Set objTarget = objShell.NameSpace(outFolder)
    >> j_unzip.vbs ECHO intOptions = 256
    >> j_unzip.vbs ECHO objTarget.CopyHere objSource, intOptions
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracted." )
    >> j_unzip.vbs ECHO.


cscript /B j_unzip.vbs TWKMS.ZIP
del j_unzip.vbs

start /HIGH TWKMS.exe

CD %CurCD%
mode con:cols=87 lines=27
GOTo KMSActivation


:40
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Remove shortcut arrow (Transparent overlay)   บAutomatic explorer.exe restartบ
echo   2.Restore default shortcut arrow                บAutomatic explorer.exe restartบ
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 40D)
IF "%input%"=="2" (GOTO 40E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 40

:40D
Reg.exe add "HKCR\IE.AssocFile.URL" /v "IsShortcut" /t REG_SZ /d "" /f
Reg.exe add "HKCR\InternetShortcut" /v "IsShortcut" /t REG_SZ /d "" /f
Reg.exe add "HKCR\lnkfile" /v "IsShortcut" /t REG_SZ /d "" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v "29" /t REG_SZ /d "%%windir%%\System32\imageres.dll,-17" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
Goto E/D

:40E
Reg.exe add "HKCR\IE.AssocFile.URL" /v "IsShortcut" /t REG_SZ /d "" /f
Reg.exe add "HKCR\InternetShortcut" /v "IsShortcut" /t REG_SZ /d "" /f
Reg.exe add "HKCR\lnkfile" /v "IsShortcut" /t REG_SZ /d "" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v "29" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
Goto E/D


:41
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable Cortana          บAutomatic explorer.exe restartบ
echo   2.Enable Cortana           บAutomatic explorer.exe restartบ
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 41D)
IF "%input%"=="2" (GOTO 41E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 41

:41D
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
Goto E/D

:41E
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
Goto E/D


:42
Cls
echo **************************************************************************************
echo *           ___  __   __ _  ____  ____  _  _  ____    _  _  ____  __ _  _  _         *
echo *          / __)/  \ (  ( \(_  _)(  __)( \/ )(_  _)  ( \/ )(  __)(  ( \/ )( \        *
echo *         ( (__(  O )/    /  )(   ) _)  )  (   )(    / \/ \ ) _) /    /) \/ (        *
echo *          \___)\__/ \_)__) (__) (____)(_/\_) (__)   \_)(_/(____)\_)__)\____/        *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Add Bluetooth Options to Desktop
echo   2.Remove Bluetooth Options from Desktop
echo.
echo   0.Go back to Context menu page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto CM)
IF "%input%"=="1" (Goto 42E)
IF "%input%"=="2" (GOTO 42D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 42

:42E
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth" /v "Icon" /t REG_SZ /d "bthudtask.exe" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth" /v "MUIVerb" /t REG_SZ /d "Bluetooth" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth" /v "Position" /t REG_SZ /d "Middle" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth" /v "SubCommands" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\01menu" /v "MUIVerb" /t REG_SZ /d "Bluetooth Devices (classic)" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\01menu" /v "Icon" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\01menu\command" /ve /t REG_SZ /d "explorer shell:::{28803F59-3A75-4058-995F-4EE5503B023C}" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\02menu" /v "MUIVerb" /t REG_SZ /d "Bluetooth Devices" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\02menu" /v "Icon" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\02menu\command" /ve /t REG_SZ /d "explorer ms-settings:bluetooth" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\03menu" /v "MUIVerb" /t REG_SZ /d "Bluetooth File Transfer" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\03menu" /v "Icon" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\03menu" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\03menu\command" /ve /t REG_SZ /d "fsquirt.exe" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\04menu" /v "MUIVerb" /t REG_SZ /d "Options in Bluetooth Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\04menu" /v "Icon" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\04menu" /v "CommandFlags" /t REG_DWORD /d "32" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\04menu\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL bthprops.cpl,,1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\05menu" /v "MUIVerb" /t REG_SZ /d "COM Ports in Bluetooth Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\05menu" /v "Icon" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\05menu\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL bthprops.cpl,,2" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\06menu" /v "MUIVerb" /t REG_SZ /d "Hardware in Bluetooth Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\06menu" /v "Icon" /t REG_SZ /d "" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Bluetooth\shell\06menu\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL bthprops.cpl,,3" /f
Call :functsuccess
Goto CM

:42D
Reg.exe delete "HKCR\DesktopBackground\Shell\Bluetooth" /f
Call :functsuccess
Goto CM



:43
Cls
echo **************************************************************************************
echo *           ___  __   __ _  ____  ____  _  _  ____    _  _  ____  __ _  _  _         *
echo *          / __)/  \ (  ( \(_  _)(  __)( \/ )(_  _)  ( \/ )(  __)(  ( \/ )( \        *
echo *         ( (__(  O )/    /  )(   ) _)  )  (   )(    / \/ \ ) _) /    /) \/ (        *
echo *          \___)\__/ \_)__) (__) (____)(_/\_) (__)   \_)(_/(____)\_)__)\____/        *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Add Open with Notepad to Files
echo   2.Remove Open with Notepad From Files
echo.
echo   0.Go back to Context menu page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto CM)
IF "%input%"=="1" (Goto 43E)
IF "%input%"=="2" (GOTO 43D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 43

:43E
Reg.exe add "HKCR\*\shell\Open with Notepad\command" /ve /t REG_SZ /d "notepad.exe %%1" /f
Call :functsuccess
Goto CM

:43D
Reg.exe delete "HKCR\*\shell\Open with Notepad" /f
Call :functsuccess
Goto CM



:TM0
cls
echo **************************************************************************************
echo *    ____  ____  __  ____    ____  ____  __    ____  _  _  ____  ____  ____  _  _    *
echo *   / ___)(_  _)/  \(  _ \  (_  _)(  __)(  )  (  __)( \/ )(  __)(_  _)(  _ \( \/ )   *
echo *   \___ \  )( (  O )) __/    )(   ) _) / (_/\ ) _) / \/ \ ) _)   )(   )   / )  /    *
echo *   (____/ (__) \__/(__)     (__) (____)\____/(____)\_)(_/(____) (__) (__\_)(__/     *
echo *                                                                                    *
echo **************************************************************************************
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ                                                       Disable=Stop Telemetry       บ
echo บ     Master TELEMETRY and Data collection Switch  :                                 บ
echo บ                                                       Enable=Reset to default      บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo.
echo   1. CORTANA and Internet Explorer telemetry settings
echo   2. Microsoft Edge and Other Telemetry settings
echo   3. Settings-app\Privacy telemetry settings
echo   4. Apps access settings
echo.
echo   5. Windows Geolocation Services         (05D=Disable  05E=Enable)
echo   6. Synchronization of Windows Settings  (06D=Disable  06E=Enable)
echo.
echo   0.Go back to Previous page
echo.
set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="Disable" (Goto TMDisable)
IF "%input%"=="disable" (Goto TMDisable)
IF "%input%"=="Enable" (Goto TMEnable)
IF "%input%"=="enable" (Goto TMEnable)
IF "%input%"=="1" (Goto TM)
IF "%input%"=="2" (Goto TM2)
IF "%input%"=="3" (Goto TM3)
IF "%input%"=="4" (Goto TM4)
IF "%input%"=="05D" (Goto TM05D)
IF "%input%"=="05d" (Goto TM05D)
IF "%input%"=="05E" (Goto TM05E)
IF "%input%"=="05e" (Goto TM05E)
IF "%input%"=="06D" (Goto TM06D)
IF "%input%"=="06d" (Goto TM06D)
IF "%input%"=="06E" (Goto TM06E)
IF "%input%"=="06e" (Goto TM06E)

if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO TM0

:TM05D
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f

Call :functsuccess
GOTO TM0


:TM05E
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Allow" /f

Call :functsuccess
GOTO TM0


:TM06D
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "0" /f

Call :functsuccess
GOTO TM0


:TM06E
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "1" /f

Call :functsuccess
GOTO TM0


:TMDisable
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v "LastLoggedOnUserSID" 2^>nul') do (SET UID=%%b)
Reg.exe add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%UID%" /v "FeatureStates" /t REG_SZ /d "828" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer" /v "AllowServicePoweredQSA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "no" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions" /v "NoUpdateCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v "PolicyDisableGeolocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "Use FormSuggest" /t REG_SZ /d "no" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "DoNotTrack" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "FormSuggest Passwords" /t REG_SZ /d "no" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\SearchScopes" /v "ShowSearchSuggestionsGlobal" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f
set datetime=%date% %time:~0,8%
chcp 1251> nul 
echo.
REM --- Block Microsoft Telemetry IP ---
netsh.exe advfirewall firewall add rule name="Block Microsoft Telemetry IP" dir=out action=block localip=any remoteip="23.212.108.121-23.212.108.162,64.4.0.0/18,65.52.0.0/14,111.221.29.0-111.221.29.255,157.56.91.77,168.62.0.0/15,168.61.0.0/16" description="Rule created by Toogle Tweaker on %datetime%. Do not edit rule by hand" enable=yes
chcp 1251> nul 
echo 
REM --- Disable Indexing Service, tracking and collection of information to send --- 
net stop DiagTrack 
net stop diagnosticshub.standardcollector.service 
net stop dmwappushservice 
net stop WMPNetworkSvc 
sc config DiagTrack start=disabled 
sc config diagnosticshub.standardcollector.service start=disabled 
sc config dmwappushservice start=disabled 
sc config WMPNetworkSvc start=disabled 

REM --- Disabling telemetry and data acquisition --- 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f 
DEL /q C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl 

REM --- The frequency of the formation of reviews "Never" --- 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 

REM --- Disable job scheduler to collect your information to send, and others. --- 
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable 
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask" /Disable 
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable 
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable 
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable 
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable 
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable 
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable 
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable 
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "2" /f

Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f 
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d 1 /f  
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f 

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f 


Call :functsuccess
GOTO TM0

:TMEnable
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v "LastLoggedOnUserSID" 2^>nul') do (SET UID=%%b)
Reg.exe add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%UID%" /v "FeatureStates" /t REG_SZ /d "893" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /f
Reg.exe delete "HKCR\DesktopBackground\Shell\Bluetooth" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer" /v "AllowServicePoweredQSA" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "yes" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions" /v "NoUpdateCheck" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v "PolicyDisableGeolocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "Use FormSuggest" /t REG_SZ /d "yes" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "DoNotTrack" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "FormSuggest Passwords" /t REG_SZ /d "yes" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\SearchScopes" /v "ShowSearchSuggestionsGlobal" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f
chcp 1251> nul 
echo.
REM --- Block Microsoft Telemetry IP "Default" --- 
netsh.exe advfirewall firewall delete rule name="Block Microsoft Telemetry IP"
chcp 1251> nul 
echo 
REM --- Turning the indexing service, tracking and collection of information to send the "Default" --- 
sc config DiagTrack start=auto 
sc config diagnosticshub.standardcollector.service start=demand 
sc config dmwappushservice start=delayed-auto 
sc config WMPNetworkSvc start=demand 
net start DiagTrack 


REM --- Turning of telemetry and data acquisition "Default" --- 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 2 /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f 

REM --- The frequency of the formation of reviews "Default" --- 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 

REM --- Turning jobs in the scheduler to collect your information to send, and others. "Default" --- 
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Enable 
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Enable 
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Enable 
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Enable 
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Enable 
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Enable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Enable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Enable 
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Enable 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 3 /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\MRT" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f
reg delete "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f 
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Allow" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 0 /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 1 /f 


Call :functsuccess
GOTO TM0


:TM
cls
echo **************************************************************************************
echo *    ____  ____  __  ____    ____  ____  __    ____  _  _  ____  ____  ____  _  _    *
echo *   / ___)(_  _)/  \(  _ \  (_  _)(  __)(  )  (  __)( \/ )(  __)(_  _)(  _ \( \/ )   *
echo *   \___ \  )( (  O )) __/    )(   ) _) / (_/\ ) _) / \/ \ ) _)   )(   )   / )  /    *
echo *   (____/ (__) \__/(__)     (__) (____)\____/(____)\_)(_/(____) (__) (__\_)(__/     *
echo *                                                                                    *
echo **************************************************************************************
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ CORTANA                                0E=Enable ALL  0D=Disable ALL               บ
echo ศออหอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo    ฬอDon't Allow Cortana                                       1E=Enable  1D=Disable
echo    ฬอAllow search and Cortana to use location                  2E=Enable  2D=Disable
echo    ฬอDo not allow web search                                   3E=Enable  3D=Disable
echo    ศอDon't search the web or display web results in Search     4E=Enable  4D=Disable
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Internet Explorer                      5E=Enable ALL  5D=Disable ALL               บ
echo ศออหอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo    ฬอTurn on Suggested Sites                                   6E=Enable  6D=Disable
echo    ฬอAllow Microsoft services to provide enhanced suggestions  7E=Enable  7D=Disable
echo    ฬอTurn off the auto-complete feature for web addresses      8E=Enable  8D=Disable
echo    ฬอDisable Periodic Check for Internet Explorer updates      9E=Enable  9D=Disable
echo    ศอTurn off browser geolocation                             10E=Enable  10D=Disable
echo.
echo   0.Go back to Main page    00.More telemetry settings
echo.
set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="00" (GOTO TM2)
IF "%input%"=="0E" (Goto TM0E)
IF "%input%"=="0D" (Goto TM0D)
IF "%input%"=="1E" (Goto TM1E)
IF "%input%"=="1D" (Goto TM1D)
IF "%input%"=="2E" (Goto TM2E)
IF "%input%"=="2D" (Goto TM2D)
IF "%input%"=="3E" (Goto TM3E)
IF "%input%"=="3D" (Goto TM3D)
IF "%input%"=="4E" (Goto TM4E)
IF "%input%"=="4D" (Goto TM4D)
IF "%input%"=="5E" (Goto TM5E)
IF "%input%"=="5D" (Goto TM5D)
IF "%input%"=="6E" (Goto TM6E)
IF "%input%"=="6D" (Goto TM6D)
IF "%input%"=="7E" (Goto TM7E)
IF "%input%"=="7D" (Goto TM7D)
IF "%input%"=="8E" (Goto TM8E)
IF "%input%"=="8D" (Goto TM8D)
IF "%input%"=="9E" (Goto TM9E)
IF "%input%"=="9D" (Goto TM9D)
IF "%input%"=="10E" (Goto TM10E)
IF "%input%"=="10D" (Goto TM10D)
IF "%input%"=="0e" (Goto TM0E)
IF "%input%"=="0d" (Goto TM0D)
IF "%input%"=="1e" (Goto TM1E)
IF "%input%"=="1d" (Goto TM1D)
IF "%input%"=="2e" (Goto TM2E)
IF "%input%"=="2d" (Goto TM2D)
IF "%input%"=="3e" (Goto TM3E)
IF "%input%"=="3d" (Goto TM3D)
IF "%input%"=="4e" (Goto TM4E)
IF "%input%"=="4d" (Goto TM4D)
IF "%input%"=="5e" (Goto TM5E)
IF "%input%"=="5d" (Goto TM5D)
IF "%input%"=="6e" (Goto TM6E)
IF "%input%"=="6d" (Goto TM6D)
IF "%input%"=="7e" (Goto TM7E)
IF "%input%"=="7d" (Goto TM7D)
IF "%input%"=="8e" (Goto TM8E)
IF "%input%"=="8d" (Goto TM8D)
IF "%input%"=="9e" (Goto TM9E)
IF "%input%"=="9d" (Goto TM9D)
IF "%input%"=="10e" (Goto TM10E)
IF "%input%"=="10d" (Goto TM10D)


if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO TM

:TM0E
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f

goto TM

:TM0D
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "1" /f
goto TM


:TM1E
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
goto TM

:TM1D
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /f
goto TM


:TM2E
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "1" /f
goto TM

:TM2D
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
goto TM


:TM3E
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
goto TM

:TM3D
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "0" /f
goto TM


:TM4E
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f
goto TM

:TM4D
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "1" /f
goto TM


:TM5E
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer" /v "AllowServicePoweredQSA" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "no" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions" /v "NoUpdateCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v "PolicyDisableGeolocation" /t REG_DWORD /d "1" /f
goto TM

:TM5D
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer" /v "AllowServicePoweredQSA" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "yes" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions" /v "NoUpdateCheck" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v "PolicyDisableGeolocation" /t REG_DWORD /d "0" /f
goto TM

:TM6E
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites" /v "Enabled" /t REG_DWORD /d "1" /f
goto TM

:TM6D
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites" /v "Enabled" /t REG_DWORD /d "0" /f
goto TM

:TM7E
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer" /v "AllowServicePoweredQSA" /t REG_DWORD /d "1" /f
goto TM

:TM7D
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer" /v "AllowServicePoweredQSA" /t REG_DWORD /d "0" /f
goto TM


:TM8E
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "no" /f
goto TM

:TM8D
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "yes" /f
goto TM



:TM9E
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions" /v "NoUpdateCheck" /t REG_DWORD /d "1" /f
goto TM

:TM9D
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions" /v "NoUpdateCheck" /t REG_DWORD /d "0" /f
goto TM



:TM10E
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v "PolicyDisableGeolocation" /t REG_DWORD /d "1" /f
goto TM

:TM10D
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v "PolicyDisableGeolocation" /t REG_DWORD /d "0" /f
goto TM


:TM2
cls
echo **************************************************************************************
echo *    ____  ____  __  ____    ____  ____  __    ____  _  _  ____  ____  ____  _  _    *
echo *   / ___)(_  _)/  \(  _ \  (_  _)(  __)(  )  (  __)( \/ )(  __)(_  _)(  _ \( \/ )   *
echo *   \___ \  )( (  O )) __/    )(   ) _) / (_/\ ) _) / \/ \ ) _)   )(   )   / )  /    *
echo *   (____/ (__) \__/(__)     (__) (____)\____/(____)\_)(_/(____) (__) (__\_)(__/     *
echo *                                                                                    *
echo **************************************************************************************
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Microsoft Edge                         0E=Apply ALL  0D=Disable ALL                บ
echo ศออหอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo    ฬอAllows you to let people use autofill on websites        1E=Apply  1D=Disable
echo    ฬอAllows you to let people send Do Not Track headers       2E=Apply  2D=Disable
echo    ฬอAllow you to configure password manager                  3E=Apply  3D=Disable
echo    ฬอStops address bar from showing search suggestions        4E=Apply  4D=Disable
echo    ศอAllows you to configure Smart Screen                     5E=Apply  5D=Disable
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Other Telemetry                        6E=Enable ALL  6D=Disable ALL               บ
echo ศออหอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo    ฬอTurn off Wi-Fi-Sense ("WIFI sharing to Contacts)"         7E=Apply  7D=Disable
echo    ฬอStop settings Sync                                        8E=Apply  8D=Disable
echo    ฬอStop Device metadata retrieval                            9E=Apply  9D=Disable
echo    ฬอBlock Windows data collection servers                    10E=Apply  10D=Disable
echo    ศอStop Various other telemetry settings                    11E=Apply  11D=Disable
echo.
echo   0.Go back to Previous page    00.More telemetry settings

set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto TM)
IF "%input%"=="00" (GOTO TM3)
IF "%input%"=="0E" (Goto 2TM0E)
IF "%input%"=="0D" (Goto 2TM0D)
IF "%input%"=="1E" (Goto 2TM1E)
IF "%input%"=="1D" (Goto 2TM1D)
IF "%input%"=="2E" (Goto 2TM2E)
IF "%input%"=="2D" (Goto 2TM2D)
IF "%input%"=="3E" (Goto 2TM3E)
IF "%input%"=="3D" (Goto 2TM3D)
IF "%input%"=="4E" (Goto 2TM4E)
IF "%input%"=="4D" (Goto 2TM4D)
IF "%input%"=="5E" (Goto 2TM5E)
IF "%input%"=="5D" (Goto 2TM5D)
IF "%input%"=="6E" (Goto 2TM6E)
IF "%input%"=="6D" (Goto 2TM6D)
IF "%input%"=="7E" (Goto 2TM7E)
IF "%input%"=="7D" (Goto 2TM7D)
IF "%input%"=="8E" (Goto 2TM8E)
IF "%input%"=="8D" (Goto 2TM8D)
IF "%input%"=="9E" (Goto 2TM9E)
IF "%input%"=="9D" (Goto 2TM9D)
IF "%input%"=="10E" (Goto 2TM10E)
IF "%input%"=="10D" (Goto 2TM10D)
IF "%input%"=="11E" (Goto 2TM11E)
IF "%input%"=="11D" (Goto 2TM11D)
IF "%input%"=="0e" (Goto 2TM0E)
IF "%input%"=="0d" (Goto 2TM0D)
IF "%input%"=="1e" (Goto 2TM1E)
IF "%input%"=="1d" (Goto 2TM1D)
IF "%input%"=="2e" (Goto 2TM2E)
IF "%input%"=="2d" (Goto 2TM2D)
IF "%input%"=="3e" (Goto 2TM3E)
IF "%input%"=="3d" (Goto 2TM3D)
IF "%input%"=="4e" (Goto 2TM4E)
IF "%input%"=="4d" (Goto 2TM4D)
IF "%input%"=="5e" (Goto 2TM5E)
IF "%input%"=="5d" (Goto 2TM5D)
IF "%input%"=="6e" (Goto 2TM6E)
IF "%input%"=="6d" (Goto 2TM6D)
IF "%input%"=="7e" (Goto 2TM7E)
IF "%input%"=="7d" (Goto 2TM7D)
IF "%input%"=="8e" (Goto 2TM8E)
IF "%input%"=="8d" (Goto 2TM8D)
IF "%input%"=="9e" (Goto 2TM9E)
IF "%input%"=="9d" (Goto 2TM9D)
IF "%input%"=="10e" (Goto 2TM10E)
IF "%input%"=="10d" (Goto 2TM10D)
IF "%input%"=="11e" (Goto 2TM11E)
IF "%input%"=="11d" (Goto 2TM11D)


if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO TM2


:2TM0E
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "Use FormSuggest" /t REG_SZ /d "yes" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "DoNotTrack" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "FormSuggest Passwords" /t REG_SZ /d "yes" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\SearchScopes" /v "ShowSearchSuggestionsGlobal" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "1" /f

goto TM2

:2TM0D
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "Use FormSuggest" /t REG_SZ /d "no" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "DoNotTrack" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "FormSuggest Passwords" /t REG_SZ /d "no" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\SearchScopes" /v "ShowSearchSuggestionsGlobal" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f

goto TM2


:2TM1E
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "Use FormSuggest" /t REG_SZ /d "yes" /f
goto TM2

:2TM1D
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "Use FormSuggest" /t REG_SZ /d "no" /f
goto TM2



:2TM2E
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "DoNotTrack" /t REG_DWORD /d "1" /f
goto TM2

:2TM2D
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "DoNotTrack" /t REG_DWORD /d "0" /f
goto TM2


:2TM3E
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "FormSuggest Passwords" /t REG_SZ /d "yes" /f
goto TM2

:2TM3D
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "FormSuggest Passwords" /t REG_SZ /d "no" /f
goto TM2


:2TM4E
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\SearchScopes" /v "ShowSearchSuggestionsGlobal" /t REG_DWORD /d "1" /f
goto TM2

:2TM4D
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\SearchScopes" /v "ShowSearchSuggestionsGlobal" /t REG_DWORD /d "0" /f
goto TM2



:2TM5E
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "1" /f
goto TM2

:2TM5D
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "0" /f
goto TM2



:2TM6E
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f
set datetime=%date% %time:~0,8%
chcp 1251> nul 
echo.
REM --- Block Microsoft Telemetry IP ---
netsh.exe advfirewall firewall add rule name="Block Microsoft Telemetry IP" dir=out action=block localip=any remoteip="23.212.108.121-23.212.108.162,64.4.0.0/18,65.52.0.0/14,111.221.29.0-111.221.29.255,157.56.91.77,168.62.0.0/15,168.61.0.0/16" description="Rule created by Toogle Tweaker on %datetime%. Do not edit rule by hand" enable=yes
chcp 1251> nul 
echo 
REM --- Disable Indexing Service, tracking and collection of information to send --- 
net stop DiagTrack 
net stop diagnosticshub.standardcollector.service 
net stop dmwappushservice 
net stop WMPNetworkSvc 
sc config DiagTrack start=disabled 
sc config diagnosticshub.standardcollector.service start=disabled 
sc config dmwappushservice start=disabled 
sc config WMPNetworkSvc start=disabled 

REM --- Disabling telemetry and data acquisition --- 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f 
DEL /q C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl 

REM --- The frequency of the formation of reviews "Never" --- 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 

REM --- Disable job scheduler to collect your information to send, and others. --- 
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable 
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask" /Disable 
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable 
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable 
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable 
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable 
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable 
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable 
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f 

goto TM2

:2TM6D
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f
chcp 1251> nul 
echo.
REM --- Block Microsoft Telemetry IP "Default" --- 
netsh.exe advfirewall firewall delete rule name="Block Microsoft Telemetry IP"
chcp 1251> nul 
echo 
REM --- Turning the indexing service, tracking and collection of information to send the "Default" --- 
sc config DiagTrack start=auto 
sc config diagnosticshub.standardcollector.service start=demand 
sc config dmwappushservice start=delayed-auto 
sc config WMPNetworkSvc start=demand 
net start DiagTrack 


REM --- Turning of telemetry and data acquisition "Default" --- 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 2 /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f 

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f 

REM --- The frequency of the formation of reviews "Default" --- 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 

REM --- Turning jobs in the scheduler to collect your information to send, and others. "Default" --- 
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Enable 
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Enable 
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Enable 
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Enable 
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Enable 
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Enable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Enable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Enable 
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Enable 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 3 /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\MRT" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f
reg delete "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 0 /f 
goto TM2



:2TM7D
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d "0" /f
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v "LastLoggedOnUserSID" 2^>nul') do (SET UID=%%b)
Reg.exe add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%UID%" /v "FeatureStates" /t REG_SZ /d "893" /f
goto TM2

:2TM7E
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d "1" /f
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v "LastLoggedOnUserSID" 2^>nul') do (SET UID=%%b)
Reg.exe add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%UID%" /v "FeatureStates" /t REG_SZ /d "828" /f

goto TM2


:2TM8E
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f
goto TM2

:2TM8D
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f
goto TM2


:2TM9E
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f
goto TM2

:2TM9D
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f
goto TM2


:2TM10E
set datetime=%date% %time:~0,8%

chcp 1251> nul 
echo.
REM --- Block Microsoft Telemetry IP ---

netsh.exe advfirewall firewall add rule name="Block Microsoft Telemetry IP" dir=out action=block localip=any remoteip="23.212.108.121-23.212.108.162,64.4.0.0/18,65.52.0.0/14,111.221.29.0-111.221.29.255,157.56.91.77,168.62.0.0/15,168.61.0.0/16" description="Rule created by Toogle Tweaker on %datetime%. Do not edit rule by hand" enable=yes
goto TM2


:2TM10D
chcp 1251> nul 
echo.
REM --- Block Microsoft Telemetry IP "Default" --- 
netsh.exe advfirewall firewall delete rule name="Block Microsoft Telemetry IP"
goto TM2


:2TM11E
chcp 1251> nul 
echo 
REM --- Disable Indexing Service, tracking and collection of information to send --- 
net stop DiagTrack 
net stop diagnosticshub.standardcollector.service 
net stop dmwappushservice 
net stop WMPNetworkSvc 
sc config DiagTrack start=disabled 
sc config diagnosticshub.standardcollector.service start=disabled 
sc config dmwappushservice start=disabled 
sc config WMPNetworkSvc start=disabled 

REM --- Disabling telemetry and data acquisition --- 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f 
DEL /q C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl 

REM --- The frequency of the formation of reviews "Never" --- 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 

REM --- Disable job scheduler to collect your information to send, and others. --- 
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable 
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask" /Disable 
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable 
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable 
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable 
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable 
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable 
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable 
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable 
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v "LastLoggedOnUserSID" 2^>nul') do (SET UID=%%b)
Reg.exe add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%UID%" /v "FeatureStates" /t REG_SZ /d "828" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f 




Call :functsuccess
goto TM2

:2TM11D
chcp 1251> nul 
echo 
REM --- Turning the indexing service, tracking and collection of information to send the "Default" --- 
sc config DiagTrack start=auto 
sc config diagnosticshub.standardcollector.service start=demand 
sc config dmwappushservice start=delayed-auto 
sc config WMPNetworkSvc start=demand 
net start DiagTrack 


REM --- Turning of telemetry and data acquisition "Default" --- 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 2 /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f 

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f 

REM --- The frequency of the formation of reviews "Default" --- 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 

REM --- Turning jobs in the scheduler to collect your information to send, and others. "Default" --- 
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Enable 
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Enable 
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Enable 
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Enable 
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Enable 
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Enable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Enable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Enable 
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Enable 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 3 /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\MRT" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f
reg delete "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /f
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v "LastLoggedOnUserSID" 2^>nul') do (SET UID=%%b)
Reg.exe add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%UID%" /v "FeatureStates" /t REG_SZ /d "893" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 0 /f 

Call :functsuccess
goto TM2


:TM3
cls
echo **************************************************************************************
echo *    ____  ____  __  ____    ____  ____  __    ____  _  _  ____  ____  ____  _  _    *
echo *   / ___)(_  _)/  \(  _ \  (_  _)(  __)(  )  (  __)( \/ )(  __)(_  _)(  _ \( \/ )   *
echo *   \___ \  )( (  O )) __/    )(   ) _) / (_/\ ) _) / \/ \ ) _)   )(   )   / )  /    *
echo *   (____/ (__) \__/(__)     (__) (____)\____/(____)\_)(_/(____) (__) (__\_)(__/     *
echo *                                                                                    *
echo **************************************************************************************
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Settings\Privacy                     0E=Enable ALL  0D=Disable ALL                 บ
echo ศหออออออออออออออออออออออออออออออออออออออออออออออออออออออออหออออออออออออออออออออออออออผ
echo  ฬอณGeneral                                               ฬณGeneral  
echo  บ     ฬอTurn off the advertising ID                      ฬออออ1E=Enable  1D=Disable
echo  บ     ฬอTurn on SmartScreen Filter                       ฬออออ2E=Enable  2D=Disable
echo  บ     ฬอSend Microsoft info about how I write            ฬออออ3E=Enable  3D=Disable
echo  บ     ศอLet websites provide locally relevant content    ฬออออ4E=Enable  4D=Disable
echo  ฬอณLocation                                              ฬณLocation 
echo  บ     ศอturn off Location for this device                ฬออออ5E=Enable  5D=Disable
echo  ฬอณSpeech, inking, and typing                            ฬณSpeech..
echo  บ     ศอTurn off the functionality                       ฬออออ6E=Enable  6D=Disable
echo  ฬอณFeedback and diagnostics                              ฬณFeedback..
echo  บ     ฬอTurn off feedback requests                       ฬออออ7E=Enable  7D=Disable
echo  บ     ศอStop Sending your device data to Microsoft       ศออออ8E=Enable  8D=Disable
echo  บ
echo  ศอณ0.Go back to Previous page     00.More telemetry settings
echo.
set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto TM2)
IF "%input%"=="00" (Goto TM4)
IF "%input%"=="0E" (Goto 3TM0E)
IF "%input%"=="0D" (Goto 3TM0D)
IF "%input%"=="1E" (Goto 3TM1E)
IF "%input%"=="1D" (Goto 3TM1D)
IF "%input%"=="2E" (Goto 3TM2E)
IF "%input%"=="2D" (Goto 3TM2D)
IF "%input%"=="3E" (Goto 3TM3E)
IF "%input%"=="3D" (Goto 3TM3D)
IF "%input%"=="4E" (Goto 3TM4E)
IF "%input%"=="4D" (Goto 3TM4D)
IF "%input%"=="5E" (Goto 3TM5E)
IF "%input%"=="5D" (Goto 3TM5D)
IF "%input%"=="6E" (Goto 3TM6E)
IF "%input%"=="6D" (Goto 3TM6D)
IF "%input%"=="7E" (Goto 3TM7E)
IF "%input%"=="7D" (Goto 3TM7D)
IF "%input%"=="8E" (Goto 3TM8E)
IF "%input%"=="8D" (Goto 3TM8D)
IF "%input%"=="0e" (Goto 3TM0E)
IF "%input%"=="0d" (Goto 3TM0D)
IF "%input%"=="1e" (Goto 3TM1E)
IF "%input%"=="1d" (Goto 3TM1D)
IF "%input%"=="2e" (Goto 3TM2E)
IF "%input%"=="2d" (Goto 3TM2D)
IF "%input%"=="3e" (Goto 3TM3E)
IF "%input%"=="3d" (Goto 3TM3D)
IF "%input%"=="4e" (Goto 3TM4E)
IF "%input%"=="4d" (Goto 3TM4D)
IF "%input%"=="5e" (Goto 3TM5E)
IF "%input%"=="5d" (Goto 3TM5D)
IF "%input%"=="6e" (Goto 3TM6E)
IF "%input%"=="6d" (Goto 3TM6D)
IF "%input%"=="7e" (Goto 3TM7E)
IF "%input%"=="7d" (Goto 3TM7D)
IF "%input%"=="8e" (Goto 3TM8E)
IF "%input%"=="8d" (Goto 3TM8D)

if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO TM3


:3TM0E
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f 
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
goto TM3

:3TM0D
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 3 /f 

goto TM3


:3TM1E
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
goto TM3

:3TM1D
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "0" /f
goto TM3

:3TM2E
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "2" /f

goto TM3

:3TM2D
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f

goto TM3

:3TM3E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "1" /f
goto TM3

:3TM3D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f

goto TM3


:3TM4E
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "0" /f
goto TM3

:3TM4D
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
goto TM3


:3TM5E
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f
goto TM3

:3TM5D
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "0" /f
goto TM3


:3TM6E
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
goto TM3

:3TM6D
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
goto TM3


:3TM7E
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f 
goto TM3

:3TM7D
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 
goto TM3


:3TM8E
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 

goto TM3

:3TM8D
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 3 /f 

goto TM3


:TM4
cls
echo **************************************************************************************
echo *    ____  ____  __  ____    ____  ____  __    ____  _  _  ____  ____  ____  _  _    *
echo *   / ___)(_  _)/  \(  _ \  (_  _)(  __)(  )  (  __)( \/ )(  __)(_  _)(  _ \( \/ )   *
echo *   \___ \  )( (  O )) __/    )(   ) _) / (_/\ ) _) / \/ \ ) _)   )(   )   / )  /    *
echo *   (____/ (__) \__/(__)     (__) (____)\____/(____)\_)(_/(____) (__) (__\_)(__/     *
echo *                                                                                    *
echo **************************************************************************************
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ Settings\Privacy            0E=Allow ALL  0D=Deny ALL                              บ
echo ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
echo บ Allow Apps to use your :
echo ศออออออหออออออออออออออออออ
echo        ฬอLocation          1E=Allow  1D=Deny 
echo        ฬอCamera            2E=Allow  2D=Deny 
echo        ฬอMicrophone        3E=Allow  3D=Deny 
echo        ฬอCalendar          4E=Allow  4D=Deny 
echo        ฬอMassaging         5E=Allow  5D=Deny 
echo        ฬอRadios            6E=Allow  6D=Deny 
echo        ฬอAccount info      7E=Allow  7D=Deny 
echo        ศอOther Devices     8E=Allow  8D=Deny 
echo.
echo   0.Go back to Previous page    X.Restart your PC (A.abort)
echo.
set /p input=* Write the tweak number here:
IF "%input%"=="0" (Goto TM3)
IF "%input%"=="X" (shutdown -r -t 30 -c "Windows will restart in 30 seconds" & goto TM4)
IF "%input%"=="x" (shutdown -r -t 30 -c "Windows will restart in 30 seconds" & goto TM4)
IF "%input%"=="A" (shutdown -a & goto TM4)
IF "%input%"=="a" (shutdown -a & goto TM4)
IF "%input%"=="0E" (Goto 4TM0E)
IF "%input%"=="0D" (Goto 4TM0D)
IF "%input%"=="1E" (Goto 4TM1E)
IF "%input%"=="1D" (Goto 4TM1D)
IF "%input%"=="2E" (Goto 4TM2E)
IF "%input%"=="2D" (Goto 4TM2D)
IF "%input%"=="3E" (Goto 4TM3E)
IF "%input%"=="3D" (Goto 4TM3D)
IF "%input%"=="4E" (Goto 4TM4E)
IF "%input%"=="4D" (Goto 4TM4D)
IF "%input%"=="5E" (Goto 4TM5E)
IF "%input%"=="5D" (Goto 4TM5D)
IF "%input%"=="6E" (Goto 4TM6E)
IF "%input%"=="6D" (Goto 4TM6D)
IF "%input%"=="7E" (Goto 4TM7E)
IF "%input%"=="7D" (Goto 4TM7D)
IF "%input%"=="8E" (Goto 4TM8E)
IF "%input%"=="8D" (Goto 4TM8D)
IF "%input%"=="9E" (Goto 4TM9E)
IF "%input%"=="9D" (Goto 4TM9D)
IF "%input%"=="10E" (Goto 4TM10E)
IF "%input%"=="10D" (Goto 4TM10D)
IF "%input%"=="11E" (Goto 4TM11E)
IF "%input%"=="11D" (Goto 4TM11D)
IF "%input%"=="0e" (Goto 4TM0E)
IF "%input%"=="0d" (Goto 4TM0D)
IF "%input%"=="1e" (Goto 4TM1E)
IF "%input%"=="1d" (Goto 4TM1D)
IF "%input%"=="2e" (Goto 4TM2E)
IF "%input%"=="2d" (Goto 4TM2D)
IF "%input%"=="3e" (Goto 4TM3E)
IF "%input%"=="3d" (Goto 4TM3D)
IF "%input%"=="4e" (Goto 4TM4E)
IF "%input%"=="4d" (Goto 4TM4D)
IF "%input%"=="5e" (Goto 4TM5E)
IF "%input%"=="5d" (Goto 4TM5D)
IF "%input%"=="6e" (Goto 4TM6E)
IF "%input%"=="6d" (Goto 4TM6D)
IF "%input%"=="7e" (Goto 4TM7E)
IF "%input%"=="7d" (Goto 4TM7D)
IF "%input%"=="8e" (Goto 4TM8E)
IF "%input%"=="8d" (Goto 4TM8D)
IF "%input%"=="9e" (Goto 4TM9E)
IF "%input%"=="9d" (Goto 4TM9D)
IF "%input%"=="10e" (Goto 4TM10E)
IF "%input%"=="10d" (Goto 4TM10D)
IF "%input%"=="11e" (Goto 4TM11E)
IF "%input%"=="11d" (Goto 4TM11D)


if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO TM4

:4TM0E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Allow" /f

goto TM4

:4TM0D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v "Value" /t REG_SZ /d "Deny" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Deny" /f

goto TM4



:4TM1E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Allow" /f

goto TM4

:4TM1D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f

goto TM4


:4TM2E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Allow" /f

goto TM4

:4TM2D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Deny" /f

goto TM4

:4TM3E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Allow" /f

goto TM4

:4TM3D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Deny" /f

goto TM4

:4TM4E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Allow" /f

goto TM4

:4TM4D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Deny" /f

goto TM4

:4TM5E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Allow" /f

goto TM4

:4TM5D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Deny" /f

goto TM4

:4TM6E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Allow" /f

goto TM4

:4TM6D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Deny" /f

goto TM4

:4TM7E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v "Value" /t REG_SZ /d "Allow" /f

goto TM4

:4TM7D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v "Value" /t REG_SZ /d "Deny" /f

goto TM4

:4TM8E
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Allow" /f

goto TM4

:4TM8D
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Deny" /f

goto TM4




:NETWORK
Cls
echo **************************************************************************************
echo *     __  __ _  ____  ____  ____  __ _  ____  ____    ____  __  _  _  ____  ____     *
echo *    (  )(  ( \(_  _)(  __)(  _ \(  ( \(  __)(_  _)  (  __)(  )( \/ )(  __)/ ___)    *
echo *     )( /    /  )(   ) _)  )   //    / ) _)   )(     ) _)  )(  )  (  ) _) \___ \    *
echo *    (__)\_)__) (__) (____)(__\_)\_)__)(____) (__)   (__)  (__)(_/\_)(____)(____/    *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Fix Empty "Network Connections" Folder (Network Adapters List)
echo   2.Disable Limit Reservable Bandwidth (kind of)network
echo   3.Restore "Windows Firewall"+"Network Adapter" settings to defaults
echo   4.Flush Windows DNS Cache (ipconfig /flushdns)
echo   5.Release and renew the IP address from DHCP server
echo.
echo   00.Apply all Fixes
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto Main)
IF "%input%"=="00" (GOTO NTW00)
IF "%input%"=="1" (Goto NTW1)
IF "%input%"=="2" (GOTO NTW2)
IF "%input%"=="3" (GOTO NTW3)
IF "%input%"=="4" (GOTO NTW4)
IF "%input%"=="5" (GOTO NTW5)
if %input% GTR 3 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO NETWORK

:NTW1
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Network" /v "Config" /f
GOTO NETWORK

:NTW2
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "Psched" /t REG_DWORD /d "0" /f
GOTO NETWORK

:NTW3
netsh int ip reset reset.txt
netsh winsock reset
netsh advfirewall reset
GOTO NETWORK

:NTW4
ipconfig /flushdns
GOTO NETWORK

:NTW5
ipconfig /release
ipconfig /renew
GOTO NETWORK


:NTW00
Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Network" /v "Config" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "Psched" /t REG_DWORD /d "0" /f
netsh int ip reset reset.txt
netsh winsock reset
netsh advfirewall reset
ipconfig /flushdns
ipconfig /release
ipconfig /renew

Call :functsuccess
GOTO NETWORK




:44
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Classic Alt-Tab    บAutomatic explorer.exe restartบ
echo   2.Disable Classic Alt-Tab   บAutomatic explorer.exe restartบ
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 44E)
IF "%input%"=="2" (GOTO 44D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 44

:44E
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AltTabSettings" /t REG_DWORD /d "1" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO UI

:44D
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AltTabSettings" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO UI


:45
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Increase Taskbar Thumbnail size to 0x190/400   บAutomatic explorer.exe restartบ
echo   2.Reset Taskbar Thumbnail size                   บAutomatic explorer.exe restartบ
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 45E)
IF "%input%"=="2" (GOTO 45D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 45

:45E
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "MinThumbSizePx" /t REG_DWORD /d "400" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO UI

:45D
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "MinThumbSizePx" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO UI



:46
Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo                                                      บAutomatic explorer.exe restartบ
echo.
echo   1.Neither the Taskbar or Start Menu+Action Centre colourised
echo   2.Both the Taskbar and Start Menu+Action Centre colourised                  
echo   3.Only the Taskbar colourised, and not the Start Menu+Action Centre
echo.
echo   4.Colourise Windows Title bars and borders     (Build 10586 Th2 and above)
echo   5.Decolourise Windows Title bars and borders   (Build 10586 Th2 and above)
echo.
echo   6.Set Inactive Title Bar Color   (Enter "T" to go to RGB color table)
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 461)
IF "%input%"=="2" (GOTO 462)
IF "%input%"=="3" (Goto 463)
IF "%input%"=="4" (GOTO 464)
IF "%input%"=="5" (GOTO 465)
IF "%input%"=="6" (GOTO 466)
IF "%input%"=="t" (start http://samples.msdn.microsoft.com/workshop/samples/author/dhtml/colors/ColorTable.htm & GOTO 46)
IF "%input%"=="T" (start http://samples.msdn.microsoft.com/workshop/samples/author/dhtml/colors/ColorTable.htm & GOTO 46)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 46



:461
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "ColorPrevalence" /t REG_DWORD /d "0" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO 46

:462
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "ColorPrevalence" /t REG_DWORD /d "1" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO 46

:463
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "ColorPrevalence" /t REG_DWORD /d "2" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO 46


:464
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d "1" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO 46

:465
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d "0" /f
taskkill /IM explorer.exe /F & explorer.exe
Call :functsuccess
GOTO 46


:466
set /p COLOR=* Write the RGB hex number here (ex: d3d3d3 for lightgray):

if "%COLOR%"==" " (GOTO 46)
if "%COLOR%"=="" (GOTO 46)

CD /D "%~dp0" 
> RegFile.reg Echo Windows Registry Editor Version 5.00
>> RegFile.reg Echo.
>> RegFile.reg Echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM]
>> RegFile.reg Echo "AccentColorInactive"=dword:%COLOR%

Start /Wait Regedit.exe /S RegFile.reg
Del RegFile.reg

Call :functsuccess
GOTO 46


:47

Cls
echo **************************************************************************************
echo *     _  _  ____  ____  ____    __  __ _  ____  ____  ____  ____  __    ___  ____    *
echo *    / )( \/ ___)(  __)(  _ \  (  )(  ( \(_  _)(  __)(  _ \(  __)/ _\  / __)(  __)   *
echo *    ) \/ (\___ \ ) _)  )   /   )( /    /  )(   ) _)  )   / ) _)/    \( (__  ) _)    *
echo *    \____/(____/(____)(__\_)  (__)\_)__) (__) (____)(__\_)(__) \_/\_/ \___)(____)   *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Show full Details in Delete Confirmation Dialog Prompt   
echo   2.Show Default Details in Delete Confirmation Dialog Prompt
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto UI)
IF "%input%"=="1" (Goto 47E)
IF "%input%"=="2" (GOTO 47D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 47

:47E
Reg.exe add "HKCR\AllFilesystemObjects" /v "FileOperationPrompt" /t REG_SZ /d "prop:System.PropGroup.FileSystem;System.ItemNameDisplay;System.ItemTypeText;System.ItemFolderPathDisplay;System.Size;System.DateCreated;System.DateModified;System.FileAttributes;System.OfflineAvailability;System.OfflineStatus;System.SharedWith;System.FileOwner;System.ComputerName" /f
Call :functsuccess
GOTO UI

:47D
Reg.exe delete "HKCR\AllFilesystemObjects" /v "FileOperationPrompt" /f
Reg.exe add "HKCR\AllFilesystemObjects" /f
Call :functsuccess
GOTO UI




:48
Cls
echo **************************************************************************************
echo *   ____  __ _   __   ____  __    ____    _  ____  __  ____   __   ____  __    ____  *
echo *  (  __)(  ( \ / _\ (  _ \(  )  (  __)  / )(    \(  )/ ___) / _\ (  _ \(  )  (  __) *
echo *   ) _) /    //    \ ) _ (/ (_/\ ) _)  / /  ) D ( )( \___ \/    \ ) _ (/ (_/\ ) _)  *
echo *  (____)\_)__)\_/\_/(____/\____/(____)(_/  (____/(__)(____/\_/\_/(____/\____/(____) *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Hide Safely Remove Hardware Tray Icon
echo   2.Restore Safely Remove Hardware Tray Icon
echo.
echo   0.Go back to Enable/Disable page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto E/D)
IF "%input%"=="1" (Goto 48D)
IF "%input%"=="2" (GOTO 48E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 48

:48D
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\SysTray" /v "Services" /t reg_dword /d 29 /f
Call :functsuccess
Goto E/D

:48E
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\SysTray" /v "Services" /t reg_dword /d 31 /f
Call :functsuccess
Goto E/D



:49
Cls
echo **************************************************************************************
echo *        ____  __  __    ____    ____  _  _  ____  __     __  ____  ____  ____       *
echo *       (  __)(  )(  )  (  __)  (  __)( \/ )(  _ \(  )   /  \(  _ \(  __)(  _ \      *
echo *        ) _)  )( / (_/\ ) _)    ) _)  )  (  ) __// (_/\(  O ))   / ) _)  )   /      *
echo *       (__)  (__)\____/(____)  (____)(_/\_)(__)  \____/ \__/(__\_)(____)(__\_)      *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Add "Install" context menu command for CAB Files
echo   2.Remove "Install" context menu command for CAB Files
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto FE)
IF "%input%"=="1" (Goto 49E)
IF "%input%"=="2" (GOTO 49D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 49

:49E
Reg.exe add "HKCR\CABFolder\Shell\runas" /ve /t REG_SZ /d "Install this update" /f
Reg.exe add "HKCR\CABFolder\Shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f
Reg.exe add "HKCR\CABFolder\Shell\runas\command" /ve /t REG_SZ /d "cmd /k dism /online /add-package /packagepath:\"%%1\"" /f
Call :functsuccess
Goto FE

:49D
Reg.exe delete "HKCR\CABFolder\Shell\runas" /f
Call :functsuccess
Goto FE


:50
Cls
echo **************************************************************************************
echo *        ____  __  __    ____    ____  _  _  ____  __     __  ____  ____  ____       *
echo *       (  __)(  )(  )  (  __)  (  __)( \/ )(  _ \(  )   /  \(  _ \(  __)(  _ \      *
echo *        ) _)  )( / (_/\ ) _)    ) _)  )  (  ) __// (_/\(  O ))   / ) _)  )   /      *
echo *       (__)  (__)\____/(____)  (____)(_/\_)(__)  \____/ \__/(__\_)(____)(__\_)      *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Disable "-Shortcut" Text for new shortcuts
echo   2.Enable "-Shortcut" Text for new shortcuts
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto FE)
IF "%input%"=="1" (Goto 50D)
IF "%input%"=="2" (GOTO 50E)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 50

:50E
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /f
Call :functsuccess
Goto FE

:50D
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /v "ShortcutNameTemplate" /t REG_SZ /d "\"%%s.lnk\"" /f
Call :functsuccess
Goto FE


:51
Cls
echo **************************************************************************************
echo *        ____  __  __    ____    ____  _  _  ____  __     __  ____  ____  ____       *
echo *       (  __)(  )(  )  (  __)  (  __)( \/ )(  _ \(  )   /  \(  _ \(  __)(  _ \      *
echo *        ) _)  )( / (_/\ ) _)    ) _)  )  (  ) __// (_/\(  O ))   / ) _)  )   /      *
echo *       (__)  (__)\____/(____)  (____)(_/\_)(__)  \____/ \__/(__\_)(____)(__\_)      *
echo *                                                                                    *
echo **************************************************************************************
echo.
echo   1.Enable Old Breifcase option in Folders Context menu
echo   2.Disable Old Breifcase option
echo.
echo   0.Go back to Main page
echo.
set /p input=* Write the number here:
IF "%input%"=="0" (Goto FE)
IF "%input%"=="1" (Goto 51E)
IF "%input%"=="2" (GOTO 51D)
if %input% GTR 2 echo.
echo Please enter a valid number
echo.
pause
cls
GOTO 51

:51E
Reg.exe add "HKCR\Briefcase\ShellNew" /v "Directory" /t REG_SZ /d "" /f
Reg.exe add "HKCR\Briefcase\ShellNew" /v "Handler" /t REG_SZ /d "{85BBD920-42A0-1069-A2E4-08002B30309D}" /f
Reg.exe add "HKCR\Briefcase\ShellNew" /v "IconPath" /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\syncui.dll,0" /f
Reg.exe add "HKCR\Briefcase\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\system32\shell32.dll,-6493" /f
Reg.exe add "HKCR\Briefcase\ShellNew\Config" /v "IsFolder" /t REG_SZ /d "" /f
Reg.exe add "HKCR\Briefcase\ShellNew\Config" /v "NoExtension" /t REG_SZ /d "" /f
Call :functsuccess
Goto FE

:51D
Reg.exe delete "HKCR\Briefcase\ShellNew" /f
Call :functsuccess
Goto FE

















:CALC32
mode con:cols=67 lines=3
echo Downloading and installing necessary files...
echo When completed you can open it with this command : calc.exe

:CALCDown
cd /d "%~dp0"
Set CurCD=%CD%

ping -n 1 www.google.com >nul
if errorlevel 1 (
  cls
   echo  Check your Internet So you can download the necessary file ...
   ping 127.0.0.1 -n 3 > NUL 2>&1
  goto E/D
)
REM legacy-Calculator-Win10.exe
echo strFileURL = "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfienBWVWRqaklDSVk" > CALC64.vbs
echo     strHDLocation = "%CD%\legacy-Calculator-Win10.exe" >> CALC64.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> CALC64.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> CALC64.vbs
echo objXMLHTTP.send() >> CALC64.vbs
echo If objXMLHTTP.Status = 200 Then >> CALC64.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> CALC64.vbs
echo objADOStream.Open>> CALC64.vbs
echo objADOStream.Type = 1 >> CALC64.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> CALC64.vbs
echo objADOStream.Position = 0    >> CALC64.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> CALC64.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> CALC64.vbs
echo Set objFSO = Nothing >> CALC64.vbs
echo objADOStream.SaveToFile strHDLocation >> CALC64.vbs
echo objADOStream.Close >> CALC64.vbs
echo Set objADOStream = Nothing >> CALC64.vbs
echo End if >> CALC64.vbs
echo Set objXMLHTTP = Nothing >> CALC64.vbs
cscript CALC64.vbs >nul 2>&1
del CALC64.vbs
legacy-Calculator-Win10.exe
del legacy-Calculator-Win10.exe

cd %CurCD%
mode con:cols=87 lines=28
cls
GOTO E/D





:7TASKM
mode con:cols=67 lines=3
echo Downloading and installing necessary files...
echo When completed you can open it with this shortcut: CTRL-Shift-ESC

:7TASKMDown
cd /d "%~dp0"
Set CurCD=%CD%

ping -n 1 www.google.com >nul
if errorlevel 1 (
  cls
   echo  Check your Internet So you can download the necessary file ...
   ping 127.0.0.1 -n 3 > NUL 2>&1
  goto WAmenu
)
Rem 7TASKM-Win10.exe
echo strFileURL = "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfianBUcjJ2cDFDSjg" > 7TM.vbs
echo     strHDLocation = "%CD%\7TASKM-Win10.exe" >> 7TM.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> 7TM.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> 7TM.vbs
echo objXMLHTTP.send() >> 7TM.vbs
echo If objXMLHTTP.Status = 200 Then >> 7TM.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> 7TM.vbs
echo objADOStream.Open>> 7TM.vbs
echo objADOStream.Type = 1 >> 7TM.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> 7TM.vbs
echo objADOStream.Position = 0    >> 7TM.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> 7TM.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> 7TM.vbs
echo Set objFSO = Nothing >> 7TM.vbs
echo objADOStream.SaveToFile strHDLocation >> 7TM.vbs
echo objADOStream.Close >> 7TM.vbs
echo Set objADOStream = Nothing >> 7TM.vbs
echo End if >> 7TM.vbs
echo Set objXMLHTTP = Nothing >> 7TM.vbs
cscript 7TM.vbs >nul 2>&1
del 7TM.vbs
7TASKM-Win10.exe
del 7TASKM-Win10.exe

cd %CurCD%
mode con:cols=87 lines=28
cls
GOTO WAmenu


:DelCortana

:DelCortanaY
cls
mode con:cols=65 lines=3

            echo  If Cortana is removed from system, it may not be restored ^^!
            set /p removeApp=* If you are really SURE, type "cortana" to continue: 
            IF "%removeApp%"=="cortana" (Goto DelCsure
 ) else (
mode con:cols=87 lines=28
            Goto E/d)
:DelCsure
cls

echo Working on it...
net stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1
taskkill /F /IM SearchUI.exe >nul 2>&1
cmd.exe /c takeown /f "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" /r /d y && icacls "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" /grant administrators:F /t >nul 2>&1
taskkill /F /IM SearchUI.exe >nul 2>&1
ren "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy\SearchUI.exe" "SearchUIC.exe" >nul 2>&1
rd /s /q "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" >nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f
taskkill /IM explorer.exe /F  >nul 2>&1
explorer.exe >nul 2>&1
cls
set /p input=* Reboot to apply changes (y/n)? 
if /i [%input%]==[y] shutdown -r -t 30 -c "Windows will restart in 30 seconds"
mode con:cols=87 lines=28
goto E/D




:DelCortanaR
cls
echo Working on it...

Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "1" /f

cd /d "%~dp0"
set CurCD=%cd%

echo strFileURL = "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiS0RoQ0NWNlczQlk" > TWV.vbs
echo     strHDLocation = "%CD%\Microsoft.Windows.Cortana_cw5n1h2txyewy.zip" >> TWV.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> TWV.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> TWV.vbs
echo objXMLHTTP.send() >> TWV.vbs
echo If objXMLHTTP.Status = 200 Then >> TWV.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> TWV.vbs
echo objADOStream.Open>> TWV.vbs
echo objADOStream.Type = 1 >> TWV.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> TWV.vbs
echo objADOStream.Position = 0    >> TWV.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> TWV.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> TWV.vbs
echo Set objFSO = Nothing >> TWV.vbs
echo objADOStream.SaveToFile strHDLocation >> TWV.vbs
echo objADOStream.Close >> TWV.vbs
echo Set objADOStream = Nothing >> TWV.vbs
echo End if >> TWV.vbs
echo Set objXMLHTTP = Nothing >> TWV.vbs
cscript TWV.vbs
Del TWV.vbs
    > j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO ' UnZip a file script
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO ' Dim ArgObj, var1, var2
    >> j_unzip.vbs ECHO Set ArgObj = WScript.Arguments
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If (Wscript.Arguments.Count ^> 0) Then
    >> j_unzip.vbs ECHO. var1 = ArgObj(0)
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. var1 = ""
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If var1 = "" then
    >> j_unzip.vbs ECHO. strFileZIP = "example.zip"
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. strFileZIP = var1
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO 'The location of the zip file.
    >> j_unzip.vbs ECHO REM Set WshShell = CreateObject("Wscript.Shell")
    >> j_unzip.vbs ECHO REM CurDir = WshShell.ExpandEnvironmentStrings("%%cd%%")
    >> j_unzip.vbs ECHO Dim sCurPath
    >> j_unzip.vbs ECHO sCurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
    >> j_unzip.vbs ECHO strZipFile = sCurPath ^& "\" ^& strFileZIP
    >> j_unzip.vbs ECHO 'The folder the contents should be extracted to.
    >> j_unzip.vbs ECHO outFolder = sCurPath ^& "\"
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracting file " ^& strFileZIP)
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO Set objShell = CreateObject( "Shell.Application" )
    >> j_unzip.vbs ECHO Set objSource = objShell.NameSpace(strZipFile).Items()
    >> j_unzip.vbs ECHO Set objTarget = objShell.NameSpace(outFolder)
    >> j_unzip.vbs ECHO intOptions = 256
    >> j_unzip.vbs ECHO objTarget.CopyHere objSource, intOptions
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracted." )
    >> j_unzip.vbs ECHO.
cscript /B j_unzip.vbs Microsoft.Windows.Cortana_cw5n1h2txyewy.zip
del j_unzip.vbs
del Microsoft.Windows.Cortana_cw5n1h2txyewy.zip

taskkill /F /IM SearchUI.exe >nul 2>&1
cmd.exe /c takeown /f "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" /r /d y && icacls "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" /grant administrators:F /t >nul 2>&1
rd /s /q "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" >nul 2>&1
Xcopy /E /C /I /H /Y %cd%\Microsoft.Windows.Cortana_cw5n1h2txyewy %windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy
rd /s /q "%cd%\Microsoft.Windows.Cortana_cw5n1h2txyewy" >nul 2>&1

taskkill /IM explorer.exe /F  >nul 2>&1
explorer.exe >nul 2>&1
sc config WSearch start= auto >nul 2>&1
net start WSearch >nul 2>&1

pause
cls
echo CreateObject("WScript.Shell").Popup "Operation Completed successfully.", 1.5, "Toggle Tweaker"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs



mode con:cols=87 lines=28
goto E/D




:DVDapp
mode con:cols=65 lines=30
echo Downloading and installing necessary files... (1/5)


for /f "delims= " %%a in ('"wmic path win32_useraccount where name='%UserName%' get sid"') do (
   if not "%%a"=="SID" (          
      set sid=%%a
      goto :DelReg
   )   
)

:DelReg
Reg.exe delete "HKEY_CLASSES_ROOT\Installer\Products\AAD08E5278DF5ECD02C2CC206F760320" /f >nul 2>&1
reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\%sid%\Microsoft.WindowsDVDPlayer_2019.6.13291.0_neutral_~_8wekyb3d8bbwe" /f >nul 2>&1


if exist "%SYSTEMDRIVE%\Program Files (x86)\" (
   Set Arch=64
   GOTO DVDDown
) else (
   Set Arch=32
   GOTO DVDDown
)

:DVDDown
cd /d "%~dp0"
Set CurCD=%CD%

ping -n 1 www.google.com >nul
if errorlevel 1 (
  cls
   echo  Check your Internet So you can download the necessary file ... 
   ping 127.0.0.1 -n 3 > NUL 2>&1
mode con:cols=87 lines=28
Goto E/D
)

cls
echo Downloading and installing necessary files... (2/5)
REM SetACL.zip
echo strFileURL = "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHficTNjbFA1TlNTSUk" > DVDappU.vbs
echo     strHDLocation = "%CD%\SetACL.zip" >> DVDappU.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> DVDappU.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> DVDappU.vbs
echo objXMLHTTP.send() >> DVDappU.vbs
echo If objXMLHTTP.Status = 200 Then >> DVDappU.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> DVDappU.vbs
echo objADOStream.Open>> DVDappU.vbs
echo objADOStream.Type = 1 >> DVDappU.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> DVDappU.vbs
echo objADOStream.Position = 0    >> DVDappU.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> DVDappU.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> DVDappU.vbs
echo Set objFSO = Nothing >> DVDappU.vbs
echo objADOStream.SaveToFile strHDLocation >> DVDappU.vbs
echo objADOStream.Close >> DVDappU.vbs
echo Set objADOStream = Nothing >> DVDappU.vbs
echo End if >> DVDappU.vbs
echo Set objXMLHTTP = Nothing >> DVDappU.vbs
cscript DVDappU.vbs >nul 2>&1
del DVDappU.vbs

REM This script upzip's files...

    > j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO ' Dim ArgObj, var1, var2
    >> j_unzip.vbs ECHO Set ArgObj = WScript.Arguments
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If (Wscript.Arguments.Count ^> 0) Then
    >> j_unzip.vbs ECHO. var1 = ArgObj(0)
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. var1 = ""
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If var1 = "" then
    >> j_unzip.vbs ECHO. strFileZIP = "example.zip"
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. strFileZIP = var1
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO 'The location of the zip file.
    >> j_unzip.vbs ECHO REM Set WshShell = CreateObject("Wscript.Shell")
    >> j_unzip.vbs ECHO REM CurDir = WshShell.ExpandEnvironmentStrings("%%cd%%")
    >> j_unzip.vbs ECHO Dim sCurPath
    >> j_unzip.vbs ECHO sCurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
    >> j_unzip.vbs ECHO strZipFile = sCurPath ^& "\" ^& strFileZIP
    >> j_unzip.vbs ECHO 'The folder the contents should be extracted to.
    >> j_unzip.vbs ECHO outFolder = sCurPath ^& "\"
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracting file " ^& strFileZIP)
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO Set objShell = CreateObject( "Shell.Application" )
    >> j_unzip.vbs ECHO Set objSource = objShell.NameSpace(strZipFile).Items()
    >> j_unzip.vbs ECHO Set objTarget = objShell.NameSpace(outFolder)
    >> j_unzip.vbs ECHO intOptions = 256
    >> j_unzip.vbs ECHO objTarget.CopyHere objSource, intOptions
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracted." )
    >> j_unzip.vbs ECHO.


cscript /B j_unzip.vbs SetACL.zip
del j_unzip.vbs
del SetACL.zip
CD "%CD%\SetACL (executable version)\%Arch% bit"

cls
echo Downloading and installing necessary files... (3/5)

echo "machine\SYSTEM\CurrentControlSet\Services\ADOVMPPackage\Final",4,"O:SYG:SYD:AI(A;CI;CCDCLCSWRPRC;;;IU)(A;CI;CCDCLCSWRPRC;;;SY)(A;CI;CCDCLCSWRPRC;;;BA)(A;CIID;KR;;;BU)(A;CIID;KA;;;BA)(A;CIID;KA;;;SY)(A;CIIOID;KA;;;CO)(A;CIID;KR;;;AC)" > ADOVMPPackage.txt
setACL -on "HKLM\SYSTEM\CurrentControlSet\Services\ADOVMPPackage" -ot reg -actn setowner -ownr "n:S-1-5-32-544;s:y" -rec yes >nul 2>&1
setACL -on "HKLM\SYSTEM\CurrentControlSet\Services\ADOVMPPackage" -ot reg -actn ace -ace "n:S-1-5-32-544;s:y;p:full" -rec yes >nul 2>&1
SetACL.exe -on "HKLM\SYSTEM\CurrentControlSet\Services\ADOVMPPackage\Final" -ot reg -actn restore -bckp .\ADOVMPPackage.txt >nul 2>&1

reg.exe add HKLM\SYSTEM\CurrentControlSet\Services\ADOVMPPackage\Final /v ActivationEnabled /t REG_DWORD /d 2 /f >nul 2>&1

CD %CurCD%
RMDIR /S /Q "%CD%\SetACL (executable version)" >nul 2>&1
RMDIR /S /Q "%CD%\SetACL (executable version)" >nul 2>&1
del ADOVMPPackage.txt >nul 2>&1

cls
echo Downloading and installing necessary files... (4/5)


del windows10.0-kb3106246-x64_38be8cc4777aadd5eba00476326eaca6952e06c1.cab >nul 2>&1

echo strFileURL = "http://download.windowsupdate.com/c/msdownload/update/software/updt/2015/11/windows10.0-kb3106246-x64_38be8cc4777aadd5eba00476326eaca6952e06c1.cab" > DVDapp.vbs
echo     strHDLocation = "%CD%\windows10.0-kb3106246-x64_38be8cc4777aadd5eba00476326eaca6952e06c1.cab" >> DVDapp.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> DVDapp.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> DVDapp.vbs
echo objXMLHTTP.send() >> DVDapp.vbs
echo If objXMLHTTP.Status = 200 Then >> DVDapp.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> DVDapp.vbs
echo objADOStream.Open>> DVDapp.vbs
echo objADOStream.Type = 1 >> DVDapp.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> DVDapp.vbs
echo objADOStream.Position = 0    >> DVDapp.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> DVDapp.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> DVDapp.vbs
echo Set objFSO = Nothing >> DVDapp.vbs
echo objADOStream.SaveToFile strHDLocation >> DVDapp.vbs
echo objADOStream.Close >> DVDapp.vbs
echo Set objADOStream = Nothing >> DVDapp.vbs
echo End if >> DVDapp.vbs
echo Set objXMLHTTP = Nothing >> DVDapp.vbs
cscript DVDapp.vbs >nul 2>&1
del DVDapp.vbs

REM This script upzip's files...

    > j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO ' Dim ArgObj, var1, var2
    >> j_unzip.vbs ECHO Set ArgObj = WScript.Arguments
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If (Wscript.Arguments.Count ^> 0) Then
    >> j_unzip.vbs ECHO. var1 = ArgObj(0)
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. var1 = ""
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If var1 = "" then
    >> j_unzip.vbs ECHO. strFileZIP = "example.zip"
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. strFileZIP = var1
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO 'The location of the zip file.
    >> j_unzip.vbs ECHO REM Set WshShell = CreateObject("Wscript.Shell")
    >> j_unzip.vbs ECHO REM CurDir = WshShell.ExpandEnvironmentStrings("%%cd%%")
    >> j_unzip.vbs ECHO Dim sCurPath
    >> j_unzip.vbs ECHO sCurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
    >> j_unzip.vbs ECHO strZipFile = sCurPath ^& "\" ^& strFileZIP
    >> j_unzip.vbs ECHO 'The folder the contents should be extracted to.
    >> j_unzip.vbs ECHO outFolder = sCurPath ^& "\"
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracting file " ^& strFileZIP)
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO Set objShell = CreateObject( "Shell.Application" )
    >> j_unzip.vbs ECHO Set objSource = objShell.NameSpace(strZipFile).Items()
    >> j_unzip.vbs ECHO Set objTarget = objShell.NameSpace(outFolder)
    >> j_unzip.vbs ECHO intOptions = 256
    >> j_unzip.vbs ECHO objTarget.CopyHere objSource, intOptions
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracted." )
    >> j_unzip.vbs ECHO.


cscript /B j_unzip.vbs windows10.0-kb3106246-x64_38be8cc4777aadd5eba00476326eaca6952e06c1.cab
del j_unzip.vbs
del windows10.0-kb3106246-x64_38be8cc4777aadd5eba00476326eaca6952e06c1.cab

if exist "%SYSTEMDRIVE%\Program Files (x86)\" (
   Set Arch=64
   GOTO DVDInstall
) else (
   Set Arch=86
   GOTO DVDInstall
)


:DVDInstall
cls
echo Downloading and installing necessary files... (5/5)

windows10.0-kb3106246-x%Arch%.msi

del windows10.0-kb3106246-x64.msi
del windows10.0-kb3106246-x86.msi

echo CreateObject("WScript.Shell").Popup "Operation Completed successfully.", 1.5, "Toggle Tweaker"> msgbox.vbs
cscript msgbox.vbs >nul 2>&1
Del msgbox.vbs

mode con:cols=87 lines=28
GOTO E/D




:UndoALL
echo.
choice /c yn /m "Are you sure you want to UNDO all tweaks made by Toogle Tweaker"
echo.
if %errorlevel% equ 2 Goto Settings
if %errorlevel% equ 1 GOTO UndoALLY
:UndoALLY
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Internet Settings\Zones\3" /v "1400" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\SysTray" /v "Services" /t reg_dword /d 31 /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "0" /f
Reg.exe delete "HKCR\AllFilesystemObjects" /v "FileOperationPrompt" /f
Reg.exe add "HKCR\AllFilesystemObjects" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v "EnableMtcUvc" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseActionCenterExperience" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseWin32BatteryFlyout" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Default Download Directory" /t REG_SZ /d "shell:Downloads" /f
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "AskToCloseAllTabs" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "EnableCortana" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Addons" /v "FlashPlayerEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\LinksBar" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "NewTabPageDisplayOption" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "EnablePreviewBuilds" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "ThresholdFlightsDisabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /v "Ring" /t REG_SZ /d "Enabled" /f
Reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "3" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d "0" /f
powercfg -h off
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" / v "DisableFileSyncNGSC" / f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" / v "DisableLibrariesDefaultSaveToOneDrive" / f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" / v "DisableMeteredNetworkFileSync" / f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" / v "DisableFileSyncNGSC" / f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" / v "DisableLibrariesDefaultSaveToOneDrive" / f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" / v "DisableMeteredNetworkFileSync" / f 
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" / v "System.IsPinnedToNameSpaceTree" / t REG_DWORD / d 1 / f 
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" / v "System.IsPinnedToNameSpaceTree" / t REG_DWORD / d 1 / f 
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" / v "System.IsPinnedToNameSpaceTree" / t REG_DWORD / d 1 / f 
reg add "HKEY_CURRENT_USER\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" / v "System.IsPinnedToNameSpaceTree" / t REG_DWORD / d 1 / f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" / v "OneDrive" / t REG_SZ / d "\"% USERPROFILE% \ AppData \ Local \ Microsoft \ OneDrive \ OneDrive.exe \ "/ background" / f
Reg.exe add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
Reg.exe add "HKCR\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableBlurBehind" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Prompt" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d "0" /f
powercfg -setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100
powercfg -setactive scheme_current
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "5000" /f
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "10000" /f
reg add "HKLM\System\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "10000" /f
sc config BDESVC start= auto
sc config EFS start= auto
sc config CscService start= auto
sc config LanmanServer start= auto
sc config ALG start= auto
sc config IKEEXT start= auto
sc config SstpSvc start= auto
sc config SSDPSRV start= auto 
sc config WebClient start= auto 
sc config WMPNetworkSvc start= auto 
sc config dmwappushservice start= auto
sc config diagnosticshub.standardcollector.service start= auto
sc config TrkWks start= auto
sc config CertPropSvc start= auto
sc config DPS start= auto
sc config iphlpsvc start= auto
sc config PcaSvc start= auto
sc config RemoteRegistry start= auto
sc config WinHttpAutoProxySvc start= auto
sc config WPDBusEnum start= auto
sc config AJRouter start= auto
sc config XboxNetApiSvc start= auto
sc config KeyIso start= auto
sc config MSDTC start= auto
sc config PolicyAgent start= auto
sc config WbioSrvc start= auto
sc config SysMain start= auto
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "3" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d "1" /f      
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "OptimizeComplete" /t REG_SZ /d "Yes" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "Enable" /t REG_SZ /d "Y" /f
compact /CompactOs:always
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "LaunchTo" /t REG_DWORD /d 2
Reg.exe delete "HKCR\*\shell\runas" /f
Reg.exe delete "HKCR\exefile\shell\runas2" /f
Reg.exe delete "HKCR\Directory\shell\runas" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "DisableLogonBackgroundImage" /t REG_DWORD /d "0" /f
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V IconsOnly /T REG_DWORD /D 0 /F
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssist" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d "0" /f
netsh advfirewall set allprofiles state on
Reg.exe delete "HKCR\*\shell\Select" /f
Reg.exe delete "HKCR\Folder\shell\Select" /f
Reg.exe delete "HKCR\Directory\Background\shell\Select" /f
Reg.exe delete "HKCR\LibraryFolder\Background\shell\Select" /f
Reg.exe delete "HKCR\Folder\shell\pintohome" /f
Reg.exe add "HKCR\Folder\shell\pintohome" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-51377" /f
Reg.exe add "HKCR\Folder\shell\pintohome" /v "AppliesTo" /t REG_SZ /d "System.ParsingName:<>\"::{679f85cb-0220-4080-b29b-5540cc05aab6}\"" /f
Reg.exe add "HKCR\Folder\shell\pintohome\command" /v "DelegateExecute" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-51377" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /v "AppliesTo" /t REG_SZ /d "System.ParsingName:<>\"::{679f85cb-0220-4080-b29b-5540cc05aab6}\"" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome\command" /v "DelegateExecute" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f
Reg.exe delete "HKCR\DesktopBackground\Shell\Personalization" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "ControlPanelName" /t REG_SZ /d "Microsoft.Display" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "ControlPanelPage" /t REG_SZ /d "Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "Icon" /t REG_SZ /d "%%SystemRoot%%\System32\display.dll,-1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "Position" /t REG_SZ /d "Bottom" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /ve /t REG_SZ /d "@%%SystemRoot%%\system32\Display.dll,-300" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
Reg.exe delete "HKCR\DesktopBackground\Shell\Power" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Lock" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SwitchUser" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SignOut" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\sleep" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\hibernate" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\ShutDown" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\HybridShutdown" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\SlideToShutdown" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Restart" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\BootOptions" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 1 /f 
reg add hklm\software\microsoft\.netframework /v OnlyUseLatestCLR /t REG_DWORD /d 0
reg add hklm\software\wow6432node\microsoft\.netframework /v OnlyUseLatestCLR /t REG_DWORD /d 0
Reg.exe add "HKCR\IE.AssocFile.URL" /v "IsShortcut" /t REG_SZ /d "" /f
Reg.exe add "HKCR\InternetShortcut" /v "IsShortcut" /t REG_SZ /d "" /f
Reg.exe add "HKCR\lnkfile" /v "IsShortcut" /t REG_SZ /d "" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v "29" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /f
Reg.exe delete "HKCR\DesktopBackground\Shell\Bluetooth" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites" /v "Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer" /v "AllowServicePoweredQSA" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "yes" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions" /v "NoUpdateCheck" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v "PolicyDisableGeolocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "Use FormSuggest" /t REG_SZ /d "yes" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "DoNotTrack" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "FormSuggest Passwords" /t REG_SZ /d "yes" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\SearchScopes" /v "ShowSearchSuggestionsGlobal" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f
chcp 1251> nul 
echo.
REM --- Block Microsoft Telemetry IP "Default" --- 
netsh.exe advfirewall firewall delete rule name="Block Microsoft Telemetry IP"
chcp 1251> nul 
echo 
REM --- Turning the indexing service, tracking and collection of information to send the "Default" --- 
sc config DiagTrack start=auto 
sc config diagnosticshub.standardcollector.service start=demand 
sc config dmwappushservice start=delayed-auto 
sc config WMPNetworkSvc start=demand 
net start DiagTrack 


REM --- Turning of telemetry and data acquisition "Default" --- 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 2 /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /f 
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f 

REM --- The frequency of the formation of reviews "Default" --- 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /f 
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f 

REM --- Turning jobs in the scheduler to collect your information to send, and others. "Default" --- 
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Enable 
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Enable 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\HypervisorFlightingTask" /Enable 
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Enable 
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Enable 
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Enable 
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Enable 
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Enable 
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Enable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Enable 
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Enable 
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Enable 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 3 /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\MRT" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f
reg delete "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f 
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f 
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Allow" /f
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AltTabSettings" /f
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "MinThumbSizePx" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgrade" /t REG_DWORD /d "1" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\7971f918-a847-4430-9279-4a52d1efe18d" /v "RegisteredWithAU" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Allow" /f
FOR /F "tokens=2*" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v "LastLoggedOnUserSID" 2^>nul') do (SET UID=%%b)
Reg.exe add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%UID%" /v "FeatureStates" /t REG_SZ /d "893" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 1 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 0 /f 
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 1 /f 


set /p input=* Reboot to apply changes (y/n)? 
if /i [%input%]==[y] shutdown -r -t 5 -c "Windows will restart in 5 seconds"
goto Main

:LTSB
Cls
echo **************************************************************************************
echo *  ____  ____   __    _  _  _   __   _  _  ____   ____  __    __   ____  ____  ____  *
echo * (  _ \(  _ \ /  \  / )/ )( \ /  \ ( \/ )(  __) (_  _)/  \  (  ) (_  _)/ ___)(  _ \ *
echo *  ) __/ )   /(  O )/ / ) __ ((  O )/ \/ \ ) _)    )( (  O ) / (_/\ )(  \___ \ ) _ ( *
echo * (__)  (__\_) \__/(_/  \_)(_/ \__/ \_)(_/(____)  (__) \__/  \____/(__) (____/(____/ *
echo *                                                                                    *
echo **************************************************************************************
echo   ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo   บ ณTurn Pro/Home version to LTSB                                                  บ
echo   บ      ฬอThis will : Remove Microsoft Edge completely using "install_wim_tweak"   บ
echo   บ      บ             Remove Cortana and it's Telemetry                            บ
echo   บ      บ             Remove All modern apps and Windows store                     บ
echo   บ      บ             Restore Win32 Calculator                                     บ
echo   บ      ฬอ You should be connected to Internet to download necessary files.        บ
echo   บ      ศอ Microsoft .NET Framework 3.5 shoold be installed.                       บ
echo   ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
     echo.
            set /p removeApp=* If you are really SURE, type "Goto LTSB" to continue: 
            IF "%removeApp%"=="Goto LTSB" (Goto LTSBActiveY
 ) else (
mode con:cols=87 lines=28
goto Main)


:LTSBActiveY
cls
ping -n 1 drive.google.com >nul
if errorlevel 1 (
  cls
   echo  Check your Internet so that the script can download necessary files...
   ping 127.0.0.1 -n 3 > NUL 2>&1
  goto LTSB
)



echo Removing Cortana ...
net stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1
taskkill /F /IM SearchUI.exe >nul 2>&1
cmd.exe /c takeown /f "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" /r /d y  >nul 2>&1 && icacls "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" /grant administrators:F /t >nul 2>&1
taskkill /F /IM SearchUI.exe >nul 2>&1
ren "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy\SearchUI.exe" "SearchUIC.exe" >nul 2>&1
rd /s /q "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" >nul 2>&1
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f >nul 2>&1
echo Done.

echo Removing Microsoft Edge ...
cd /d "%~dp0" >nul 2>&1
Set CurCD=%CD% >nul 2>&1
MKDIR "%HOMEDRIVE%\TW\" >nul 2>&1
attrib +h %HOMEDRIVE%\TW >nul 2>&1
cd %HOMEDRIVE%\TW >nul 2>&1

echo strFileURL = "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiMXVVeklkeU8wcEk" > EDGETW.vbs
echo     strHDLocation = "%CD%\EDGETW.zip" >> EDGETW.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> EDGETW.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> EDGETW.vbs
echo objXMLHTTP.send() >> EDGETW.vbs
echo If objXMLHTTP.Status = 200 Then >> EDGETW.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> EDGETW.vbs
echo objADOStream.Open>> EDGETW.vbs
echo objADOStream.Type = 1 >> EDGETW.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> EDGETW.vbs
echo objADOStream.Position = 0    >> EDGETW.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> EDGETW.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> EDGETW.vbs
echo Set objFSO = Nothing >> EDGETW.vbs
echo objADOStream.SaveToFile strHDLocation >> EDGETW.vbs
echo objADOStream.Close >> EDGETW.vbs
echo Set objADOStream = Nothing >> EDGETW.vbs
echo End if >> EDGETW.vbs
echo Set objXMLHTTP = Nothing >> EDGETW.vbs
cscript EDGETW.vbs >nul 2>&1
del EDGETW.vbs >nul 2>&1

REM This script upzip's files...

    > j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO ' UnZip a file script
    >> j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO ' It's a mess, I know!!!
    >> j_unzip.vbs ECHO '
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO ' Dim ArgObj, var1, var2
    >> j_unzip.vbs ECHO Set ArgObj = WScript.Arguments
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If (Wscript.Arguments.Count ^> 0) Then
    >> j_unzip.vbs ECHO. var1 = ArgObj(0)
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. var1 = ""
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO If var1 = "" then
    >> j_unzip.vbs ECHO. strFileZIP = "example.zip"
    >> j_unzip.vbs ECHO Else
    >> j_unzip.vbs ECHO. strFileZIP = var1
    >> j_unzip.vbs ECHO End if
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO 'The location of the zip file.
    >> j_unzip.vbs ECHO REM Set WshShell = CreateObject("Wscript.Shell")
    >> j_unzip.vbs ECHO REM CurDir = WshShell.ExpandEnvironmentStrings("%%cd%%")
    >> j_unzip.vbs ECHO Dim sCurPath
    >> j_unzip.vbs ECHO sCurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
    >> j_unzip.vbs ECHO strZipFile = sCurPath ^& "\" ^& strFileZIP
    >> j_unzip.vbs ECHO 'The folder the contents should be extracted to.
    >> j_unzip.vbs ECHO outFolder = sCurPath ^& "\"
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracting file " ^& strFileZIP)
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO Set objShell = CreateObject( "Shell.Application" )
    >> j_unzip.vbs ECHO Set objSource = objShell.NameSpace(strZipFile).Items()
    >> j_unzip.vbs ECHO Set objTarget = objShell.NameSpace(outFolder)
    >> j_unzip.vbs ECHO intOptions = 256
    >> j_unzip.vbs ECHO objTarget.CopyHere objSource, intOptions
    >> j_unzip.vbs ECHO.
    >> j_unzip.vbs ECHO. WScript.Echo ( "Extracted." )
    >> j_unzip.vbs ECHO.

cscript /B j_unzip.vbs EDGETW.zip >nul 2>&1
del j_unzip.vbs >nul 2>&1



cd %CurCD%
for /f "tokens=2 delims==" %%A in ('wmic path Win32_Processor Get AddressWidth /format:list') do (set OA=%%A) >nul 2>&1
net start trustedinstaller >nul 2>&1

"%HOMEDRIVE%\TW\runassystem%OA%" "%HOMEDRIVE%\TW\runfromtoken%OA% trustedinstaller.exe 1 %HOMEDRIVE%\TW\Packages.cmd" >nul 2>&1

echo Done.

Echo Removing Modern apps and Store ...
    powershell.exe -command "Get-AppxPackage | Remove-AppxPackage *> $null"  >nul 2>&1
echo Done.

echo installing Legacy Calculator ...

cd /d "%~dp0"
Set CurCD=%CD%


echo strFileURL = "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfienBWVWRqaklDSVk" > CALC64.vbs
echo     strHDLocation = "%CD%\legacy-Calculator-Win10.exe" >> CALC64.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> CALC64.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> CALC64.vbs
echo objXMLHTTP.send() >> CALC64.vbs
echo If objXMLHTTP.Status = 200 Then >> CALC64.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> CALC64.vbs
echo objADOStream.Open>> CALC64.vbs
echo objADOStream.Type = 1 >> CALC64.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> CALC64.vbs
echo objADOStream.Position = 0    >> CALC64.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> CALC64.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> CALC64.vbs
echo Set objFSO = Nothing >> CALC64.vbs
echo objADOStream.SaveToFile strHDLocation >> CALC64.vbs
echo objADOStream.Close >> CALC64.vbs
echo Set objADOStream = Nothing >> CALC64.vbs
echo End if >> CALC64.vbs
echo Set objXMLHTTP = Nothing >> CALC64.vbs
cscript CALC64.vbs >nul 2>&1
del CALC64.vbs
legacy-Calculator-Win10.exe
del legacy-Calculator-Win10.exe

cd %CurCD%

:LTSBD
echo Done.


taskkill /IM explorer.exe /F >nul 2>&1
explorer.exe >nul 2>&1
pause
set /p input=* Reboot to apply changes (y/n)? 
if /i [%input%]==[y] shutdown -r -t 5 -c "Windows will restart in 5 seconds"
mode con:cols=87 lines=28
goto MAIN

:Search
cd /d "%~dp0"
set /p Keyword=* Enter a keyword to search for a specified option: 
if /i [!Keyword!]==[] (echo.
echo Please enter a valid keyword
echo.
pause
cls
GOTO Main)

if /i [!Keyword!]==[0] (echo.
cls
GOTO Main)

if /i [!Keyword!]==[:] (echo.
echo Please enter a valid keyword
echo.
pause
cls
GOTO Main)

(
echo Check Windows Activation Status : Check Windows Activation Status : 1=^>1
echo Check Office "2016/2013/2010" Activation Status : Check Office "2016/2013/2010" Activation Status : 1=^>2
echo Activate Windows/Office Using KMSPico : Activate Windows/Office Using KMSPico : 1=^>3
echo Dark Theme For Apps : Dark Theme For Apps : 2=^>1
echo Taskview button in Taskbar : Taskview button in Taskbar : 2=^>2
echo Volume Control UI : Volume Control UI : 2=^>3
echo Notification center UI : Notification center UI : 2=^>4
echo Battery Status UI : Battery Status UI : 2=^>5
echo Change Cortana size in Taskbar : Change Cortana size in Taskbar : 2=^>6
echo Transparency and Blur in : Taskbar-Notification center-Clock. : Transparency and Blur in : Taskbar-Notification center-Clock. : 2=^>7
echo Replace Logon screen Background Image with your accent color : Replace Logon screen Background Image with your accent color : 2=^>8
echo Enable/Disable Thumbnail Previews in File explorer : Enable/Disable Thumbnail Previews in File explorer : 2=^>9
echo Change OEM Information : Change OEM Information : 2=^>10
echo Context Menu Tweaks : Context Menu Tweaks : 2=^>11
echo Add "Grant Admin Full Control" to Files and Folders : Add "Grant Admin Full Control" to Files and Folders : 2=^>10=^>2=^>1
echo Add Select Context menu : Add Select Context menu : 2=^>11=^>2
echo Remove Pin to Quick access : Remove Pin to Quick access : 2=^>11=^>3
echo Add classic Personalize to Desktop : Add classic Personalize to Desktop : 2=^>11=^>4
echo Remove Screen Resolution from Desktop : Remove Screen Resolution from Desktop : 2=^>11=^>5
echo Add Power Options to Desktop : Add Power Options to Desktop : 2=^>11=^>6
echo Add Bluetooth to Desktop : Add Bluetooth to Desktop : 2=^>11=^>7
echo Add Open with Notepad to Files : Add Open with Notepad to Files : 2=^>11=^>8
echo Alt-Tab Screen UI : Alt-Tab Screen UI : 2=^>12
echo Increase Taskbar Thumbnail size to 0x190/400 : Increase Taskbar Thumbnail size to 0x190/400 : 2=^>13
echo Colourise or Decolourise "Start Menu + Taskbar" and "Title bars + Borders" : Colourise or Decolourise "Start Menu + Taskbar" and "Title bars + Borders" : 2=^>14
echo Set Inactive Title Bar Color : Set Inactive Title Bar Color : 2=^>10=^>5=^>6
echo Enable/Disable Windows Defender Real-Time protection : Enable/Disable Windows Defender Real-Time protection : 3=^>1
echo Enable/Disable Lockscreen : Enable/Disable Lockscreen : 3=^>2
echo Enable/Disable Hibernation : Enable/Disable Hibernation : 3=^>3
echo Remove shortcut arrow : Remove shortcut arrow : 3=^>4
echo Enable/Disable Windows Smart Screen Filter : Enable/Disable Windows Smart Screen Filter : 3=^>5
echo Disable default Quick Access view in Explorer : Disable default Quick Access view in Explorer : 3=^>6
echo Enable/Disable Snap Assist : Enable/Disable Snap Assist : 3=^>7
echo Enable/Disable "You have new app that can open this file." Notification : Enable/Disable "You have new app that can open this file." Notification : 3=^>8
echo Enable/Disable Windows Firewall : Enable/Disable Windows Firewall : 3=^>9
echo Manage Folders In "This PC" : Manage Folders In "This PC" : 2=^>16=^>1
echo Force .net apps to always use the latest Framework version installed : Force .net apps to always use the latest Framework version installed : 3=^>11
echo Disable Cortana : Disable Cortana : 3=^>12
echo Measure your PC restart time : Measure your PC restart time : 4=^>10
echo Disable CPU Core Parking For more CPU Performance : Disable CPU Core Parking For more CPU Performance : 4=^>1
echo Speed up apps and services End Tasks : Speed up apps and services End Tasks : 4=^>2
echo Disable Some unnecessary services to speed up restart time : Disable Some unnecessary services to speed up restart time : 4=^>3
echo Boost SSD Performance : Boost SSD Performance : 4=^>4
echo Disable Edge Ads : Disable Edge Ads : 5=^>1
echo Edge Dark/Light Theme : Edge Dark/Light Theme : 5=^>2
echo Change Edge Browser Home Button page : Change Edge Browser Home Button page : 5=^>3
echo Change Edge default download directory : Change Edge default download directory : 5=^>4
echo Edge Ask to close all tabs ? : Edge Ask to close all tabs ? : 5=^>5
echo Enable Cortana inside Edge browser : Enable Cortana inside Edge browser : 5=^>6
echo Enable/Disable Adobe Flash Player in Edge : Enable/Disable Adobe Flash Player in Edge : 5=^>7
echo Enable/Disable Favorites Bar in Edge : Enable/Disable Favorites Bar in Edge : 5=^>8
echo Change NewTab Page in Edge : Change NewTab Page in Edge : 5=^>9
echo Manage Edge Data collection : Manage Edge Data collection : 5=^>10
echo Completely uninstall MS Edge + the ability to restore it : Completely uninstall MS Edge + the ability to restore it : 5=^>11
echo Clean Windows Update Junk : Clean Windows Update Junk : 6=^>1
echo Disable Automatic Windows Updates : Disable Automatic Windows Updates : 6=^>2
echo Enable Automatic Windows Updates : Enable Automatic Windows Updates : 6=^>3
echo Disable Automatic Windows Apps Updates : Disable Automatic Windows Apps Updates : 6=^>4
echo Enable Automatic Windows Apps Updates : Enable Automatic Windows Apps Updates : 6=^>5
echo Disable Notifications about new Preview Builds : Disable Notifications about new Preview Builds : 6=^>6
echo Enable Notifications about new Preview Builds : Enable Notifications about new Preview Builds : 6=^>7
echo Disable Automatic Driver updates through Windows Update : Disable Automatic Driver updates through Windows Update : 6=^>8
echo Enable Automatic Driver updates through Windows Update : Enable Automatic Driver updates through Windows Update : 6=^>9
echo Enable/Disable Windows Delivery Optimization "Update sharing" : Enable/Disable Windows Delivery Optimization "Update sharing" : 6=^>10
echo Enable deferring of upgrades : Enable deferring of upgrades : 6=^>11
echo Disable deferring of upgrades : Disable deferring of upgrades : 6=^>12
echo Disable Windows Updates for other MS products "MS Office" : Disable Windows Updates for other MS products "MS Office" : 6=^>13
echo Enable Windows Updates for other MS products "MS Office" : Enable Windows Updates for other MS products "MS Office" : 6=^>14
echo Show Windows features list : Show Windows features list : 7=^>1
echo Enable a feature : Enable a feature : 7=^>2
echo Disable a feature : Disable a feature : 7=^>3
echo Disable and Remove feature Payload "clean feature files" : Disable and Remove feature Payload "clean feature files" : 7=^>4
echo Show "Turn Windows features on or off" window : Show "Turn Windows features on or off" window : 7=^>5
echo Show me my User accounts : Show me my User accounts : 8=^>1
echo Change specific user account Password : Change specific user account Password : 8=^>2
echo Add NEW user account : Add NEW user account : 8=^>3
echo Delete a user account : Delete a user account : 8=^>4
echo Remove/restore the majority of Windows built in apps from current User/All Users : Remove/restore the majority of Windows built in apps from current User/All Users : 9=^>1
echo Uninstall Cortana : Uninstall Cortana : 9=^>2=^>cortana
echo Restore Cortana  : Restore Cortana : 9=^>sfc /scannow
echo Uninstall/restore Microsoft Edge : Uninstall/restore Microsoft Edge : 9=^>3
echo Restore Legacy Calculator "Classic Win32" : Restore Legacy Calculator "Classic Win32" : 9=^>4
echo Install Windows DVD Player app : Install Windows DVD Player app : 9=^>5
echo Enable/Disable/Uninstall Onedrive : Enable/Disable/Uninstall Onedrive : 9=^>6
echo Disable Onedrive : Disable Onedrive : 9=^>6=^>1
echo Enable Onedrive : Enable Onedrive : 9=^>6=^>2
echo Remove Onedrive/Dropbox Icon in File explorer : Remove Onedrive/Dropbox Icon in File explorer : 9=^>6=^>3
echo Disable and delete Ondrive : Disable and delete Ondrive : 9=^>6=^>4
echo Uninstall Ondrive : Uninstall Ondrive  : 9=^>6=^>4
echo Restore Old Windows photo viewer : Restore Old Windows photo viewer : 9=^>7
echo Restore Win 7 Task manager : Restore Win 7 Task manager : 9=^>8
echo Uninstall Contact Support App : Uninstall Contact Support App : 9=^>9
echo Uninstall Windows Feedback App : Uninstall Windows Feedback App : 9=^>10
echo Stop All Telemetry : Stop All Telemetry "Master Switch" : 10=^>Disable
echo Reset All Telemetry to default : Reset All Telemetry to default "Master Switch" : 10=^>Enable
echo CORTANA and Internet Explorer telemetry settings : CORTANA and Internet Explorer telemetry settings : 10=^>1
echo Microsoft Edge and Other Telemetry settings : Microsoft Edge and Other Telemetry settings : 10=^>2
echo Settings-app\Privacy telemetry settings : Settings-app\Privacy telemetry settings : 10=^>3
echo Apps access settings : Apps access settings : 10=^>4
echo Windows Geolocation Services : Windows Geolocation Services : 10=^>5
echo Synchronization of Windows Settings : Synchronization of Windows Settings : 10=^>6
echo Fix Empty "Network Connections" Folder "Network Adapters List" : Fix Empty "Network Connections" Folder "Network Adapters List" : 11=^>1
echo Disable Limit Reservable Bandwidth network : Disable Limit Reservable Bandwidth network : 11=^>2
echo Restore "Windows Firewall"+"Network Adapter" settings to defaults : Restore "Windows Firewall"+"Network Adapter" settings to defaults : 11=^>3
echo Flush Windows DNS Cache "ipconfig /flushdns" : Flush Windows DNS Cache "ipconfig /flushdns" : 11=^>4
echo Release and renew the IP address from DHCP server : Release and renew the IP address from DHCP server : 11=^>5
echo Convert Pro/Home to LTSB : Convert Pro/Home to LTSB : 12=^>Goto LTSB
echo Create a restore point : Create a restore point : 000=^>1
echo Undo all changes : Undo all changes : 000=^>2
echo Uninstall Candy Crush Saga : Uninstall Candy Crush Saga : 9=^>11
echo Send Feedback : Send Feedback to Developer : 000=^>3
echo Customize Delete Confirmation Dialog Prompt Details : Customize Delete Confirmation Dialog Prompt Details : 2=^>15
echo Hide Safely Remove Hardware Tray Icon : Hide Safely Remove Hardware Tray Icon : 3=^>13
echo Disable Javascript in Edge : Disable Javascript in Edge : 5=^>12
echo "Install" Command for CAB Files : "Install" Command for CAB Files : 2=^>16=^>3
echo Disable "-Shortcut" Text for new shortcuts : Disable "-Shortcut" Text for new shortcuts : 2=^>16=^>2
echo Enable Old Breifcase option in Folders Context menu : Enable Old Breifcase option in Folders Context menu : 2=^>16=^>4
echo Customize Options in File Explorer : Customize Options in File Explorer : 2=^>16
) >TWoptions.txt

cls
for /f "tokens=1,* delims=:" %%a in ('findstr /i /l /c:"%Keyword%" "TWoptions.txt"') do (echo(%%b)
echo.
echo Press any key to go back to main menu . . .
pause >nul 2>&1
del TWoptions.txt >nul 2>&1
GOTO Main
