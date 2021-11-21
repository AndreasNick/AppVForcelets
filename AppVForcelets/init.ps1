
# use this file to define global variables on module scope
# or perform other initialization procedures.
# this file will not be touched when new functions are exported to
# this module.


Add-Type -AssemblyName System.IO
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

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
  "ConfigPath",
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
$AppxManifestInfo = "Name, Discription, ConfigPath, AppVSchemaVersion, PackageVersion, PackageID, VersionID, OSMinVersion, OSMaxVersionTested, TargetOSes, MaxfileSize, MaxfilePath,FileCount,
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
$UserConfigInfo = @("Name, ConfigPath,ComMode,InProcessEnabled, OutOfProcessEnabled, HasRegistrySettings, HasURLProtocols,
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
# MIIs/gYJKoZIhvcNAQcCoIIs7zCCLOsCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCLvM4ayZvdt4e7
# 7ecktbOpqUMIxp7R8UJYNOyLXQZB9KCCJQkwggWBMIIEaaADAgECAhA5ckQ6+SK3
# UdfTbBDdMTWVMA0GCSqGSIb3DQEBDAUAMHsxCzAJBgNVBAYTAkdCMRswGQYDVQQI
# DBJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNVBAoM
# EUNvbW9kbyBDQSBMaW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2Vy
# dmljZXMwHhcNMTkwMzEyMDAwMDAwWhcNMjgxMjMxMjM1OTU5WjCBiDELMAkGA1UE
# BhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5
# MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJU
# cnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQCAEmUXNg7D2wiz0KxXDXbtzSfTTK1Qg2HiqiBNCS1k
# CdzOiZ/MPans9s/B3PHTsdZ7NygRK0faOca8Ohm0X6a9fZ2jY0K2dvKpOyuR+OJv
# 0OwWIJAJPuLodMkYtJHUYmTbf6MG8YgYapAiPLz+E/CHFHv25B+O1ORRxhFnRghR
# y4YUVD+8M/5+bJz/Fp0YvVGONaanZshyZ9shZrHUm3gDwFA66Mzw3LyeTP6vBZY1
# H1dat//O+T23LLb2VN3I5xI6Ta5MirdcmrS3ID3KfyI0rn47aGYBROcBTkZTmzNg
# 95S+UzeQc0PzMsNT79uq/nROacdrjGCT3sTHDN/hMq7MkztReJVni+49Vv4M0GkP
# Gw/zJSZrM233bkf6c0Plfg6lZrEpfDKEY1WJxA3Bk1QwGROs0303p+tdOmw1XNtB
# 1xLaqUkL39iAigmTYo61Zs8liM2EuLE/pDkP2QKe6xJMlXzzawWpXhaDzLhn4ugT
# ncxbgtNMs+1b/97lc6wjOy0AvzVVdAlJ2ElYGn+SNuZRkg7zJn0cTRe8yexDJtC/
# QV9AqURE9JnnV4eeUB9XVKg+/XRjL7FQZQnmWEIuQxpMtPAlR1n6BB6T1CZGSlCB
# st6+eLf8ZxXhyVeEHg9j1uliutZfVS7qXMYoCAQlObgOK6nyTJccBz8NUvXt7y+C
# DwIDAQABo4HyMIHvMB8GA1UdIwQYMBaAFKARCiM+lvEH7OKvKe+CpX/QMKS0MB0G
# A1UdDgQWBBRTeb9aqitKz1SA4dibwJ3ysgNmyzAOBgNVHQ8BAf8EBAMCAYYwDwYD
# VR0TAQH/BAUwAwEB/zARBgNVHSAECjAIMAYGBFUdIAAwQwYDVR0fBDwwOjA4oDag
# NIYyaHR0cDovL2NybC5jb21vZG9jYS5jb20vQUFBQ2VydGlmaWNhdGVTZXJ2aWNl
# cy5jcmwwNAYIKwYBBQUHAQEEKDAmMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5j
# b21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggEBABiHUdx0IT2ciuAntzPQLszs
# 8ObLXhHeIm+bdY6ecv7k1v6qH5yWLe8DSn6u9I1vcjxDO8A/67jfXKqpxq7y/Nju
# o3tD9oY2fBTgzfT3P/7euLSK8JGW/v1DZH79zNIBoX19+BkZyUIrE79Yi7qkomYE
# doiRTgyJFM6iTckys7roFBq8cfFb8EELmAAKIgMQ5Qyx+c2SNxntO/HkOrb5RRMm
# da+7qu8/e3c70sQCkT0ZANMXXDnbP3sYDUXNk4WWL13fWRZPP1G91UUYP+1KjugG
# YXQjFrUNUHMnREd/EF2JKmuFMRTE6KlqTIC8anjPuH+OdnKZDJ3+15EIFqGjX5Uw
# ggXJMIIEsaADAgECAhAbtY8lKt8jAEkoya49fu0nMA0GCSqGSIb3DQEBDAUAMH4x
# CzAJBgNVBAYTAlBMMSIwIAYDVQQKExlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEu
# MScwJQYDVQQLEx5DZXJ0dW0gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIjAgBgNV
# BAMTGUNlcnR1bSBUcnVzdGVkIE5ldHdvcmsgQ0EwHhcNMjEwNTMxMDY0MzA2WhcN
# MjkwOTE3MDY0MzA2WjCBgDELMAkGA1UEBhMCUEwxIjAgBgNVBAoTGVVuaXpldG8g
# VGVjaG5vbG9naWVzIFMuQS4xJzAlBgNVBAsTHkNlcnR1bSBDZXJ0aWZpY2F0aW9u
# IEF1dGhvcml0eTEkMCIGA1UEAxMbQ2VydHVtIFRydXN0ZWQgTmV0d29yayBDQSAy
# MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAvfl4+ObVgAxknYYblmRn
# PyI6HnUBfe/7XGeMycxca6mR5rlC5SBLm9qbe7mZXdmbgEvXhEArJ9PoujC7Pgka
# p0mV7ytAJMKXx6fumyXvqAoAl4Vaqp3cKcniNQfrcE1K1sGzVrihQTib0fsxf4/g
# X+GxPw+OFklg1waNGPmqJhCrKtPQ0WeNG0a+RzDVLnLRxWPa52N5RH5LYySJhi40
# PylMUosqp8DikSiJucBb+R3Z5yet/5oCl8HGUJKbAiy9qbk0WQq/hEr/3/6zn+vZ
# nuCYI+yma3cWKtvMrTscpIfcRnNeGWJoRVfkkIJCu0LW8GHgwaM9ZqNd9BjuiMmN
# F0UpmTJ1AjHuKSbIawLmtWJFfzcVWiNoidQ+3k4nsPBADLxNF8tNorMe0AZa3faT
# z1d1mfX6hhpneLO/lv403L3nUlbls+V1e9dBkQXcXWnjlQ1DufyDljmVe2yAWk8T
# csbXfSl6RLpSpCrVQUYJIP4ioLZbMI28iQzV13D4h1L92u+sUS4Hs07+0AnacO+Y
# +lbmbdu1V0vc5SwlFcieLnhO+NqcnoYsylfzGuXIkosagpZ6w7xQEmnYDlpGizrr
# Jvojybawgb5CAKT41v4wLsfSRvbljnX98sy50IdbzAYQYLuDNbdeZ95H7JlI8aSh
# Ff6tjGKOOVVPORa5sWOd/7cCAwEAAaOCAT4wggE6MA8GA1UdEwEB/wQFMAMBAf8w
# HQYDVR0OBBYEFLahVDkCw6A/joq8+tT4HKbROg79MB8GA1UdIwQYMBaAFAh2zcsH
# /yT2xc3tu5C84oQ3RnX3MA4GA1UdDwEB/wQEAwIBBjAvBgNVHR8EKDAmMCSgIqAg
# hh5odHRwOi8vY3JsLmNlcnR1bS5wbC9jdG5jYS5jcmwwawYIKwYBBQUHAQEEXzBd
# MCgGCCsGAQUFBzABhhxodHRwOi8vc3ViY2Eub2NzcC1jZXJ0dW0uY29tMDEGCCsG
# AQUFBzAChiVodHRwOi8vcmVwb3NpdG9yeS5jZXJ0dW0ucGwvY3RuY2EuY2VyMDkG
# A1UdIAQyMDAwLgYEVR0gADAmMCQGCCsGAQUFBwIBFhhodHRwOi8vd3d3LmNlcnR1
# bS5wbC9DUFMwDQYJKoZIhvcNAQEMBQADggEBAFHCoVgWIhCL/IYx1MIy01z4S6Iv
# aj5N+KsIHu3V6PrnCA3st8YeDrJ1BXqxC/rXdGoABh+kzqrya33YEcARCNQOTWHF
# Oqj6seHjmOriY/1B9ZN9DbxdkjuRmmW60F9MvkyNaAMQFtXx0ASKhTP5N+dbLiZp
# Qjy6zbzUeulNndrnQ/tjUoCFBMQllVXwfqefAcVbKPjgzoZwpic7Ofs4LphTZSJ1
# Ldf23SIikZbr3WjtP6MZl9M7JYjsNhI9qX7OAo0FmpKnJ25FspxihjcNpDOO16hO
# 0EoXQ0zF8ads0h5YbBRRfopUofbvn3l6XYGaFpAP4bvxSgD5+d2+7arszgowggX1
# MIID3aADAgECAhAdokgwb5smGNCC4JZ9M9NqMA0GCSqGSIb3DQEBDAUAMIGIMQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5
# IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMl
# VVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xODExMDIw
# MDAwMDBaFw0zMDEyMzEyMzU5NTlaMHwxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
# cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1Nl
# Y3RpZ28gTGltaXRlZDEkMCIGA1UEAxMbU2VjdGlnbyBSU0EgQ29kZSBTaWduaW5n
# IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhiKNMoV6GJ9J8JYv
# YwgeLdx8nxTP4ya2JWYpQIZURnQxYsUQ7bKHJ6aZy5UwwFb1pHXGqQ5QYqVRkRBq
# 4Etirv3w+Bisp//uLjMg+gwZiahse60Aw2Gh3GllbR9uJ5bXl1GGpvQn5Xxqi5Ue
# W2DVftcWkpwAL2j3l+1qcr44O2Pej79uTEFdEiAIWeg5zY/S1s8GtFcFtk6hPldr
# H5i8xGLWGwuNx2YbSp+dgcRyQLXiX+8LRf+jzhemLVWwt7C8VGqdvI1WU8bwunlQ
# SSz3A7n+L2U18iLqLAevRtn5RhzcjHxxKPP+p8YU3VWRbooRDd8GJJV9D6ehfDra
# hjVh0wIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rID
# ZsswHQYDVR0OBBYEFA7hOqhTOjHVir7Bu61nGgOFrTQOMA4GA1UdDwEB/wQEAwIB
# hjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMDBggrBgEF
# BQcDCDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDov
# L2NybC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRo
# b3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2Ny
# dC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsG
# AQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUA
# A4ICAQBNY1DtRzRKYaTb3moqjJvxAAAeHWJ7Otcywvaz4GOz+2EAiJobbRAHBE++
# uOqJeCLrD0bs80ZeQEaJEvQLd1qcKkE6/Nb06+f3FZUzw6GDKLfeL+SU94Uzgy1K
# QEi/msJPSrGPJPSzgTfTt2SwpiNqWWhSQl//BOvhdGV5CPWpk95rcUCZlrp48bnI
# 4sMIFrGrY1rIFYBtdF5KdX6luMNstc/fSnmHXMdATWM19jDTz7UKDgsEf6BLrruj
# pdCEAJM+U100pQA1aWy+nyAlEA0Z+1CQYb45j3qOTfafDh7+B1ESZoMmGUiVzkrJ
# wX/zOgWb+W/fiH/AI57SHkN6RTHBnE2p8FmyWRnoao0pBAJ3fEtLzXC+OrJVWng+
# vLtvAxAldxU0ivk2zEOS5LpP8WKTKCVXKftRGcehJUBqhFfGsp2xvBwK2nxnfn0u
# 6ShMGH7EezFBcZpLKewLPVdQ0srd/Z4FUeVEeN0B3rF1mA1UJP3wTuPi+IO9crrL
# PTru8F4XkmhtyGH5pvEqCgulufSe7pgyBYWe6/mDKdPGLH29OncuizdCoGqC7TtK
# qpQQpOEN+BfFtlp5MxiS47V1+KHpjgolHuQe8Z9ahyP/n6RRnvs5gBHN27XEp6iA
# b+VT1ODjosLSWxr6MiYtaldwHDykWC6j81tLB9wyWfOHpxptWDCCBmQwggVMoAMC
# AQICEA5ZOEkd/YQAY+aJApJpNrAwDQYJKoZIhvcNAQELBQAwfDELMAkGA1UEBhMC
# R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
# ZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJT
# QSBDb2RlIFNpZ25pbmcgQ0EwHhcNMjAwODE3MDAwMDAwWhcNMjMwODE3MjM1OTU5
# WjCBrTELMAkGA1UEBhMCREUxDjAMBgNVBBEMBTMwNTM5MRYwFAYDVQQIDA1OaWVk
# ZXJzYWNoc2VuMREwDwYDVQQHDAhIYW5ub3ZlcjETMBEGA1UECQwKRHJpYnVzY2gg
# MjEmMCQGA1UECgwdTmljayBJbmZvcm1hdGlvbnN0ZWNobmlrIEdtYkgxJjAkBgNV
# BAMMHU5pY2sgSW5mb3JtYXRpb25zdGVjaG5payBHbWJIMIICIjANBgkqhkiG9w0B
# AQEFAAOCAg8AMIICCgKCAgEA2l6t2wRnLEQqeMUV6f7uRX4R8vk2llTPpiXhiGSl
# hg9Ed/vP3IFYa9zRyNWVwHhmv0CGpxU+ezkSpSNPtMI4nG4aNJw37q9O3Uo7GuA6
# MyW+hTO0qsps6wax2Evk6FQA05na/A69zSVAzVwwJCxb/+JWey7WehiILWO7ja1M
# P3JyIiJIgLeR8vWYkoEXNbdjS3u103IgRLlG2YTQp6pockG1sDexu5tjUEH9PFNZ
# VNc2OvYe6+xs27JNR3zgLcceCh53uGtJa/Tt9m+8MXnU2ef/BmtFTbC0cT8cl9n5
# u2By0jk9CzGYicGjE9OAvmIy4rN9TpWTTi/KZzdroAFe5d9RJQHk5w9kKdqflXxB
# rScraX4oIPdpb5mq9lrH4XQj+KPUwXG2oWAuopp5s6WuLxH1a/eE6GR8agMP4M2L
# OFAN7OckNARLdzUG7oWAqXstF1V9oz+rBKrqzzXuBs5w8a457jOS57i8HOvO8p89
# x6m3G0IiA0X/d9DFKJyTUae26E8LNbyLs4VSgMrg9jqN1m0/e2NveglDKbQWOzSn
# WDUEwtTh3fUUP4oZ4047fufwrNU8+bQVl/nNJ3/c15FFnLR8jhkIm8kwlCC5Ksx5
# OPF8sWdNHmbo1rRIFQEuxd2jN1a/CFl3Ek23i1iQ8tRlRAtHuhIVc5HbllabtZ1/
# waUCAwEAAaOCAa4wggGqMB8GA1UdIwQYMBaAFA7hOqhTOjHVir7Bu61nGgOFrTQO
# MB0GA1UdDgQWBBSrRDvFAhELOtbF7kQCSvBeQkmL2jAOBgNVHQ8BAf8EBAMCB4Aw
# DAYDVR0TAQH/BAIwADATBgNVHSUEDDAKBggrBgEFBQcDAzARBglghkgBhvhCAQEE
# BAMCBBAwSgYDVR0gBEMwQTA1BgwrBgEEAbIxAQIBAwIwJTAjBggrBgEFBQcCARYX
# aHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwCAYGZ4EMAQQBMEMGA1UdHwQ8MDowOKA2
# oDSGMmh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNvZGVTaWduaW5n
# Q0EuY3JsMHMGCCsGAQUFBwEBBGcwZTA+BggrBgEFBQcwAoYyaHR0cDovL2NydC5z
# ZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ29kZVNpZ25pbmdDQS5jcnQwIwYIKwYBBQUH
# MAGGF2h0dHA6Ly9vY3NwLnNlY3RpZ28uY29tMBwGA1UdEQQVMBOBEWEubmlja0Bu
# aWNrLWl0LmRlMA0GCSqGSIb3DQEBCwUAA4IBAQALorM7/GxLkSRLkotjzvenAdqY
# UYyk7MgQd6gCKqlfsszLwa7jVHOeyi79lAaNhL0emB7NiTiSTkCg0Zj/45tydIi8
# 0U6vsSRjBm365N6N3OBtjyCEOaF2bdel+Oo74OMl7rG1/xB+J6ztudeFwq80VO/J
# wg+OKRW/EX+1t8XPH2JGrM5cKDOecxHZ75Vsrq+Nkl4yBHQpodGZc59e3+Nftwm3
# WPRNq14qkQJ4XFrAoDx+aV5kHDYpVcQj7SUOa7GTihFGQt0fSdS/TqaqJyCx/BQV
# sKRTbq2AYl6YZ2a1/lVxUz3Tcr/jEmSSG46XAwDV71dT+KzSRKT8pbUb2ay8MIIG
# lTCCBH2gAwIBAgIRAPFkJYwJtuJ74g4yYI5L9KgwDQYJKoZIhvcNAQEMBQAwVjEL
# MAkGA1UEBhMCUEwxITAfBgNVBAoTGEFzc2VjbyBEYXRhIFN5c3RlbXMgUy5BLjEk
# MCIGA1UEAxMbQ2VydHVtIFRpbWVzdGFtcGluZyAyMDIxIENBMB4XDTIxMDUxOTA1
# NDI0NloXDTMyMDUxODA1NDI0NlowUDELMAkGA1UEBhMCUEwxITAfBgNVBAoMGEFz
# c2VjbyBEYXRhIFN5c3RlbXMgUy5BLjEeMBwGA1UEAwwVQ2VydHVtIFRpbWVzdGFt
# cCAyMDIxMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA1WG+gAC93YRj
# 7hJlmB14VItG+saRFhq6PR58vjQY9ui/eIJiPJDjVWHbtgs/QX7ZIsr5OPtzBQ65
# KL2WUPFg3Jhl5bV+MQMDwHI1xG14BGdHsRD+QHtm5MCpU4slFwmqtA/SRGiubeCq
# u6x+653SneZF+ygEXDBVhDfopFdXIBpSoKpiUk5NAb24G3Ou6KJSIbaIXBJLWWRb
# reVScUydTirEUdxVJjfuEKwJNESL+HcNmeLFopam3QWgUv+Yai7efLKbYjkZMZ4o
# 6991Z74iz9vsG1skDOZPwIKyo/JZOgOQvFf3UoY+pf06qkTMpBgCjpougnLxm1A4
# mzypI5cZQC3eJhyxbo1qBPdRonClCn1ZC7BaqZW/3Tz10I8NkwpmWwHoA0JbAKaZ
# 3YvVFGcR7z3K8sstBModcuBp+179bxMJ8AYrGYwe9jMvJM1ENII8T9ur4QZLxdgo
# nNep1QB8chjj5tGNL+5RZnEsmFVoNSeemGW/kACWQi+wSfQgUiaQFzRsXDVETdG2
# gAZWUx5922wTzgYTkmPb2xsC9+JzpkxaURuZj+h0FV3PxDvXI/OemvWrngxss9oX
# JTCGYoxhGua8GnBrT8NR81qYDQDiNuAoQwUUPGJg9tyDda5i5cwjLEWfcBWCLzQ7
# TCVTEkIAtPl0ARTznuvZD8MYDzTeAgsCAwEAAaOCAWIwggFeMAwGA1UdEwEB/wQC
# MAAwHQYDVR0OBBYEFMVHEk5yV7ZEFGuIcRoUrDG5P7oIMB8GA1UdIwQYMBaAFL5U
# Ai+/QGxzQ86sCSVOnkNEGu7gMA4GA1UdDwEB/wQEAwIHgDAWBgNVHSUBAf8EDDAK
# BggrBgEFBQcDCDAzBgNVHR8ELDAqMCigJqAkhiJodHRwOi8vY3JsLmNlcnR1bS5w
# bC9jdHNjYTIwMjEuY3JsMG8GCCsGAQUFBwEBBGMwYTAoBggrBgEFBQcwAYYcaHR0
# cDovL3N1YmNhLm9jc3AtY2VydHVtLmNvbTA1BggrBgEFBQcwAoYpaHR0cDovL3Jl
# cG9zaXRvcnkuY2VydHVtLnBsL2N0c2NhMjAyMS5jZXIwQAYDVR0gBDkwNzA1Bgsq
# hGgBhvZ3AgUBCzAmMCQGCCsGAQUFBwIBFhhodHRwOi8vd3d3LmNlcnR1bS5wbC9D
# UFMwDQYJKoZIhvcNAQEMBQADggIBADdzzDC3wl+J5qp0rB1Nq2YRP3ZKq3UmC7yN
# 1PYuPYcbPovvaKOZiZeLqzy2SdMSM+gewhxQTVvXRcIGoZxTF4k+0Jz7meQgMHy/
# /Qn7AC913Z0tAFpZfuyEqJkaPHedW36Rx7dz948fQuiJodQO9yUqfdAqtDaj6pxH
# 5a1cWF/rGGtkjvbxrETGLIVO7sxNVeXGFlqBVDGgx6cELh+AzV4mTug+3/EBlp1z
# R17ukt0pWmAxuGKMe0iFtbUL9I7JJhdb3TX6MVQMpkBkXTS7BswF5+jjwFIsNcUO
# jNaqYyuFJyk1IhSX74A1209XL62LCa8mwf+NbKPg7ALdMoysW6UuYj+0qcch7J3I
# dFXCOeLCH9Cuun+CyRqHAaQ0ym1NQDqtzrx21aiO1cKrPkxgru0yqq0y9jUE0QwM
# R5LKOxbR/ONUdgNpb2EhQ3xsfOwdTbz1mFN5mPxkbJkMfkYAPD5f+zb6e2QGPgFP
# Jg1a9il6xT+Lp6bMFQUJR8bSDsc+o3sn3SyBtqBSZZd4qXAEh2r/6G2BLfxdRkZS
# fphSELSg2ncVAZn4UZYCIGLxBLbiRhER7sXzA9uoy5osbvEkzxkUXKPkeQXYLvqh
# W58pin7lzuLEfeiWKmjjsYpXDf8a+5rNd4ku8KgDaXdrcSmYz8t8HVp4lUHLi+8g
# lw9rhHNtMIIGuTCCBKGgAwIBAgIRAOf/acc7Nc5LkSbYdHxopYcwDQYJKoZIhvcN
# AQEMBQAwgYAxCzAJBgNVBAYTAlBMMSIwIAYDVQQKExlVbml6ZXRvIFRlY2hub2xv
# Z2llcyBTLkEuMScwJQYDVQQLEx5DZXJ0dW0gQ2VydGlmaWNhdGlvbiBBdXRob3Jp
# dHkxJDAiBgNVBAMTG0NlcnR1bSBUcnVzdGVkIE5ldHdvcmsgQ0EgMjAeFw0yMTA1
# MTkwNTMyMDdaFw0zNjA1MTgwNTMyMDdaMFYxCzAJBgNVBAYTAlBMMSEwHwYDVQQK
# ExhBc3NlY28gRGF0YSBTeXN0ZW1zIFMuQS4xJDAiBgNVBAMTG0NlcnR1bSBUaW1l
# c3RhbXBpbmcgMjAyMSBDQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
# AOkSHwQ17bldesWmlUG+imV/TnfRbSV102aO2/hhKH9/t4NAoVoipzu0ePujH67y
# 8iwlmWuhqRR4xLeLdPxolEL55CzgUXQaq+Qzr5Zk7ySbNl/GZloFiYwuzwWS2AVg
# LPLCZd5DV8QTF+V57Y6lsdWTrrl5dEeMfsxhkjM2eOXabwfLy6UH2ZHzAv9bS/Sm
# Mo1PobSx+vHWST7c4aiwVRvvJY2dWRYpTipLEu/XqQnqhUngFJtnjExqTokt4Hyz
# Osr2/AYOm8YOcoJQxgvc26+LAfXHiBkbQkBdTfHak4DP3UlYolICZHL+XSzSXlsR
# gqiWD4MypWGU4A13xiHmaRBZowS8FET+QAbMiqBaHDM3Y6wohW07yZ/mw9ZKu/Km
# VIAEBhrXesxifPB+DTyeWNkeCGq4IlgJr/Ecr1px6/1QPtj66yvXl3uauzPPGEXU
# k6vUym6nZyE1IGXI45uGVI7XqvCt99WuD9LNop9Kd1LmzBGGvxucOo0lj1M3IRi8
# FimAX3krunSDguC5HgD75nWcUgdZVjm/R81VmaDPEP25Wj+C1reicY5CPckLGBjH
# QqsJe7jJz1CJXBMUtZs10cVKMEK3n/xD2ku5GFWhx0K6eFwe50xLUIZD9GfT7s/5
# /MyBZ1Ep8Q6H+GMuudDwF0mJitk3G8g6EzZprfMQMc3DAgMBAAGjggFVMIIBUTAP
# BgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBS+VAIvv0Bsc0POrAklTp5DRBru4DAf
# BgNVHSMEGDAWgBS2oVQ5AsOgP46KvPrU+Bym0ToO/TAOBgNVHQ8BAf8EBAMCAQYw
# EwYDVR0lBAwwCgYIKwYBBQUHAwgwMAYDVR0fBCkwJzAloCOgIYYfaHR0cDovL2Ny
# bC5jZXJ0dW0ucGwvY3RuY2EyLmNybDBsBggrBgEFBQcBAQRgMF4wKAYIKwYBBQUH
# MAGGHGh0dHA6Ly9zdWJjYS5vY3NwLWNlcnR1bS5jb20wMgYIKwYBBQUHMAKGJmh0
# dHA6Ly9yZXBvc2l0b3J5LmNlcnR1bS5wbC9jdG5jYTIuY2VyMDkGA1UdIAQyMDAw
# LgYEVR0gADAmMCQGCCsGAQUFBwIBFhhodHRwOi8vd3d3LmNlcnR1bS5wbC9DUFMw
# DQYJKoZIhvcNAQEMBQADggIBALiTWXfJTBX9lAcIoKd6oCzwQZOfARQkt0OmiQ39
# 0yEqMrStHmpfycggfPGlBHdMDDYhHDVTGyvY+WIbdsIWpJ1BNRt9pOrpXe8HMR5s
# Ou71AWOqUqfEIXaHWOEs0UWmVs8mJb4lKclOHV8oSoR0p3GCX2tVO+XF8Qnt7E6f
# bkwZt3/AY/C5KYzFElU7TCeqBLuSagmM0X3Op56EVIMM/xlWRaDgRna0hLQze5mY
# HJGv7UuTCOO3wC1bzeZWdlPJOw5v4U1/AljsNLgWZaGRFuBwdF62t6hOKs86v+jP
# IMqFPwxNJN/ou22DqzpP+7TyYNbDocrThlEN9D2xvvtBXyYqA7jhYY/fW9edUqhZ
# UmkUGM++Mvz9lyT/nBdfaKqM5otK0U5H8hCSL4SGfjOVyBWbbZlUIE8X6XycDBRR
# KEK0q5JTsaZksoKabFAyRKJYgtObwS1UPoDGcmGirwSeGMQTJSh+WR5EXZaEWJVA
# 6ZZPBlGvjgjFYaQ0kLq1OitbmuXZmX7Z70ks9h/elK0A8wOg8oiNVd3o1bb59ms1
# QF4OjZ45rkWfsGuz8ctB9/leCuKzkx5Rt1WAOsXy7E7pws+9k+jrePrZKw2DnmlN
# aT19QgX2I+hFtvhC6uOhj/CgjVEA4q1i1OJzpoAmre7zdEg+kZcFIkrDHgokA5mc
# IMK1MYIHSzCCB0cCAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0
# ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGln
# byBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0EC
# EA5ZOEkd/YQAY+aJApJpNrAwDQYJYIZIAWUDBAIBBQCggYQwGAYKKwYBBAGCNwIB
# DDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEE
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgH6B/zXP31kRX
# rfzqbUB4RSoLzSWm1pJQgOvAN1LYeuMwDQYJKoZIhvcNAQEBBQAEggIALSaw0vKA
# k2eIVnFuXK6sUURBesUtEur6mgr6GkEHAbtKtFDzrMKqzQQA73jo+oKYvzQn70Ff
# uHqplkgQk0DqbTIRnmZQy5UwBcJUdqDA0derT+SvjDXcF+LU8jfy+YlIMq56AU3H
# 83CXLyUnmASS8Dy+WG5IJe/qsrnyT7GNeWs6UeSBKrtmJxCopQUHTO0HU4xE/UI+
# qZGEsMXvjZx1x0W9pUQU03O+aug1WRiqyIHDHoyDuP6bkTUbKdpk+IOhnsZXxmGr
# /6GNkcFIlzCwujuwMXVqQ0eQZ/zb+r6MGKNfyy/zY6S+E74F3daeh2TN+fefQqv3
# JFvs6DcMhETEdkcmkYvte3vois0mx4idliN2sjtxYrZzAqbGkbk2KOPX0ZZv3YT0
# KhOFpE2G1eCmqP55+dtKoSeH8kgqHdef4oGIUFQMiheGzwSPexKl+6Bt0MOtkytH
# 4e1T/rabZQ9t2adcIwntxV0iF8SWeO6txkkMV0sdgL9k6wije/XbrmtGoYs8jWGm
# mncRFwpR62RZivFwqsoG2PUjgP0o1eyP0cEmUp5cGMZdMoYpu3tXVUSlO1LCeVgP
# Q2t6SXN67082B2DOEXpnPKOgv0Z5ZHMwbqNriHXI8GNx48WFDO9qx7xUj/ml8cX7
# ZeKDRqY/Q5Tjn+pZVJ1p7Xqazg7kPMywLMehggQEMIIEAAYJKoZIhvcNAQkGMYID
# 8TCCA+0CAQEwazBWMQswCQYDVQQGEwJQTDEhMB8GA1UEChMYQXNzZWNvIERhdGEg
# U3lzdGVtcyBTLkEuMSQwIgYDVQQDExtDZXJ0dW0gVGltZXN0YW1waW5nIDIwMjEg
# Q0ECEQDxZCWMCbbie+IOMmCOS/SoMA0GCWCGSAFlAwQCAgUAoIIBVzAaBgkqhkiG
# 9w0BCQMxDQYLKoZIhvcNAQkQAQQwHAYJKoZIhvcNAQkFMQ8XDTIxMTEyMTEyMjYy
# NlowNwYLKoZIhvcNAQkQAi8xKDAmMCQwIgQgG1m/6OV3K6z2Q7t5rLSOgVh4TyHF
# VK4TR206Gj4FxdMwPwYJKoZIhvcNAQkEMTIEMP7NHgRsrqkZDoOZuBJE1GUL9tEp
# +ibDJ/h7jkVIFI1P85d5QjX6SEPrPfLYEYt7EjCBoAYLKoZIhvcNAQkQAgwxgZAw
# gY0wgYowgYcEFNMRxpUxG4znP9W1Uxis31mK4ZsTMG8wWqRYMFYxCzAJBgNVBAYT
# AlBMMSEwHwYDVQQKExhBc3NlY28gRGF0YSBTeXN0ZW1zIFMuQS4xJDAiBgNVBAMT
# G0NlcnR1bSBUaW1lc3RhbXBpbmcgMjAyMSBDQQIRAPFkJYwJtuJ74g4yYI5L9Kgw
# DQYJKoZIhvcNAQEBBQAEggIALmMNmIQlDJ8PfeKbtU5VA5c6jG2lbAbW+kQatUQw
# 9BoA1rB7BQcPB1C5hoV493lHW1eouofrSeX5icnLS0wHtkH9vbU4zISLH8pAhxO8
# tfjaptIIIVSK+iUPaK0WgluVDy88zlCkm28VuVyK7+JvAo0eck4rQlIJxBXpnrzH
# GTaLNVcaLmi8a03YYDWpYmxQzr7i7RKrRfpCTojzzhyFGELAVHcJnml0PyNR5tzp
# e+W/EKLR9hXtHZ/cR/gEK6bsjcMrAOrA3iSzsA3P7D3yJMYl+RPhTNWcXMjVG0VA
# BdTWBe1loxqg2PserbAS7VaaW2we24L7hQctooMf7VY6kpfybGHaexhxifFXeNIA
# yRYz/QqwJCLCQ/vncp7WlYboOfR5dsNjsW3PFJV++hLyepP1OuOFoS9tyOUivlPf
# 0fJJHnjVcLixV9YPj/iJlZ/96BP+eaPIEEdoQzv80FktKRUyOdBEFsPrccrPcitd
# hEiwZ0NPOAqZJ+ZD6r6vvMjLU+NJcSm2EsbPiZ8CddzVIYWL18406KTsLTTq5Ghf
# abZVXYrFcnNszxQsNLzaMdEdV6g8D44TcQvTuB8M3t6D7AxJYxUj6IyOhOG5nEk9
# I2jZyzJ1uBAuhrQH/PJrCkVHL9/k8dMqqRHXZjAHcW1/GlgQL8U4G85/+LOw+6XX
# Bxs=
# SIG # End signature block
