
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


# SIG # Begin signature block
# MIIetQYJKoZIhvcNAQcCoIIepjCCHqICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUjXSMGqHIl6ebdP7KpCNzmUFY
# npGgghm/MIIEhDCCA2ygAwIBAgIQQhrylAmEGR9SCkvGJCanSzANBgkqhkiG9w0B
# AQUFADBvMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNV
# BAsTHUFkZFRydXN0IEV4dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRU
# cnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTA1MDYwNzA4MDkxMFoXDTIwMDUzMDEw
# NDgzOFowgZUxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2Fs
# dCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8G
# A1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMR0wGwYDVQQDExRVVE4tVVNF
# UkZpcnN0LU9iamVjdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM6q
# gT+jo2F4qjEAVZURnicPHxzfOpuCaDDASmEd8S8O+r5596Uj71VRloTN2+O5bj4x
# 2AogZ8f02b+U60cEPgLOKqJdhwQJ9jCdGIqXsqoc/EHSoTbL+z2RuufZcDX65OeQ
# w5ujm9M89RKZd7G3CeBo5hy485RjiGpq/gt2yb70IuRnuasaXnfBhQfdDWy/7gbH
# d2pBnqcP1/vulBe3/IW+pKvEHDHd17bR5PDv3xaPslKT16HUiaEHLr/hARJCHhrh
# 2JU022R5KP+6LhHC5ehbkkj7RwvCbNqtMoNB86XlQXD9ZZBt+vpRxPm9lisZBCzT
# bafc8H9vg2XiaquHhnUCAwEAAaOB9DCB8TAfBgNVHSMEGDAWgBStvZh6NLQm9/rE
# JlTvA73gJMtUGjAdBgNVHQ4EFgQU2u1kdBScFDyr3ZmpvVsoTYs8ydgwDgYDVR0P
# AQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEQG
# A1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVz
# dEV4dGVybmFsQ0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGG
# GWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEFBQADggEBAE1C
# L6bBiusHgJBYRoz4GTlmKjxaLG3P1NmHVY15CxKIe0CP1cf4S41VFmOtt1fcOyu9
# 08FPHgOHS0Sb4+JARSbzJkkraoTxVHrUQtr802q7Zn7Knurpu9wHx8OSToM8gUmf
# ktUyCepJLqERcZo20sVOaLbLDhslFq9s3l122B9ysZMmhhfbGN6vRenf+5ivFBjt
# pF72iZRF8FUESt3/J90GSkD2tLzx5A+ZArv9XQ4uKMG+O18aP5cQhLwWPtijnGMd
# ZstcX9o+8w8KCTUi29vAPwD55g1dZ9H9oB4DK9lA977Mh2ZUgKajuPUZYtXSJrGY
# Ju6ay0SnRVqBlRUa9VEwggTmMIIDzqADAgECAhBiXE2QjNVC+6supXM/8VQZMA0G
# CSqGSIb3DQEBBQUAMIGVMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNV
# BAcTDlNhbHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdv
# cmsxITAfBgNVBAsTGGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTEdMBsGA1UEAxMU
# VVROLVVTRVJGaXJzdC1PYmplY3QwHhcNMTEwNDI3MDAwMDAwWhcNMjAwNTMwMTA0
# ODM4WjB6MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
# MRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDEg
# MB4GA1UEAxMXQ09NT0RPIFRpbWUgU3RhbXBpbmcgQ0EwggEiMA0GCSqGSIb3DQEB
# AQUAA4IBDwAwggEKAoIBAQCqgvGEqVvYcbXSXSvt9BMgDPmb6dGPdF5u7uspSNjI
# vizrCmFgzL2SjXzddLsKnmhOqnUkcyeuN/MagqVtuMgJRkx+oYPp4gNgpCEQJ0Ca
# WeFtrz6CryFpWW1jzM6x9haaeYOXOh0Mr8l90U7Yw0ahpZiqYM5V1BIR8zsLbMaI
# upUu76BGRTl8rOnjrehXl1/++8IJjf6OmqU/WUb8xy1dhIfwb1gmw/BC/FXeZb5n
# OGOzEbGhJe2pm75I30x3wKoZC7b9So8seVWx/llaWm1VixxD9rFVcimJTUA/vn9J
# AV08m1wI+8ridRUFk50IYv+6Dduq+LW/EDLKcuoIJs0ZAgMBAAGjggFKMIIBRjAf
# BgNVHSMEGDAWgBTa7WR0FJwUPKvdmam9WyhNizzJ2DAdBgNVHQ4EFgQUZCKGtkqJ
# yQQP0ARYkiuzbj0eJ2wwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8C
# AQAwEwYDVR0lBAwwCgYIKwYBBQUHAwgwEQYDVR0gBAowCDAGBgRVHSAAMEIGA1Ud
# HwQ7MDkwN6A1oDOGMWh0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VVE4tVVNFUkZp
# cnN0LU9iamVjdC5jcmwwdAYIKwYBBQUHAQEEaDBmMD0GCCsGAQUFBzAChjFodHRw
# Oi8vY3J0LnVzZXJ0cnVzdC5jb20vVVROQWRkVHJ1c3RPYmplY3RfQ0EuY3J0MCUG
# CCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEB
# BQUAA4IBAQARyT3hBeg7ZazJdDEDt9qDOMaSuv3N+Ntjm30ekKSYyNlYaDS18Ash
# U55ZRv1jhd/+R6pw5D9eCJUoXxTx/SKucOS38bC2Vp+xZ7hog16oYNuYOfbcSV4T
# p5BnS+Nu5+vwQ8fQL33/llqnA9abVKAj06XCoI75T9GyBiH+IV0njKCv2bBS7vzI
# 7bec8ckmONalMu1Il5RePeA9NbSwyVivx1j/YnQWkmRB2sqo64sDvcFOrh+RMrjh
# JDt77RRoCYaWKMk7yWwowiVp9UphreAn+FOndRWwUTGw8UH/PlomHmB+4uNqOZrE
# 6u4/5rITP1UDBE0LkHLU6/u8h5BRsjgZMIIE/jCCA+agAwIBAgIQK3PbdGMRTFpb
# MkryMFdySTANBgkqhkiG9w0BAQUFADB6MQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
# R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFD
# T01PRE8gQ0EgTGltaXRlZDEgMB4GA1UEAxMXQ09NT0RPIFRpbWUgU3RhbXBpbmcg
# Q0EwHhcNMTkwNTAyMDAwMDAwWhcNMjAwNTMwMTA0ODM4WjCBgzELMAkGA1UEBhMC
# R0IxGzAZBgNVBAgMEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBwwHU2FsZm9y
# ZDEYMBYGA1UECgwPU2VjdGlnbyBMaW1pdGVkMSswKQYDVQQDDCJTZWN0aWdvIFNI
# QS0xIFRpbWUgU3RhbXBpbmcgU2lnbmVyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
# MIIBCgKCAQEAv1I2gjrcdDcNeNV/FlAZZu26GpnRYziaDGayQNungFC/aS42Lwpn
# P0ChSopjNZvQGcx0qhcZkSu1VSAZ+8AaOm3KOZuC8rqVoRrYNMe4iXtwiHBRZmns
# d/7GlHJ6zyWB7TSCmt8IFTcxtG2uHL8Y1Q3P/rXhxPuxR3Hp+u5jkezx7M5ZBBF8
# rgtgU+oq874vAg/QTF0xEy8eaQ+Fm0WWwo0Si2euH69pqwaWgQDfkXyVHOaeGWTf
# dshgRC9J449/YGpFORNEIaW6+5H6QUDtTQK0S3/f4uA9uKrzGthBg49/M+1BBuJ9
# nj9ThI0o2t12xr33jh44zcDLYCQD3npMqwIDAQABo4IBdDCCAXAwHwYDVR0jBBgw
# FoAUZCKGtkqJyQQP0ARYkiuzbj0eJ2wwHQYDVR0OBBYEFK7u2WC6XvUsARL9jo2y
# VXI1Rm/xMA4GA1UdDwEB/wQEAwIGwDAMBgNVHRMBAf8EAjAAMBYGA1UdJQEB/wQM
# MAoGCCsGAQUFBwMIMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQMIMCUwIwYIKwYB
# BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMEIGA1UdHwQ7MDkwN6A1oDOG
# MWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vQ09NT0RPVGltZVN0YW1waW5nQ0FfMi5j
# cmwwcgYIKwYBBQUHAQEEZjBkMD0GCCsGAQUFBzAChjFodHRwOi8vY3J0LnNlY3Rp
# Z28uY29tL0NPTU9ET1RpbWVTdGFtcGluZ0NBXzIuY3J0MCMGCCsGAQUFBzABhhdo
# dHRwOi8vb2NzcC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAen+pStKw
# pBwdDZ0tXMauWt2PRR3wnlyQ9l6scP7T2c3kGaQKQ3VgaoOkw5mEIDG61v5MzxP4
# EPdUCX7q3NIuedcHTFS3tcmdsvDyHiQU0JzHyGeqC2K3tPEG5OfkIUsZMpk0uRlh
# dwozkGdswIhKkvWhQwHzrqJvyZW9ljj3g/etfCgf8zjfjiHIcWhTLcuuquIwF4Mi
# KRi14YyJ6274fji7kE+5Xwc0EmuX1eY7kb4AFyFu4m38UnnvgSW6zxPQ+90rzYG2
# V4lO8N3zC0o0yoX/CLmWX+sRE+DhxQOtVxzhXZIGvhvIPD+lIJ9p0GnBxcLJPufF
# cvfqG5bilK+GLjCCBWMwggRLoAMCAQICEQCNpmTSLuzUmCLFvasjR87HMA0GCSqG
# SIb3DQEBCwUAMH0xCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNo
# ZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1p
# dGVkMSMwIQYDVQQDExpDT01PRE8gUlNBIENvZGUgU2lnbmluZyBDQTAeFw0xODA3
# MDgwMDAwMDBaFw0yMDA3MDcyMzU5NTlaMIGtMQswCQYDVQQGEwJERTEOMAwGA1UE
# EQwFMzA1MzkxFjAUBgNVBAgMDU5pZWRlcnNhY2hzZW4xETAPBgNVBAcMCEhhbm5v
# dmVyMRMwEQYDVQQJDApEcmlidXNjaCAyMSYwJAYDVQQKDB1OaWNrIEluZm9ybWF0
# aW9uc3RlY2huaWsgR21iSDEmMCQGA1UEAwwdTmljayBJbmZvcm1hdGlvbnN0ZWNo
# bmlrIEdtYkgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCrc6lZm8xu
# lPRIGaegFWyjuDkhYm5qdzcj0ZcLh+GLefGrZsTb8ZwqD3XwhNsKeYmRlds5chg8
# Y7YVnHbtXVThuL51O64W6B5n2CzZyeJVFrc6AyAGEnUPl8ooyywcS6Ch+a2879Jm
# otLXWKwRnDbvGz/OAGYE8MYWp/uD/xkSvqW5RwJoDK3/e3n6aVESXDyj+MfMiZQy
# KKGL7W5tdcMngApa1Ner3ifk0+GevD7zRyImBH5mglzXq22DBlbMLBfhi7IWiDFf
# eWbmoxP3sd+imMRlejR//kA+QxHdxnlvpvgz6uvyPzZDuf9my3YYR/IHJb/rwi5S
# TXLB4BH0uTqxAgMBAAGjggGrMIIBpzAfBgNVHSMEGDAWgBQpkWD/ik366/mmarjP
# +eZLvUnOEjAdBgNVHQ4EFgQUJoBGq4fcme5y6uv+6ukStosAu4MwDgYDVR0PAQH/
# BAQDAgeAMAwGA1UdEwEB/wQCMAAwEwYDVR0lBAwwCgYIKwYBBQUHAwMwEQYJYIZI
# AYb4QgEBBAQDAgQQMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQMCMCswKQYIKwYB
# BQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMEMGA1UdHwQ8MDow
# OKA2oDSGMmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNvZGVTaWdu
# aW5nQ0EuY3JsMHQGCCsGAQUFBwEBBGgwZjA+BggrBgEFBQcwAoYyaHR0cDovL2Ny
# dC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ29kZVNpZ25pbmdDQS5jcnQwJAYIKwYB
# BQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAcBgNVHREEFTATgRFhLm5p
# Y2tAbmljay1pdC5kZTANBgkqhkiG9w0BAQsFAAOCAQEAB9Yo3aM+0hPf1l3Ckn3x
# xdlVtZZ/yhhaXDB2eMSkL3RuSGsmkvWBa64+S44DawxcdOqsZcMkmyMFC7NE9NHK
# r31mSVAfakNoOcVV18pGxmUermlsKIYkyrHki8AMOVYYxWI1gWV9tLWYZmswqWQa
# YACmcu+8Rm964vjcDVcNC+ENGFxT2WOiWSolUvbgn8nz/mO4gVJkI34ZuxT5gj6m
# EPLUt2pWYaSswDHHQ9ytrsQrbumqeu9ygm9xWW5pzv7FNxSMtj/XpCtKUphmaLWK
# J99HIz3ypySk+hat6x5Sfre49claJnb/mU6PyVWp3yR3p4KjfTsJF0yvQrmmKV8X
# YTCCBeAwggPIoAMCAQICEC58h8wOk0pS/pT9HLfNNK8wDQYJKoZIhvcNAQEMBQAw
# gYUxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
# BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYD
# VQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTEzMDUw
# OTAwMDAwMFoXDTI4MDUwODIzNTk1OVowfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
# EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMR
# Q09NT0RPIENBIExpbWl0ZWQxIzAhBgNVBAMTGkNPTU9ETyBSU0EgQ29kZSBTaWdu
# aW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAppiQY3eRNH+K
# 0d3pZzER68we/TEds7liVz+TvFvjnx4kMhEna7xRkafPnp4ls1+BqBgPHR4gMA77
# YXuGCbPj/aJonRwsnb9y4+R1oOU1I47Jiu4aDGTH2EKhe7VSA0s6sI4jS0tj4CKU
# N3vVeZAKFBhRLOb+wRLwHD9hYQqMotz2wzCqzSgYdUjBeVoIzbuMVYz31HaQOjNG
# UHOYXPSFSmsPgN1e1r39qS/AJfX5eNeNXxDCRFU8kDwxRstwrgepCuOvwQFvkBoj
# 4l8428YIXUezg0HwLgA3FLkSqnmSUs2HD3vYYimkfjC9G7WMcrRI8uPoIfleTGJ5
# iwIGn3/VCwIDAQABo4IBUTCCAU0wHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY
# 7NkyMtQwHQYDVR0OBBYEFCmRYP+KTfrr+aZquM/55ku9Sc4SMA4GA1UdDwEB/wQE
# AwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMBEG
# A1UdIAQKMAgwBgYEVR0gADBMBgNVHR8ERTBDMEGgP6A9hjtodHRwOi8vY3JsLmNv
# bW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBx
# BggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2Eu
# Y29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8v
# b2NzcC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAAI/AjnD7vjKO4ne
# DG1NsfFOkk+vwjgsBMzFYxGrCWOvq6LXAj/MbxnDPdYaCJT/JdipiKcrEBrgm7EH
# IhpRHDrU4ekJv+YkdK8eexYxbiPvVFEtUgLidQgFTPG3UeFRAMaH9mzuEER2V2rx
# 31hrIapJ1Hw3Tr3/tnVUQBg2V2cRzU8C5P7z2vx1F9vst/dlCSNJH0NXg+p+IHdh
# yE3yu2VNqPeFRQevemknZZApQIvfezpROYyoH3B5rW1CIKLPDGwDjEzNcweU51qO
# OgS6oqF8H8tjOhWn1BUbp1JHMqn0v2RH0aofU04yMHPCb7d4gp1c/0a7ayIdiAv4
# G6o0pvyM9d1/ZYyMMVcx0DbsR6HPy4uo7xwYWMUGd8pLm1GvTAhKeo/io1Lijo7M
# JuSy2OU4wqjtxoGcNWupWGFKCpe0S0K2VZ2+medwbVn4bSoMfxlgXwyaiGwwrFIJ
# kBYb/yud29AgyonqKH4yjhnfe0gzHtdl+K7J+IMUk3Z9ZNCOzr41ff9yMU2fnr0e
# bC+ojwwGUPuMJ7N2yfTm18M04oyHIYZh/r9VdOEhdwMKaGy75Mmp5s9ZJet87EUO
# eWZo6CLNuO+YhU2WETwJitB/vCgoE/tqylSNklzNwmWYBp7OSFvUtTeTRkF8B93P
# +kPvumdh/31J4LswfVyA4+YWOUunMYIEYDCCBFwCAQEwgZIwfTELMAkGA1UEBhMC
# R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
# ZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxIzAhBgNVBAMTGkNPTU9ETyBS
# U0EgQ29kZSBTaWduaW5nIENBAhEAjaZk0i7s1Jgixb2rI0fOxzAJBgUrDgMCGgUA
# oHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYB
# BAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0B
# CQQxFgQUIxi2+vTi3FV6PxeQ4eM/PlS50SkwDQYJKoZIhvcNAQEBBQAEggEAG+WA
# 7DwGdl9rR2mSBJIMNQU8boyDCOwc/KXn/BuNMFl20ZcrhqfGAXQA7XHWK/T5hjmK
# aZOx/nYlgXxuXoD/N1qS5TjlIOOJrHszeQiIrBNrAgmLuQCXTBI8jrohecKhB1ju
# UTQi90EPNIyx1lXdF+7NCX4CBLRfBzG6TDLCMW5JujSz7b4XhU0nZ/bHurD5rN/j
# YB1P5mrc6FSLzjZTIVJNNX9RpjDPcbZEgnUS7Uv8Z6MSlovxyQ0Ym6dokUXufyuG
# q7fKwMXO0FeFZu+0IHjJu778olCERFBQ8vo+zrXyuuxdaCIA4hfTXMEWnXfyeoXA
# pfeZLxLelcFle2+OkqGCAigwggIkBgkqhkiG9w0BCQYxggIVMIICEQIBATCBjjB6
# MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
# VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDEgMB4GA1UE
# AxMXQ09NT0RPIFRpbWUgU3RhbXBpbmcgQ0ECECtz23RjEUxaWzJK8jBXckkwCQYF
# Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
# MQ8XDTIwMDExMTE2MDIwM1owIwYJKoZIhvcNAQkEMRYEFDgn3kE8zY9I/GR9aOGe
# 9tyD90EvMA0GCSqGSIb3DQEBAQUABIIBAAV+dERJF2oCeLnItKTbryZ9eHvPbpPs
# 8Z/mlii8higk7SfuohWR0wl6Ukj6LGK+Y4KTfyxJP2h+OE1UPc/gA0hxc3eAIXoA
# bew3bVv2RpfrlO7zrXORAitYbXwXcaRqEKpkNzaYFpgvYde4dVwnfDjoYs/uDnUP
# bJqmHS8nOsTShhS0EIh1Indzv+bLGzhFkV1rgvYMx7QzPr3WUpqTOTCStECkn9b3
# GYTnMGXvrTjE4RP+M+e0epfdqnFslVMLmgq8N59OtjQgVxmW/ryUK8qXHct7Lcgf
# Zg7xqhvMSSLRF9QGmi2IYPZxvC9zywRKkNtIw2JprL0BVEKFVDq1JeA=
# SIG # End signature block
