@echo off
SetLocal EnableDelayedExpansion


:: define current version
set CurV=4.0


Title Windows 10 Toggle Tweaker v%CurV%
Color 1F

::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: get admininstrative privileges ::::==============================================================================================================================================================================
::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
mode con:cols=55 lines=2



>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
  echo Requesting administrative privileges...
  goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs" 
exit /b

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"



::::::::::::::::::::::::::::==============================================================================================================================================================================
:: set global variables ::::==============================================================================================================================================================================
::::::::::::::::::::::::::::==============================================================================================================================================================================

::Set Default Input Mode
set "SelectMode=Mouse"

::set Reg key path to use to store Script configs
set "Main_Script_Reg_key=HKLM\SOFTWARE\ToggleTweaker"

:: create dependencies 
call :batbox
rem replacement variables for dependencies
set BB="%temp%\batbox.exe"

:: change window size
mode con:cols=119 lines=33

:: define known builds, new ones will be added as they come along
set "knownBuilds=10240 10586 14393"

:: Define the current windows build number
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if %%i==Version (set "windowsBuild=%%i.%%j.%%k") else (set "windowsBuild=%%k"))

set "WAaction=1"

:: Define color for all Back buttons in sub-menus
set BackButtonColor=8F

::Define Supprted apps in removing sections
set "AppStrings=3DBuilder_8wekyb3d8bbwe WindowsAlarms_8wekyb3d8bbwe WindowsCalculator_8wekyb3d8bbwe windowscommunicationsapps_8wekyb3d8bbwe WindowsCamera_8wekyb3d8bbwe MicrosoftOfficeHub_8wekyb3d8bbwe SkypeApp_kzf8qxf38zg5c Getstarted_8wekyb3d8bbwe ZuneMusic_8wekyb3d8bbwe WindowsMaps_8wekyb3d8bbwe MicrosoftSolitaireCollection_8wekyb3d8bbwe BingFinance_8wekyb3d8bbwe ZuneVideo_8wekyb3d8bbwe BingNews_8wekyb3d8bbwe Office.OneNote_8wekyb3d8bbwe People_8wekyb3d8bbwe WindowsPhone_8wekyb3d8bbwe Windows.Photos_8wekyb3d8bbwe BingSports_8wekyb3d8bbwe WindowsSoundRecorder_8wekyb3d8bbwe BingWeather_8wekyb3d8bbwe XboxApp_8wekyb3d8bbwe Messaging_8wekyb3d8bbwe ConnectivityStore_8wekyb3d8bbwe CommsPhone_8wekyb3d8bbwe Office.Sway_8wekyb3d8bbwe oneconnect_8wekyb3d8bbwe microsoftstickynotes_8wekyb3d8bbwe Microsoft3DViewer_8wekyb3d8bbwe MSPaint_8wekyb3d8bbwe WindowsStore_8wekyb3d8bbwe"


rem LineFeed variable, requires 2 empty lines below
set LF=^



:: Disable Quickedit in CMD (To make Mouse Work) 
Reg.exe add "HKCU\Console" /v "QuickEdit" /t REG_DWORD /d "0" /f >nul 2>&1 
Reg.exe add "HKCU\Console\%%SystemRoot%%_System32_cmd.exe" /v "QuickEdit" /t REG_DWORD /d "0" /f >nul 2>&1 



::Show What's NEW PAge if running current version for the first time 
reg query "HKLM\SOFTWARE\ToggleTweaker" /v Version | find "%CurV%" >nul 
if "%errorlevel%"=="0" (goto Versioncheck) else ((Reg.exe add "HKLM\SOFTWARE\ToggleTweaker" /v "Version" /t REG_SZ /d "%CurV%" /f  >nul  ) & call :WhatsNEW)


:::::::::::::::::::::::::::::==============================================================================================================================================================================
:: check for new version ::::==============================================================================================================================================================================
:::::::::::::::::::::::::::::==============================================================================================================================================================================


:Versioncheck



cls
echo  Checking For Updates ...
echo.

if exist "%~dp0\Updater.bat" ( del "%~dp0\Updater.bat" )

call :Servercheck dl.dropbox.com MainMenu
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiNkU3VUJkYlh0aGc" TWV.TXT



set content=
for /F "delims=" %%i in (TWV.TXT) do set content=!content! %%i
set NewV=%content%
del TWV.txt
if %NewV% GTR %CurV% (Goto New)
if %CurV% == %NewV% (Goto MainMenu)

:New
call :msgBox NewVersion  
if /i "!buttonClicked!"=="NO" GOto :Startintro
if /i "!buttonClicked!"=="YES" (
::AUTOUpdate
call :Infomsgbox "Downloading and installing The New version..." 9F 900
cd %Temp%
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiXzdKLTVzUkk0SGs" "Toggle Tweaker.bat"
CD /D %~dp0

call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiekQtaFJwUzFVYm8" "Updater.bat"
start Updater.bat
start https://goo.gl/KZqoyt
exit
)

::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================

:Startintro
cls

:: Skip the Intro
call :verify-SkipIntro  >nul 2>&1
If "%SkipIntro%"=="YES" goto MainMenu

:: generate random number between 1 and 3 because there are 3 intro animations :)
SET /a rand=%random% %%4 +1

:: "play" intro
call :intro %rand%





::::::::::::::
:: MainMenu ::
::::::::::::::
:MainMenu

cls
call :ClearButtons
call :verify-Updates 5

set "Title1=                 _______________________________________________________________________________________"   
set "Title2=                ^|  ____   __    ___   ___  __    ____        ____  _  _  ____   __   __ _  ____  ____   ^|"
set "Title3=                ^| (_  _) /  \  / __) / __)(  )  (  __)      (_  _)/ )( \(  __) / _\ (  / )(  __)(  _ \  ^|"
set "Title4=                ^|   )(  (  O )( (_ \( (_ \/ (_/\ ) _)         )(  \ /\ / ) _) /    \ )  (  ) _)  )   /  ^|"
set "Title5=                ^|  (__)  \__/  \___/ \___/\____/(____)       (__) (_/\_)(____)\_/\_/(__\_)(____)(__\_)  ^|"
set "Title6=                ^|_______________________________________________________________________________________^|" 


set  "button1=Windows / Office KMS activation"
set  "button2=Manage Built-in apps and restore old ones"
set  "button3=Enable/Disable stuff In Windows10"
set  "button4=User Interface Tweaks"
set  "button5=Toggle Windows Update status (%Updates%) [O]"
set  "button6=Manage Windows Features"
set  "button7=Manage User Accounts " 
set  "button8=Speed Up PC Performance"
set  "button9=Manage Microsoft Edge browser"
set "button10=Internet Tweaks and Fixes"
set "button11=Convert Pro/Home version to LTSB [O]"
set "button12=TELEMETRY and Data collection Settings ^!^!"

set "button13=TWEAKER SETTINGS"                                     & set Button13Color=37
set "button14=EXIT TOGGLE TWEAKER"                                  & set Button14Color=4F


call :drawMenu



call :readInput
if "%buttonClicked%"=="1"  (cls & goto KMSActivation     )
if "%buttonClicked%"=="2"  (cls & goto WinAppsmenu       )
if "%buttonClicked%"=="3"  (cls & goto Enable/Disable    )
if "%buttonClicked%"=="4"  (cls & goto UI                )
if "%buttonClicked%"=="5"  (if /i "%Updates%"=="Disabled" (Call :Enable-Updates) else (Call :Disable-Updates) & Goto MainMenu )
if "%buttonClicked%"=="6"  (cls & goto Features          )
if "%buttonClicked%"=="7"  (cls & goto Users             )
if "%buttonClicked%"=="8"  (cls & goto Performance       )
if "%buttonClicked%"=="9"  (cls & goto Edge              )
if "%buttonClicked%"=="10" (cls & goto NETWORK           )
if "%buttonClicked%"=="11" (cls & goto LTSB              )
if "%buttonClicked%"=="12" (cls & goto TELEMETRY         )

if "%buttonClicked%"=="13" (goto :settingsMenu           )
if "%buttonClicked%"=="14" (Exit)
goto MainMenu






:TELEMETRY
Call :GetActiveButton 9 1
Call :GetActiveButton 10 2
cls
call :ClearButtons

set "Title1=                 _______________________________________________________________________________________"   
set "Title2=                ^|  ____   __    ___   ___  __    ____        ____  _  _  ____   __   __ _  ____  ____   ^|"
set "Title3=                ^| (_  _) /  \  / __) / __)(  )  (  __)      (_  _)/ )( \(  __) / _\ (  / )(  __)(  _ \  ^|"
set "Title4=                ^|   )(  (  O )( (_ \( (_ \/ (_/\ ) _)         )(  \ /\ / ) _) /    \ )  (  ) _)  )   /  ^|"
set "Title5=                ^|  (__)  \__/  \___/ \___/\____/(____)       (__) (_/\_)(____)\_/\_/(__\_)(____)(__\_)  ^|"
set "Title6=                ^|_______________________________________________________________________________________^|" 




set   "button9=[REPO] Windows 10 TELEMETRY REPOSITORY"         & set Button3Color=9F                  
set  "button10=[Guide] Way to Disable Keylogger/ Telemetry"	& set Button2Color=9F

set "button14=Go Back"                                      & set Button14Color=%BackButtonColor%
call :drawMenu


%BB% /c 0x1F /g 0 12
echo                     Telemetry is not Built inside WIndows 10, BUT Windows 10 is Built on TELEMETRY.
echo.
echo          The point here is that anyway you try it to disable Telemetry it will be enabled by something else later
echo             And if you go far in disabling it you will find yourself using a system that is worse than Win 8
echo.
echo.
echo.
echo                              But if you insist here are some links that may help you
%BB% /c 0x1F /g 59 21

call :readInput


if "%buttonClicked%"=="%ActiveButton9%"  (cls & Start https://forums.mydigitallife.info/threads/63874-REPO-Windows-10-TELEMETRY-REPOSITORY)
if "%buttonClicked%"=="%ActiveButton10%"  (cls & Start https://forums.mydigitallife.info/threads/57339-Guide-Way-to-Disable-Keylogger-Telemetry-v3-53)

if "%buttonClicked%"=="14" (Goto MainMenu)
goto TELEMETRY








::==============================================================================================================================================================================
::==============================================================================================================================================================================



:KMSActivation

call :ClearButtons
set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|  ____   __    ___   ___  __    ____        ____  _  _  ____   __   __ _  ____  ____   ^|"
set "Title3=                ^| (_  _) /  \  / __) / __)(  )  (  __)      (_  _)/ )( \(  __) / _\ (  / )(  __)(  _ \  ^|"
set "Title4=                ^|   )(  (  O )( (_ \( (_ \/ (_/\ ) _)         )(  \ /\ / ) _) /    \ )  (  ) _)  )   /  ^|"
set "Title5=                ^|  (__)  \__/  \___/ \___/\____/(____)       (__) (_/\_)(____)\_/\_/(__\_)(____)(__\_)  ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"
set  "button1=Check Windows Activation Status"
set  "button2=Check Office Activation Status"
set  "button3=Activate Windows/Office Using KMSPico"
set "button14=Go Back"                                      & set Button14Color=%BackButtonColor%
call :drawMenu

call :readInput
if "%buttonClicked%"=="1" ( cls & call :CheckWindowsactivation  )
if "%buttonClicked%"=="2" ( cls & call :CheckOfficeactivation   )
if "%buttonClicked%"=="3" ( cls & call :ActivateWindows/office  )
if "%buttonClicked%"=="14" goto MainMenu
goto KMSActivation


::==============================================================================================================================================================================

::==============================================================================================================================================================================


:WinAppsmenu

call :ClearButtons
call :verify-photoviewer 2

set "Title1=                 _______________________________________________________________________________________"   
set "Title2=                ^|            _    _  __  _  _  ___    __  _    _  ___     __   ___  ___  ___            ^|"
set "Title3=                ^|           ( \/\/ )(  )( \( )(   \  /  \( \/\/ )/ __)   (  ) (  ,\(  ,\/ __)           ^|"
set "Title4=                ^|            \    /  )(  )  (  ) ) )( () )\    / \__ \   /__\  ) _/ ) _/\__ \           ^|"
set "Title5=                ^|             \/\/  (__)(_)\_)(___/  \__/  \/\/  (___/  (_)(_)(_)  (_)  (___/           ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"


set  "button1=Remove/restore Windows built-in apps from Users"              
set  "button3=Uninstall/restore Cortana [O]"
set  "button5=Uninstall/restore Microsoft Edge [O]"     
set  "button7=Uninstall/restore Internet Explorer 11 [O]"                       
set  "button9=Uninstall, Disable and reenable Onedrive" 
set "button11=Uninstall Contact Support (Get Help) App [O]"    
set "button13=Uninstall WindowsFeedback App [O]"    


set  "button2=Restore Old Windows photo viewer (%photoviewer%)"
set  "button4=Restore Legacy Calculator (Classic Win32) [O]"
set  "button6=Restore Win 7 Task manager [O]"       
set  "button8=Restore Classic MSConfig [O]"         
set  "button10=Install Windows DVD Player app [O]"  
set "button12=Restore Classic Paint app [B:14986] [O]"  





set "button14=Go Back"                                                  & set Button14Color=%BackButtonColor%
call :drawMenu


call :readInput
if "%buttonClicked%"=="1"  ( cls & call :Awamenu          )
if "%buttonClicked%"=="2"  ( Call :Enable-photoviewer     )
if "%buttonClicked%"=="3"  ( cls & call :UninstallCortana )
if "%buttonClicked%"=="4"  ( cls & call :CALC32           )
if "%buttonClicked%"=="5"  ( cls & call :UninstallEdge    )
if "%buttonClicked%"=="6"  ( cls & call :Win7Taskmanager  )
if "%buttonClicked%"=="7"  ( cls & call :UninstallIE11    )
if "%buttonClicked%"=="8"  ( cls & call :OLDMSConfig      )
if "%buttonClicked%"=="9"  ( cls & call :Onedrive         )
if "%buttonClicked%"=="10" ( cls & call :InstallDVDapp    )
if "%buttonClicked%"=="11" ( cls & call :ContactSuppo     )
if "%buttonClicked%"=="12" ( cls & call :Paint32          )
if "%buttonClicked%"=="13" ( cls & call :WFeedbackApp     )
if "%buttonClicked%"=="14" goto MainMenu
goto WinAppsmenu


::==============================================================================================================================================================================
::==============================================================================================================================================================================


:Enable/Disable

call :ClearButtons
call :verify-WindowsDefender 1      >nul 2>&1
call :verify-QuickAccess 2		 	>nul 2>&1
call :verify-Firewall 3             >nul 2>&1
call :verify-BSOD 4			        >nul 2>&1

call :verify-PSWRDReveal 6          >nul 2>&1
call :verify-Lockscreen 7           >nul 2>&1
call :verify-HardwareICon 8         >nul 2>&1
call :verify-SmartScreen 9          >nul 2>&1
call :verify-CMDinWinX 10           >nul 2>&1



set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|      ___  _  _   __   ___  __    ___     _   ___   __  ___   __   ___  __    ___      ^|"
set "Title3=                ^|     (  _)( \( ) (  ) (  ,)(  )  (  _)   / ) (   \ (  )/ __) (  ) (  ,)(  )  (  _)     ^|"
set "Title4=                ^|      ) _) )  (  /__\  ) ,\ )(__  ) _)  / /   ) ) ) )( \__ \ /__\  ) ,\ )(__  ) _)     ^|"
set "Title5=                ^|     (___)(_)\_)(_)(_)(___)(____)(___) /_/   (___) (__)(___)(_)(_)(___)(____)(___)     ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1=Windows Defender (%WindowsDefender%)"
set  "button3=Windows Firewall (%Firewall%)" 
set  "button5=Manage Folders In 'This PC'"
set  "button7=Lockscreen (%Lockscreen%)"                     
set  "button9=Windows/Store Smart Screen Filter (%SmartScreen%)"
//set "button11=** Hibernation  & Fast Startup"                                      & set Button11Color=4F


set  "button2=Default Quick Access view in Explorer (%QuickAccess%)"
set  "button4=Show BSOD details instead of the sad smiley (%BSOD%)"
set  "button6=Password Reveal Button (%PSWRDReveal%)"                        
set  "button8=Safely Remove Hardware Tray Icon (%HardwareICon%)"                                  
set "button10=Replace PowerShell with CMD in Win X menu (%CMDinWinX%)" 


set "button14=Go Back"                                                          & set Button14Color=%BackButtonColor%
call :drawMenu


call :readInput
if "%buttonClicked%"=="1"  (if /i "%WindowsDefender%"=="Disabled" (Call :Enable-WindowsDefender) else (Call :Disable-WindowsDefender) & Goto Enable/Disable )
if "%buttonClicked%"=="2"  (if /i "%QuickAccess%"=="Disabled" (Call :Enable-QuickAccess) else (Call :Disable-QuickAccess) & Goto Enable/Disable )
if "%buttonClicked%"=="3"  (if /i "%Firewall%"=="Disabled" (Call :Enable-Firewall) else (Call :Disable-Firewall) & Goto Enable/Disable )
if "%buttonClicked%"=="4"  (if /i "%BSOD%"=="Disabled" (Call :Enable-BSOD) else (Call :Disable-BSOD) & Goto Enable/Disable )
if "%buttonClicked%"=="5"  (Goto This-PC)
if "%buttonClicked%"=="6"  (if /i "%PSWRDReveal%"=="Disabled" (Call :Enable-PSWRDReveal) else (Call :Disable-PSWRDReveal) & Goto Enable/Disable )
if "%buttonClicked%"=="7"  (if /i "%Lockscreen%"=="Disabled" (Call :Enable-Lockscreen) else (Call :Disable-Lockscreen) & Goto Enable/Disable )
if "%buttonClicked%"=="8"  (if /i "%HardwareICon%"=="Disabled" (Call :Enable-HardwareICon) else (Call :Disable-HardwareICon) & Goto Enable/Disable )
if "%buttonClicked%"=="9"  (if /i "%SmartScreen%"=="Disabled" (Call :Enable-SmartScreen) else (Call :Disable-SmartScreen) & Goto Enable/Disable )
if "%buttonClicked%"=="10"  (if /i "%CMDinWinX%"=="Disabled" (Call :Enable-CMDinWinX) else (Call :Disable-CMDinWinX) & Goto Enable/Disable )
if "%buttonClicked%"=="11"  ( cls )

if "%buttonClicked%"=="14" goto MainMenu
goto Enable/Disable








::==============================================================================================================================================================================
::==============================================================================================================================================================================


:UI
call :ClearButtons

call :verify-Darkmode 1 >nul 2>&1
call :verify-Thumbnails 2 >nul 2>&1
call :verify-VolumeControlUI 3 >nul 2>&1
call :verify-TaskViewBTN 4 >nul 2>&1
call :verify-BatteryStatusUI 5 >nul 2>&1
call :verify-DeleteDialogDetails 6 >nul 2>&1
call :verify-AltTabUI 7 >nul 2>&1
call :verify-TransparencyBlur 8 >nul 2>&1
call :verify-Logonscreen 10 >nul 2>&1
call :verify-Thumbnailsize 13 >nul 2>&1



set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|        _  _  ___  ___  ___      __  _  _  ____  ___  ___   ___   __    __  ___        ^|"
set "Title3=                ^|       ( )( )/ __)(  _)(  ,)    (  )( \( )(_  _)(  _)(  ,) (  _) (  )  / _)(  _)       ^|"
set "Title4=                ^|        )()( \__ \ ) _) )  \     )(  )  (   )(   ) _) )  \  ) _) /__\ ( (_  ) _)       ^|"
set "Title5=                ^|        \__/ (___/(___)(_)\_)   (__)(_)\_) (__) (___)(_)\_)(_)  (_)(_) \__)(___)       ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1=Dark Theme For Apps (%Darkmode%)" 
set  "button3=Volume Control UI (%VolumeControlUI%)"
set  "button5=Battery Status UI (%BatteryStatusUI%)"
set  "button7=Alt-Tab Screen UI (%AltTabUI%)  [FE]"
set  "button9=Context Menu Tweaks"
set "button11=Change OEM Information" 
set "button13=Taskbar Thumbnail size ( %Thumbnailsize%) [FE]"

set  "button2=Thumbnail Previews in File explorer (%Thumbnails%) [FE]"
set  "button4=Taskview button in Taskbar (%TaskViewBTN%) [FE]"
set  "button6=Show Delete-Confirmation-Dialog Prompt Details (%DeleteDialogDetails%)"
set  "button8=Transparency and Blur in: Taskbar-Clock... (%TransparencyBlur%)" 
set "button10=Change Logon Background Image/accent-color (%Logonscreen%)"
set "button12=Colourise/Decolourise Start Me,Taskbar and Title bars"

set "button14=Go Back"                                                              & set Button14Color=%BackButtonColor%


call :drawMenu
call :readInput

if "%buttonClicked%"=="1"  ((if /i "%Darkmode%"=="Disabled"         (Call :Enable-Darkmode         )) & (if /i "%Darkmode%"=="Enabled"          (Call :Disable-Darkmode         )) & goto UI ) >nul 2>&1
if "%buttonClicked%"=="2"  ((if /i "%Thumbnails%"=="Disabled"       (Call :Enable-Thumbnails       )) & (if /i "%Thumbnails%"=="Enabled"        (Call :Disable-Thumbnails       )) & goto UI ) >nul 2>&1
if "%buttonClicked%"=="3"  ((if /i "%VolumeControlUI%"=="OLD"       (Call :NEW-VolumeControlUI     )) & (if /i "%VolumeControlUI%"=="NEW"       (Call :OLD-VolumeControlUI      )) & goto UI ) >nul 2>&1
if "%buttonClicked%"=="4"  ((if /i "%TaskViewBTN%"=="Disabled"      (Call :Enable-TaskViewBTN      )) & (if /i "%TaskViewBTN%"=="Enabled"       (Call :Disable-TaskViewBTN      )) & goto UI ) >nul 2>&1    
if "%buttonClicked%"=="5"  ((if /i "%BatteryStatusUI%"=="OLD"       (Call :NEW-BatteryStatusUI     )) & (if /i "%BatteryStatusUI%"=="NEW"       (Call :OLD-BatteryStatusUI      )) & goto UI ) >nul 2>&1
if "%buttonClicked%"=="6"  ((if /i "%DeleteDialogDetails%"=="Yes"   (Call :NO-DeleteDialogDetails  )) & (if /i "%DeleteDialogDetails%"==" No"   (Call :Yes-DeleteDialogDetails  )) & goto UI ) >nul 2>&1
if "%buttonClicked%"=="7"  ((if /i "%AltTabUI%"=="OLD"              (Call :NEW-AltTabUI            )) & (if /i "%AltTabUI%"=="NEW"              (Call :OLD-AltTabUI             )) & goto UI ) >nul 2>&1
if "%buttonClicked%"=="8"  ((if /i "%TransparencyBlur%"=="Disabled" (Call :Enable-TransparencyBlur )) & (if /i "%TransparencyBlur%"=="Enabled"  (Call :Disable-TransparencyBlur )) & goto UI ) >nul 2>&1
if "%buttonClicked%"=="9"  ( cls & call :ContextMenu)
if "%buttonClicked%"=="10" ((if /i "%Logonscreen%"=="Color"         (Call :Image-Logonscreen       )) & (if /i "%Logonscreen%"=="Image"         (Call :Color-Logonscreen        )) & goto UI ) >nul 2>&1
if "%buttonClicked%"=="11" ( cls & call :OEMInfo )
if "%buttonClicked%"=="12" ( cls & call :ColouriseStartmenu )
if "%buttonClicked%"=="13"  ((if /i "%Thumbnailsize%"=="Default"    (Call :400-Thumbnailsize       )) & (if /i "%Thumbnailsize%"=="190/400"     (Call :Default-Thumbnailsize    )) & goto UI ) >nul 2>&1

if "%buttonClicked%"=="14" goto MainMenu
goto UI



::==============================================================================================================================================================================
::==============================================================================================================================================================================



:Features
cls
call :ClearButtons
set "buttonClicked= "

Call :GetActiveButton 5 3
Call :GetActiveButton 6 4
Call :GetActiveButton 9 5

set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|                     ____  ____   __  ____  _  _  ____  ____  ____                     ^|"
set "Title3=                ^|                    (  __)(  __) / _\(_  _)/ )( \(  _ )(  __)/ ___)                    ^|"
set "Title4=                ^|                     ) _)  ) _) /    \ )(  ) \/ ( )   / ) _) \___ \                    ^|"
set "Title5=                ^|                    (__)  (____)\_/\_/(__) \____/(__\_)(____)(____)                    ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1=Show Windows features list"
set  "button5=Enable a feature"                                     
set  "button9=Disable and Remove feature Payload (clean feature files)" 

set  "button2=Show 'Turn Windows features on or off' window"
set  "button6=Disable a feature"                                            

set "button14=Go Back"                                                          & set Button14Color=%BackButtonColor%
call :drawMenu

call :readInput

if "%buttonClicked%"=="1"  ( cls & dism /online /get-features | more )
if "%buttonClicked%"=="2"  ( start OptionalFeatures.exe )
if "%buttonClicked%"=="%ActiveButton5%"  ( call :Features-Input & cls & DISM /online /enable-feature /featurename:!input! & pause )
if "%buttonClicked%"=="%ActiveButton6%"  ( call :Features-Input & cls & dism /online /disable-feature /featurename:!input! & pause )
if "%buttonClicked%"=="%ActiveButton9%"  ( call :Features-Input & cls & dism /online /disable-feature /featurename:!input! /remove & pause )
if "%buttonClicked%"=="14" goto MainMenu

goto Features



:Features-Input
call :ClearButton 14
%BB% ^
   /c 0x1F /g 2 27  /d " ________________________________________________________" ^
   /c 0x2F /g 2 28  /d "|                                                        |"^
           /g 2 29  /d "| Input :                                                |"^
           /g 2 30  /d "|________________________________________________________|"^
   /c 0xF1 /g 12 29 /d "                                              "               ^
           /g 13 29      
)

set /p Input=
%BB% /c 0x1F
If "%Input%"==""  Goto Features
If "%Input%"==" " Goto Features
If "%Input%"=="0" Goto Features

exit /b



::==============================================================================================================================================================================
::==============================================================================================================================================================================



:Users
call :ClearButtons
call :verify-AdminAccount

set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|       _  _  ____  ____  ____  ____     _  _   __   __ _   __    ___  ____  ____       ^|"
set "Title3=                ^|      / )( \/ ___)(  __)(  _ \/ ___)   ( \/ ) / _\ (  ( \ / _\  / __)(  __)(  _ \      ^|"
set "Title4=                ^|      ) \/ (\___ \ ) _)  )   /\___ \   / \/ \/    \/    //    \( (_ \ ) _)  )   /      ^|"
set "Title5=                ^|      \____/(____/(____)(__\_)(____/   \_)(_/\_/\_/\_)__)\_/\_/ \___/(____)(__\_)      ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1=Show me my User accounts"
set  "button3=Add NEW user account" 
set  "button5=Change specific user account Password"

set  "button4=Delete a user account"
set  "button2=Built-in Administrator Account (%AdminAccount%)"

set "button14=Go Back"                                          & set Button14Color=%BackButtonColor%
call :drawMenu

call :readInput

if "%buttonClicked%"=="1"  ( %BB% /g 1 21 & net user & pause & goto Users )
if "%buttonClicked%"=="2"  ((if /i "%AdminAccount%"=="Disabled"     (net user administrator /active:yes & reg add "%Main_Script_Reg_key%" /v "AdminAccount" /t REG_DWORD /d 1 /f  ))    &    (if /i "%AdminAccount%"=="Enabled"     (net user administrator /active:no & reg add "%Main_Script_Reg_key%" /v "AdminAccount" /t REG_DWORD /d 0 /f )) & goto Users ) >nul 2>&1


reg query "%Main_Script_Reg_key%" /v AdminAccount | find "0x1" >nul



if "%buttonClicked%"=="3"  ( call :Users-Input
                             net user "!Input!" /add
                             PAUSE
                             goto Users
                            )


if "%buttonClicked%"=="4"  ( call :Users-Input
                             net user "!Input!" /delete
                             PAUSE
                             goto Users
                            )

if "%buttonClicked%"=="5"  (%BB% /g 0 22 
                            set /p name=* Write the name of the desired account:
                            set /p PWD=* Write the new password:
                            set /p PWDC=* Confirm the new password:
                            if "!PWD!"=="!PWDC!" (net user "!name!" "!PWD!" & call :msgbox ok & goto Users) Else (echo something Happend & pause & goto Users) )

if "%buttonClicked%"=="14" goto MainMenu

goto Users


:Users-Input
call :ClearButton 14
%BB% ^
   /c 0x1F /g 1 22  /d " _________________________________________________________" ^
   /c 0x2F /g 1 23  /d "|                                                         |"^
           /g 1 24  /d "| Input :                                                 |"^
           /g 1 25  /d "|_________________________________________________________|"^
   /c 0xF1 /g 12 24 /d "                                               "              ^
          /g 13 24      
)

