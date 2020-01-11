
# use this file to define global variables on module scope
# or perform other initialization procedures.
# this file will not be touched when new functions are exported to
# this module.


Add-Type -AssemblyName System.IO
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.Drawing
  

[XML] $Script:AppVPathSubstitution = @'
<AppVPathSubstitution>
  <Source path="88ROOTDIR88" Substitution="[{AppVPackageRoot}]" />
  <Source path="C:\AppVPackageDrive" Substitution="[{AppVPackageDrive}]" />
  <Source path="C:\Program Files (x86)\Common Files" Substitution="[{ProgramFilesCommonX86}]" />
  <Source path="C:\Program Files (x86)" Substitution="[{ProgramFilesX86}]" />
  <Source path="C:\Program Files\Common Files" Substitution="[{ProgramFilesCommonX64}]" />
  <Source path="C:\Program Files\Common Files" Substitution="[{ProgramFilesCommon}]" />
  <Source path="C:\Program Files\Windows Sidebar\Gadgets" Substitution="[{Default Gadgets}]" />
  <Source path="C:\Program Files" Substitution="[{ProgramFilesX64}]" />
  <Source path="C:\Program Files" Substitution="[{ProgramFiles}]" />
  <Source path="C:\PROGRA~2\COMMON~1" Substitution="[{ProgramFilesCommonX86}{~}]" />
  <Source path="C:\PROGRA~2" Substitution="[{ProgramFilesX86}{~}]" />
  <Source path="C:\PROGRA~1\COMMON~1" Substitution="[{ProgramFilesCommonX64}{~}]" />
  <Source path="C:\PROGRA~1\COMMON~1" Substitution="[{ProgramFilesCommon}{~}]" />
  <Source path="C:\PROGRA~1\WI4223~1\Gadgets" Substitution="[{Default Gadgets}{~}]" />
  <Source path="C:\PROGRA~1" Substitution="[{ProgramFilesX64}{~}]" />
  <Source path="C:\PROGRA~1" Substitution="[{ProgramFiles}{~}]" />
  <Source path="C:\Windows\Fonts" Substitution="[{Fonts}]" />
  <Source path="C:\Windows\SysWOW64" Substitution="[{SystemX86}]" />
  <Source path="C:\Windows\resources" Substitution="[{ResourceDir}]" />
  <Source path="C:\Windows\system32\catroot" Substitution="[{AppVSystem32Catroot}]" />
  <Source path="C:\Windows\system32\catroot2" Substitution="[{AppVSystem32Catroot2}]" />
  <Source path="C:\Windows\system32\drivers\etc" Substitution="[{AppVSystem32DriversEtc}]" />
  <Source path="C:\Windows\system32\driverstore" Substitution="[{AppVSystem32Driverstore}]" />
  <Source path="C:\Windows\system32\logfiles" Substitution="[{AppVSystem32Logfiles}]" />
  <Source path="C:\Windows\system32\spool" Substitution="[{AppVSystem32Spool}]" />
  <Source path="C:\Windows\system32" Substitution="[{System}]" />
  <Source path="C:\Windows" Substitution="[{Windows}]" />
  <Source path="C:\Windows\system32\DRIVER~1" Substitution="[{AppVSystem32Driverstore}{~}]" />
  <Source path="C:\Windows\RESOUR~1" Substitution="[{ResourceDir}{~}]" />
  <Source path="C:\Users\Public\Desktop" Substitution="[{Common Desktop}]" />
  <Source path="C:\Users\Public\Documents" Substitution="[{Common Documents}]" />
  <Source path="C:\Users\Public\Downloads" Substitution="[{CommonDownloads}]" />
  <Source path="C:\Users\{0}\DOCUME~1" Substitution="[{Personal}{~}]" />
  <Source path="C:\Users\{0}\DOWNLO~1" Substitution="[{Downloads}{~}]" />
  <Source path="C:\Users\{0}\FAVORI~1" Substitution="[{Favorites}{~}]" />
  <Source path="C:\Users\{0}\SAVEDG~1" Substitution="[{SavedGames}{~}]" />
  <Source path="C:\Users" Substitution="[{UserProfiles}]" />
  <Source path="C:/Program Files (x86)/Common Files" Substitution="[{ProgramFilesCommonX86}]" />
  <Source path="C:/Program Files (x86)" Substitution="[{ProgramFilesX86}]" />
  <Source path="C:/Program Files/Common Files" Substitution="[{ProgramFilesCommonX64}]" />
  <Source path="C:/Program Files/Common Files" Substitution="[{ProgramFilesCommon}]" />
  <Source path="C:/Program Files/Windows Sidebar/Gadgets" Substitution="[{Default Gadgets}]" />
  <Source path="C:/Program Files" Substitution="[{ProgramFilesX64}]" />
  <Source path="C:/Program Files" Substitution="[{ProgramFiles}]" />
  <Source path="C:/PROGRA~2/COMMON~1" Substitution="[{ProgramFilesCommonX86}{~}]" />
  <Source path="C:/PROGRA~2" Substitution="[{ProgramFilesX86}{~}]" />
  <Source path="C:/PROGRA~1/COMMON~1" Substitution="[{ProgramFilesCommonX64}{~}]" />
  <Source path="C:/PROGRA~1/COMMON~1" Substitution="[{ProgramFilesCommon}{~}]" />
  <Source path="C:/PROGRA~1/WI4223~1/Gadgets" Substitution="[{Default Gadgets}{~}]" />
  <Source path="C:/PROGRA~1" Substitution="[{ProgramFilesX64}{~}]" />
  <Source path="C:/PROGRA~1" Substitution="[{ProgramFiles}{~}]" />
  <Source path="C:/ProgramData/Microsoft/Windows/DeviceMetadataStore" Substitution="[{Device Metadata Store}]" />
  <Source path="C:/ProgramData/Microsoft/Windows/GameExplorer" Substitution="[{PublicGameTasks}]" />
  <Source path="C:/ProgramData/Microsoft/Windows/Ringtones" Substitution="[{CommonRingtones}]" />
  <Source path="C:/ProgramData/Microsoft/Windows/Start Menu/Programs/Administrative Tools" Substitution="[{Common Administrative Tools}]" />
  <Source path="C:/ProgramData/Microsoft/Windows/Start Menu/Programs/Startup" Substitution="[{Common Startup}]" />
  <Source path="C:/ProgramData/Microsoft/Windows/Start Menu/Programs" Substitution="[{Common Programs}]" />
  <Source path="C:/ProgramData/Microsoft/Windows/Start Menu" Substitution="[{Common Start Menu}]" />
  <Source path="C:/ProgramData/Microsoft/Windows/Templates" Substitution="[{Common Templates}]" />
  <Source path="C:/ProgramData" Substitution="[{Common AppData}]" />
  <Source path="C:/PROGRA~3/MICROS~1/Windows/DEVICE~1" Substitution="[{Device Metadata Store}{~}]" />
  <Source path="C:/PROGRA~3/MICROS~1/Windows/GAMEEX~1" Substitution="[{PublicGameTasks}{~}]" />
  <Source path="C:/PROGRA~3/MICROS~1/Windows/RINGTO~1" Substitution="[{CommonRingtones}{~}]" />
  <Source path="C:/PROGRA~3/MICROS~1/Windows/STARTM~1/Programs/ADMINI~1" Substitution="[{Common Administrative Tools}{~}]" />
  <Source path="C:/PROGRA~3/MICROS~1/Windows/STARTM~1/Programs/Startup" Substitution="[{Common Startup}{~}]" />
  <Source path="C:/PROGRA~3/MICROS~1/Windows/STARTM~1/Programs" Substitution="[{Common Programs}{~}]" />
  <Source path="C:/PROGRA~3/MICROS~1/Windows/STARTM~1" Substitution="[{Common Start Menu}{~}]" />
  <Source path="C:/PROGRA~3/MICROS~1/Windows/TEMPLA~1" Substitution="[{Common Templates}{~}]" />
  <Source path="C:/PROGRA~3" Substitution="[{Common AppData}{~}]" />
  <Source path="C:/Windows/Fonts" Substitution="[{Fonts}]" />
  <Source path="C:/Windows/SysWOW64" Substitution="[{SystemX86}]" />
  <Source path="C:/Windows/resources" Substitution="[{ResourceDir}]" />
  <Source path="C:/Windows/system32/catroot" Substitution="[{AppVSystem32Catroot}]" />
  <Source path="C:/Windows/system32/catroot2" Substitution="[{AppVSystem32Catroot2}]" />
  <Source path="C:/Windows/system32/drivers/etc" Substitution="[{AppVSystem32DriversEtc}]" />
  <Source path="C:/Windows/system32/driverstore" Substitution="[{AppVSystem32Driverstore}]" />
  <Source path="C:/Windows/system32/logfiles" Substitution="[{AppVSystem32Logfiles}]" />
  <Source path="C:/Windows/system32/spool" Substitution="[{AppVSystem32Spool}]" />
  <Source path="C:/Windows/system32" Substitution="[{System}]" />
  <Source path="C:/Windows" Substitution="[{Windows}]" />
  <Source path="C:/Windows/system32/DRIVER~1" Substitution="[{AppVSystem32Driverstore}{~}]" />
  <Source path="C:/Windows/RESOUR~1" Substitution="[{ResourceDir}{~}]" />
  <Source path="C:/Users/Public/Desktop" Substitution="[{Common Desktop}]" />
  <Source path="C:/Users/Public/Documents" Substitution="[{Common Documents}]" />
  <Source path="C:/Users/Public/Downloads" Substitution="[{CommonDownloads}]" />
  <Source path="C:/Users/Public/Libraries/RecordedTV.library-ms" Substitution="[{RecordedTVLibrary}]" />
  <Source path="C:/Users/Public/Libraries" Substitution="[{PublicLibraries}]" />
  <Source path="C:/Users/Public/Music/Sample Music" Substitution="[{SampleMusic}]" />
  <Source path="C:/Users/Public/Music" Substitution="[{CommonMusic}]" />
  <Source path="C:/Users/Public/Pictures/Sample Pictures" Substitution="[{SamplePictures}]" />
  <Source path="C:/Users/Public/Pictures" Substitution="[{CommonPictures}]" />
  <Source path="C:/Users/Public/Videos/Sample Videos" Substitution="[{SampleVideos}]" />
  <Source path="C:/Users/Public/Videos" Substitution="[{CommonVideo}]" />
  <Source path="C:/Users/Public" Substitution="[{Public}]" />
  <Source path="C:/Users/All Users" Substitution="[{AppVAllUsersDir}]" />
  <Source path="C:/Users/Public/DOCUME~1" Substitution="[{Common Documents}{~}]" />
  <Source path="C:/Users/Public/DOWNLO~1" Substitution="[{CommonDownloads}{~}]" />
  <Source path="C:/Users/Public/LIBRAR~1/RECORD~1.LIB" Substitution="[{RecordedTVLibrary}{~}]" />
  <Source path="C:/Users/Public/LIBRAR~1" Substitution="[{PublicLibraries}{~}]" />
  <Source path="C:/Users/Public/Music/SAMPLE~1" Substitution="[{SampleMusic}{~}]" />
  <Source path="C:/Users/Public/Pictures/SAMPLE~1" Substitution="[{SamplePictures}{~}]" />
  <Source path="C:/Users/Public/Videos/SAMPLE~1" Substitution="[{SampleVideos}{~}]" />
  <Source path="C:/Users/ALLUSE~1" Substitution="[{AppVAllUsersDir}{~}]" />
  <Source path="C:/Users" Substitution="[{UserProfiles}]" />
  <Source path="C:/Users/{0}/AppData/Roaming" substitution="[{AppData}]" />
