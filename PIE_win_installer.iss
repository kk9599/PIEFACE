; Script generated by the Inno Setup Script Wizard.
 ; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!
 ; then did a few changes to make maintenance, move to other folder easier
 ; Define name of main output program (GUI)
 #define GUIEXE "distellipsoid_gui.exe"
 ; define the path to your work folder
 #define BaseFolder64 "C:\Users\JCC\Documents\custom_python_libs\distellipsoid\dist\distellipsoid_win64"
 #define BaseFolder32 "C:\Users\JCC\Documents\custom_python_libs\distellipsoid\dist\distellipsoid_win32"
 ; get version information from the exe
 #define GUIName BaseFolder64+"\"+GUIEXE
 #define CMDName BaseFolder64+"\CIFellipsoid.exe"
 #define AppVersionNo GetFileVersion(GUIName)
 #define AppMajorVersionIdx Pos(".", AppVersionNo)
 #define AppMinorVersionTemp Copy(AppVersionNo, AppMajorVersionIdx +1)
 #define AppMajorVersionNo Copy(AppVersionNo, 1, AppMajorVersionIdx -1)
 #define AppMinorVersionNo Copy(AppMinorVersionTemp, 1, Pos(".", AppMinorVersionTemp)-1)
  
 ; define some more stuff, mainly to just keep it all at the beginning
 #define MyAppName "PIE"
 #define MyAppPublisher "University of Edinburgh"
 #define MyAppURL "http://www.csec.ed.ac.uk"
 #define MyAppSupportURL "http://www.csec.ed.ac.uk"
 #define MyAppUpdatesURL "http://www.csec.ed.ac.uk"
 #define OutputFileName "WinSetup_PIE"
      
 [Setup]
 ; NOTE: The value of AppId uniquely identifies this application.
 ; Do not use the same AppId value in installers for other applications.
 ; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
 AppId={{71C0FA60-614B-4A53-8275-E38BCDB65707}}
 AppName={#MyAppName}
 AppVersion={#AppVersionNo}
 AppVerName={#MyAppName} version {#AppMajorVersionNo}.{#AppMinorVersionNo}
 AppPublisher={#MyAppPublisher}
 AppPublisherURL={#MyAppURL}
 AppSupportURL={#MyAppSupportURL}
 AppUpdatesURL={#MyAppUpdatesURL}
 
 ; Allow different installation for 64/32-bit
 ArchitecturesInstallIn64BitMode = x64
 
 ; Following should probably be something like "{pf}\yourappname" for a real application
 ; set DefaultDirName to store files after setup done
 DefaultDirName={pf}\PIE
 DefaultGroupName=PIE
 AllowNoIcons=yes
 PrivilegesRequired=admin
 DisableStartupPrompt=yes
 DisableWelcomePage=yes
 ; AlwaysRestart=yes
  
 OutputBaseFilename={#OutputFileName}_{#AppVersionNo}
 OutputDir="..\"
  
 ; bzip/9 is better by about 400KB over zip/9 and lzma is even better
 Compression=lzma/ultra
 ; Following would reduce size a bit more
 ; SolidCompression=yes

 ; Location of files to use
 SourceDir=C:\Users\JCC\Documents\custom_python_libs\distellipsoid\dist\distellipsoid_win64

 Uninstallable=yes
 ; Add ability to add program to PATH
 ChangesEnvironment=true

 ; Show README during setup
 ;InfoAfterFile=README.rst
 LicenseFile=license.txt


  
 [Languages]
 Name: english; MessagesFile: compiler:Default.isl
  
 [Tasks]
; To create Desktop Icon
 Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}
; Add reference to modpath.iss, to enable add/remove of program to PATH
 Name: modifypath; Description: Add application directory to your environmental path
; To create Quicklaunchicon
; Name: quicklaunchicon; Description: {cm:CreateQuickLaunchIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked
  
 [Files]
 ; 64-bit source
 Source: "{#BaseFolder64}\*" ; DestDir: {app}; Excludes: "*.exe, *.rst" ;Flags: ignoreversion; Check: Is64BitInstallMode;
 Source: "{#BaseFolder64}\CIFellipsoid.exe"; DestDir: {app}; Flags: ignoreversion; Check: Is64BitInstallMode;
 Source: "{#BaseFolder64}\{#GUIEXE}"; DestDir: {app}; Flags: ignoreversion; Check: Is64BitInstallMode;
 Source: "{#BaseFolder64}\README.rst"; DestDir: {app}; Check: Is64BitInstallMode;
 ;Flags: isreadme; 
 Source: "{#BaseFolder64}\*"; DestDir: {app}; Flags: recursesubdirs createallsubdirs; Check: Is64BitInstallMode;
 ; 32-bit source
 Source: "{#BaseFolder32}\*" ; DestDir: {app}; Excludes: "*.exe, *.rst" ;Flags: ignoreversion; Check: not Is64BitInstallMode;
 Source: "{#BaseFolder32}\CIFellipsoid.exe"; DestDir: {app}; Flags: ignoreversion; Check: not Is64BitInstallMode;
 Source: "{#BaseFolder32}\{#GUIEXE}"; DestDir: {app}; Flags: ignoreversion; Check: not Is64BitInstallMode;
 Source: "{#BaseFolder32}\README.rst"; DestDir: {app}; Check: not Is64BitInstallMode;
 ;Flags: isreadme; 
 Source: "{#BaseFolder32}\*"; DestDir: {app}; Flags: recursesubdirs createallsubdirs; Check: not Is64BitInstallMode;
 ; NOTE: Don't use "Flags: ignoreversion" on any shared system files
  
 [Icons]
 Name: {group}\PIE_GUI; Filename: {app}\{#GUIEXE};  IconFilename: "{app}\ellipsoid_icon.ico"; WorkingDir: "{userdocs}"
 Name: {commondesktop}\PIE_GUI; Filename: {app}\{#GUIEXE}; Tasks: desktopicon;
 ;create uninstall shortcut in start menu
 Name: {group}\Uninstall PIE GUI; Filename: {uninstallexe}     

 ;[Registry]
 ;Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: {#MyAppName}; ValueData: {app}\{#MyAppExeName}; Flags: uninsdeletevalue
 ;Root: HKLM; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
  
 [Run]
; Open README file when complete
Filename: "{app}\README.rst"; Description: "View the README file"; Flags: postinstall shellexec skipifsilent
; Here runhidden flag is used to hide pop up window after setup done
 Filename: {app}\{#GUIEXE}; Description: {cm:LaunchProgram,{#GUIEXE}}; Flags: nowait postinstall skipifsilent runhidden
; Filename: {sys}\net.exe; Parameters: start {#MyAppName}; Flags: runhidden;

 [Code]
 const
     ModPathName = 'modifypath';
     ModPathType = 'user';

 function ModPathDir(): TArrayOfString;
 begin
     setArrayLength(Result, 1)
     Result[0] := ExpandConstant('{app}');
 end;
 #include "modpath.iss"