set /p Input=
%BB% /c 0x1F
If "%Input%"==""  Goto Users
If "%Input%"==" " Goto Users
If "%Input%"=="0" Goto Users

%BB% /g 0 25
exit /b

:verify-AdminAccount
reg query "%Main_Script_Reg_key%" /v AdminAccount | find "0x1" >nul
if "%errorlevel%"=="0" (set "AdminAccount=Enabled") else (set "AdminAccount=Disabled")
exit/b




::==============================================================================================================================================================================
::==============================================================================================================================================================================




:Performance
call :ClearButtons


call :FolderSize "%Windir%\SoftwareDistribution\Download" 2
call :FolderSize "%Temp%" 3 
call :FolderSize "%Windir%\Prefetch" 4 
call :verify-GameMode 7

set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|     ____   ___     ____  ____  ____  ____  __  ____  _  _   __   __ _   ___  ____     ^|"
set "Title3=                ^|    (  _ \ / __)   (  _ \(  __)(  _ \(  __)/  \(  _ \( \/ ) / _\ (  ( \ / __)(  __)    ^|"
set "Title4=                ^|     ) __/( (__     ) __/ ) _)  )   / ) _)(  O ))   // \/ \/    \/    /( (__  ) _)     ^|"
set "Title5=                ^|    (__)   \___)   (__)  (____)(__\_)(__)  \__/(__\_)\_)(_/\_/\_/\_)__) \___)(____)    ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1=Calculate Restart Time" 
set  "button3=Clean TEMP Folder {'%FolderSize3%' Can be cleaned}"
set  "button5=Start Disk Cleanup (Not automatic)"
set  "button7=Game Mode (%GameMode%)"

set  "button2=Clean Update Junk {'%FolderSize2%' Can be cleaned}"
set  "button4=Clean Prefetch Folder {'%FolderSize4%' Can be cleaned}"
set  "button6=Disable : Unnecessary services,BitLocker,Encrypting..."


set "button14=Go Back"                                                  & set Button14Color=%BackButtonColor%


call :drawMenu
call :readInput


if "%buttonClicked%"=="1" goto Restart_time
if "%buttonClicked%"=="2" goto CleanUpdatefiles
if "%buttonClicked%"=="3" (cls & del %TEMP%\*.* /f /s /q & call :batbox)
if "%buttonClicked%"=="4" (cls & del %Windir%\Prefetch\*.* /f /s /q)
if "%buttonClicked%"=="5" cleanmgr.exe /LOWDISK
if "%buttonClicked%"=="6" cls & call :Services
if "%buttonClicked%"=="7" (if /i "%GameMode%"=="Disabled" (Call :Enable-GameMode) else (Call :Disable-GameMode) & Goto Performance )



if "%buttonClicked%"=="14" goto MainMenu
goto Performance


if "%buttonClicked%"=="" goto 


::==============================================================================================================================================================================
::==============================================================================================================================================================================


:NETWORK
call :ClearButtons

set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|       __  __ _  ____  ____  ____  __ _  ____  ____    ____  __  _  _  ____  ____      ^|"
set "Title3=                ^|      (  )(  ( \(_  _)(  __)(  _ \(  ( \(  __)(_  _)  (  __)(  )( \/ )(  __)/ ___)     ^|"
set "Title4=                ^|       )( /    /  )(   ) _)  )   //    / ) _)   )(     ) _)  )(  )  (  ) _) \___ \     ^|"
set "Title5=                ^|      (__)\_)__) (__) (____)(__\_)\_)__)(____) (__)   (__)  (__)(_/\_)(____)(____/     ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1=Fix Empty 'Network Connections'Folder {Network Adapters}" 
set  "button3=Restore 'Windows Firewall'+'Network Adapter' settings"
set  "button5=Release and renew the IP address from DHCP server"


set  "button2=Disable Limit Reservable Bandwidth (kind of)network"
set  "button4=Flush Windows DNS Cache {ipconfig /flushdns}"



set "button14=Go Back"                                                  & set Button14Color=%BackButtonColor%


call :drawMenu
call :readInput


if "%buttonClicked%"=="1" Reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Control\Network" /v "Config" /f
if "%buttonClicked%"=="2" Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "Psched" /t REG_DWORD /d "0" /f
if "%buttonClicked%"=="3" netsh int ip reset reset.txt & netsh winsock reset & netsh advfirewall reset
if "%buttonClicked%"=="4" ipconfig /flushdns
if "%buttonClicked%"=="5" ipconfig /release & ipconfig /renew

if "%buttonClicked%"=="14" goto MainMenu
goto NETWORK


::==============================================================================================================================================================================
::==============================================================================================================================================================================


:Edge
call :ClearButtons


call :verify-EdgeAds 1 >nul 2>&1
call :verify-EdgeTheme 2 >nul 2>&1
call :verify-closeTabs 5 >nul 2>&1
call :verify-CoratnainEdge 6 >nul 2>&1
call :verify-EdgeFlashPlayer 7 >nul 2>&1
call :verify-FavoritesBar 8 >nul 2>&1
call :verify-NewTabPage 10 >nul 2>&1



set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|       _  _  __  ___  ____   __   ____   __  ____  ____    ____  ____   ___  ____      ^|"
set "Title3=                ^|      ( \/ )(  )/ __)(  _ \ /  \ / ___) /  \(  __)(_  _)  (  __)(    \ / __)(  __)     ^|"
set "Title4=                ^|      / \/ \ )(( (__  )   /(  O )\___ \(  O )) _)   )(     ) _)  ) D (( (_ \ ) _)      ^|"
set "Title5=                ^|      \_)(_/(__)\___)(__\_) \__/ (____/ \__/(__)   (__)   (____)(____/ \___/(____)     ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1=Disable Ads (using Hosts File) [O] (%EdgeAds%) " 
set  "button3=Change Browser Home Button page"
set  "button5=Ask to close all tabs ? (%closeTabs%)"
set  "button7=Adobe Flash Player In Edge (%EdgeFlashPlayer%)"
set  "button9=Uninstall/restore Microsoft Edge [O]"

set  "button2=Dark Theme (%EdgeTheme%)"
set  "button4=Change default download directory"
set  "button6=Cortana inside the browser (%CoratnainEdge%)"
set  "button8=Favorites Bar (%FavoritesBar%)"
set "button10=NewTab Page : %NewTabPage% "

set "button14=Go Back"                                                              & set Button14Color=%BackButtonColor%






call :drawMenu


call :readInput

if "%buttonClicked%"=="1"  ((if /i "%EdgeAds%"=="Disabled"          (Call :Enable-EdgeAds          )) & (if /i "%EdgeAds%"=="Enabled"           (Call :Disable-EdgeAds         )) & goto Edge )
if "%buttonClicked%"=="2"  ((if /i "%EdgeTheme%"=="Disabled"        (Call :Enable-EdgeTheme        )) & (if /i "%EdgeTheme%"=="Enabled"         (Call :Disable-EdgeTheme       )) & goto Edge ) >nul 2>&1
if "%buttonClicked%"=="3"  (call :Edge-Input & Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "HomeButtonPage" /t REG_SZ /d "%Input%" /f & goto Edge ) >nul 2>&1
if "%buttonClicked%"=="4"  (call :Edge-Input & Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Default Download Directory" /t REG_SZ /d "%Input%" /f & goto Edge ) >nul 2>&1    
if "%buttonClicked%"=="5"  ((if /i "%closeTabs%"=="Disabled"        (Call :Enable-closeTabs        )) & (if /i "%closeTabs%"=="Enabled"         (Call :Disable-closeTabs       )) & goto Edge ) >nul 2>&1
if "%buttonClicked%"=="6"  ((if /i "%CoratnainEdge%"=="Disabled"    (Call :Enable-CoratnainEdge    )) & (if /i "%CoratnainEdge%"=="Enabled"     (Call :Disable-CoratnainEdge   )) & goto Edge ) >nul 2>&1
if "%buttonClicked%"=="7"  ((if /i "%EdgeFlashPlayer%"=="Disabled"  (Call :Enable-EdgeFlashPlayer  )) & (if /i "%EdgeFlashPlayer%"=="Enabled"   (Call :Disable-EdgeFlashPlayer )) & goto Edge ) >nul 2>&1
if "%buttonClicked%"=="8"  ((if /i "%FavoritesBar%"=="Disabled"     (Call :Enable-FavoritesBar     )) & (if /i "%FavoritesBar%"=="Enabled"      (Call :Disable-FavoritesBar    )) & goto Edge ) >nul 2>&1
if "%buttonClicked%"=="9"  ( cls & call :UninstallEdge)
if "%buttonClicked%"=="10"  ((if /i "%NewTabPage%"=="Suggested" (Call :NewTabPage-Blank )) & (if /i "%NewTabPage%"=="Blank" (Call :NewTabPage-Topsites )) & (if /i "%NewTabPage%"=="Topsites" (Call :NewTabPage-Suggested )) & goto Edge ) >nul 2>&1

if "%buttonClicked%"=="14" goto MainMenu
goto Edge


:Edge-Input
call :ClearButton 14
%BB% ^
   /c 0x1F /g 1 27  /d " _________________________________________________________" ^
   /c 0x2F /g 1 28  /d "|                                                         |"^
           /g 1 29  /d "| Input :                                                 |"^
           /g 1 30  /d "|_________________________________________________________|"^
   /c 0xF1 /g 12 29 /d "                                               "              ^
          /g 13 29      
)

set /p Input=
%BB% /c 0x1F
exit/b





::==============================================================================================================================================================================

:CheckWindowsactivation
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
call :msgBox ok

exit /b

::==============================================================================================================================================================================


:CheckOfficeactivation
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

call :msgBox ok

exit /b


::==============================================================================================================================================================================


:ActivateWindows/office

Set CurCD=%CD%
cd %temp%
Del TWKMS.ZIP
Del TWKMS.exe

cls
echo  Downloading KMSpico ...
echo.
Call :Servercheck drive.google.com MainMenu
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfibDZ1RWRtUzViMGc" TWKMS.ZIP
echo  Installing KMSpico ...
call :UnZip TWKMS.ZIP
start /HIGH TWKMS.exe

CD %CurCD%

call :msgBox ok 
exit /b




::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================

:Awamenu
set MainInput= 
set  appDisplayName1= 1.3D Builder          
set  appDisplayName2= 2.Alarms and Clocks   
set  appDisplayName3= 3.Calculator          
set  appDisplayName4= 4.Calendar and Mail   
set  appDisplayName5= 5.Camera              
set  appDisplayName6= 6.Get Office          
set  appDisplayName7= 7.Skype Preview       
set  appDisplayName8= 8.Get Started         
set  appDisplayName9= 9.Groove Music        
set appDisplayName10=10.Maps                
set appDisplayName11=11.Microsoft Solitaire 
set appDisplayName12=12.Money (Finance)     
set appDisplayName13=13.Movies and TV       
set appDisplayName14=14.MSN News            
set appDisplayName15=15.OneNote             
set appDisplayName16=16.People              
set appDisplayName17=17.Phone Companion     
set appDisplayName18=18.Photos              
set appDisplayName19=19.Sports              
set appDisplayName20=20.Voice Recorder      
set appDisplayName21=21.Weather             
set appDisplayName22=22.Xbox                
set appDisplayName23=23.Messaging           
set appDisplayName24=24.Microsoft Wi-Fi     
set appDisplayName25=25.Phone               
set appDisplayName26=26.Office Sway         
set appDisplayName27=27.Paid Wifi/cellular  
set appDisplayName28=28.Sticky notes        
set appDisplayName29=29.3D Viewer           
set appDisplayName30=30.3D Paint            
set appDisplayName31=31.Store (No Restore)  