</AppVPathSubstitution>
'@
  

[XML] $Script:AppVVFSPathSubstitution =
@'
  <VFSPathSubstitution>
  <Source path="C:\Program Files (x86)\Common Files" x86="VFS\ProgramFilesCommonX86" x64="VFS\ProgramFilesCommonX86" />
  <Source path="C:\Program Files (x86)" x86="VFS\ProgramFilesX86" x64="VFS\ProgramFilesX86" />
  <Source path="C:\Program Files\Common Files" x86="VFS\ProgramFilesCommonX86" x64="VFS\ProgramFilesCommonX64" />
  <Source path="C:\Program Files" x86="VFS\ProgramFilesX86" x64="VFS\ProgramFilesX64"/>
  
  <Source path="C:\Windows\assembly\GAC" x86="VFS\Windows\assembly" x64="VFS\Windows\assembly" />
  <Source path="C:\Windows\assembly" x86="VFS\Windows\assembly" x64="VFS\Windows\assembly" />
  <Source path="C:\Windows\Fonts" x86="VFS\Windows\Fonts" x64="VFS\Windows\Fonts" />
  <Source path="C:\Windows\SysWOW64" x86="VFS\SystemX86" x64="VFS\SystemX86" />
  <Source path="C:\Windows" x86="VFS\Windows" x64="VFS\Windows" />

  <Source path="C:\Windows\System32" x86="VFS\SystemX86" x64="VFS\SystemX64" />
  <Source path="C:\Windows\System" x86="VFS\Windows\System" x64="VFS\Windows\System" />
  <Source path="C:\ProgramData\Microsoft" x86="VFS\Common AppData" x64="VFS\Common AppData" />
  <Source path="C:\ProgramData" x86="VFS\Common AppData" x64="VFS\Common AppData" />
  <Source path="C:/Users/{0}/AppData/Roaming" x86="VFS\AppData" x64="VFS\AppData" />
  <Source path="88ROOTDIR88" x86="" x64="" />
  <Source path="C:\AppVPackageDrive" x86="VFS\AppVPackageDrive" x64="VFS\AppVPackageDrive" />
  </VFSPathSubstitution>
'@

$Script:AppvDeploymentInfo = 
@("Name",
  "ComMode",
  "InProcessEnabled",
  "OutOfProcessEnabled",
  "HasRegistrySettings",  
  "HasURLProtocols",
  "FontsEnabled",
  "FileSystemEnabled",
  "ServicesEnabled",
  "HasFileTypeAssociation",
  "FileTypeAssociation",
  "FileTypeAssociationEnabled",
  "EnvironmentVariablesEnabled",
  "HasEnvironmentVariables",
  "ObjectsEnabled",
  "RegistryEnabled",
  "HasApplications",
  "Applications",
  "HasShortcuts",
  "Shortcuts",
  "ShortcutsEnabled",
  "HasUserScripts",
  "UserScripts",
  "ApplicationCapabilities",
  "HasApplicationCapabilities",
  "ApplicationCapabilitiesEnabled",
  "HasMachineRegistrySettings",
  "MachineScripts",
  "HasMachineScripts",
  "HasTerminateChildProcesses",
  "TerminateChildProcesses")

Remove-TypeData -TypeName 'DeploymentConfigObject' -ea SilentlyContinue

$AppVDeploymentConfig = @{
  MemberType = 'NoteProperty'
  TypeName   = 'DeploymentConfigObject'
  Value      = $null
}