cls
echo                 _______________________________________________________________________________________
echo                ^|            _    _  __  _  _  ___    __  _    _  ___      __   ___  ___  ___           ^|
echo                ^|           ( \/\/ )(  )( \( )(   \  /  \( \/\/ )/ __)    (  ) (  ,\(  ,\/ __)          ^|
echo                ^|            \    /  )(  )  (  ) ) )( () )\    / \__ \    /__\  ) _/ ) _/\__ \          ^|
echo                ^|             \/\/  (__)(_)\_)(___/  \__/  \/\/  (___/   (_)(_)(_)  (_)  (___/          ^|
echo                ^|_______________________________________________________________________________________^|
echo                         ^|                                                                 ^| Commands credit to : 
echo.                        ^| You can execute multiple commands at once, ex: "a 1 b 6 8 c 23" ^|     'johnye_pt'
echo                         ^|_________________________________________________________________^|
echo.


echo   Default App Removing method :

if [!WAaction!]==[2] (
  echo    a. [ ] Remove App from current User
%BB% /c 0x9F /d "   b. [x] Remove App from All Users " /c 0x1F & echo.
  echo.
)


if not [!WAaction!]==[2] (

%BB% /c 0x9F /d "   a. [x] Remove App from current User " /c 0x1F & echo.
  echo    b. [ ] Remove App from All Users 
  echo.
)


for /l %%a in (1,1,31) do (
set AS%%a=OFF)




echo                                                                                                              ________
echo  Apps :                                                                      0. Go back to Main page        ^| ^<-     ^| 
echo   __________________________________________________________________________________________________________^|________^|
echo  ^|                            ^|                            ^|                            ^|                            ^|
echo  ^|                            ^|                            ^|                            ^|                            ^|
echo  ^|                            ^|                            ^|                            ^|                            ^|
echo  ^|                            ^|                            ^|                            ^|                            ^|
echo  ^|                            ^|                            ^|                            ^|                            ^|
echo  ^|                            ^|                            ^|                            ^|                            ^|
echo  ^|                            ^|                            ^|                            ^|                            ^|
echo  ^|                            ^|                            ^|                            ^|                            ^|
echo  ^|                            ^|                            ^|                            ^|                            ^|
echo  ^|____________________________^|____________________________^|____________________________^|____________________________^|
echo  ^|                            ^|                                                         ^|                            ^|
echo  ^|     32.ALL, but store      ^|            V. refresh Apps Installation Status          ^|        Apply changes       ^|
echo  ^|____________________________^|                                                         ^|____________________________^|
echo.

If /i "%SelectMode%"=="Mouse" ( %BB% ^
   /c 0x1F /g 111 1  /d " _______"^
   /c 0x3F /g 111 2  /d "|       "^
           /g 111 3  /d "|  USE  "^
           /g 111 4  /d "|  KBD  "^
           /g 111 5  /d "|_______" 

) else (%BB% ^
   /c 0x1F /g 111 1  /d " _______"^
   /c 0x3F /g 111 2  /d "|       "^
           /g 111 3  /d "|Press U"^
           /g 111 4  /d "|'Mouse'"^
           /g 111 5  /d "|_______" 
           )



call :ViewCurrentApps


If /i "%SelectMode%"=="Mouse" (

:readingMouseAppsMenu
set buttonClicked=""
call :readMouseAppsMenu

for /l %%a in (1,1,31) do ( if "!buttonClicked!"=="%%a" (
                                                        If !AS%%a!==OFF (
                                                                  set "MainInput=!MainInput! c !buttonClicked!"
                                                                  %BB% /c 0x1F /G 1 31 /d "Input =!MainInput!"
                                                                  call :ToggleAS %%a 
                                                          ) else (
                                                             If %WAaction%==2 set "MainInput=!MainInput! b !buttonClicked!"
                                                             If not %WAaction%==2 set "MainInput=!MainInput! a !buttonClicked!"
                                                          %BB% /c 0x1F /G 1 31 /d "Input =!MainInput!"
                                                          call :ToggleAS %%a ) 
                                                           ) 
)

If "!buttonClicked!"=="Back" (
set "MainInput=!MainInput:~0,-3!"
%BB% /c 0x1F /G 1 31 /d "                                                                                                                                                  "
%BB% /G 1 31  /d "Input =!MainInput!" 

)


If "!buttonClicked!"=="32" (set "MainInput=!MainInput! 32" & %BB% /c 0x1F /G 1 31 /d "Input =!MainInput!")
if "!buttonClicked!"=="V" (set MainInput= & call :ViewCurrentApps)
If "!buttonClicked!"=="a" (set "WAaction=1" & goto Awamenu)
If "!buttonClicked!"=="b" (set "WAaction=2" & goto Awamenu)
If "!buttonClicked!"=="0" (goto WinAppsmenu)

if "!buttonClicked!"=="apply" (goto WAfunction)

goto readingMouseAppsMenu

)



If /i "%SelectMode%"=="KBD" (
::Clean Mouse-Only UI       "
%BB% /G 109 14  /d "        "
%BB% /G 108 15  /d "          "
%BB% /G 108 16  /d "_________ "

%BB% /G 89 27  /d "                            "
%BB% /G 89 28  /d "    Press Enter to Apply    "
%BB% /G 89 29  /d "____________________________"

if [!WAaction!]==[3] (
 %BB% /g 0 13 /c 0x9F /d "   c. [x] Restore App to current User  (Not all apps can be restored)" /c 0x1F /g 0 10
echo   Default action :                        
echo    a. [ ] Remove App from current User 
echo    b. [ ] Remove App from All Users
) else (%BB% /g 0 13 /d "   c. [ ] Restore App to current User  (Not all apps can be restored)" /c 0x1F /g 0 10 /d "  Default action :               ")

%BB% /G 1 31
set /p MainInput=Input =
    if /i !MainInput!==a set "WAaction=1" & goto Awamenu
    if /i !MainInput!==b set "WAaction=2" & goto Awamenu
    if /i !MainInput!==c set "WAaction=3" 
    if /i !MainInput!==v goto Awamenu
    if /i !MainInput!==0 goto WinAppsmenu

    if /i !MainInput!==u ( If /i "%SelectMode%"=="Mouse" (set "SelectMode=KBD" & goto Awamenu ) else ( set "SelectMode=Mouse" & goto Awamenu ) )

goto WAfunction

)





:readMouseAppsMenu
for /f "tokens=1,2,3 delims=:" %%a in ('%BB% /m') do (
  %BB% /g 0 0

  set "buttonClicked"=""
  %BB% /d "mouse: %%b %%a %%c   "  >nul 2>&1
  REM : %%a = X    %%b = Y
    if %%c EQU 1 if %%b EQU 18 if %%a GEQ 2 if %%a LEQ 29 set "buttonClicked=1"
    if %%c EQU 1 if %%b EQU 19 if %%a GEQ 2 if %%a LEQ 29 set "buttonClicked=5"
    if %%c EQU 1 if %%b EQU 20 if %%a GEQ 2 if %%a LEQ 29 set "buttonClicked=9"
    if %%c EQU 1 if %%b EQU 21 if %%a GEQ 2 if %%a LEQ 29 set "buttonClicked=13"
    if %%c EQU 1 if %%b EQU 22 if %%a GEQ 2 if %%a LEQ 29 set "buttonClicked=17"
    if %%c EQU 1 if %%b EQU 23 if %%a GEQ 2 if %%a LEQ 29 set "buttonClicked=21"
    if %%c EQU 1 if %%b EQU 24 if %%a GEQ 2 if %%a LEQ 29 set "buttonClicked=25"
    if %%c EQU 1 if %%b EQU 25 if %%a GEQ 2 if %%a LEQ 29 set "buttonClicked=29"

    if %%c EQU 1 if %%b EQU 18 if %%a GEQ 31 if %%a LEQ 58 set "buttonClicked=2"
    if %%c EQU 1 if %%b EQU 19 if %%a GEQ 31 if %%a LEQ 58 set "buttonClicked=6"
    if %%c EQU 1 if %%b EQU 20 if %%a GEQ 31 if %%a LEQ 58 set "buttonClicked=10"
    if %%c EQU 1 if %%b EQU 21 if %%a GEQ 31 if %%a LEQ 58 set "buttonClicked=14"
    if %%c EQU 1 if %%b EQU 22 if %%a GEQ 31 if %%a LEQ 58 set "buttonClicked=18"
    if %%c EQU 1 if %%b EQU 23 if %%a GEQ 31 if %%a LEQ 58 set "buttonClicked=22"
    if %%c EQU 1 if %%b EQU 24 if %%a GEQ 31 if %%a LEQ 58 set "buttonClicked=26"
    if %%c EQU 1 if %%b EQU 25 if %%a GEQ 31 if %%a LEQ 58 set "buttonClicked=30"

    if %%c EQU 1 if %%b EQU 18 if %%a GEQ 60 if %%a LEQ 87 set "buttonClicked=3"
    if %%c EQU 1 if %%b EQU 19 if %%a GEQ 60 if %%a LEQ 87 set "buttonClicked=7"
    if %%c EQU 1 if %%b EQU 20 if %%a GEQ 60 if %%a LEQ 87 set "buttonClicked=11"
    if %%c EQU 1 if %%b EQU 21 if %%a GEQ 60 if %%a LEQ 87 set "buttonClicked=15"
    if %%c EQU 1 if %%b EQU 22 if %%a GEQ 60 if %%a LEQ 87 set "buttonClicked=19"
    if %%c EQU 1 if %%b EQU 23 if %%a GEQ 60 if %%a LEQ 87 set "buttonClicked=23"
    if %%c EQU 1 if %%b EQU 24 if %%a GEQ 60 if %%a LEQ 87 set "buttonClicked=27"
    if %%c EQU 1 if %%b EQU 25 if %%a GEQ 60 if %%a LEQ 87 set "buttonClicked=31"

    if %%c EQU 1 if %%b EQU 18 if %%a GEQ 89 if %%a LEQ 116 set "buttonClicked=4"
    if %%c EQU 1 if %%b EQU 19 if %%a GEQ 89 if %%a LEQ 116 set "buttonClicked=8"
    if %%c EQU 1 if %%b EQU 20 if %%a GEQ 89 if %%a LEQ 116 set "buttonClicked=12"
    if %%c EQU 1 if %%b EQU 21 if %%a GEQ 89 if %%a LEQ 116 set "buttonClicked=16"
    if %%c EQU 1 if %%b EQU 22 if %%a GEQ 89 if %%a LEQ 116 set "buttonClicked=20"
    if %%c EQU 1 if %%b EQU 23 if %%a GEQ 89 if %%a LEQ 116 set "buttonClicked=24"
    if %%c EQU 1 if %%b EQU 24 if %%a GEQ 89 if %%a LEQ 116 set "buttonClicked=28"

    if %%c EQU 1 if %%b EQU 11 if %%a GEQ 0 if %%a LEQ 38 set "buttonClicked=a"
    if %%c EQU 1 if %%b EQU 12 if %%a GEQ 0 if %%a LEQ 35 set "buttonClicked=b"
    if %%c EQU 1 if %%b EQU 28 if %%a GEQ 43 if %%a LEQ 77 set "buttonClicked=V"
    if %%c EQU 1 if %%b EQU 15 if %%a GEQ 77 if %%a LEQ 99 set "buttonClicked=0"


    if %%c EQU 1 if %%b GEQ 27 if %%b LEQ 29 if %%a GEQ 2 if %%a LEQ 29 set "buttonClicked=32"
    if %%c EQU 1 if %%b GEQ 27 if %%b LEQ 29 if %%a GEQ 89 if %%a LEQ 116 set "buttonClicked=apply"
    if %%c EQU 1 if %%b GEQ 15 if %%b LEQ 16 if %%a GEQ 109 if %%a LEQ 116 set "buttonClicked=Back"




    if %%c EQU 1 if %%b GEQ 1 if %%b LEQ 5 if %%a GEQ 111 if %%a LEQ 119 ( If /i "%SelectMode%"=="Mouse" (set "SelectMode=KBD" & goto Awamenu ) else ( set "SelectMode=Mouse" & goto Awamenu ) )


    )
exit /b


:ToggleAS
If /i "!AS%~1!"==" ON" (
  set AS%~1=OFF
  Call :ColorizeAppButton %~1 5F
  set AS%~1= ON
  ) else (
  set AS%~1= ON
  Call :ColorizeAppButton %~1 5F
  set AS%~1=OFF)
  %BB% !Line! /c 0x1F
exit /b




:ViewCurrentApps
set Line=

Rem === Setting Local Variables
set "NoRestart=0"
Set Installed=
Set NotInstalled=
set CPT=0

Rem === Going through all apps names listed in AppStrings variable
for %%k in (%AppStrings%) do (
set Keyword=%%k

Rem === Finding the app
for /f "tokens=4" %%a in ('reg query "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage" /f "!Keyword!"') do (
set /a CPT+=1
rem === Storing Installed and NotInstalled apps Numbers in variables
 if "%%a"=="0" (Set NotInstalled=!NotInstalled! !CPT!
  set AS!CPT!=OFF
) else (
Set Installed=!Installed! !CPT!
  set AS!CPT!= ON
 ) 
)
)

rem === colorize apps names
for %%I in (%Installed%) do ( Call :ColorizeAppButton %%I 2F )
for %%I in (%NotInstalled%) do ( Call :ColorizeAppButton %%I 4F )

%BB% !Line!

%BB% /c 0x1F /G 1 31 /d "Input =                                                                                "

%BB% /c 0x1F /g 9 31
exit /b





:WAfunction
cls
echo.
rem === the "WAaction" variable defines what action will be taken
rem === the "input" variable from the menu is used below, it equals the order in the "AppStrings" variable


rem === circle through all inputs
For %%a in (%MainInput%) do (
 set input=%%a
 
 rem === initialize App position
 set /a AppNum=0
 
 if /i !input!==a set "WAaction=1"
 if /i !input!==b set "WAaction=2"
 if /i !input!==c set "WAaction=3"
 
 
 rem === cicle through all Apps
 for %%a in (%AppStrings%) do (
 
   rem === increment App position by 1
   set /a AppNum+=1
 
   rem === get App Name without underscore
   set "AppName=%%a"
   set "AppName=!AppName:~0,-14!"



   rem === if chosen action is remove App from user/system
   if !WAaction! LEQ 2 (
 
     rem === if chosen option is 32 remove all Apps but store
     if [!input!]==[32] (
 
       rem === remove all Apps except the store
       if NOT [!AppNum!]==[31] (
 
         rem === remove from user
         if [!WAaction!]==[1] (
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
       if [!input!]==[!AppNum!] (
 
         rem === remove from user
         if [!WAaction!]==[1] (
           echo  Removing "!AppName!" from user...
           powershell.exe -command "Get-AppxPackage Microsoft.!AppName! | Remove-AppxPackage" > NUL 2>&1
 
         rem === remove from system
         ) else (
 
           rem === make sure user wants to remove Store App
           set "removeApp=0"
           if [!input!]==[29] (
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
     if [!input!]==[32] (
 
       rem === restore all Apps except the store
       if NOT [!AppNum!]==[31] (
 
         rem === restore app with Get-AppxPackage
         echo  Restoring "!AppName!" to user...
         powershell.exe -command "Get-AppxPackage -AllUsers Microsoft.!AppName! | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register ($_.InstallLocation + '\AppXManifest.xml')}" > NUL 2>&1
         
       )
     ) else (
 
       rem === restore chosen App
       if [!input!]==[!AppNum!] (
 
         rem === restore app with Get-AppxPackage
         echo  Restoring "!AppName!" to user...
         powershell.exe -command "Get-AppxPackage -AllUsers Microsoft.!AppName! | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register ($_.InstallLocation + '\AppXManifest.xml')}" > NUL 2>&1
       )
     )
   )
  )
)
echo.
choice /c yn /m "* Reboot to apply changes (y/n)?"
echo.
if %errorlevel% equ 2 goto Awamenu
if %errorlevel% equ 1 REM shutdown -r -t 30 -c "Windows will restart in 30 seconds"
goto Awamenu



:ColorizeAppButton
set N=%~1
set /a X=!N! %% 4
If !X!==0 set X=4

set /a Mod=!N! %% 4
set /a Y=(!N!/4)+1
If !Mod!==0 set /a Y-=1


set /a X=(28*!X!) -27 + !X!
set /a Y=!Y!+17


set Line=!Line! /c 0x%~2 /g !X! !Y! /D "!appDisplayName%~1!(!AS%~1!)"
exit /b





::==============================================================================================================================================================================






:WFeedbackApp

cd /d "%~dp0"


call :Infomsgbox "Downloading Windows Feedback Uninstaller..." 9F
call :Servercheck drive.google.com Awamenu
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiWTNGYXdiRU9SNVU" install_wim_tweak.exe


cls
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c Microsoft-WindowsFeedback /r
install_wim_tweak.exe /h /o /l
del Packages.txt
del install_wim_tweak.exe

call :Infomsgbox "Windows Feedback should be uninstalled." 9F

If /i "%SelectMode%"=="Mouse"  ( %BB% /m 
) else ( %BB% /k )


exit /b

::==============================================================================================================================================================================





:ContactSuppo
cd /d "%~dp0"


call :Infomsgbox "Downloading Contact Support Uninstaller..." 9F
call :Servercheck drive.google.com Awamenu
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiWTNGYXdiRU9SNVU" install_wim_tweak.exe

CLS
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c Microsoft-Windows-ContactSupport /r
install_wim_tweak.exe /h /o /l
del Packages.txt
del install_wim_tweak.exe

call :Infomsgbox "Windows Contact Support should be uninstalled." 9F

If /i "%SelectMode%"=="Mouse"  ( %BB% /m 
) else ( %BB% /k )


GOTO WinAppsmenu


::==============================================================================================================================================================================


:InstallDVDapp
call :Infomsgbox "Downloading and installing necessary files... (1/5)" 9F


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
cls
call :Infomsgbox "Downloading and installing necessary files... (2/5)" 9F
call :Servercheck www.google.com WinAppsmenu
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHficTNjbFA1TlNTSUk" SetACL.zip
call :Unzip SetACL.zip 
del SetACL.zip
CD "%CD%\SetACL (executable version)\%Arch% bit"



cls
call :Infomsgbox "Downloading and installing necessary files... (3/5)" 9F

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
call :Infomsgbox "Downloading and installing necessary files... (4/5)" 9F

del windows10.0-kb3106246-x64_38be8cc4777aadd5eba00476326eaca6952e06c1.cab >nul 2>&1


call :Download "http://download.windowsupdate.com/c/msdownload/update/software/updt/2015/11/windows10.0-kb3106246-x64_38be8cc4777aadd5eba00476326eaca6952e06c1.cab" "windows10.0-kb3106246-x64_38be8cc4777aadd5eba00476326eaca6952e06c1.cab"
call :Unzip "windows10.0-kb3106246-x64_38be8cc4777aadd5eba00476326eaca6952e06c1.cab"
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
call :Infomsgbox "Downloading and installing necessary files... (5/5)" 9F

windows10.0-kb3106246-x%Arch%.msi
del windows10.0-kb3106246-x64.msi
del windows10.0-kb3106246-x86.msi
cls
call :msgbox ok

GOTO WinAppsmenu



::==============================================================================================================================================================================


:Onedrive

call :ClearButtons
Call :GetActiveButton 9 7


set "Title1=              _____________________________________________________________________________________________"
set "Title2=             ^|    __  __   __   _  _   __    __  ___     __  __  _  ___      ____   ___   __  _  _  ___    ^|"
set "Title3=             ^|   (  \/  ) (  ) ( \( ) (  )  / _)(  _)   /  \ \ \( )(  _) ___ \   \ (  ,) (  )( )( )(  _)   ^|"
set "Title4=             ^|    )    (  /__\  )  (  /__\ ( (/\ ) _)  ( () ) )  (  ) _)(___) ) ) ) )  \  )(  \\//  ) _)   ^|"
set "Title5=             ^|   (_/\/\_)(_)(_)(_)\_)(_)(_) \__/(___)   \__/ (_)\_)(___)     (___/ (_)\_)(__) (__) (___)   ^|"
set "Title6=             ^|_____________________________________________________________________________________________^|"



set  "button1=Disable  Onedrive"
set  "button2=Enable Onedrive"
set  "button3=Remove One-drive Icon From Windows Explorer"
set  "button4=Remove Dropbox Icon From Windows Explorer"
set  "button5=Add Onedrive Icon To Windows Explorer"
set  "button6=Add Onedrive Icon To Windows Explorer"

set  "button9=Uninstall One-Drive (No-restore)" 


set "button14=Go Back"                                                               & set Button14Color=%BackButtonColor%
call :drawMenu




call :readInput
if "%buttonClicked%"=="1" ( cls & call :Onedrive1 )
if "%buttonClicked%"=="2" ( cls & call :Onedrive2 )
if "%buttonClicked%"=="3" ( cls & call :Onedrive3OnedireDisable )
if "%buttonClicked%"=="4" ( cls & call :Onedrive3DropboxDisable )
if "%buttonClicked%"=="5" ( cls & call :Onedrive3OnedireEnable )
if "%buttonClicked%"=="6" ( cls & call :Onedrive3DropboxEnable )
if "%buttonClicked%"=="%ActiveButton9%" ( cls & call :Onedrive4 )
if "%buttonClicked%"=="14" goto WinAppsmenu
goto Onedrive



:Onedrive1
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


call :msgbox ok
goto Onedrive


:Onedrive2
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 0 /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Onedrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 0 /f 
reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f 
reg add "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f 
reg add "HKEY_CURRENT_USER\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f 


call :msgbox ok
goto Onedrive







:Onedrive3OnedireDisable
Reg.exe add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
call :RestartExplorer
call :msgbox ok
goto Onedrive

:Onedrive3DropboxDisable
Reg.exe add "HKCR\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
call :RestartExplorer
call :msgbox ok
goto Onedrive

:Onedrive3OnedireEnable
Reg.exe add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
call :RestartExplorer
call :msgbox ok
goto Onedrive

:Onedrive3DropboxEnable
Reg.exe add "HKCR\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
Reg.exe add "HKCR\Wow6432Node\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f
call :RestartExplorer
call :msgbox ok
goto Onedrive


:Onedrive4
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
echo.
echo                                             Closing OneDrive process.
echo ---------------------------------------------------------------------------------------------------------------------

echo.
taskkill /f /im OneDrive.exe
ping 127.0.0.1 -n 1,5 > NUL 2>&1
echo.
echo                                  Uninstalling OneDrive using included uninstaller
echo ---------------------------------------------------------------------------------------------------------------------
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
echo.
echo                                            Removing OneDrive leftovers.
echo ---------------------------------------------------------------------------------------------------------------------

echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "%systemroot%/Users/%username%/OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 

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
echo.
echo                               Removing OneDrive from the Explorer Side Panel.
echo ---------------------------------------------------------------------------------------------------------------------

REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
echo.
echo                                        Removing Onedrive Packages
echo ---------------------------------------------------------------------------------------------------------------------
cd /d "%~dp0"
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiWTNGYXdiRU9SNVU" install_wim_tweak.exe
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c Microsoft-Windows-OneDrive-Setup-Package /r
install_wim_tweak.exe /h /o /l
del Packages.txt
del install_wim_tweak.exe


call :RestartExplorer
echo. & echo. & echo. & echo. 
call :msgbox ok
goto Onedrive




::==============================================================================================================================================================================

:UninstallEdge
cls
set Button1Color=4F
set Button2Color=2F

%BB% ^
   /c 0x1F                  /g 16 1  /d "_______________________________________________________________________________________"^
                            /g 15 2  /d "|        __  __  __   __  ___    __   ___   __   ___  ____    ___  ___    __  ___       |"^
                            /g 15 3  /d "|       (  \/  )(  ) / _)(  ,)  /  \ / __) /  \ (  _)(_  _)  (  _)(   \  / _)(  _)      |"^
                            /g 15 4  /d "|        )    (  )( ( (_  )  \ ( () )\__ \( () ) ) _)  )(     ) _) ) ) )( (/\ ) _)      |"^
                            /g 15 5  /d "|       (_/\/\_)(__) \__)(_)\_) \__/ (___/ \__/ (_)   (__)   (___)(___/  \__/(___)      |"^
                            /g 15 6  /d "|_______________________________________________________________________________________|"^
                            /g 15 7  /d "                                                                                         "^
                            /g 16 8  /d "________________________________________________________________________________________"^
   /c 0x%Button1Color%      /g 15 9  /d "|                                                                                        |"^
                            /g 15 10 /d "|  1.Uninstall Microsoft Edge                                                            |"^
                            /g 15 11 /d "|       This will remove MS Edge completely using : install_wim_tweak but the script     |"^
                            /g 15 12 /d "|           will first backup all packages to restore them when needed.                  |"^
                            /g 15 13 /d "|       If you uninstall MS Edge twice then the packages will be removed.                |"^
                            /g 15 14 /d "|       Microsoft .NET Framework 3.5 should be installed.                                |"^
                            /g 15 15 /d "|       You Should be connected to Internet to download necessary files.                 |"^
                            /g 15 16 /d "|________________________________________________________________________________________|"^
   /c 0x1F                  /g 16 17 /d "________________________________________________________________________________________"  ^
   /c 0x%Button2Color%      /g 15 18 /d "|                                                                                        |"^
                            /g 15 19 /d "|  2.Restore Microsoft Edge                                                              |"^
                            /g 15 20 /d "|       This will restore MS Edge using backed up packages.If the restore operation      |"^
                            /g 15 21 /d "|           didn't work try it again and Contact Yasser Da Sila in MDL.                  |"^
                            /g 15 22 /d "|       If you uninstalled EDGE twice you won't be able to restore it.                   |"^
                            /g 15 23 /d "|________________________________________________________________________________________|"^
   /c 0x1F                  /g 16 24 /d "________________________________________________________________________________________"^
   /c 0x9F                  /g 15 25 /d "|                                                                                        |"^
   /c 0x9F                  /g 15 26 /d "|                                    0. Go Back                                          |"^
   /c 0x9F                  /g 15 27 /d "|________________________________________________________________________________________|"^
   /c 0x1F

If /i "%SelectMode%"=="Mouse" (
for /f "tokens=1,2,3 delims=:" %%a in ('%BB% /m') do (
  %BB% /g 0 0

  set "buttonClicked"=""
  %BB% /d "mouse: %%b %%a %%c   "  >nul 2>&1
    if %%c EQU 1 if %%b GEQ 9 if %%b LEQ 16 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=1" 
    if %%c EQU 1 if %%b GEQ 19 if %%b LEQ 24 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=2" 
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 28 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=0" 
)
) else (
    %BB% /g 16 29
    Set /p buttonClicked=Use Your Keyboard Numbers to select options :
)


If %buttonClicked%==0 exit /b
If %buttonClicked%==1 call :UninstallEdge_Confirm
If %buttonClicked%==2 call :UninstallEdge_restore
goto UninstallEdge



:UninstallEdge_Confirm
call :msgbox Confirm
if /i "!buttonClicked!"=="No" ( goto UninstallEdge
) else (
cls
call :Infomsgbox "Downloading necessary files... " 9F 0
Set CurCD=%CD%
Del /Q "%HOMEDRIVE%\Export-Edge-Packages\" >nul 2>&1
MKDIR "%HOMEDRIVE%\Export-Edge-Packages\" >nul 2>&1
attrib +h %HOMEDRIVE%\Export-Edge-Packages >nul 2>&1
cd %HOMEDRIVE%\Export-Edge-Packages

call :Servercheck drive.google.com UninstallEdge
call :download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiUnZHSm9ZVVBMQTQ" Export-Edge-Packages.zip
call :Unzip Export-Edge-Packages.zip
del Export-Edge-Packages.zip

cmd /c %HOMEDRIVE%\Export-Edge-Packages\Start.cmd 
cd %CurCD%
goto UninstallEdge
)



:UninstallEdge_restore
cls 
sc stop wuauserv >nul 2>&1
FOR /F "delims=" %%A IN ('dir %HOMEDRIVE%\Export-Edge-Packages\Output\*.cab /s /b') DO (dism.exe /online /Add-Package /PackagePath:%%A /NoRestart)
FOR /F "delims=" %%A IN ('dir %HOMEDRIVE%\Export-Edge-Packages\Output\*.cab /s /b') DO (dism.exe /online /Add-Package /PackagePath:%%A /NoRestart)
call :Infomsgbox "Microsoft Edge should be installed, Please Restart your computer.","9F"
goto UninstallEdge






::==============================================================================================================================================================================



:UninstallCortana
cls
set Button1Color=4F
set Button2Color=2F

%BB% ^
   /c 0x1F                  /g 16 1  /d "_______________________________________________________________________________________"^
                            /g 15 2  /d "|                         __   __   ___   ____   __   _  _   __                         |"^
                            /g 15 3  /d "|                        / _) /  \ (  ,) (_  _) (  ) ( \( ) (  )                        |"^
                            /g 15 4  /d "|                       ( (_ ( () ) )  \   )(   /__\  )  (  /__\                        |"^
                            /g 15 5  /d "|                        \__) \__/ (_)\_) (__) (_)(_)(_)\_)(_)(_)                       |"^
                            /g 15 6  /d "|_______________________________________________________________________________________|"^
                            /g 15 7  /d "                                                                                         "^
                            /g 16 8  /d "________________________________________________________________________________________"^
   /c 0x%Button1Color%      /g 15 9  /d "|                                                                                        |"^
                            /g 15 10 /d "|  1.Uninstall Cortana                                                                   |"^
                            /g 15 11 /d "|       This will remove Cortana completely using : install_wim_tweak but the script     |"^
                            /g 15 12 /d "|           will first backup all packages to restore them when needed.                  |"^
                            /g 15 13 /d "|       If you uninstall Cortana twice then the packages will be removed.                |"^
                            /g 15 14 /d "|       Microsoft .NET Framework 3.5 should be installed.                                |"^
                            /g 15 15 /d "|       You Should be connected to Internet to download necessary files.                 |"^
                            /g 15 16 /d "|________________________________________________________________________________________|"^
   /c 0x1F                  /g 16 17 /d "________________________________________________________________________________________"  ^
   /c 0x%Button2Color%      /g 15 18 /d "|                                                                                        |"^
                            /g 15 19 /d "|  2.Restore Cortana                                                                     |"^
                            /g 15 20 /d "|       This will restore Cortana using backed up packages.If the restore operation      |"^
                            /g 15 21 /d "|           didn't work try it again and Contact Yasser Da Sila in MDL.                  |"^
                            /g 15 22 /d "|       If you uninstalled Cortana twice you won't be able to restore it.                |"^
                            /g 15 23 /d "|________________________________________________________________________________________|"^
   /c 0x1F                  /g 16 24 /d "________________________________________________________________________________________"^
   /c 0x9F                  /g 15 25 /d "|                                                                                        |"^
   /c 0x9F                  /g 15 26 /d "|                                    0. Go Back                                          |"^
   /c 0x9F                  /g 15 27 /d "|________________________________________________________________________________________|"^
   /c 0x1F


If /i "%SelectMode%"=="Mouse" (
for /f "tokens=1,2,3 delims=:" %%a in ('%BB% /m') do (
  %BB% /g 0 0

  set "buttonClicked"=""
  %BB% /d "mouse: %%b %%a %%c   "  >nul 2>&1
    if %%c EQU 1 if %%b GEQ 9 if %%b LEQ 16 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=1" 
    if %%c EQU 1 if %%b GEQ 19 if %%b LEQ 24 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=2" 
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 28 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=0" 
)
) else (
    %BB% /g 16 29
    Set /p buttonClicked=Use Your Keyboard Numbers to select options :
)




If %buttonClicked%==0 exit /b
If %buttonClicked%==1 call :UninstallCortana_Confirm
If %buttonClicked%==2 call :UninstallCortana_restore
goto UninstallCortana



:UninstallCortana_Confirm
call :msgbox Confirm
if /i "!buttonClicked!"=="No" ( goto UninstallCortana
) else (
cls
call :Infomsgbox "Downloading necessary files... " 9F 0
Set CurCD=%CD%
Del /Q "%HOMEDRIVE%\Export-Cortana-Packages\" >nul 2>&1
MKDIR "%HOMEDRIVE%\Export-Cortana-Packages\" >nul 2>&1
attrib +h %HOMEDRIVE%\Export-Cortana-Packages >nul 2>&1
cd %HOMEDRIVE%\Export-Cortana-Packages

call :Servercheck drive.google.com UninstallCortana
call :download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiNTdPeUFSdUx4WkU" Export-Cortana-Packages.zip
call :Unzip Export-Cortana-Packages.zip
del Export-Cortana-Packages.zip

cmd /c %HOMEDRIVE%\Export-Cortana-Packages\Start.cmd 
cd %CurCD%
goto UninstallCortana)



:UninstallCortana_restore
cls 
sc stop wuauserv >nul 2>&1
FOR /F "delims=" %%A IN ('dir %HOMEDRIVE%\Export-Cortana-Packages\Output\*.cab /s /b') DO (dism.exe /online /Add-Package /PackagePath:%%A /NoRestart)
FOR /F "delims=" %%A IN ('dir %HOMEDRIVE%\Export-Cortana-Packages\Output\*.cab /s /b') DO (dism.exe /online /Add-Package /PackagePath:%%A /NoRestart)
call :Infomsgbox "Cortana should be installed, Please Restart your computer.","9F"
goto UninstallCortana






::==============================================================================================================================================================================

:UninstallIE11
cls
set Button1Color=4F
set Button2Color=2F

%BB% ^
   /c 0x1F                  /g 16 1  /d "_______________________________________________________________________________________"^
                            /g 15 2  /d "|   __  __ _ ____ ____ ____ __ _ ____ ____    ____ _  _ ____ __    __ ____ ____ ____    |"^
                            /g 15 3  /d "|  (  )(  ( (_  _(  __(  _ (  ( (  __(_  _)  (  __( \/ (  _ (  )  /  (  _ (  __(  _ \   |"^
                            /g 15 4  /d "|   )( /    / )(  ) _) )   /    /) _)  )(     ) _) )  ( ) __/ (_/(  O )   /) _) )   /   |"^
                            /g 15 5  /d "|  (__)\_)__)(__)(____(__\_\_)__(____)(__)   (____(_/\_(__) \____/\__(__\_(____(__\_)   |"^
                            /g 15 6  /d "|_______________________________________________________________________________________|"^
                            /g 15 7  /d "                                                                                         "^
                            /g 16 8  /d "________________________________________________________________________________________"^
   /c 0x%Button1Color%      /g 15 9  /d "|                                                                                        |"^
                            /g 15 10 /d "|  1.Uninstall Internet Explorer 11                                                      |"^
                            /g 15 11 /d "|       This will remove IE 11 completely using : install_wim_tweak but the script       |"^
                            /g 15 12 /d "|           will first backup all packages to restore them when needed.                  |"^
                            /g 15 13 /d "|       If you uninstall IE 11  twice then the packages will be removed.                 |"^
                            /g 15 14 /d "|       Microsoft .NET Framework 3.5 should be installed.                                |"^
                            /g 15 15 /d "|       You Should be connected to Internet to download necessary files.                 |"^
                            /g 15 16 /d "|________________________________________________________________________________________|"^
   /c 0x1F                  /g 16 17 /d "________________________________________________________________________________________"  ^
   /c 0x%Button2Color%      /g 15 18 /d "|                                                                                        |"^
                            /g 15 19 /d "|  2.Restore Internet Explorer 11                                                        |"^
                            /g 15 20 /d "|       This will restore IE 11 using backed up packages.If the restore operation didn't |"^
                            /g 15 21 /d "|            work try it again and Contact Yasser Da Sila in MDL.                        |"^
                            /g 15 22 /d "|       If you uninstalled IE11 twice you won't be able to restore it.                   |"^
                            /g 15 23 /d "|________________________________________________________________________________________|"^
   /c 0x1F                  /g 16 24 /d "________________________________________________________________________________________"^
   /c 0x9F                  /g 15 25 /d "|                                                                                        |"^
   /c 0x9F                  /g 15 26 /d "|                                    0. Go Back                                          |"^
   /c 0x9F                  /g 15 27 /d "|________________________________________________________________________________________|"^
   /c 0x1F



If /i "%SelectMode%"=="Mouse" (
for /f "tokens=1,2,3 delims=:" %%a in ('%BB% /m') do (
  %BB% /g 0 0

  set "buttonClicked"=""
  %BB% /d "mouse: %%b %%a %%c   "  >nul 2>&1
    if %%c EQU 1 if %%b GEQ 9 if %%b LEQ 16 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=1" 
    if %%c EQU 1 if %%b GEQ 19 if %%b LEQ 24 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=2" 
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 28 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=0" 
)
) else (
    %BB% /g 16 29
    Set /p buttonClicked=Use Your Keyboard Numbers to select options :
)



If %buttonClicked%==0 exit /b
If %buttonClicked%==1 call :UninstallIE11_Confirm
If %buttonClicked%==2 call :UninstallIE11_restore
goto UninstallIE11



:UninstallIE11_Confirm
call :msgbox Confirm
if /i "!buttonClicked!"=="No" ( goto UninstallIE11
) else (
cls
call :Infomsgbox "Downloading necessary files... " 9F 0
Set CurCD=%CD%
Del /Q "%HOMEDRIVE%\Export-IE-Packages\" >nul 2>&1
MKDIR "%HOMEDRIVE%\Export-IE-Packages\" >nul 2>&1
attrib +h %HOMEDRIVE%\Export-IE-Packages >nul 2>&1
cd %HOMEDRIVE%\Export-IE-Packages

call :Servercheck drive.google.com UninstallIE11
call :download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiVlJ4WUlRVnFhTTg" Export-IE-Packages.zip
call :Unzip Export-IE-Packages.zip
del Export-IE-Packages.zip

cmd /c %HOMEDRIVE%\Export-IE-Packages\Start.cmd 
cd %CurCD%
goto UninstallIE11
)



:UninstallIE11_restore
cls 
sc stop wuauserv >nul 2>&1
FOR /F "delims=" %%A IN ('dir %HOMEDRIVE%\Export-IE-Packages\Output\*.cab /s /b') DO (dism.exe /online /Add-Package /PackagePath:%%A /NoRestart)
FOR /F "delims=" %%A IN ('dir %HOMEDRIVE%\Export-IE-Packages\Output\*.cab /s /b') DO (dism.exe /online /Add-Package /PackagePath:%%A /NoRestart)
call :Infomsgbox "IE11 should be installed, Please Restart your computer.","9F"
goto UninstallIE11




::==============================================================================================================================================================================


:CALC32
cd /d "%~dp0"
Set CurCD=%CD%

call :Infomsgbox "Downloading and installing necessary files..." 9F 0
call :Servercheck drive.google.com WinAppsmenu
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiaGNnbm94aDhQbjg" Old-Calculator-for-Windows10.exe
"Old-Calculator-for-Windows10.exe" /S
del "Old-Calculator-for-Windows10.exe"

cd %CurCD%

cls

call :msgbox ok
exit /b


::==============================================================================================================================================================================


:Paint32
cd /d "%~dp0"
Set CurCD=%CD%
call :Infomsgbox "Downloading and installing necessary files..." 9F 0
call :Servercheck drive.google.com WinAppsmenu
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiVC1SWWRIajRna0E" Classic-Paint-for-Windows-10.exe
"Classic-Paint-for-Windows-10.exe" /S
del "Classic-Paint-for-Windows-10.exe"
cd %CurCD%
cls

call :msgbox ok
exit /b




::==============================================================================================================================================================================

:Win7Taskmanager
cd /d "%~dp0"
Set CurCD=%CD%


call :Infomsgbox "Downloading and installing necessary files..." 9F 0
call :Servercheck drive.google.com WinAppsmenu.................................
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiT1pJWkc4c0VrM0E" Old-Task-Manager-for-Windows10.exe
"Old-Task-Manager-for-Windows10.exe" /S
del "Old-Task-Manager-for-Windows10.exe"
cd %CurCD%

cls
call :msgbox ok
exit /b


::==============================================================================================================================================================================


:OLDMSConfig
cd /d "%~dp0"
Set CurCD=%CD%

call :Infomsgbox "Downloading and installing necessary files..." 9F 0
call :Servercheck drive.google.com WinAppsmenu
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiZTlyQ09ZRGFkTDg" MSCONFIGforWindows10and8.exe
"MSCONFIGforWindows10and8.exe" /S
del "MSCONFIGforWindows10and8.exe"
cd %CurCD%

cls

call :msgbox ok
exit /b



:================================================================================================

:verify-WindowsDefender
  reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware | find "0x1" >nul
  if "%errorlevel%"=="0" ( (set "WindowsDefender=Disabled") & (set Button%~1Color="4F") ) else ( (set "WindowsDefender=Enabled") & (set Button%~1Color="2F") )

exit/b


:Enable-WindowsDefender
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 1 /f  > NUL 2>&1

Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f > NUL 2>&1

Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "WindowsDefender" /t REG_BINARY /d "060000000000000000000000" /f > NUL 2>&1
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /t REG_EXPAND_SZ /d "\"%%ProgramFiles%%\Windows Defender\MSASCuiL.exe\"" /f > NUL 2>&1

Start /d "%ProgramFiles%\Windows Defender" MSASCui.exe
call :msgbox ok 300
exit /b


:Disable-WindowsDefender
taskkill /IM MSASCuiL.exe /F > NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 0 /f > NUL 2>&1

Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f > NUL 2>&1

Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Windows Defender" /f > NUL 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f > NUL 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Windows Defender" /f > NUL 2>&1

call :msgbox ok 300
exit /b




::==============================================================================================================================================================================




:verify-PhotoViewer
  reg query "HKCR\Applications\photoviewer.dll\shell\open" /v MuiVerb | find "@photoviewer.dll,-3043" >nul
  if "%errorlevel%"=="0" ( (set "PhotoViewer=Enabled") & (set Button%~1Color="2F") ) else ( (set "PhotoViewer=Disabled") & (set Button%~1Color="4F") )

exit/b



:Enable-PhotoViewer
reg add "HKCR\Applications\photoviewer.dll\shell\open" /v "MuiVerb" /t REG_SZ /d "@photoviewer.dll,-3043" /f > NUL 2>&1
reg add "HKCR\Applications\photoviewer.dll\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > NUL 2>&1
reg add "HKCR\Applications\photoviewer.dll\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Bitmap" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Bitmap" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Bitmap\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-70" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Bitmap\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Bitmap\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.JFIF" /v "EditFlags" /t REG_DWORD /d "65536" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.JFIF" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.JFIF" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.JFIF\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-72" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.JFIF\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.JFIF\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.JFIF\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg" /v "EditFlags" /t REG_DWORD /d "65536" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-72" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Jpeg\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Png" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Png" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3057" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Png\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-71" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Png\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Png\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Gif" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Gif" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3057" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Gif\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\imageres.dll,-83" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Gif\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Gif\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Wdp" /v "EditFlags" /t REG_DWORD /d "65536" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Wdp" /v "ImageOptionFlags" /t REG_DWORD /d "1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Wdp\DefaultIcon" /ve /t REG_SZ /d "%%SystemRoot%%\System32\wmphoto.dll,-400" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Wdp\shell\open" /v "MuiVerb" /t REG_EXPAND_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Wdp\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f > NUL 2>&1
reg add "HKCR\PhotoViewer.FileAssoc.Wdp\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationDescription" /t REG_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3069" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities" /v "ApplicationName" /t REG_SZ /d "@%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3009" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".wdp" /t REG_SZ /d "PhotoViewer.FileAssoc.Wdp" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jfif" /t REG_SZ /d "PhotoViewer.FileAssoc.JFIF" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".dib" /t REG_SZ /d "PhotoViewer.FileAssoc.Bitmap" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d "PhotoViewer.FileAssoc.Png" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jxr" /t REG_SZ /d "PhotoViewer.FileAssoc.Wdp" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d "PhotoViewer.FileAssoc.Bitmap" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpe" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d "PhotoViewer.FileAssoc.Jpeg" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".gif" /t REG_SZ /d "PhotoViewer.FileAssoc.Gif" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".tiff" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > NUL 2>&1
Call :msgbox ok 200

exit /b


:: ===============================================================================================================================================================================

:verify-Darkmode

  reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme | find "0x0" >nul
  if "%errorlevel%"=="0" ( (set "Darkmode=Enabled") & (set Button%~1Color="2F") ) else ( (set "Darkmode=Disabled") & (set Button%~1Color="4F") )

exit/b


:Enable-Darkmode
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "1" /f >nul
exit /b



:Disable-Darkmode
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "0" /f >nul
exit /b




::==============================================================================================================================================================================


:verify-VolumeControlUI
  reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v EnableMtcUvc | find "0x0" >nul
  if "%errorlevel%"=="0" ( (set "VolumeControlUI=OLD") & (set Button%~1Color="4F") ) else ( (set "VolumeControlUI=NEW") & (set Button%~1Color="2F") )
exit /b



:OLD-VolumeControlUI
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v "EnableMtcUvc" /t REG_DWORD /d "0" /f
exit /b


:NEW-VolumeControlUI
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v "EnableMtcUvc" /t REG_DWORD /d "1" /f
exit /b


::==============================================================================================================================================================================


:verify-BatteryStatusUI
  reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32BatteryFlyout | find "0x1" >nul
  if "%errorlevel%"=="0" ( (set "BatteryStatusUI=OLD") & (set Button%~1Color="4F") ) else ( (set "BatteryStatusUI=NEW") & (set Button%~1Color="2F") )
exit /b



:OLD-BatteryStatusUI
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseWin32BatteryFlyout" /t REG_DWORD /d "1" /f
exit /b


:NEW-BatteryStatusUI
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "UseWin32BatteryFlyout" /t REG_DWORD /d "0" /f
exit /b



::==============================================================================================================================================================================



:verify-AltTabUI
  reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v AltTabSettings | find "0x1" >nul
  if "%errorlevel%"=="0" ( (set "AltTabUI=OLD") & (set Button%~1Color="4F") ) else ( (set "AltTabUI=NEW") & (set Button%~1Color="2F") )
exit /b



:OLD-AltTabUI
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AltTabSettings" /t REG_DWORD /d "1" /f
call :RestartExplorer
exit /b


:NEW-AltTabUI
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AltTabSettings" /f
call :RestartExplorer
exit /b


::==============================================================================================================================================================================



:verify-Thumbnails
  reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v IconsOnly | find "0x1" >nul
  if "%errorlevel%"=="0" ( (set "Thumbnails=Disabled") & (set Button%~1Color="4F") ) else ( (set "Thumbnails=Enabled") & (set Button%~1Color="2F") )
exit /b



:Enable-Thumbnails
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V IconsOnly /T REG_DWORD /D 0 /F
call :RestartExplorer
exit /b


:Disable-Thumbnails
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V IconsOnly /T REG_DWORD /D 1 /F
call :RestartExplorer
exit /b


::==============================================================================================================================================================================



:verify-TaskViewBTN
  reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton | find "0x0" >nul
  if "%errorlevel%"=="0" ( (set "TaskViewBTN=Disabled") & (set Button%~1Color="2F") ) else ( (set "TaskViewBTN=Enabled") & (set Button%~1Color="2F") )
exit /b



:Enable-TaskViewBTN
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "1" /f
call :RestartExplorer
exit /b


:Disable-TaskViewBTN
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f
call :RestartExplorer
exit /b


::==============================================================================================================================================================================



:verify-TransparencyBlur
  reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency | find "0x1" >nul
  if "%errorlevel%"=="0" ( (set "TransparencyBlur=Enabled") & (set Button%~1Color="2F") ) else ( (set "TransparencyBlur=Disabled") & (set Button%~1Color="4F") )
exit /b



:Disable-TransparencyBlur
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableBlurBehind" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f
call :RestartExplorer
exit /b


:Enable-TransparencyBlur
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableBlurBehind" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "1" /f
call :RestartExplorer
exit /b




::==============================================================================================================================================================================

:verify-Logonscreen
  reg query "HKLM\Software\Policies\Microsoft\Windows\System" /v DisableLogonBackgroundImage | find "0x1" >nul
  if "%errorlevel%"=="0" (set "Logonscreen=Color") else (set "Logonscreen=Image")
exit /b



:Color-Logonscreen
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "DisableLogonBackgroundImage" /t REG_DWORD /d "1" /f
exit /b


:Image-Logonscreen
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "DisableLogonBackgroundImage" /t REG_DWORD /d "0" /f
exit /b

::==============================================================================================================================================================================


:verify-DeleteDialogDetails
  reg query "HKCR\AllFilesystemObjects" /v FileOperationPrompt | find "prop:System.PropGroup.FileSystem;System.ItemNameDisplay;System.ItemTypeText;System.ItemFolderPathDisplay;System.Size;System.DateCreated;System.DateModified;System.FileAttributes;System.OfflineAvailability;System.OfflineStatus;System.SharedWith;System.FileOwner;System.ComputerName" >nul
  if "%errorlevel%"=="0" ( (set "DeleteDialogDetails=Yes") & (set Button%~1Color="2F") ) else ( (set "DeleteDialogDetails= No") & (set Button%~1Color="2F") )
exit /b



:Yes-DeleteDialogDetails
Reg.exe add "HKCR\AllFilesystemObjects" /v "FileOperationPrompt" /t REG_SZ /d "prop:System.PropGroup.FileSystem;System.ItemNameDisplay;System.ItemTypeText;System.ItemFolderPathDisplay;System.Size;System.DateCreated;System.DateModified;System.FileAttributes;System.OfflineAvailability;System.OfflineStatus;System.SharedWith;System.FileOwner;System.ComputerName" /f
exit /b


:NO-DeleteDialogDetails
Reg.exe delete "HKCR\AllFilesystemObjects" /v "FileOperationPrompt" /f
Reg.exe add "HKCR\AllFilesystemObjects" /f
exit /b



::==============================================================================================================================================================================

:verify-Thumbnailsize
  reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v MinThumbSizePx | find "0x190" >nul
  if "%errorlevel%"=="0" (set "Thumbnailsize=190/400") else (set "Thumbnailsize=Default")
exit /b


:400-Thumbnailsize
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "MinThumbSizePx" /t REG_DWORD /d "400" /f
call :RestartExplorer
exit /b


:Default-Thumbnailsize
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "MinThumbSizePx" /f
call :RestartExplorer
exit /b


::==============================================================================================================================================================================




:ContextMenu
call :ClearButtons

call :verify-AdminRightsCM 1 >nul 2>&1
call :verify-SelectCM 2 >nul 2>&1
call :verify-PinQuickaccess 3 >nul 2>&1
call :verify-PersonalizeCM 4 >nul 2>&1
call :verify-ResolutionCM 5 >nul 2>&1
call :verify-PowerCM 6 >nul 2>&1
call :verify-BluetoothCM 7 >nul 2>&1
call :verify-OpenwithNotepad 8 >nul 2>&1 
call :verify-CopyPath 9 >nul 2>&1


set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|            __   __  __  _  ____  ___  _  _  ____    __  __  ___ __  _  _  _           ^|"
set "Title3=                ^|           / _) /  \ \ \( )(_  _)(  _)( \/ )(_  _)  (  \/  )(  _)\ \( )( )( )          ^|"
set "Title4=                ^|          ( (_ ( () ) )  (   )(   ) _) )  (   )(     )    (  ) _) )  (  )()/           ^|"
set "Title5=                ^|           \__) \__/ (_)\_) (__) (___)(_/\_) (__)   (_/\/\_)(___)(_)\_) \__/           ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1='Grant Admin Full Control' In Files and Folders (%AdminRightsCM% )" 
set  "button3=                 Pin to Quick access             (%PinQuickaccess% )"
set  "button5=           Screen Resolution menu in Desktop     (%ResolutionCM% )"
set  "button7=               Bluetooth menu in Desktop         (%BluetoothCM% )"
set  "button9=            Copy File Location to Clipboard      (%CopyPath% )"

set  "button2=                 Select Context menu             (%SelectCM% )"
set  "button4=           Classic Personalize to Desktop        (%PersonalizeCM% )"
set  "button6=               Power Options in Desktop          (%PowerCM% )"
set  "button8=           Add Open with Notepad to Files        (%OpenwithNotepad% )"


set "button14=Go Back"                                                              & set Button14Color=%BackButtonColor%
call :drawMenu 


call :readInput

if "%buttonClicked%"=="1"  ((if /i "%AdminRightsCM%"==" ON"     (Call :OFF-AdminRightsCM        )) & (if /i "%AdminRightsCM%"=="OFF"        (Call :ON-AdminRightsCM         )) & goto ContextMenu ) >nul 2>&1
if "%buttonClicked%"=="2"  ((if /i "%SelectCM%"==" ON"          (Call :OFF-SelectCM             )) & (if /i "%SelectCM%"=="OFF"             (Call :ON-SelectCM              )) & goto ContextMenu ) >nul 2>&1
if "%buttonClicked%"=="3"  ((if /i "%PinQuickaccess%"==" ON"    (Call :OFF-PinQuickaccess       )) & (if /i "%PinQuickaccess%"=="OFF"       (Call :ON-PinQuickaccess        )) & goto ContextMenu ) >nul 2>&1
if "%buttonClicked%"=="4"  ((if /i "%PersonalizeCM%"==" ON"     (Call :OFF-PersonalizeCM        )) & (if /i "%PersonalizeCM%"=="OFF"        (Call :ON-PersonalizeCM         )) & goto ContextMenu ) >nul 2>&1
if "%buttonClicked%"=="5"  ((if /i "%ResolutionCM%"==" ON"      (Call :OFF-ResolutionCM         )) & (if /i "%ResolutionCM%"=="OFF"         (Call :ON-ResolutionCM          )) & goto ContextMenu ) >nul 2>&1
if "%buttonClicked%"=="6"  ((if /i "%PowerCM%"==" ON"           (Call :OFF-PowerCM              )) & (if /i "%PowerCM%"=="OFF"              (Call :ON-PowerCM               )) & goto ContextMenu ) >nul 2>&1
if "%buttonClicked%"=="7"  ((if /i "%BluetoothCM%"==" ON"       (Call :OFF-BluetoothCM          )) & (if /i "%BluetoothCM%"=="OFF"          (Call :ON-BluetoothCM           )) & goto ContextMenu ) >nul 2>&1
if "%buttonClicked%"=="8"  ((if /i "%OpenwithNotepad%"==" ON"   (Call :OFF-OpenwithNotepad      )) & (if /i "%OpenwithNotepad%"=="OFF"      (Call :ON-OpenwithNotepad       )) & goto ContextMenu ) >nul 2>&1
if "%buttonClicked%"=="9"  ((if /i "%CopyPath%"==" ON"          (Call :OFF-CopyPath             )) & (if /i "%CopyPath%"=="OFF"             (Call :ON-CopyPath              )) & goto ContextMenu ) >nul 2>&1


if "%buttonClicked%"=="14" goto UI
goto ContextMenu





:verify-AdminRightsCM
  reg query "HKCR\*\shell\runas" /v MUIVerb | find "Grant Admin Full Control" >nul
  if "%errorlevel%"=="0" (set "AdminRightsCM= ON") else (set "AdminRightsCM=OFF")
exit /b



:ON-AdminRightsCM
Reg.exe add "HKCR\*\shell\runas" /v "MUIVerb" /t REG_SZ /d "Grant Admin Full Control" /f
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
exit /b


:OFF-AdminRightsCM
Reg.exe delete "HKCR\*\shell\runas" /f
Reg.exe delete "HKCR\exefile\shell\runas2" /f
Reg.exe delete "HKCR\Directory\shell\runas" /f
exit /b



:verify-SelectCM
  reg query "HKCR\*\shell\Select" /v SubCommands | find "Windows.selectall;Windows.selectnone;Windows.invertselection" >nul
  if "%errorlevel%"=="0" (set "SelectCM= ON") else (set "SelectCM=OFF")
exit /b



:ON-SelectCM
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
exit /b


:OFF-SelectCM
Reg.exe delete "HKCR\*\shell\Select" /f
Reg.exe delete "HKCR\Folder\shell\Select" /f
Reg.exe delete "HKCR\Directory\Background\shell\Select" /f
Reg.exe delete "HKCR\LibraryFolder\Background\shell\Select" /f
exit /b




:verify-PinQuickaccess
  reg query "HKCR\Folder\shell\pintohome" /v MUIVerb | find "@shell32.dll,-51377" >nul
  if "%errorlevel%"=="0" (set "PinQuickaccess= ON") else (set "PinQuickaccess=OFF")
exit /b



:ON-PinQuickaccess
Reg.exe delete "HKCR\Folder\shell\pintohome" /f
Reg.exe add "HKCR\Folder\shell\pintohome" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-51377" /f
Reg.exe add "HKCR\Folder\shell\pintohome" /v "AppliesTo" /t REG_SZ /d "System.ParsingName:<>\"::{679f85cb-0220-4080-b29b-5540cc05aab6}\"" /f
Reg.exe add "HKCR\Folder\shell\pintohome\command" /v "DelegateExecute" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-51377" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /v "AppliesTo" /t REG_SZ /d "System.ParsingName:<>\"::{679f85cb-0220-4080-b29b-5540cc05aab6}\"" /f
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome\command" /v "DelegateExecute" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f
exit /b


:OFF-PinQuickaccess
Reg.exe delete "HKCR\Folder\shell\pintohome" /f
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /f
exit /b



:verify-PersonalizeCM
  reg query "HKCR\DesktopBackground\Shell\Personalization\shell\001flyout" /v MUIVerb | find "Theme Settings" >nul
  if "%errorlevel%"=="0" (set "PersonalizeCM= ON") else (set "PersonalizeCM=OFF")
exit /b



:ON-PersonalizeCM
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
exit /b


:OFF-PersonalizeCM
Reg.exe delete "HKCR\DesktopBackground\Shell\Personalization" /f

exit /b


:verify-ResolutionCM
  reg query "HKCR\DesktopBackground\Shell\Screen resolution" /v ControlPanelName | find "Microsoft.Display" >nul
  if "%errorlevel%"=="0" (set "ResolutionCM= ON") else (set "ResolutionCM=OFF") 
exit /b



:ON-ResolutionCM
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "ControlPanelName" /t REG_SZ /d "Microsoft.Display" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "ControlPanelPage" /t REG_SZ /d "Settings" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "Icon" /t REG_SZ /d "%%SystemRoot%%\System32\display.dll,-1" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /v "Position" /t REG_SZ /d "Bottom" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution" /ve /t REG_SZ /d "@%%SystemRoot%%\system32\Display.dll,-300" /f
Reg.exe add "HKCR\DesktopBackground\Shell\Screen resolution\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
exit /b


:OFF-ResolutionCM
Reg.exe delete "HKCR\DesktopBackground\Shell\Screen resolution" /f
exit /b





:verify-PowerCM
  reg query "HKCR\DesktopBackground\Shell\Power" /v MUIVerb | find "Power" >nul
  if "%errorlevel%"=="0" (set "PowerCM= ON") else (set "PowerCM=OFF")
exit /b



:ON-PowerCM
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
exit /b


:OFF-PowerCM
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
exit /b


:verify-BluetoothCM
  reg query "HKCR\DesktopBackground\Shell\Bluetooth" /v MUIVerb | find "Bluetooth" >nul
  if "%errorlevel%"=="0" (set "BluetoothCM= ON") else (set "BluetoothCM=OFF")
exit /b



:ON-BluetoothCM
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
exit /b


:OFF-BluetoothCM
Reg.exe delete "HKCR\DesktopBackground\Shell\Bluetooth" /f
exit /b



:verify-OpenwithNotepad
  reg query "HKCR\*\shell\Open with Notepad" /v MUIVerb | find "Open with Notepad" >nul
  if "%errorlevel%"=="0" (set "OpenwithNotepad= ON") else (set "OpenwithNotepad=OFF")
exit /b



:ON-OpenwithNotepad
Reg.exe add "HKCR\*\shell\Open with Notepad" /v "MUIVerb" /t REG_SZ /d "Open with Notepad" /f
Reg.exe add "HKCR\*\shell\Open with Notepad\command" /ve /t REG_SZ /d "notepad.exe %%1" /f
exit /b


:OFF-OpenwithNotepad
Reg.exe delete "HKCR\*\shell\Open with Notepad" /f
exit /b



:verify-CopyPath
  reg query "HKCR\*\shell\Copy Path to Clipboard" /v icon | find "%%SystemRoot%%\System32\shell32.dll ,260" >nul
  if "%errorlevel%"=="0" (set "CopyPath= ON") else (set "CopyPath=OFF")
exit /b



:ON-CopyPath
Reg.exe add "HKCR\*\shell\Copy Path to Clipboard" /v "icon" /t REG_SZ /d "%%SystemRoot%%\System32\shell32.dll ,260" /f
Reg.exe add "HKCR\*\shell\Copy Path to Clipboard\command" /ve /t REG_SZ /d "cmd.exe /c echo \"%%1\" > Path.txt &  CLIP < Path.txt  & del path.txt" /f
exit /b


:OFF-CopyPath
Reg.exe delete "HKCR\*\shell\Copy Path to Clipboard" /f
exit /b

::==============================================================================================================================================================================


:OEMInfo
call :ClearButtons


set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|    __   ___  __  __    __ __  _  ___   __   ___   __  __   __   ____  __   __  __  _  ^|"
set "Title3=                ^|   /  \ (  _)(  \/  )  (  )\ \( )(  _) /  \ (  ,) (  \/  ) (  ) (_  _)(  ) /  \ \ \( ) ^|"
set "Title4=                ^|  ( () ) ) _) )    (    )(  )  (  ) _)( () ) )  \  )    (  /__\   )(   )( ( () ) )  )  ^|"
set "Title5=                ^|   \__/ (___)(_/\/\_)  (__)(_)\_)(_)   \__/ (_)\_)(_/\/\_)(_)(_) (__) (__) \__/ (_)\_) ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1=MANUFACTURER" 
set  "button3=MODEL"
set  "button5=LOGO"

set  "button2=SUPPORT HOURS"
set  "button4=SUPPORT PHONE"
set  "button6=SUPPORT URL"



set "button12=Go Back"              & set Button12Color=%BackButtonColor%
call :drawMenu
call :readInput

if "%buttonClicked%"=="7" goto OEMInfo
if "%buttonClicked%"=="8" goto OEMInfo
if "%buttonClicked%"=="9" goto OEMInfo
if "%buttonClicked%"=="10" goto OEMInfo
if "%buttonClicked%"=="11" goto OEMInfo
if "%buttonClicked%"=="13" goto OEMInfo
if "%buttonClicked%"=="14" goto OEMInfo

if "%buttonClicked%"=="12" goto UI


%BB% /g 0 20
echo.  __________________________________________________________________________________________________________________
echo. ^|                                                                                                                  ^|
echo. ^| Input :                                                                                                          ^|
echo. ^|__________________________________________________________________________________________________________________^|
%BB% /c 0x1F /g 10 22 /d "                                                                                                         "
call :ClearButton 12
%BB% /g 11 22
set /p Input=
If "%Input%"==""  Goto OEMInfo
If "%Input%"==" " Goto OEMInfo
If "%Input%"=="0" Goto OEMInfo
%BB% /g 0 25
if "%buttonClicked%"=="1"  (reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Manufacturer /f /t REG_SZ /d "%Input%")
if "%buttonClicked%"=="2"  (reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportHours /f /t REG_SZ /d "%Input%")
if "%buttonClicked%"=="3"  (reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Model /f /t REG_SZ /d "%Input%")
if "%buttonClicked%"=="4"  (reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportPhone /f /t REG_SZ /d "%Input%")
if "%buttonClicked%"=="5"  (reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v logo /f /t REG_SZ /d "%Input%")
if "%buttonClicked%"=="6"  (reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportURL /f /t REG_SZ /d "%Input%")
call :msgbox Ok 300
pause >nul
goto OEMInfo




::==============================================================================================================================================================================




:ColouriseStartmenu
call :ClearButtons

call :verify-TitleBars 1 >nul 2>&1
call :verify-Colourised 2

Call :GetActiveButton 5 3
Call :GetActiveButton 6 4



set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|        _  _  ___  ___  ___      __  _  _  ____  ___  ___   ___   __    __  ___        ^|"
set "Title3=                ^|       ( )( )/ __)(  _)(  ,)    (  )( \( )(_  _)(  _)(  ,) (  _) (  )  / _)(  _)       ^|"
set "Title4=                ^|        )()( \__ \ ) _) )  \     )(  )  (   )(   ) _) )  \  ) _) /__\ ( (_  ) _)       ^|"
set "Title5=                ^|        \__/ (___/(___)(_)\_)   (__)(_)\_) (__) (___)(_)\_)(_)  (_)(_) \__)(___)       ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1=Windows Title bars and borders (%TitleBars%)  [FE]" 
set  "button2=Colourise Start Menu & Taskbar : %Colourised%  [FE]"

set  "button5=Set Inactive Title Bar Color  [FE]"
set  "button6=RGB color table"



set "button14=Go Back" & set Button14Color=%BackButtonColor%
call :drawMenu


call :readInput

if "%buttonClicked%"=="1"  ((if /i "%TitleBars%"=="Colourised"  (Call :DeColourise-TitleBars ))      &       (if /i "%TitleBars%"=="DeColourised" (Call :Colourise-TitleBars ))         & goto ColouriseStartmenu )
if "%buttonClicked%"=="2"  ((if /i "%Colourised%"=="Taskbar" (Call :Colourise-Both )) & (if /i "%Colourised%"=="Both" (Call :Colourise-None )) & (if /i "%Colourised%"=="None" (Call :Colourise-Taskbar )) & goto ColouriseStartmenu ) >nul 2>&1

if "%buttonClicked%"=="%ActiveButton5%"  (call :InactiveTitleBars)
if "%buttonClicked%"=="%ActiveButton6%"  (start http://samples.msdn.microsoft.com/workshop/samples/author/dhtml/colors/ColorTable.htm & GOTO ColouriseStartmenu)


if "%buttonClicked%"=="14" goto UI
goto ColouriseStartmenu








:verify-TitleBars
  reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM" /v ColorPrevalence | find "0x1" >nul
  if "%errorlevel%"=="0" ((set "TitleBars=Colourised") & (set Button%~1Color="2F") ) else ((set "TitleBars=DeColourised") & (set Button%~1Color="1F") )
exit /b



:Colourise-TitleBars
call :validateBuild 10586 +
if "%applyTweak%"=="0"  exit /b
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d "1" /f  >nul 2>&1
call :RestartExplorer
exit /b


:DeColourise-TitleBars
call :validateBuild 10586 +
if "%applyTweak%"=="0"  exit /b
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d "0" /f  >nul 2>&1
call :RestartExplorer
exit /b




:verify-Colourised
  reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v ColorPrevalence | find "0x0" >nul
  if "%errorlevel%"=="0" (set "Colourised=None") else (set "Colourised=Taskbar" )

  reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v ColorPrevalence | find "0x1"
   if "%errorlevel%"=="0" (set "Colourised=Both" )
exit /b


:Colourise-None
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "ColorPrevalence" /t REG_DWORD /d "0" /f
call :RestartExplorer
exit /b

:Colourise-Both
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "ColorPrevalence" /t REG_DWORD /d "1" /f
call :RestartExplorer
exit /b

:Colourise-Taskbar
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "ColorPrevalence" /t REG_DWORD /d "2" /f
call :RestartExplorer
exit /b



:InactiveTitleBars

%BB% /g 0 20
echo.  ___________________________________________________________________
echo. ^|                                                                   ^|
echo. ^| Write the RGB hex number here (ex: d3d3d3 for lightgray):         ^|
echo. ^|___________________________________________________________________^|
%BB% /c 0xF1 /g 61 22 /d "       "
%BB% /g 61 22
set /p COLOR=

if "%COLOR%"==" " (exit /b)
if "%COLOR%"=="" (exit /b)

CD /D "%~dp0" 
> RegFile.reg Echo Windows Registry Editor Version 5.00
>> RegFile.reg Echo.
>> RegFile.reg Echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM]
>> RegFile.reg Echo "AccentColorInactive"=dword:%COLOR%

Start /Wait Regedit.exe /S RegFile.reg
Del RegFile.reg
call :RestartExplorer
call :msgbox Ok
exit /b







::==============================================================================================================================================================================




:verify-Updates
  sc query "UpdateDisabler" | find "RUNNING" >nul
  if "%errorlevel%"=="0" ( (set "Updates=Disabled") & (set Button%~1Color="4F") ) else ( (set "Updates=Enabled") & (set Button%~1Color="2F") )

exit/b





:Enable-Updates
call :Infomsgbox "Downloading and installing dependencies ... Please Wait" 9F 0
call :Servercheck drive.google.com MainMenu
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiUGRwelRKYnNwZGM" UpdaterDisabler.exe
UpdaterDisabler.exe -remove >nul 2>&1
Del /f /q /a UpdaterDisabler.exe >nul 2>&1

call :msgbox ok 300
exit /b


:Disable-Updates
call :Infomsgbox "Downloading and installing dependencies ... Please Wait" 9F 0
call :Servercheck drive.google.com MainMenu
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiUGRwelRKYnNwZGM" UpdaterDisabler.exe
UpdaterDisabler.exe -install >nul 2>&1
Del /f /q /a UpdaterDisabler.exe >nul 2>&1

call :msgbox ok 300
exit /b


::==============================================================================================================================================================================


:verify-Firewall
 Netsh Advfirewall show allprofiles | find "ON" >nul
  if "%errorlevel%"=="0" ( (set "Firewall=Enabled") & (set Button%~1Color="2F") ) else ( (set "Firewall=Disabled") & (set Button%~1Color="4F") )

exit/b


:Enable-Firewall
NetSh Advfirewall set allprofiles state on
exit /b


:Disable-Firewall
NetSh Advfirewall set allprofiles state off
exit /b



::==============================================================================================================================================================================

:verify-Lockscreen
cd %windir%/SystemApps
 IF exist Microsoft.LockApp_cw5n1h2txyewy.backup ( (set "Lockscreen=Disabled") & (set Button%~1Color="4F") ) else ( (set "Lockscreen=Enabled") & (set Button%~1Color="2F") )
CD /d %~dp0
exit/b


:Enable-Lockscreen
cd %windir%/SystemApps
Ren Microsoft.LockApp_cw5n1h2txyewy.backup Microsoft.LockApp_cw5n1h2txyewy
CD /d %~dp0
exit /b


:Disable-Lockscreen
cd %windir%/SystemApps
Ren Microsoft.LockApp_cw5n1h2txyewy Microsoft.LockApp_cw5n1h2txyewy.backup
CD /d %~dp0
exit /b


::==============================================================================================================================================================================


:CleanUpdatefiles
cls
net stop wuauserv
net stop bits


RMDIR /S /Q "%Windir%\SoftwareDistribution\Download\"
MKDIR "%Windir%\SoftwareDistribution\Download\"


Dism.exe /online /Cleanup-Image /StartComponentCleanup

net start wuauserv
net start bits
call :msgbox ok

GOTO Performance


::==============================================================================================================================================================================

:Restart_time


> Restart_Time.vbs ECHO Option Explicit 
>> Restart_Time.vbs ECHO On Error Resume Next
>> Restart_Time.vbs ECHO Dim Wsh, Time1, Time2, Result, PathFile, MsgResult, MsgA, AppName, KeyA, KeyB, TimeDiff

>> Restart_Time.vbs ECHO MsgA = "Close all aplications and click OK."
>> Restart_Time.vbs ECHO KeyA = "HKEY_CURRENT_USER\Software\RestartTime\"
>> Restart_Time.vbs ECHO KeyB = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run\RestartTime"
>> Restart_Time.vbs ECHO AppName = "Restart Time"
>> Restart_Time.vbs ECHO Set Wsh = CreateObject("WScript.Shell")
>> Restart_Time.vbs ECHO PathFile = """" ^& WScript.ScriptFullName ^& """"
>> Restart_Time.vbs ECHO Result = wsh.RegRead(KeyA ^& "Times")
>> Restart_Time.vbs ECHO if Result = "" then
>> Restart_Time.vbs ECHO MsgResult = Msgbox (MsgA, vbOKCancel, AppName)
>> Restart_Time.vbs ECHO If MsgResult = vbcancel then WScript.Quit
>> Restart_Time.vbs ECHO Wsh.RegWrite KeyA ^& "Times", left(Time,8), "REG_SZ"
>> Restart_Time.vbs ECHO Wsh.RegWrite KeyB, PathFile, "REG_SZ"
>> Restart_Time.vbs ECHO Wsh.Run "cmd /c Shutdown -r -t 00", false, 0 
>> Restart_Time.vbs ECHO else
>> Restart_Time.vbs ECHO Wsh.RegDelete KeyA ^& "Times"
>> Restart_Time.vbs ECHO Wsh.RegDelete KeyA
>> Restart_Time.vbs ECHO Wsh.RegDelete KeyB
>> Restart_Time.vbs ECHO TimeDiff = DateDiff("s",Result,left(Time,8))
>> Restart_Time.vbs ECHO MsgBox "PC restarted in " ^& TimeDiff ^& " secondes", VbInformation, AppName
>> Restart_Time.vbs ECHO end if
>> Restart_Time.vbs ECHO wScript.Quit


"Restart_Time.vbs"

GOTO Performance


::=============================================================================================================================================================================
::==============================================================================================================================================================================


:Services
::Files related services
sc config BDESVC start= disabled
sc config EFS start= disabled
sc config CscService start= disabled
sc config LanmanServer start= disabled

::Other services
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
exit /b

::==============================================================================================================================================================================

:verify-QuickAccess
  reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo | find "0x2" >nul
  if "%errorlevel%"=="0" ( (set "QuickAccess=Enabled") & (set Button%~1Color="4F") ) else ( (set "QuickAccess=Disabled") & (set Button%~1Color="2F") )

exit/b


:Enable-QuickAccess
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "LaunchTo" /t REG_DWORD /d 2 >nul

call :msgbox ok 300
exit /b


:Disable-QuickAccess
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "LaunchTo" /t REG_DWORD /d 1 >nul

call :msgbox ok 300
exit /b




::==============================================================================================================================================================================

:verify-BSOD
  reg query "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v DisplayParameters | find "0x1" >nul
  if "%errorlevel%"=="0" (set "BSOD=Enabled") else (set "BSOD=Disabled") 

exit/b


:Enable-BSOD
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "1" /f >nul

call :msgbox ok 300
exit /b


:Disable-BSOD
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "0" /f >nul

call :msgbox ok 300
exit /b




::==============================================================================================================================================================================

:verify-PSWRDReveal
  reg query "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CredUI" /v DisablePasswordReveal | find "0x1" >nul
  if "%errorlevel%"=="0" (set "PSWRDReveal=Disabled") else (set "PSWRDReveal=Enabled") 

exit/b


:Enable-PSWRDReveal
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d "0" /f >nul

call :msgbox ok 300
exit /b


:Disable-PSWRDReveal
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d "1" /f >nul

call :msgbox ok 300
exit /b




::==============================================================================================================================================================================

:verify-CMDinWinX
  reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DontUsePowerShellOnWinX | find "0x1" >nul
  if "%errorlevel%"=="0" (set "CMDinWinX=Enabled") else (set "CMDinWinX=Disabled") 

exit/b


:Enable-CMDinWinX
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DontUsePowerShellOnWinX" /t REG_DWORD /d "1" /f >nul

call :msgbox ok 300
exit /b


:Disable-CMDinWinX
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DontUsePowerShellOnWinX" /t REG_DWORD /d "0" /f >nul

call :msgbox ok 300
exit /b





::==============================================================================================================================================================================

:verify-HardwareICon
  reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\SysTray" /v Services | find "0x1f" >nul
  if "%errorlevel%"=="0" (set "HardwareICon=Enabled") else (set "HardwareICon=Disabled")

exit/b


:Enable-HardwareICon
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\SysTray" /v "Services" /t reg_dword /d 31 /f >nul

call :msgbox ok 300
exit /b


:Disable-HardwareICon
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\SysTray" /v "Services" /t reg_dword /d 29 /f >nul

call :msgbox ok 300
exit /b


::==============================================================================================================================================================================

:verify-SmartScreen
  reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen | find "0x0" >nul
  if "%errorlevel%"=="0" ( (set "SmartScreen=Disabled") & (set Button%~1Color="4F") ) else ( (set "SmartScreen=Enabled") & (set Button%~1Color="2F") )

exit/b


:Enable-SmartScreen
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t reg_dword /d 1 /f >nul

call :msgbox ok 300
exit /b




:Disable-SmartScreen
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t reg_dword /d 0 /f >nul

call :msgbox ok 300
exit /b




::==============================================================================================================================================================================


:Verify-EdgeAds
IF EXIST %windir%\SYSTEM32\DRIVERS\ETC\HOSTS.MVP ( (set "EdgeAds=Disabled") & (set Button%~1Color="2F") 
) else ( (set "EdgeAds=Enabled") & (set Button%~1Color="4F") )

exit /b

:Enable-EdgeAds
if exist %WINDIR%\system32\drivers\etc\hosts.MVP (
    attrib -r "%WINDIR%\system32\drivers\etc\hosts"
    del /F /Q "%WINDIR%\system32\drivers\etc\hosts"
    ren "%WINDIR%\system32\drivers\etc\hosts.MVP" "hosts"
    attrib +r "%WINDIR%\system32\drivers\etc\hosts"
call :msgbox ok 300
) else (
call :Infomsgbox "There is no Hosts.MVP file" 9F
)
exit /b


:Disable-EdgeAds
call :Infomsgbox "Downloading and installing necessary files..." 9F 1
call :Servercheck drive.google.com Edge
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfib2hTMDhVamF1OWs" HOSTS
cls



echo.

:: ------------EXTRA CODE TO CHANGE DIRECTORY-------------
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
  
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DnsCache\Parameters" /v "MaxCacheTtl" /t REG_DWORD /d "1" /f>NUL
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DnsCache\Parameters" /v "MaxNegativeCacheTtl" /t REG_DWORD /d "0" /f>NUL
del /F /Q HOSTS
tasklist /FI "IMAGENAME eq MicrosoftEdge.exe" 2>NUL | find /I /N "MicrosoftEdge.exe">NUL


if "%ERRORLEVEL%"=="0" call :Infomsgbox "You need to restart MS Edge so that changes takes effect." 9F
if "%ERRORLEVEL%"=="1" call :msgbox ok 300

exit /b

:noHostsFile
call :Infomsgbox "There is no HOSTS file in the same directory with this script." 9F

exit /b



::==============================================================================================================================================================================
:verify-EdgeTheme
  reg query "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v Theme | find "0x0" >nul
  if "%errorlevel%"=="0" (set "EdgeTheme=Disabled") else (set "EdgeTheme=Enabled")

exit/b


:Enable-EdgeTheme
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "1" /f >nul

call :msgbox ok 300
exit /b


:Disable-EdgeTheme
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "Theme" /t REG_DWORD /d "0" /f >nul

call :msgbox ok 300
exit /b

::==============================================================================================================================================================================

:verify-closeTabs
  reg query "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v AskToCloseAllTabs | find "0x0" >nul
  if "%errorlevel%"=="0" (set "closeTabs=Disabled") else (set "closeTabs=Enabled")

exit/b


:Enable-closeTabs
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "AskToCloseAllTabs" /t REG_DWORD /d "1" /f >nul

call :msgbox ok 300
exit /b


:Disable-closeTabs
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "AskToCloseAllTabs" /t REG_DWORD /d "0" /f >nul

call :msgbox ok 300
exit /b

::==============================================================================================================================================================================

:verify-CoratnainEdge
  reg query "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v EnableCortana | find "0x0" >nul
  if "%errorlevel%"=="0" (set "CoratnainEdge=Disabled") else (set "CoratnainEdge=Enabled")

exit/b


:Enable-CoratnainEdge
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "EnableCortana" /t REG_DWORD /d "1" /f >nul

call :msgbox ok 300
exit /b


:Disable-CoratnainEdge
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "EnableCortana" /t REG_DWORD /d "0" /f >nul

call :msgbox ok 300
exit /b

::==============================================================================================================================================================================

:verify-EdgeFlashPlayer
  reg query "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Addons" /v FlashPlayerEnabled | find "0x0" >nul
  if "%errorlevel%"=="0" (set "EdgeFlashPlayer=Disabled") else (set "EdgeFlashPlayer=Enabled")

exit/b


:Enable-EdgeFlashPlayer
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Addons" /v "FlashPlayerEnabled" /t REG_DWORD /d "1" /f >nul

call :msgbox ok 300
exit /b


:Disable-EdgeFlashPlayer
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Addons" /v "FlashPlayerEnabled" /t REG_DWORD /d "0" /f >nul

call :msgbox ok 300
exit /b

::==============================================================================================================================================================================

:verify-FavoritesBar
  reg query "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\LinksBar" /v Enabled | find "0x1" >nul
  if "%errorlevel%"=="0" (set "FavoritesBar=Enabled") else (set "FavoritesBar=Disabled")

exit/b


:Enable-FavoritesBar
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\LinksBar" /v "Enabled" /t REG_DWORD /d "1" /f >nul

call :msgbox ok 300
exit /b


:Disable-FavoritesBar
Reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\LinksBar" /v "Enabled" /t REG_DWORD /d "0" /f >nul

call :msgbox ok 300
exit /b

::==============================================================================================================================================================================

:verify-NewTabPage
  reg query "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v NewTabPageDisplayOption | find "0x2" >nul
  if "%errorlevel%"=="0" (set "NewTabPage=Blank") else (set "NewTabPage=Suggested" )

  reg query "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v NewTabPageDisplayOption | find "0x1"
   if "%errorlevel%"=="0" (set "NewTabPage=Topsites" )
exit /b


:NewTabPage-Blank
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "NewTabPageDisplayOption" /t REG_DWORD /d "2" /f >nul
exit /b

:NewTabPage-Topsites
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "NewTabPageDisplayOption" /t REG_DWORD /d "1" /f >nul
exit /b

:NewTabPage-Suggested
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ServiceUI" /v "NewTabPageDisplayOption" /t REG_DWORD /d "0" /f >nul
exit /b


::==============================================================================================================================================================================


:LTSB
cls
set Button1Color=3F

%BB% ^
   /c 0x1F                  /g 16 1  /d "_______________________________________________________________________________________"^
                            /g 15 2  /d "|  ____  ____   __     _   _  _   __   _  _  ____   ____  __     __   ____  ____  ____  |"^
                            /g 15 3  /d "| (  _ \(  _ \ /  \   / ) / )( \ /  \ ( \/ )(  __) (_  _)/  \   (  ) (_  _)/ ___)(  _ \ |"^
                            /g 15 4  /d "|  ) __/ )   /(  O ) / /  ) __ ((  O )/ \/ \ ) _)    )( (  O )  / (_/\ )(  \___ \ ) _ ( |"^
                            /g 15 5  /d "| (__)  (__\_) \__/ (_/   \_)(_/ \__/ \_)(_/(____)  (__) \__/   \____/(__) (____/(____/ |"^
                            /g 15 6  /d "|_______________________________________________________________________________________|"^
                            /g 15 7  /d "                                                                                         "^
                            /g 16 8  /d "________________________________________________________________________________________"^
   /c 0x%Button1Color%      /g 15 9  /d "|                                                                                        |"^
                            /g 15 10 /d "|  1.Turn Pro/Home version to LTSB (Kind of)                                             |"^
                            /g 15 11 /d "|       This will : Remove Microsoft Edge completely using 'install_wim_tweak'           |"^
                            /g 15 12 /d "|                   Remove Cortana and SearchUI                                          |"^
                            /g 15 13 /d "|                   Remove All modern apps and Windows store                             |"^
                            /g 15 14 /d "|                   Restore Win32 Calculator                                             |"^
                            /g 15 15 /d "|       You should be connected to Internet to download necessary files.                 |"^
                            /g 15 16 /d "|       Microsoft .NET Framework 3.5 should be installed.                                |"^
                            /g 15 17 /d "|       After removing these apps you won't be able to restore them (No backup Files)    |"^
                            /g 15 18 /d "|________________________________________________________________________________________|"^
   /c 0x1F                  /g 16 24 /d "________________________________________________________________________________________"^
   /c 0x9F                  /g 15 25 /d "|                                                                                        |"^
   /c 0x9F                  /g 15 26 /d "|                                    0. Go Back                                          |"^
   /c 0x9F                  /g 15 27 /d "|________________________________________________________________________________________|"^
   /c 0x1F



If /i "%SelectMode%"=="Mouse" (
for /f "tokens=1,2,3 delims=:" %%a in ('%BB% /m') do (
  %BB% /g 0 0

  set "buttonClicked"=""
  %BB% /d "mouse: %%b %%a %%c   "  >nul 2>&1
    if %%c EQU 1 if %%b GEQ 9 if %%b LEQ 18 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=1" 
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 28 if %%a GEQ 15 if %%a LEQ 104 set "buttonClicked=0" 
 )
) else (
    %BB% /g 16 29
    Set /p buttonClicked=Use Your Keyboard Numbers to select options :
)


If %buttonClicked%==0 goto MainMenu
If %buttonClicked%==1 call :LTSB_Confirm
goto LTSB

:LTSB_Confirm
call :msgbox Confirm
if /i "!buttonClicked!"=="No" ( goto LTSB
) else (
cls

call :Servercheck drive.google.com LTSB

call :Infomsgbox "Uninstalling All modern apps" 9F 1

for %%a in (%AppStrings%) do (
   rem === get App Name without underscore
   set "AppName=%%a"
   set "AppName=!AppName:~0,-14!"

   rem === Remove apps
           echo  Removing "!AppName!" from user...
           powershell.exe -command "Get-AppxPackage Microsoft.!AppName! | Remove-AppxPackage"
)


call :Infomsgbox "Restoring Win32 Calculator" 9F 1
call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiaGNnbm94aDhQbjg" Old-Calculator-for-Windows10.exe
"Old-Calculator-for-Windows10.exe" /S
del "Old-Calculator-for-Windows10.exe"


call :Download "https://drive.google.com/uc?export=download&id=0B_Y-lCJYwHfiWTNGYXdiRU9SNVU" install_wim_tweak.exe

call :Infomsgbox "Uninstalling Microsoft Edge" 9F 1
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c Microsoft-Windows-Internet-Browser-Package /r
install_wim_tweak.exe /h /o /l


call :Infomsgbox "Uninstalling Microsoft Cortana" 9F 1
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c Microsoft-Windows-Cortana /r
install_wim_tweak.exe /h /o /l


del Packages.txt
del install_wim_tweak.exe

call :msgbox Ok 400
goto LTSB
)


::==============================================================================================================================================================================




:This-PC
call :ClearButtons

call :verify-F "{088e3905-0323-4b02-9826-5d99428e115f}" "1" >nul 2>&1
call :verify-F "{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" "2" >nul 2>&1
call :verify-F "{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" "3" >nul 2>&1
call :verify-F "{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" "4" >nul 2>&1
call :verify-F "{d3162b92-9365-467a-956b-92703aca08af}" "5" >nul 2>&1
call :verify-F "{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" "6" >nul 2>&1




set "Title1=                 _______________________________________________________________________________________"
set "Title2=                ^|  ____  _  _  __  ____        ____   ___     ____  __   __    ____  ____  ____  ____   ^|"
set "Title3=                ^| (_  _)/ )( \(  )/ ___)  ___ (  _ \ / __)   (  __)/  \ (  )  (    \(  __)(  _ \/ ___)  ^|"
set "Title4=                ^|   )(  ) __ ( )( \___ \ (___) ) __/( (__     ) _)(  O )/ (_/\ ) D ( ) _)  )   /\___ \  ^|"
set "Title5=                ^|  (__) \_)(_/(__)(____/      (__)   \___)   (__)  \__/ \____/(____/(____)(__\_)(____/  ^|"
set "Title6=                ^|_______________________________________________________________________________________^|"

set  "button1=                      Downloads                  (%F1% )" 
set  "button3=                        Music                    (%F3% )"
set  "button5=                      Documents                  (%F5% )"

set  "button9=     Remove All Folders From This PC"

set  "button2=                       Pictures                  (%F2% )"
set  "button4=                       Desktop                   (%F4% )"
set  "button6=                        Videos                   (%F6% )"
set "button10=     Add All Folders to This PC"


set "button14=Go Back"                                                              & set Button14Color=%BackButtonColor%
call :drawMenu 


call :readInput

if "%buttonClicked%"=="1"  ( (if /i "%F1%"==" ON"     (Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f)) & (if /i "%F1%"=="OFF"        (Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f)) & goto This-PC ) >nul 2>&1
if "%buttonClicked%"=="2"  ( (if /i "%F2%"==" ON"     (Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f)) & (if /i "%F2%"=="OFF"        (Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f)) & goto This-PC ) >nul 2>&1
if "%buttonClicked%"=="3"  ( (if /i "%F3%"==" ON"     (Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f)) & (if /i "%F3%"=="OFF"        (Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f)) & goto This-PC ) >nul 2>&1
if "%buttonClicked%"=="4"  ( (if /i "%F4%"==" ON"     (Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f)) & (if /i "%F4%"=="OFF"        (Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f)) & goto This-PC ) >nul 2>&1
if "%buttonClicked%"=="5"  ( (if /i "%F5%"==" ON"     (Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f)) & (if /i "%F5%"=="OFF"        (Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f)) & goto This-PC ) >nul 2>&1
if "%buttonClicked%"=="6"  ( (if /i "%F6%"==" ON"     (Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f)) & (if /i "%F6%"=="OFF"        (Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f)) & goto This-PC ) >nul 2>&1
if "%buttonClicked%"=="9"  ( Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f & Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f & Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f & Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f & Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f & Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f & goto This-PC ) >nul 2>&1
if "%buttonClicked%"=="10" ( Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f & Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f & Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f & Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f & Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f & Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f & goto This-PC ) >nul 2>&1




if "%buttonClicked%"=="14" goto Enable/Disable
goto This-PC




:verify-F
  reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\%~1" /s  >nul
  if "%errorlevel%"=="0" (set "F%~2= ON") else (set "F%~2=OFF")

exit/b



::==============================================================================================================================================================================

:verify-GameMode
  reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /v AllowAutoGameMode | find "0x1" >nul
  if "%errorlevel%"=="0" ( (set "GameMode=Enabled") & (set Button%~1Color="5F") ) else ( (set "GameMode=Disabled") & (set Button%~1Color="4F") )

exit/b


:Enable-GameMode
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t reg_dword /d 1 /f >nul

call :msgbox ok 300
exit /b




:Disable-GameMode
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t reg_dword /d 0 /f >nul

call :msgbox ok 300
exit /b




::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================









:tweakA
:: Works only on 10240
call :validateBuild 10240
if "%applyTweak%"=="0" exit /b
::replace next line with tweak code
echo applying tweak 1...
call :msgBox ok
goto MainMenu


:tweakB
:: Works on 10586 and older builds
call :validateBuild 10586 -
if "%applyTweak%"=="0" exit /b
::replace next line with tweak code
echo applying tweak 2...
call :msgBox ok
exit /b



:tweakC
:: Works on 10240 and newer builds
call :validateBuild 10240 +
if "%applyTweak%"=="0" exit /b
::replace next line with tweak code
echo applying tweak 3...
call :msgBox ok
exit /b







::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================
::==============================================================================================================================================================================

:::::::::::::::::::
:: Settings Menu ::
:::::::::::::::::::










:settingsMenu
call :ClearButtons
call :verify-SkipIntro 7
call :Verify-RestartExplorer 8
call :Verify-skipBuildWarning 6


set "Title1=                ________________________________________________________________________________________"
set "Title2=               ^|                    ___   ___   ____   ____   __   _  _    __   ___                     ^|"
set "Title3=               ^|                   / __) (  _) (_  _) (_  _) (  ) ( \( )  / _) / __)                    ^|"
set "Title4=               ^|                   \__ \  ) _)   )(     )(    )(   )  (  ( ()) \__ )                    ^|"
set "Title5=               ^|                   (___/ (___)  (__)   (__)  (__) (_)\_)  \__/ (___)                    ^|"
set "Title6=               ^|________________________________________________________________________________________^|"
set "Title7=                                                  ^|Created by 'Yasser Da Silva' ^& Designed by 'johnye_pt'"
set  "button1=Create a Restore point"
set  "button3=Send Feedback (Reply to MDL thread)"
set  "button5=Change select Mode {'U'} Current: %SelectMode%" 
set  "button7=Skip Inro animation? Current: %SkipIntro%" 
set  "button9=What'NEW in this version (Change Log)"


set  "button2=Backup the Registry" 
set  "button4=Send Feedback via eMail"
set  "button6=Skip warning on new Windows builds? Current: %skipBuildWarning%" 
set  "button8=Auto restart Explorer.exe in [FE] options? Current: %RestartExplorer%" 


set "button14=RETURN TO MAIN MENU" & set Button14Color=%BackButtonColor%

if /i "%SelectMode%"=="Mouse" ( set Button5Color=3F 
) else (
 set Button5Color=6F )


call :drawMenu

%BB% ^
   /c 0x1F                  /g 0 28  /d "Instructions :"^
                            /g 0 29  /d " [O]  :The option requires an internet connection "^
                            /g 0 30  /d " [FE] :The option requires File Explorer to be restarted "^
                            /g 0 31  /d "[B:XX]:The option Runs on the 'X' Build mentiond and higher"^
                            /g 59 9 

call :readInput
if "%buttonClicked%"=="1" cls & Wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%DATE%", 100, 7 & pause
if "%buttonClicked%"=="2" call :backupregistry
if "%buttonClicked%"=="3" Start www.goo.gl/BNjTJG
if "%buttonClicked%"=="4" (start mailto:gy_drif@esi.dz?subject=Win%%2010%%20Toggle%%20Tweaker & GOTO settingsMenu)
if "%buttonClicked%"=="5" (if /i "%SelectMode%"=="Mouse" ( set "SelectMode=KBD" ) else ( set "SelectMode=Mouse"  ) & Goto settingsMenu )
if "%buttonClicked%"=="6" (if /i "%skipBuildWarning%"=="YES" (Reg.exe add "HKLM\SOFTWARE\ToggleTweaker" /v "skipBuildWarning" /t REG_SZ /d "NO" /f ) else (Reg.exe add "HKLM\SOFTWARE\ToggleTweaker" /v "skipBuildWarning" /t REG_SZ /d "YES" /f  ) & Goto settingsMenu )
if "%buttonClicked%"=="7" (if /i "%SkipIntro%"=="YES" (Reg.exe add "HKLM\SOFTWARE\ToggleTweaker" /v "SkipIntro" /t REG_SZ /d "NO" /f ) else ( Reg.exe add "HKLM\SOFTWARE\ToggleTweaker" /v "SkipIntro" /t REG_SZ /d "YES" /f ) & Goto settingsMenu )
if "%buttonClicked%"=="8" (if /i "%RestartExplorer%"=="YES" (Reg.exe add "HKLM\SOFTWARE\ToggleTweaker" /v "RestartExplorer" /t REG_SZ /d "NO" /f ) else ( Reg.exe add "HKLM\SOFTWARE\ToggleTweaker" /v "RestartExplorer" /t REG_SZ /d "YES" /f  & call :RestartExplorer ) & Goto settingsMenu )
if "%buttonClicked%"=="9" call :WhatsNEW

if "%buttonClicked%"=="14" goto :MainMenu
goto :settingsMenu



:::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to create batbox.exe ::
:::::::::::::::::::::::::::::::::::

:batbox
echo Creating batbox.exe...
if exist "%temp%\batbox.exe" exit /b
for %%b in (
4D5343460000000073030000000000002C000000000000000301010001000000
00000000470000000100010000060000000000000000FE4259B5200062617462
6F782E657865003FD9412724030006434BB5545F485361143F5737F0CF726B3A
102ABB528B1EC24813421026D3529AB59C184460D7ED6EF7CE79EFB8F74A562F
0B1D543EF5143DC60483C27AF0C14248B18710A4979ECA40426A0329A1B21ECA
AF73EE9D4E21B287FAB6DF77CFF99DF37DDFEF3B3B779D1752C001800D5CC018
808F1C1C3ED879A41015FB9F56C064E942ED141758A8ED96649D4F6A6A4C1306
F8B0A028AAC1F789BC36A8F0B2C2B79E0DF1036A44ACDB557670638F601B4080
E3A0C3FBFDDC06B7044EAE9CE34EA2283041C3B505A48E9E450079B99B69C05B
FC4B1457BC75DD6666DECD8F981BE02EF71797FDC7A32E9A100C7C1EB1E505D9
2CDD5BC7252AC57F1E92ABCA0771EB21D968029C98E76125D25F9967D1ED838C
8372D6F24E093AD9175832FFADCAD43C7F8C459F9442D39D1E8C3947C6913F15
7BB79A7BCD18CBA6D10BB24687B9E33226E4E6904E5DE37A9DE90A3C9C7926F1
98F48C73E401F2CC731FBD66BAB2335D6E8689B0336A13E6798C76B601772CB6
F7E2565EEAD64C1589A931C93092B34B2ECE4E1C6BB466EBE82C1DDD4E8A3ED3
5ED25137B163B861AE9ED8B7D452F182D42F945F4D111213920E14F28B908D57
B3C61233710903560539A9DA3CD0E257901F6EA600D664019744879B295EE44C
3F43EF9BFD303A3FD172A61FE13CDABC17FD9BEBB39F5CD7DFD3BDEEF155565D
6E63B4D8CC0E9EEF910E15745C5D47755EAB32AB245726A20A890C55275B4616
952417A44035BA71FC8498670A970F3F77CCCD7E2862E3F524D44EBFBB6D741F
3D46F7A4DF3847E885988B835574AF0EDE4893F9056F1874970F26101F111711
B6DD3EA8411C472C20A611FD31211C8D0CA89737DAEC4665A1E532F8CA8DA13F
ED2E7013682FBA7FDFA29DA11E7F57775D6B2000A7DBBACEB4051AEA4D077EE0
02076E54833881E846488864FEB09DE2D8AAA2113222ED82124988E48744C3AF
2ABA9A103BF17F6A3BD32D0E192D86A1C97D8386B82DE21FD474550BAABA6CC8
AA42ABBA4421920F7628C941A385F213A298DCB6AE55D69309E18A79D40C6A9A
47BC422C2356106B799D7F8AE16D345931A264F5C644232C9916990382AC085A
4C475F1C920D93EFEF932C4B3734434D00FC02                          
) Do >>t.dat (Echo.For b=1 To len^("%%b"^) Step 2
 ECHO WScript.StdOut.Write Chr^(Clng^("&H"^&Mid^("%%b",b,2^)^)^) : Next)
 Cscript /b /e:vbs t.dat>batbox.ex_
 Del /f /q /a t.dat >nul 2>&1
 Expand -r batbox.ex_ >nul 2>&1
 Del /f /q /a batbox.ex_ >nul 2>&1
move /y batbox.exe "%temp%" >nul 2>&1
exit /b








:verify-SkipIntro
reg query "%Main_Script_Reg_key%" /v SkipIntro | find "YES" >nul 
  if "%errorlevel%"=="0" ( (set "SkipIntro=YES" ) & (set Button%~1Color="4F") ) else ( (set "SkipIntro=NO") & (set Button%~1Color="2F") )
exit /b



:backupregistry
cls
setlocal
set "path=%~dp0Registry Backup %date:~0,2%-%date:~3,2%-%date:~6,4%_%time:~0,2%-%time:~3,2%"
mkdir "%Path%"  >nul 2>&1 
  echo ^>^> Export : This operation could take up to 1Gb of space and some time 
  echo ^>^> Export : Saving Files to "%PATH%"
  echo ^>^> Export : Please Wait ..

for %%k in (CR CU LM U CC) do call :ExpReg %%k
echo.
pause 
exit /b


:ExpReg
%windir%\System32\reg.exe export HK%1 "%PATH%\HK%1.reg" >nul 2>&1 
if "%errorlevel%"=="1" (
  echo ^>^> Export : --HK%1-- Failed.
) else (
  echo ^>^> Export : --HK%1-- Succeed.
)

exit /b
endlocal


:Verify-skipBuildWarning
reg query "%Main_Script_Reg_key%" /v skipBuildWarning | find "YES" >nul 
  if "%errorlevel%"=="0" ( (set "skipBuildWarning=YES" ) & (set Button%~1Color="4F") ) else ( (set "skipBuildWarning=NO") & (set Button%~1Color="2F") )
exit /b


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to autorestart explorer according to settings ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:RestartExplorer
call :Verify-RestartExplorer
If /i "%RestartExplorer%"=="Yes" (taskkill /IM explorer.exe /F & explorer.exe) 
exit /b


:Verify-RestartExplorer
reg query "%Main_Script_Reg_key%" /v RestartExplorer | find "YES" >nul 
  if "%errorlevel%"=="0" ( (set "RestartExplorer=YES" ) & (set Button%~1Color="2F") ) else ( (set "RestartExplorer=NO") & (set Button%~1Color="4F") )
exit /b



::::::::::::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to Clear previous buttons entries ::
::::::::::::::::::::::::::::::::::::::::::::::::
:ClearButtons
for /l %%a in (1,1,14) do (
  if %%a LEQ 7 set "Title%%a=                                                                                                        "
  set "button%%a=                                                         "
  set "Button%%aColor=1F"
)
set "buttonClicked="
set "NextMenu=0"

%BB% /c 0x1F
exit /b




:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: function to align text in a variable by adding spaces ::
:: parameters: textString destinationSize returnString   ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:alignText
    setlocal
    set "text=%~1"
    rem get string length
    :lenLoop
    if not "!text:~%len%!"=="" set /a len+=1 & goto :lenLoop
    rem add spaces to both sides, starting from string length + 2
    set /a len+=2 & for /l %%a in (!len!,2,%~2) do set "text= !text! "
    rem add an extra space at the end when spaces and length are uneven
    set /a len = %~2 - %len% & set /a len = !len! %% 2
        if "%len%"=="1" set "text=%text% "
    endlocal & set "%~3=%text%"
exit /b




::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to draw menus ::
::::::::::::::::::::::::::::

:drawMenu


cls
echo.
echo.%title1%
echo.%title2%
echo.%title3%
echo.%title4%
echo.%title5%
echo.%title6%
echo.%title7%



  %BB% /c 0xF1
If /i "%SelectMode%"=="Mouse" ( %BB% /g 4 8 & %BB% /d "|Use Your Mouse to select options :" 
) else (
  %BB% /g 4 8 & %BB% /d "|Use Your Keyboard Numbers to select options :" )



set Line=""



for /l %%n in (1,1,14) do (
 if not "!button%%n!"=="                                                         " (

call :CalculateTextPos %%n
set T=!TextPos!

:: Calculate Button X position
set Number=%%n
SET /a NUMmod2=!Number! %% 2
if !NUMmod2!==0 (set b=59
) else (
Set b=1 )

:: Calculate Button Y position
set /a C=Number/2
set /a C=Number-C
set /a c=c*3+6


Set "L= "
If !Number! GEQ 3 set L="|"




:: Add spaces to button Key 
call :strlen STRLength Buttonkey%%n
If !STRLength! EQU 1 ( set Buttonkey%%n= !Buttonkey%%n!
  ) else (
        If not !STRLength! EQU 2 (
            set Buttonkey%%n=%%n
            call :strlen STRLength Buttonkey%%n
            If !STRLength! EQU 1  set Buttonkey%%n= %%n
                                ) 
        )



If %%n EQU 1 set PreviousColor=1F
If %%n EQU 2 set PreviousColor=1F
If %%n EQU 3 set PreviousColor=!Button1Color!
If %%n EQU 4 set PreviousColor=!Button2Color!
If %%n EQU 5 set PreviousColor=!Button3Color!
If %%n EQU 6 set PreviousColor=!Button4Color!
If %%n EQU 7 set PreviousColor=!Button5Color!
If %%n EQU 8 set PreviousColor=!Button6Color!
If %%n EQU 9 set PreviousColor=!Button7Color!
If %%n EQU 10 set PreviousColor=!Button8Color!
If %%n EQU 11 set PreviousColor=!Button9Color!
If %%n EQU 12 set PreviousColor=!Button10Color!
If %%n EQU 13 set PreviousColor=!Button11Color!
If %%n EQU 14 set PreviousColor=!Button12Color!



set /a b+=1
set Line=!Line! /c 0x!PreviousColor!    /g !b! !c!  /d "_________________________________________________________" & set /a c+=1 & set /a b-=1
set Line=!Line! /c 0x!Button%%nColor!   /g !b! !c!  /d "| !Buttonkey%%n!.                                                     |" & set /a c+=1
set Line=!Line!                         /g !b! !c!  /d "|                                                         |"
set Line=!Line!                         /g !T! !c!  /d "!button%%n!" & set /a c+=1
set Line=!Line!                         /g !b! !c!  /d "|_________________________________________________________|" & set /a c+=1



)
) 



%BB% !Line!


%BB% ^
   /c 0x1F /g 106 6  /d " __________"^
   /c 0x2F /g 106 7  /d "|          |"^
           /g 106 8  /d "|  SEARCH  |"^
           /g 106 9  /d "|__________|"


If /i "%SelectMode%"=="Mouse" ( %BB% ^
   /c 0x1F /g 111 1  /d " _______"^
   /c 0x3F /g 111 2  /d "|       "^
           /g 111 3  /d "|  USE  "^
           /g 111 4  /d "|  KBD  "^
           /g 111 5  /d "|_______" 

) else (%BB% ^
   /c 0x1F /g 111 1  /d " _______"^
   /c 0x3F /g 111 2  /d "|       "^
           /g 111 3  /d "|Press U"^
           /g 111 4  /d "|'Mouse'"^
           /g 111 5  /d "|_______" 
           )






If not %NextMenu%==0 (  
%BB% ^
   /c 0x1F /g 108 2  /d " ___ __  "^
           /g 108 3  /d "(___)\ \ "^
           /g 108 4  /d " ___  ) )"^
           /g 108 5  /d "(___)/_/ "
)



  %BB% /g 59 9
  %BB% /c 0x1F
exit /b



::::::::::::::::========================================================================================================================================================================
::ClearButton ::
::::::::::::::::


:ClearButton 

set Number=%~1
set Line=""

:: Calculate Button X position
SET /a NUMmod2=!Number! %% 2
if !NUMmod2!==0 (set b=59
) else (
Set b=1 )

:: Calculate Button Y position
set /a C=Number/2
set /a C=Number-C
set /a c=c*3+6

set /a b+=1

set Line=!Line! /c 0x1F  /g !b! !c!  /d "                                                          " & set /a c+=1 & set /a b-=1
set Line=!Line!          /g !b! !c!  /d "                                                           " & set /a c+=1
set Line=!Line!          /g !b! !c!  /d "                                                           " & set /a c+=1
set Line=!Line!          /g !b! !c!  /d "                                                           "
set Line=!Line!          /g 59 9


%BB% !Line!

exit /b



::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: Calculate text position for buttons ::
:::::::::::::::::::::::::::::::::::::::::

:CalculateTextPos
call :strlen STRLength Button%~1
Set /a TextPos=56-STRLength
Set /a TextPos=TextPos/2

SET /a NUMmod2=%~1 %% 2

if %NUMmod2%==0 (Set /a TextPos=TextPos+61
) else (
Set /a TextPos=TextPos+3 )


exit /b






::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: Function to select Input methode ::
::::::::::::::::::::::::::::::::::::::
:readInput
If /i "%SelectMode%"=="Mouse" ( goto readMouse 
) else (
 goto readKeyboard )



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to read mouse on menus and Yes/No dialogs ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:readMouse
for /f "tokens=1,2,3 delims=:" %%a in ('%BB% /m') do (
  %BB% /g 0 0

  set "buttonClicked"=""
  %BB% /d "mouse: %%b %%a %%c   "  >nul 2>&1
  if /i "%~1"=="YesNo" (
    set "buttonClicked=NO"
    if %%c EQU 1 if %%b GEQ 29 if %%b LEQ 31 if %%a GEQ 76 if %%a LEQ 84 set "buttonClicked=YES"
  ) else (
    if %%c EQU 1 if %%b GEQ 10 if %%b LEQ 12 if %%a GEQ 2 if %%a LEQ 59 set "buttonClicked=1" 
    if %%c EQU 1 if %%b GEQ 13 if %%b LEQ 15 if %%a GEQ 2 if %%a LEQ 59 set "buttonClicked=3" 
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 18 if %%a GEQ 2 if %%a LEQ 59 set "buttonClicked=5"
    if %%c EQU 1 if %%b GEQ 19 if %%b LEQ 21 if %%a GEQ 2 if %%a LEQ 59 set "buttonClicked=7"
    if %%c EQU 1 if %%b GEQ 22 if %%b LEQ 24 if %%a GEQ 2 if %%a LEQ 59 set "buttonClicked=9"
    if %%c EQU 1 if %%b GEQ 25 if %%b LEQ 27 if %%a GEQ 2 if %%a LEQ 59 set "buttonClicked=11"
    if %%c EQU 1 if %%b GEQ 28 if %%b LEQ 30 if %%a GEQ 2 if %%a LEQ 59 set "buttonClicked=13"
    if %%c EQU 1 if %%b GEQ 10 if %%b LEQ 12 if %%a GEQ 60 if %%a LEQ 117 set "buttonClicked=2"
    if %%c EQU 1 if %%b GEQ 13 if %%b LEQ 15 if %%a GEQ 60 if %%a LEQ 117 set "buttonClicked=4"
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 18 if %%a GEQ 60 if %%a LEQ 117 set "buttonClicked=6"
    if %%c EQU 1 if %%b GEQ 19 if %%b LEQ 21 if %%a GEQ 60 if %%a LEQ 117 set "buttonClicked=8"
    if %%c EQU 1 if %%b GEQ 22 if %%b LEQ 24 if %%a GEQ 60 if %%a LEQ 117 set "buttonClicked=10"
    if %%c EQU 1 if %%b GEQ 25 if %%b LEQ 27 if %%a GEQ 60 if %%a LEQ 117 set "buttonClicked=12"
    if %%c EQU 1 if %%b GEQ 28 if %%b LEQ 30 if %%a GEQ 60 if %%a LEQ 117 set "buttonClicked=14"
    if %%c EQU 1 if %%b GEQ 7 if %%b LEQ 9 if %%a GEQ 106 if %%a LEQ 117 call :searchTweaks
    if %%c EQU 1 if %%b GEQ 1 if %%b LEQ 5 if %%a GEQ 111 if %%a LEQ 119 ( If /i "%SelectMode%"=="Mouse" (set "SelectMode=KBD"  ) else ( set "SelectMode=Mouse" ) )

    )

    
if /i "%~1"=="text" (

    if %%c EQU 1 if %%b GEQ 11 if %%b LEQ 15 if %%a GEQ 10 if %%a LEQ 18 set "buttonClicked=1"
    if %%c EQU 1 if %%b GEQ 11 if %%b LEQ 15 if %%a GEQ 20 if %%a LEQ 28 set "buttonClicked=2"
    if %%c EQU 1 if %%b GEQ 11 if %%b LEQ 15 if %%a GEQ 30 if %%a LEQ 38 set "buttonClicked=3"
    if %%c EQU 1 if %%b GEQ 11 if %%b LEQ 15 if %%a GEQ 40 if %%a LEQ 48 set "buttonClicked=4"
    if %%c EQU 1 if %%b GEQ 11 if %%b LEQ 15 if %%a GEQ 50 if %%a LEQ 58 set "buttonClicked=5"
    if %%c EQU 1 if %%b GEQ 11 if %%b LEQ 15 if %%a GEQ 60 if %%a LEQ 68 set "buttonClicked=6"
    if %%c EQU 1 if %%b GEQ 11 if %%b LEQ 15 if %%a GEQ 70 if %%a LEQ 78 set "buttonClicked=7"
    if %%c EQU 1 if %%b GEQ 11 if %%b LEQ 15 if %%a GEQ 80 if %%a LEQ 88 set "buttonClicked=8"
    if %%c EQU 1 if %%b GEQ 11 if %%b LEQ 15 if %%a GEQ 90 if %%a LEQ 98 set "buttonClicked=9"
    if %%c EQU 1 if %%b GEQ 11 if %%b LEQ 15 if %%a GEQ 100 if %%a LEQ 108 set "buttonClicked=0"

    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 20 if %%a GEQ 10 if %%a LEQ 18 set "buttonClicked=Q"
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 20 if %%a GEQ 20 if %%a LEQ 28 set "buttonClicked=W"
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 20 if %%a GEQ 30 if %%a LEQ 38 set "buttonClicked=E"
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 20 if %%a GEQ 40 if %%a LEQ 48 set "buttonClicked=R"
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 20 if %%a GEQ 50 if %%a LEQ 58 set "buttonClicked=T"
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 20 if %%a GEQ 60 if %%a LEQ 68 set "buttonClicked=Y"
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 20 if %%a GEQ 70 if %%a LEQ 78 set "buttonClicked=U"
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 20 if %%a GEQ 80 if %%a LEQ 88 set "buttonClicked=I"
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 20 if %%a GEQ 90 if %%a LEQ 98 set "buttonClicked=O"
    if %%c EQU 1 if %%b GEQ 16 if %%b LEQ 20 if %%a GEQ 100 if %%a LEQ 108 set "buttonClicked=P"

    if %%c EQU 1 if %%b GEQ 21 if %%b LEQ 25 if %%a GEQ 10 if %%a LEQ 18 set "buttonClicked=A"
    if %%c EQU 1 if %%b GEQ 21 if %%b LEQ 25 if %%a GEQ 20 if %%a LEQ 28 set "buttonClicked=S"
    if %%c EQU 1 if %%b GEQ 21 if %%b LEQ 25 if %%a GEQ 30 if %%a LEQ 38 set "buttonClicked=D"
    if %%c EQU 1 if %%b GEQ 21 if %%b LEQ 25 if %%a GEQ 40 if %%a LEQ 48 set "buttonClicked=F"
    if %%c EQU 1 if %%b GEQ 21 if %%b LEQ 25 if %%a GEQ 50 if %%a LEQ 58 set "buttonClicked=G"
    if %%c EQU 1 if %%b GEQ 21 if %%b LEQ 25 if %%a GEQ 60 if %%a LEQ 68 set "buttonClicked=H"
    if %%c EQU 1 if %%b GEQ 21 if %%b LEQ 25 if %%a GEQ 70 if %%a LEQ 78 set "buttonClicked=J"
    if %%c EQU 1 if %%b GEQ 21 if %%b LEQ 25 if %%a GEQ 80 if %%a LEQ 88 set "buttonClicked=K"
    if %%c EQU 1 if %%b GEQ 21 if %%b LEQ 25 if %%a GEQ 90 if %%a LEQ 98 set "buttonClicked=L"
    if %%c EQU 1 if %%b GEQ 21 if %%b LEQ 25 if %%a GEQ 100 if %%a LEQ 108 set "buttonClicked=END"

    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 30 if %%a GEQ 10 if %%a LEQ 18 set "buttonClicked=Z"
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 30 if %%a GEQ 20 if %%a LEQ 28 set "buttonClicked=X"
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 30 if %%a GEQ 30 if %%a LEQ 38 set "buttonClicked=C"
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 30 if %%a GEQ 40 if %%a LEQ 48 set "buttonClicked=V"
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 30 if %%a GEQ 50 if %%a LEQ 58 set "buttonClicked=B"
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 30 if %%a GEQ 60 if %%a LEQ 68 set "buttonClicked=N"
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 30 if %%a GEQ 70 if %%a LEQ 78 set "buttonClicked=M"
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 30 if %%a GEQ 80 if %%a LEQ 98 set "buttonClicked=BACKSPACE"
    if %%c EQU 1 if %%b GEQ 26 if %%b LEQ 30 if %%a GEQ 100 if %%a LEQ 108 set "buttonClicked=Space"

    if %%c EQU 1 if %%b GEQ 1 if %%b LEQ 5 if %%a GEQ 111 if %%a LEQ 119 ( If /i "%SelectMode%"=="Mouse" (set "SelectMode=KBD" & %BB% /c 0x1F & goto searchTweaks  ) else ( set "SelectMode=Mouse" & %BB% /c 0x1F & goto searchTweaks ) )
  )

    if %%c EQU 1 if %%b GEQ 3 if %%b LEQ 5 if %%a GEQ 108 if %%a LEQ 116 (Set NextMenu=0 & goto %NextMenu%)


)
exit /b



::::::::::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: Function to read keyboard input on menus ::
::::::::::::::::::::::::::::::::::::::::::::::
:readkeyboard

 %BB% /c 0x1F
     %BB% /g 51 8  &  %BB% /d "                                         "  & %BB% /g 51 8 

set /p key=

  set "buttonClicked"=""

   if /i "%~1"=="YesNo" (
    set "buttonClicked=NO"
    if %key% EQU 1  set "buttonClicked=YES"
  ) else (


if %key% EQU 1  set "buttonClicked=1"
if %key% EQU 2  set "buttonClicked=2"
if %key% EQU 3  set "buttonClicked=3"
if %key% EQU 4  set "buttonClicked=4"
if %key% EQU 5  set "buttonClicked=5"
if %key% EQU 6  set "buttonClicked=6"
if %key% EQU 7  set "buttonClicked=7"
if %key% EQU 8  set "buttonClicked=8"
if %key% EQU 9  set "buttonClicked=9"
if %key% EQU 10  set "buttonClicked=10"
if %key% EQU 11  set "buttonClicked=11"
if %key% EQU 12  set "buttonClicked=12"
if %key% EQU 13  set "buttonClicked=13"
if %key% EQU 14  set "buttonClicked=14"
if %key% EQU 0  set "buttonClicked=14"
if /i %key% EQU S  call :searchTweaks
if /i %key% EQU U  ( If /i "%SelectMode%"=="Mouse" (set "SelectMode=KBD"  ) else ( set "SelectMode=Mouse" ) )
if /i %key% EQU Search  call :searchTweaks
if /i %key% EQU N  (Set NextMenu=0 & goto %NextMenu%)
if /i %key% EQU Next  (Set NextMenu=0 & goto %NextMenu%)
  )
)

exit /b






:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to check if current build applies to tweak ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:validateBuild
set "buildExists=0"
set "applyTweak=0"

for %%x in (%knownBuilds%) do if "%%x" EQU "%windowsBuild%" set "buildExists=1"


If "%~2"=="+" ( if "%windowsBuild%" GEQ "%~1" (set "applyTweak=1" & exit /b ) ) 
If "%~2"=="-" ( if "%windowsBuild%" LEQ "%~1" (set "applyTweak=1" & exit /b ) ) 




if "!buildExists!"=="0" (
  if /i "%skipBuildWarning%"=="yes" (
    set "applyTweak=1"
  ) else (
    call :msgBox UnknownBuild
    if /i "!buttonClicked!"=="YES" set "applyTweak=1"
    cls
  )
  exit /b
)

for %%x in (%*) do if "%%x"=="%windowsBuild%" set "applyTweak=1"
if "%applyTweak%"=="0" call :msgBox No



exit /b







:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to display message buttons and Yes/No buttons ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:msgBox

set "msgYesNo=0"

if /i "%~1"=="ok"             set "msgText=        Operation Completed successfully.        "           & set "msgColor=0x2F"                     & goto ShowmsgBox
if /i "%~1"=="no"             set "msgText=  This tweak doesn't work on this Windows build. "           & set "msgColor=0x4F"                     & goto ShowmsgBox
if /i "%~1"=="edge"           set "msgText=  MS Edge should be relaunched. "           & set "msgColor=0x2F"                     & goto ShowmsgBox
if /i "%~1"=="Confirm"        set "msgText=           Do you Confirm the Operation          "           & set "msgColor=0x5F" & set "msgYesNo=1"  & goto ShowmsgBox
if /i "%~1"=="UnknownBuild"   set "msgText= Win-Build: %windowsBuild% is unknown, apply tweak anyway?"  & set "msgColor=0x1F" & set "msgYesNo=1"  & goto ShowmsgBox
if /i "%~1"=="NewVersion"     set "msgText=         New version (V%NewV%).Download it?        "         & set "msgColor=0x5F" & set "msgYesNo=1"  & goto ShowmsgBox

set "msgText=%~1"


:ShowmsgBox
:: position text box according to whether or not it has yes/no buttons on the right
if "%msgYesNo%"=="0" ( set "msgPosX=34" ) else ( set "msgPosX=24" )
%BB% /c 0x1F
%BB% /g %msgPosX% 28 & %BB% /d " _________________________________________________ "
%BB% /c %msgColor%
%BB% /g %msgPosX% 29 & %BB% /d "|                                                 |"
%BB% /g %msgPosX% 30 & %BB% /d "|%msgText%|"
%BB% /g %msgPosX% 31 & %BB% /d "|_________________________________________________|"

:: wait for a mouse click, OR print yes/no and check if YES was clicked, anywhere else is NO
if "%msgYesNo%"=="0" ( 

If "%~2"=="" (
    If /i "%SelectMode%"=="Mouse"  ( %BB% /m >nul
    ) else ( %BB% /k )
    exit /b
) else (
    %BB% /w "%~2"
exit /b )

  ) else (
  %BB% /c 0x1F
  %BB% /g 76 28 & %BB% /d " _______ "
  %BB% /c 0x2F
  %BB% /g 76 29 & %BB% /d "|       |"
  %BB% /g 76 30 & %BB% /d "|  YES  |"
  %BB% /g 76 31 & %BB% /d "|_______|"
  %BB% /c 0x1F
  %BB% /g 87 28 & %BB% /d " _______ "
  %BB% /c 0x4F
  %BB% /g 87 29 & %BB% /d "|       |"
  %BB% /g 87 30 & %BB% /d "|  N O  |"
  %BB% /g 87 31 & %BB% /d "|_______|"
  call :readMouse YesNo
)
Color 1F
exit /b






:::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: Function to Display Info messages ::
:::::::::::::::::::::::::::::::::::::::

:Infomsgbox
set "String=%~1"
If "%~2"=="" ( set "msgColor=0x9F" ) else set "msgColor=0x%~2"

call :strlen STRLength String
set /a TextPosX=20+(76-%STRLength%)/2

%BB% /c 0x1F
%BB% /g 20 28 & %BB% /d " ____________________________________________________________________________ "
%BB% /c %msgColor%
%BB% /g 20 29 & %BB% /d "|                                                                            |"
%BB% /g 20 30 & %BB% /d "|                                                                            |"
%BB% /g 20 31 & %BB% /d "|____________________________________________________________________________|"


%BB% /g %TextPosX% 30 & %BB% /d "%String%"
%BB% /g 0 0
%BB% /c 0x1F

If "%~3"=="" (
    If /i "%SelectMode%"=="Mouse"  ( %BB% /m >nul
    ) else ( %BB% /k )
    exit /b
) else (
    %BB% /w "%~3" >nul
exit /b )






::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to check internet ::
::::::::::::::::::::::::::::::::
:: first function input (%~1) is the server that you want to ping it
:: second input is the menu to goto if Ping failed


:Servercheck
ping -n 1 %~1 >nul
if errorlevel 1  (

%BB% /c 0x1F
%BB% /g 34 3 & %BB% /d " _________________________________________________ "
%BB% /c 0x4F
%BB% /g 34 4 & %BB% /d "|                                                 |"
%BB% /g 34 5 & %BB% /d "|    Couldn't establish a reliable connection     |"
%BB% /g 34 6 & %BB% /d "|_________________________________________________|"
%BB% /c 0x4F
   ping 127.0.0.1 -n 3 > NUL 2>&1
%BB% /g 0 0 /c 0x1F
  goto %~2
)




::::::::::::::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to download files from direct links ::
::::::::::::::::::::::::::::::::::::::::::::::::::
:: first function input (%~1) is the link and the second one is the file name and extension
:: Link should be presented like this to avoid problems with special characters : "Link_HERE" 

:Download
echo strFileURL = "%~1" > Download.vbs
echo     strHDLocation = "%CD%\%~2" >> Download.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> Download.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> Download.vbs
echo objXMLHTTP.send() >> Download.vbs
echo If objXMLHTTP.Status = 200 Then >> Download.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> Download.vbs
echo objADOStream.Open>> Download.vbs
echo objADOStream.Type = 1 >> Download.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> Download.vbs
echo objADOStream.Position = 0    >> Download.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> Download.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> Download.vbs
echo Set objFSO = Nothing >> Download.vbs
echo objADOStream.SaveToFile strHDLocation >> Download.vbs
echo objADOStream.Close >> Download.vbs
echo Set objADOStream = Nothing >> Download.vbs
echo End if >> Download.vbs
echo Set objXMLHTTP = Nothing >> Download.vbs
cscript Download.vbs >nul 2>&1
del Download.vbs

exit /b




:::::::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to extract files (.Zip Only) ::
:::::::::::::::::::::::::::::::::::::::::::


:Unzip

    > Unzip.vbs ECHO '
    >> Unzip.vbs ECHO.
    >> Unzip.vbs ECHO ' Dim ArgObj, var1, var2
    >> Unzip.vbs ECHO Set ArgObj = WScript.Arguments
    >> Unzip.vbs ECHO.
    >> Unzip.vbs ECHO If (Wscript.Arguments.Count ^> 0) Then
    >> Unzip.vbs ECHO. var1 = ArgObj(0)
    >> Unzip.vbs ECHO Else
    >> Unzip.vbs ECHO. var1 = ""
    >> Unzip.vbs ECHO End if
    >> Unzip.vbs ECHO.
    >> Unzip.vbs ECHO If var1 = "" then
    >> Unzip.vbs ECHO. strFileZIP = "example.zip"
    >> Unzip.vbs ECHO Else
    >> Unzip.vbs ECHO. strFileZIP = var1
    >> Unzip.vbs ECHO End if
    >> Unzip.vbs ECHO.
    >> Unzip.vbs ECHO 'The location of the zip file.
    >> Unzip.vbs ECHO REM Set WshShell = CreateObject("Wscript.Shell")
    >> Unzip.vbs ECHO REM CurDir = WshShell.ExpandEnvironmentStrings("%%cd%%")
    >> Unzip.vbs ECHO Dim sCurPath
    >> Unzip.vbs ECHO sCurPath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")
    >> Unzip.vbs ECHO strZipFile = sCurPath ^& "\" ^& strFileZIP
    >> Unzip.vbs ECHO 'The folder the contents should be extracted to.
    >> Unzip.vbs ECHO outFolder = sCurPath ^& "\"
    >> Unzip.vbs ECHO.
    >> Unzip.vbs ECHO. WScript.Echo ( "Extracting file " ^& strFileZIP)
    >> Unzip.vbs ECHO.
    >> Unzip.vbs ECHO Set objShell = CreateObject( "Shell.Application" )
    >> Unzip.vbs ECHO Set objSource = objShell.NameSpace(strZipFile).Items()
    >> Unzip.vbs ECHO Set objTarget = objShell.NameSpace(outFolder)
    >> Unzip.vbs ECHO intOptions = 256
    >> Unzip.vbs ECHO objTarget.CopyHere objSource, intOptions
    >> Unzip.vbs ECHO.
    >> Unzip.vbs ECHO. WScript.Echo ( "Extracted." )
    >> Unzip.vbs ECHO.

cscript /B Unzip.vbs %~1  >nul 2>&1
del Unzip.vbs

exit /b



::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: Calculates string Length ::
::::::::::::::::::::::::::::::
:strlen <resultVar> <stringVar>
(   
    setlocal EnableDelayedExpansion
    set "s=!%~2!#"
    set "len=0"
    for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
        if "!s:~%%P,1!" NEQ "" ( 
            set /a "len+=%%P"
            set "s=!s:~%%P!"
        )
    )
)
( 
    endlocal
    set "%~1=%len%"
    exit /b
)




::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to get the button number to activate according to Input mode              ::
:: parameters: 1='Original Button Number (Mouse Mode)'  2='Button number in KBD mode' ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GetActiveButton
If /i "%SelectMode%"=="Mouse" ( set "ActiveButton%~1=%~1" ) else ( set "ActiveButton%~1=%~2" )
set Buttonkey%~1=%~2
exit /b




:::::::::::::::::::::::::::::==============================================================================================================================================================================
::         Calculates Folder Size          ::
:: call :FolderSize <Path> <Button Number> ::
:::::::::::::::::::::::::::::::::::::::::::::

:FolderSize
set Dir="%~1"

for /f "tokens=1,3" %%a in ('dir /w /s /-c %Dir% ^| findstr "File(s)"') do set Bytes=%%b



set /a KB=(%Bytes% /1024)
set /a MB=(%KB% /1024)
set /a GB=(%MB% /1024)

If not %GB%==0 set FolderSize%~2=%GB% GB
If %GB%==0 set FolderSize%~2=%MB% MB
If %MB%==0 set FolderSize%~2=%KB% KB
If %KB%==0 set FolderSize%~2=%Bytes% Bytes

exit /b


::::::::::::::::::::::::::::::::::::
:: function to draw title letters ::
:: parameters: letter x y colors  ::
::::::::::::::::::::::::::::::::::::
:drawLetter
    setlocal
    set /a y1=%~3+1 & set /a y2=%~3+2 & set /a y3=%~3+3
rem letters width: A-6, B-5, C-5, D-6, E-6, F-5, G-6, H-6 I-4, J-6, K-6, L-6, M-8, N-6, O-6, P-5, Q-6, R-6, S-5, T-6, U-6, V-6, W-7, X-6, Y-6, Z-6
    if /i "%~1"=="A" %BB% /c 0x%~4 /g %~2 %~3 /d "  __  "   /g %~2 %y1% /d " / _\ "     /g %~2 %y2% /d "/    \\"    /g %~2 %y3% /d "\_/\_/"
    if /i "%~1"=="B" %BB% /c 0x%~4 /g %~2 %~3 /d " ___ "    /g %~2 %y1% /d "(  ,)"      /g %~2 %y2% /d " ) ,\"      /g %~2 %y3% /d "(___)"
    if /i "%~1"=="C" %BB% /c 0x%~4 /g %~2 %~3 /d "  __ "    /g %~2 %y1% /d " / _)"      /g %~2 %y2% /d "( (_ "      /g %~2 %y3% /d " \__)"
    if /i "%~1"=="D" %BB% /c 0x%~4 /g %~2 %~3 /d " ___  "   /g %~2 %y1% /d "(   \ "     /g %~2 %y2% /d " ) ) )"     /g %~2 %y3% /d "(___/ "
    if /i "%~1"=="E" %BB% /c 0x%~4 /g %~2 %~3 /d " ____ "   /g %~2 %y1% /d "(  __)"     /g %~2 %y2% /d " ) _) "     /g %~2 %y3% /d "(____)"
    if /i "%~1"=="F" %BB% /c 0x%~4 /g %~2 %~3 /d " ___ "    /g %~2 %y1% /d "(  _)"      /g %~2 %y2% /d " ) _)"      /g %~2 %y3% /d "(_)  "
    if /i "%~1"=="G" %BB% /c 0x%~4 /g %~2 %~3 /d "  ___ "   /g %~2 %y1% /d " / __)"     /g %~2 %y2% /d "( (_ \\"    /g %~2 %y3% /d " \___/"
    if /i "%~1"=="H" %BB% /c 0x%~4 /g %~2 %~3 /d " _  _ "   /g %~2 %y1% /d "/ )( \"     /g %~2 %y2% /d ") __ ("     /g %~2 %y3% /d "\_)(_/"
    if /i "%~1"=="I" %BB% /c 0x%~4 /g %~2 %~3 /d " __ "     /g %~2 %y1% /d "(  )"       /g %~2 %y2% /d " )( "       /g %~2 %y3% /d "(__)"
    if /i "%~1"=="J" %BB% /c 0x%~4 /g %~2 %~3 /d "   __ "   /g %~2 %y1% /d " _(  )"     /g %~2 %y2% /d "/ \) \"     /g %~2 %y3% /d "\____/"
    if /i "%~1"=="K" %BB% /c 0x%~4 /g %~2 %~3 /d " __ _ "   /g %~2 %y1% /d "(  / )"     /g %~2 %y2% /d " )  ( "     /g %~2 %y3% /d "(__\_)"
    if /i "%~1"=="L" %BB% /c 0x%~4 /g %~2 %~3 /d " __   "   /g %~2 %y1% /d "(  )  "     /g %~2 %y2% /d "/ (_/\\"    /g %~2 %y3% /d "\____/"
    if /i "%~1"=="M" %BB% /c 0x%~4 /g %~2 %~3 /d " __  __ " /g %~2 %y1% /d "(  \/  )"   /g %~2 %y2% /d " )    ( "   /g %~2 %y3% /d "(_/\/\_)"
    if /i "%~1"=="N" %BB% /c 0x%~4 /g %~2 %~3 /d " _  _ "   /g %~2 %y1% /d "( \( )"     /g %~2 %y2% /d " )  ( "     /g %~2 %y3% /d "(_)\_)"
    if /i "%~1"=="O" %BB% /c 0x%~4 /g %~2 %~3 /d "  __  "   /g %~2 %y1% /d " /  \ "     /g %~2 %y2% /d "(  O )"     /g %~2 %y3% /d " \__/ "
    if /i "%~1"=="P" %BB% /c 0x%~4 /g %~2 %~3 /d " ___ "    /g %~2 %y1% /d "(  ,\\"     /g %~2 %y2% /d " ) _/"      /g %~2 %y3% /d "(_)  "
    if /i "%~1"=="Q" %BB% /c 0x%~4 /g %~2 %~3 /d "  __  "   /g %~2 %y1% /d " /  \ "     /g %~2 %y2% /d "(  O )"     /g %~2 %y3% /d " \__\)"
    if /i "%~1"=="R" %BB% /c 0x%~4 /g %~2 %~3 /d " ____ "   /g %~2 %y1% /d "(  _ \\"    /g %~2 %y2% /d " )   /"     /g %~2 %y3% /d "(__\_)"
    if /i "%~1"=="S" %BB% /c 0x%~4 /g %~2 %~3 /d " ___ "    /g %~2 %y1% /d "/ __)"      /g %~2 %y2% /d "\__ \\"     /g %~2 %y3% /d "(___/"
    if /i "%~1"=="T" %BB% /c 0x%~4 /g %~2 %~3 /d " ____ "   /g %~2 %y1% /d "(_  _)"     /g %~2 %y2% /d "  )(  "     /g %~2 %y3% /d " (__) "
    if /i "%~1"=="U" %BB% /c 0x%~4 /g %~2 %~3 /d " _  _ "   /g %~2 %y1% /d "( )( )"     /g %~2 %y2% /d " )()( "     /g %~2 %y3% /d " \__/ "
    if /i "%~1"=="V" %BB% /c 0x%~4 /g %~2 %~3 /d " _  _ "   /g %~2 %y1% /d "( )( )"     /g %~2 %y2% /d " \\// "     /g %~2 %y3% /d " (__) "
    if /i "%~1"=="W" %BB% /c 0x%~4 /g %~2 %~3 /d " _  _ "   /g %~2 %y1% /d "/ )( \\"    /g %~2 %y2% /d "\ /\ /"     /g %~2 %y3% /d "(_/\_)"
    if /i "%~1"=="X" %BB% /c 0x%~4 /g %~2 %~3 /d " _  _ "   /g %~2 %y1% /d "( \/ )"     /g %~2 %y2% /d " )  ( "     /g %~2 %y3% /d "(_/\_)"
    if /i "%~1"=="Y" %BB% /c 0x%~4 /g %~2 %~3 /d " _  _ "   /g %~2 %y1% /d "( \/ )"     /g %~2 %y2% /d " )  / "     /g %~2 %y3% /d "(_/\_)"
    if /i "%~1"=="Z" %BB% /c 0x%~4 /g %~2 %~3 /d " _  _ "   /g %~2 %y1% /d "( \/ )"     /g %~2 %y2% /d " )  ( "     /g %~2 %y3% /d "(_/\_)"
    if /i "%~1"=="/" %BB% /c 0x%~4 /g %~2 %~3 /d " _ "      /g %~2 %y1% /d "| |"        /g %~2 %y2% /d "| |"        /g %~2 %y3% /d "|_|"
    if /i "%~1"=="\" %BB% /c 0x%~4 /g %~2 %~3 /d "   "      /g %~2 %y1% /d "   "        /g %~2 %y2% /d "   "        /g %~2 %y3% /d "   "


    rem each letter line must use 6 spaces
    endlocal
exit /b




::::::::::::::::::::::::::::::::::::
:: function to draw title symbols ::
:: parameters: line               ::
::::::::::::::::::::::::::::::::::::
:drawSymbols
    setlocal
    set "line="
    if %~1 EQU 7                  set line=%line% /c 0x1F /g 4  0  /d "    _    " /g 107  0  /d "   __    "
    if %~1 GEQ 6 set /a y=%~1-6 & set line=%line% /c 0x1F /g 4 !y! /d "   /\\   " /g 107 !y! /d "  / /\   "
    if %~1 GEQ 5 set /a y=%~1-5 & set line=%line% /c 0x1F /g 4 !y! /d "  | //_  " /g 107 !y! /d " / / /   "
    if %~1 GEQ 4 set /a y=%~1-4 & set line=%line% /c 0x1F /g 4 !y! /d "  / \/\\ " /g 107 !y! /d "/_/ /\   "
    if %~1 GEQ 3 set /a y=%~1-3 & set line=%line% /c 0x1F /g 4 !y! /d " / /\_// " /g 107 !y! /d "\_\/\ \  "
    if %~1 GEQ 2 set /a y=%~1-2 & set line=%line% /c 0x1F /g 4 !y! /d "/ //     " /g 107 !y! /d "    \\ \ "
    if %~1 GEQ 1 set /a y=%~1-1 & set line=%line% /c 0x1F /g 4 !y! /d "\//      " /g 107 !y! /d "     \\/ "
    %BB% %line%
    endlocal
exit /b



::::::::::::::::::::::::::::::::::::::::::::
:: function to draw animated intro        ::
:: parameters: number (of intro sequence) ::
::::::::::::::::::::::::::::::::::::::::::::
:intro
    setlocal
    if "%debug%"=="1" %BB% /c 0x1F /g 2 32 /d "animation = %~1"
    rem animation of box moving up
    for /l %%a in (30,-1,2) do (
        set /a b=%%a+1 & set /a c=%%a+2
        %BB% /c 0x1F /g 54 %%a /d " _______ "^
                     /g 54 !b! /d "|_______|"^
                     /g 54 !c! /d "         "
    )

    rem animation of box opening horizontally
    set "line=_______"
    for /l %%a in (54,-1,19) do (
        set "line=!line!__"
        %BB% /g %%a 2 /d " !line! "^
             /g %%a 3 /d "|!line!|"
    )

    rem animation of box opening vertically
    set "boxlines=_______________________________________________________________________________________"
    set "boxspace=                                                                                       "
    %BB% /g 16 2 /d " %boxlines%"^
         /g 16 3 /d "|%boxspace%|"^
         /g 16 4 /d "|%boxspace%|"^
         /g 16 5 /d "|%boxlines%|"^
         /w 100^
         /g 16 1 /d " %boxlines%"^
         /g 16 2 /d "|%boxspace%|"^
         /g 16 5 /d "|%boxspace%|"^
         /g 16 6 /d "|%boxlines%|"

    rem animation of letters and symbols
    if "%~1"=="1" set "a=Td18 Od24 Gd30 Gd36 Ld42 Ed48 Td60 Wd66 Ed72 Ad78 Kd84 Ed90 Rd96 Rn96 En90 Kn84 An78 En72 Wn66 Tn60 En48 Ln42 Gn36 Gn30 On24 Tn18"
    if "%~1"=="2" set "a=Td60 Ed48 Wd66 Tn60 Ld42 Ed72 En48 Wn66 Gd36 Ad78 Ln42 En72 Gd30 Kd84 Gn36 An78 Od24 Ed90 Gn30 Kn84 Td18 Rd96 On24 En90 Tn18 Rn96"
    if "%~1"=="3" set "a=Td18 Od24 Tn18 Gd30 On24 Gd36 Gn30 Ld42 Gn36 Ed48 Ln42 Td60 En48 Wd66 Tn60 Ed72 Wn66 Ad78 En72 Kd84 An78 Ed90 Kn84 Rd96 En90 Rn96"
    if "%~1"=="4" set "a=/d19 /n19 \n19 Td18 /d24 /n24 \n24 Od24 /d30 /n30 \n30 Tn18 Gd30 /d36 /n36 \n36 On24 Gd36 /d42 /n42 \n42 Gn30 Ld42 /d48 /n48 \n48 Gn36 Ed48 /d55 /n55 \n55 Ln42 /d60 /n60 \n60 En48 Td60 /d66 /n66 \n66 Wd66 /d72 /n72 \n72 Tn60 Ed72 /d78 /n78 \n78 Wn66 Ad78 /d84 /n84 \n84 En72 Kd84 /d90 /n90 \n90 An78 Ed90 /d96 /n96 \n96 Kn84 Rd96"
    rem process groups of letters/numbers as individual lines by replacing spaces with LineFeed
    set "e=0" & for /f "tokens=1 delims=_" %%b in ("%a: =!LF!%") do (
        rem draw letters
        set "c=%%b" & if /i "!c:~1,1!"=="d" ( set "d=17" ) else ( set "d=1F" )
        call :drawLetter !c:~0,1! !c:~2! 2 !d!
        rem drop down lateral symbols vertically after every 3 cicles
        set /a e+=1 & set /a f=!e!%%3
        if !f! EQU 0 if !e! LEQ 21 set /a f=!e!/3 & call :drawSymbols !f!
    )
    endlocal
exit /b


:::::::::::::::::::::::::::==============================================================================================================================================================================
:: Get Clipboard Content ::
:::::::::::::::::::::::::::
:GetClipboard

set Clipboard=

:: Does powershell.exe exist within %PATH%?
for %%I in (powershell.exe) do if "%%~$PATH:I" neq "" (
    set getclip=powershell "Add-Type -AssemblyName System.Windows.Forms;$tb=New-Object System.Windows.Forms.TextBox;$tb.Multiline=$true;$tb.Paste();$tb.Text"
) else (
rem :: If not, compose and link C# application to retrieve clipboard text
    set getclip=%temp%\getclip.exe
    >"%temp%\c.cs" echo using System;using System.Threading;using System.Windows.Forms;class dummy{[STAThread]
    >>"%temp%\c.cs" echo public static void Main^(^){if^(Clipboard.ContainsText^(^)^) Console.Write^(Clipboard.GetText^(^)^);}}
    for /f "delims=" %%I in ('dir /b /s "%windir%\microsoft.net\*csc.exe"') do (
        if not exist "!getclip!" "%%I" /nologo /out:"!getclip!" "%temp%\c.cs" 2>NUL
    )
    del "%temp%\c.cs"
    if not exist "!getclip!" (
        

        or newer, or install PowerShell.
        goto :EOF
    )
)


for /f "delims=" %%I in ('%getclip% ^| findstr /n "^"') do (
    set "line=%%I" & set "line=!line:*:=!" )

:: This is the last line of the copied content    
set "Clipboard=!Line!"
exit/b


:::::::::::::::::::::::::::::::::::::==============================================================================================================================================================================
:: function to search for tweaks ::
:::::::::::::::::::::::::::::::::::
:searchTweaks
cls
echo.
echo.
echo.  
echo.          ___________________________________________________________________________________________________
echo.         ^|                                                                                                   ^|
echo.         ^| SEARCH FOR:                                                                                       ^|
echo.         ^|___________________________________________________________________________________________________^|
%BB% /c 0x1F /g 0 10

echo.          _________ _________ _________ _________ _________ _________ _________ _________ _________ _________ 
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|
echo.         ^|    1    ^|    2    ^|    3    ^|    4    ^|    5    ^|    6    ^|    7    ^|    8    ^|    9    ^|    0    ^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|
echo.         ^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|
echo.         ^|    Q    ^|    W    ^|    E    ^|    R    ^|    T    ^|    Y    ^|    U    ^|    I    ^|    O    ^|    P    ^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|
echo.         ^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|
echo.         ^|    A    ^|    S    ^|    D    ^|    F    ^|    G    ^|    H    ^|    J    ^|    K    ^|    L    ^|   END   ^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|
echo.         ^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|                   ^|         ^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|                   ^|     ^|   ^|
echo.         ^|    Z    ^|    X    ^|    C    ^|    V    ^|    B    ^|    N    ^|    M    ^|     BACKSPACE     ^|   ^<-'   ^|
echo.         ^|         ^|         ^|         ^|         ^|         ^|         ^|         ^|                   ^|         ^|
echo.         ^|_________^|_________^|_________^|_________^|_________^|_________^|_________^|___________________^|_________^| 
%BB% /c 0x1F /g 100 20 /d "_________"
%BB% /c 0x4F /g 99 21 /d "|         |"
%BB% /c 0x4F /g 99 22 /d "|         |"
%BB% /c 0x4F /g 99 23 /d "|   END   |"
%BB% /c 0x4F /g 99 24 /d "|         |"
%BB% /c 0x4F /g 99 25 /d "|_________|"
%BB% /c 0x2F /g 99 26 /d "|         |"
%BB% /c 0x2F /g 99 27 /d "|         |"
%BB% /c 0x2F /g 99 28 /d "|  Space  |"
%BB% /c 0x2F /g 99 29 /d "|         |"
%BB% /c 0x2F /g 99 30 /d "|_________|"


If /i "%SelectMode%"=="Mouse" ( %BB% ^
   /c 0x1F /g 111 1  /d " _______"^
   /c 0x3F /g 111 2  /d "|       "^
           /g 111 3  /d "|  USE  "^
           /g 111 4  /d "|  KBD  "^
           /g 111 5  /d "|_______" 

) else (%BB% ^
   /c 0x1F /g 111 1  /d " _______"^
   /c 0x3F /g 111 2  /d "|       "^
           /g 111 3  /d "|Press U"^
           /g 111 4  /d "|'Mouse'"^
           /g 111 5  /d "|_______" 
           )



%BB% /c 0xF1 /g 23 5 /d "                                                                                     "
set /a searchPos=24
set "searchString="

:loop
%BB% /g %searchPos% 5




set "keys=8_backspace 13_enter 27_esc 32_space 48_0 49_1 50_2 51_3 52_4 53_5 54_6 55_7 56_8 57_9 65_A 66_B 67_C 68_D 69_E 70_F 71_G 72_H 73_I 74_J 75_K 76_L 77_M 78_N 79_O 80_P 81_Q 82_R 83_S 84_T 85_U 86_V 87_W 88_X 89_Y 90_Z 97_a 98_b 99_c 100_d 101_e 102_f 103_g 104_h 105_i 106_j 107_k 108_l 109_m 110_n 111_o 112_p 113_q 114_r 115_s 116_t 117_u 118_v 119_w 120_x 121_y 122_z 292_left 293_up 294_right 295_down"
set "keys=%keys: =!LF!%"


If /i "%SelectMode%"=="Mouse" (call :readMouse text
) else (%BB% ^
%BB% /G 24 5
set /p searchString=
If /i "!searchString!"=="END" exit /b
If /i "!searchString!"=="u" ( If /i "%SelectMode%"=="Mouse" (set "SelectMode=KBD" & %BB% /c 0x1F & goto searchTweaks ) else ( set "SelectMode=Mouse" & %BB% /c 0x1F & goto searchTweaks  ) )

goto Runsearch
           )


if "%buttonClicked%"=="END" %BB% /c 0x1F & %BB% /g 0 0 & goto Runsearch
if "%buttonClicked%"=="BACKSPACE" if %searchPos% GEQ 25 set /a searchPos-=1 & %BB% /g !searchPos! 5 /d " " & %BB% /g !searchPos! 5 & set "searchString=%searchString:~0,-1%"
if "%buttonClicked%"=="Space" set "searchString=%searchString% "  & %BB% /g !searchPos! 5 /d " " & set /a searchPos+=1

for %%a in (1 2 3 4 5 6 7 8 9 0 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ) do if "%buttonClicked%" EQU "%%a" if %searchPos% LEQ 106 %BB% /g %searchPos% 5 /d "%buttonClicked%" & set /a searchPos+=1 & set "searchString=%searchString%%buttonClicked%"
goto :loop


:Runsearch
%BB% /c 0x1F

If "!searchString!"=="" exit /b
(
echo 		Windows / Office KMS activation   
 echo Check Windows Activation Status : 1=^>1
 echo Check Office Activation Status : 1=^>2
 echo Activate Windows/Office Using KMSPico : 1=^>3

echo 		Manage Built-in apps and restore old ones
 echo Remove/restore Windows built-in apps from Users : 2=^>1
 echo Restore Old Windows photo viewer : 2=^>2
 echo Uninstall/restore Cortana [O] : 2=^>3
 echo Restore Legacy Calculator Classic Win32 [O] : 2=^>4
 echo Uninstall/restore Microsoft Edge [O] : 2=^>5
 echo Restore Win 7 Task manager [O] : 2=^>6
 echo Uninstall/restore Internet Explorer 11 [O] : 2=^>7
 echo Restore Classic MSConfig [O] : 2=^>8
 echo Uninstall, Disable and reenable Onedrive : 2=^>9
 echo Install Windows DVD Player app [O] : 2=^>10
 echo Uninstall Contact Support Get Help App [O] : 2=^>11
 echo Restore Classic Paint app [B:14986] [O] : 2=^>12
 echo Uninstall WindowsFeedback App [O] : 2=^>13

echo 		Enable/Disable stuff In Windows10
 echo Windows Defender : 3=^1
 echo Default Quick Access view in Explorer : 3=^2
 echo Windows Firewall : 3=^3
 echo Show BSOD details instead of the sad smiley : 3=^4
 echo Manage Folders In 'This PC' : 3=^5
        echo This PC _ Downloads Folder : 3=^5=^1
        echo This PC _ Pictures Folder : 3=^5=^2
        echo This PC _ Music Folder : 3=^5=^3
        echo This PC _ Desktop Folder : 3=^5=^4
        echo This PC _ Documents Folder : 3=^5=^5
        echo This PC _ Videos Folder : 3=^5=^6
        echo This PC _ Remove All Folders From This PC : 3=^5=^9
        echo This PC _ Add All Folders to This PC : 3=^5=^10
 echo Password Reveal Button : 3=^6
 echo Lockscreen : 3=^7
 echo Safely Remove Hardware Tray Icon : 3=^8
 echo Windows/Store Smart Screen Filter : 3=^9
 echo Replace PowerShell with CMD in Win X menu : 3=^10

echo 		User Interface Tweaks
 echo Dark Theme For Apps : 4=^>1
 echo Thumbnail Previews in File explorer :  4=^>2
 echo Volume Control UI : 4=^>3
 echo Taskview button in Taskbar : 4=^>4
 echo Battery Status UI : 4=^>5
 echo Show Delete-Confirmation-Dialog Prompt Details : 4=^>6
 echo Alt-Tab Screen UI : 4=^>7
 echo Transparency and Blur in: Taskbar-Clock... : 4=^>8
 echo Context Menu Tweaks : 4=^>9
        echo 'Grant Admin Full Control' In Files and Folders : 4=^>9=^>1
        echo Select Context menu : 4=^>9=^>2
        echo Pin to Quick access : 4=^>9=^>3
        echo Classic Personalize to Desktop : 4=^>9=^>4
        echo Screen Resolution menu in Desktop : 4=^>9=^>5
        echo Power Options in Desktop : 4=^>9=^>6
        echo Bluetooth menu in Desktop : 4=^>9=^>7
        echo Add Open with Notepad to Files : 4=^>9=^>8
        echo Copy File Location to Clipboard : 4=^>9=^>9
 echo Change Logon Background Image/accent-color : 4=^>10
 echo Change OEM Information : 4=^>11
 echo Colourise/Decolourise Start Me,Taskbar and Title bars : 4=^>12
        echo Colourise/Decolourise Windows Title bars and borders : 4=^>12=^>1
        echo Colourise Start Menu ^& Taskbar : 4=^>12=^>2
        echo Set Inactive Title Bar Color : 4=^>12=^>3
 echo Taskbar Thumbnail size : 4=^>13




echo 		Toggle Windows Update status
 echo Toggle Windows Update status : 5

echo 		Manage Windows Features
 echo Show Windows features list : 6=^>1
 echo Show 'Turn Windows features on or off' window : 6=^>2
 echo Enable a feature : 6=^>3
 echo Disable a feature : 6=^>4
 echo Disable and Remove feature Payload {clean feature files} : 6=^>5

echo 		Manage User Accounts
 echo Show me my User accounts : 7=^>1
 echo Built-in Administrator Account : 7=^>2
 echo Add NEW user account : 7=^>3
 echo Delete a user account : 7=^>4
 echo Change specific user account Password : 7=^>5


echo 		Speed Up PC Performance
 echo Calculate Restart Time : 8=^>1
 echo Clean Update Junk : 8=^>2
 echo Clean TEMP Folder : 8=^>3
 echo Clean Prefetch Folder : 8=^>4
 echo Start Disk Cleanup {Not automatic} : 8=^>5
 echo Disable : Unnecessary services,BitLocker,Encrypting... : 8=^>6
 echo Game Mode : 8=^>7


echo 		Manage Microsoft Edge browser


echo 		Internet Tweaks and Fixes
 echo Fix Empty 'Network Connections'Folder {Network Adapters} : 10=^>1
 echo Restore 'Windows Firewall'+'Network Adapter' settings : 10=^>2
 echo Release and renew the IP address from DHCP server : 10=^>3
 echo Disable Limit Reservable Bandwidth network : 10=^>4
 echo Flush Windows DNS Cache {ipconfig /flushdns} : 10=^>5


echo 		Convert Pro/Home version to LTSB
 echo Turn Pro/Home version to LTSB (Kind of) : 11=^1


) >TWoptions.txt

cls
for /f "tokens=1,* delims=:" %%a in ('findstr /i /l /c:"%searchString%" "TWoptions.txt"') do (echo(%%a:%%b)
echo.
pause
del TWoptions.txt >nul 2>&1

exit /b




::==============================================================================================================================================================================

:WhatsNEW


echo   ___________________________________________________________________________________________________________________
echo  ^|        ____  _  _  ____   __   __ _  ____  ____      ___  _  _   __   __ _   ___  ____    __     __    ___        ^|
echo  ^|       (_  _)/ )( \(  __) / _\ (  / )(  __)(  _ \    / __)/ )( \ / _\ (  ( \ / __)(  __)  (  )   /  \  / __)       ^|
echo  ^|         )(  \ /\ / ) _) /    \ )  (  ) _)  )   /   ( (__ ) __ (/    \/    /( (_ \ ) _)   / (_/\(  O )( (_ \       ^| 
echo  ^|        (__) (_/\_)(____)\_/\_/(__\_)(____)(__\_)    \___)\_)(_/\_/\_/\_)__) \___/(____)  \____/ \__/  \___/       ^|
echo  ^|___________________________________________________________________________________________________________________^|
echo  ^|                                                                                     Version : %CurV% (12/Feb/2016)   ^|
echo  ^|  This is a completely new version of Toggle Tweaker rewritten from scratch, so a lot of things has changed :      ^|
echo  ^|                                                                                                                   ^|
echo  ^|    # The script Now can accept Mouse clicks as Input methode (You can change it from the Settings)                ^|
echo  ^|                                                                                                                   ^|
echo  ^|    # Almost all old options still exists and some are improved                                                    ^|
echo  ^|                                                                                                                   ^|
echo  ^|    # App removal section:Added New apps 3D Paint-3D View ~ Multi operations in one command ~ Apps Current Status  ^|
echo  ^|                                                                                                                   ^|
echo  ^|    # 'Undo All' is removed because of the difficulty of tracking every single change made with the tweaker        ^|
echo  ^|    and added instead options to create a restore Point and to backup the Registry                                 ^|
echo  ^|                                                                                                                   ^|
echo  ^|    # A lot of options will show you the current status (Enabled/Disabled) instead of just applying It             ^|
echo  ^|                                                                                                                   ^|
echo  ^|    # Uninstalling Onedrive Will remove it's packages from windows                                                 ^|
echo  ^|                                                                                                                   ^|
echo  ^|    # Uninstalling Internet Explorer 11 is added to Windows apps menu with the ability to restore it               ^|
echo  ^|                                                                                                                   ^|
echo  ^|    # Uninstalling Edge / Cortana Works with a new script now to avoid previous problems                           ^|
echo  ^|                                                                                                                   ^|
echo  ^|    # 'PC Performance' Menu is completely changed because the old one workded only for SSD Users                   ^|
echo  ^|                                                                                                                   ^|
echo  ^|    # Added the option to restore 'Old MSConfig' and 'Classic Paint' for Build 14986                               ^|
echo  ^|                                                                                                                   ^|
echo  ^|                                                                                                                   ^|
echo  ^|___________________________________________________________________________________________________________________^|

call :readInput
exit/b