foreach ($item in $AppvDeploymentInfo) {
  Update-TypeData @AppVDeploymentConfig -MemberName $item -force
}

#Typedef for the Manifest Infos
$AppxManifestInfo = "Name, Discription, AppVSchemaVersion, OSMinVersion, OSMaxVersionTested, TargetOSes, MaxfileSize, MaxfilePath,FileCount,
HasShortcuts, Shortcuts, HasFileTypeAssociation, FileTypeAssociation, UncompressedSize,  
ComMode,InProcessEnabled, OutOfProcessEnabled, FullVFSWriteMode, HasApplicationCapabilities, ApplicationCapabilities,
AppVInProcExt, AssetIntelligence, HasFonts, HasSxSAssemblys, SxSAssemblys, HasComComponents, HasApplications, Applications,
HasFB1,  HasShellExtensions, HasEnvironmentVariables, EmptyStreamMap, PackageFullLoad, 
HasBrowserHelpObject, HasActiveXComponents, HasUserScripts, UserScripts, HasMachineScripts, MachineScripts, HasBrowserPlugins,
ApplicationCapabilitiesEnabled, EnvironmentVariablesEnabled , ShortCutsEnabled, FileTypeAssociationsEnabled, ObjectsEnabled, ObjectsMode, 
ServicesEnabled, HasServices, Services, RegistryEnabled, FileSystemEnabled, FontsEnabled, SoftwareClientsEnabled"

$AppxManifestInfo = @($AppxManifestInfo.replace("`n", "").replace("`r", "").replace(" ", "").split(',') )

Remove-TypeData -TypeName 'AppxManifestInfo' -ea SilentlyContinue

$AppxManifestConfig = @{
  MemberType = 'NoteProperty'
  TypeName   = 'AppxManifestInfo'
  Value      = $null
}
foreach ($item in $AppxManifestInfo) {
  Update-TypeData @AppxManifestConfig -MemberName $item -force
}

#Typedef for the UserConfig.xml
$UserConfigInfo = @("Name, ComMode,InProcessEnabled, OutOfProcessEnabled, HasRegistrySettings, HasURLProtocols,
FontsEnabled, FileSystemEnabled, ServicesEnabled, HasFileTypeAssociation, FileTypeAssociation, FileTypeAssociationEnabled,
EnvironmentVariablesEnabled, HasEnvironmentVariables, ObjectsEnabled,  RegistryEnabled,
HasApplications, Applications, HasShortcuts, Shortcuts, ShortcutsEnabled, HasUserScripts, 
UserScripts".replace("`n", "").replace("`r", "").replace(" ", "").split(','))

$UserConfig = @{
  MemberType = 'NoteProperty'
  TypeName   = 'UserConfigObject'
  Value      = $null
}
foreach ($item in $UserConfigInfo) {
  Update-TypeData @UserConfig -MemberName $item -force
}


#Icon Extractor return Format

$IconInfo = @("Target", "Base64Image", "ImageType")

$IconConfig = @{
  MemberType = 'NoteProperty'
  TypeName   = 'AppVIconObject'
  Value      = $null
}
foreach ($item in $IconInfo) {
  Update-TypeData @IconConfig -MemberName $item -force
}

