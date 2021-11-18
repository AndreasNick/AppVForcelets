
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
# MIIVrgYJKoZIhvcNAQcCoIIVnzCCFZsCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUiep5ybT0F7FFicryfmmb0Jfi
# C7agghHmMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0B
# AQwFADB7MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVy
# MRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEh
# MB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTE5MDMxMjAwMDAw
# MFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcg
# SmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJU
# UlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRp
# b24gQXV0aG9yaXR5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJl
# FzYOw9sIs9CsVw127c0n00ytUINh4qogTQktZAnczomfzD2p7PbPwdzx07HWezco
# EStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i6HTJGLSR1GJk23+j
# BvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1RjjWm
# p2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2u
# TIq3XJq0tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnH
# a4xgk97Exwzf4TKuzJM7UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWax
# KXwyhGNVicQNwZNUMBkTrNN9N6frXTpsNVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjN
# hLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LTTLPtW//e5XOsIzstAL81
# VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAfV1SoPv10
# Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrW
# X1Uu6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSME
# GDAWgBSgEQojPpbxB+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHY
# m8Cd8rIDZsswDgYDVR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0g
# BAowCDAGBgRVHSAAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwuY29tb2Rv
# Y2EuY29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMuY3JsMDQGCCsGAQUFBwEBBCgw
# JjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3
# DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+c
# li3vA0p+rvSNb3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCR
# lv79Q2R+/czSAaF9ffgZGclCKxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHx
# W/BBC5gACiIDEOUMsfnNkjcZ7Tvx5Dq2+UUTJnWvu6rvP3t3O9LEApE9GQDTF1w5
# 2z97GA1FzZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBzJ0RHfxBdiSprhTEU
# xOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIF9TCCA92gAwIBAgIQHaJIMG+b
# JhjQguCWfTPTajANBgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVU
# aGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2Vy
# dGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1
# OTU5WjB8MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
# MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJDAi
# BgNVBAMTG1NlY3RpZ28gUlNBIENvZGUgU2lnbmluZyBDQTCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBAIYijTKFehifSfCWL2MIHi3cfJ8Uz+MmtiVmKUCG
# VEZ0MWLFEO2yhyemmcuVMMBW9aR1xqkOUGKlUZEQauBLYq798PgYrKf/7i4zIPoM
# GYmobHutAMNhodxpZW0fbieW15dRhqb0J+V8aouVHltg1X7XFpKcAC9o95ftanK+
# ODtj3o+/bkxBXRIgCFnoOc2P0tbPBrRXBbZOoT5Xax+YvMRi1hsLjcdmG0qfnYHE
# ckC14l/vC0X/o84Xpi1VsLewvFRqnbyNVlPG8Lp5UEks9wO5/i9lNfIi6iwHr0bZ
# +UYc3Ix8cSjz/qfGFN1VkW6KEQ3fBiSVfQ+noXw62oY1YdMCAwEAAaOCAWQwggFg
# MB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQO4Tqo
# Uzox1Yq+wbutZxoDha00DjAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB
# /wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAwYIKwYBBQUHAwgwEQYDVR0gBAowCDAG
# BgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNv
# bS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEF
# BQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9V
# U0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29j
# c3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEATWNQ7Uc0SmGk295q
# Koyb8QAAHh1iezrXMsL2s+Bjs/thAIiaG20QBwRPvrjqiXgi6w9G7PNGXkBGiRL0
# C3danCpBOvzW9Ovn9xWVM8Ohgyi33i/klPeFM4MtSkBIv5rCT0qxjyT0s4E307dk
# sKYjalloUkJf/wTr4XRleQj1qZPea3FAmZa6ePG5yOLDCBaxq2NayBWAbXReSnV+
# pbjDbLXP30p5h1zHQE1jNfYw08+1Cg4LBH+gS667o6XQhACTPlNdNKUANWlsvp8g
# JRANGftQkGG+OY96jk32nw4e/gdREmaDJhlIlc5KycF/8zoFm/lv34h/wCOe0h5D
# ekUxwZxNqfBZslkZ6GqNKQQCd3xLS81wvjqyVVp4Pry7bwMQJXcVNIr5NsxDkuS6
# T/FikyglVyn7URnHoSVAaoRXxrKdsbwcCtp8Z359LukoTBh+xHsxQXGaSynsCz1X
# UNLK3f2eBVHlRHjdAd6xdZgNVCT98E7j4viDvXK6yz067vBeF5Jobchh+abxKgoL
# pbn0nu6YMgWFnuv5gynTxix9vTp3Los3QqBqgu07SqqUEKThDfgXxbZaeTMYkuO1
# dfih6Y4KJR7kHvGfWocj/5+kUZ77OYARzdu1xKeogG/lU9Tg46LC0lsa+jImLWpX
# cBw8pFguo/NbSwfcMlnzh6cabVgwggZkMIIFTKADAgECAhAOWThJHf2EAGPmiQKS
# aTawMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVh
# dGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3Rp
# Z28gTGltaXRlZDEkMCIGA1UEAxMbU2VjdGlnbyBSU0EgQ29kZSBTaWduaW5nIENB
# MB4XDTIwMDgxNzAwMDAwMFoXDTIzMDgxNzIzNTk1OVowga0xCzAJBgNVBAYTAkRF
# MQ4wDAYDVQQRDAUzMDUzOTEWMBQGA1UECAwNTmllZGVyc2FjaHNlbjERMA8GA1UE
# BwwISGFubm92ZXIxEzARBgNVBAkMCkRyaWJ1c2NoIDIxJjAkBgNVBAoMHU5pY2sg
# SW5mb3JtYXRpb25zdGVjaG5payBHbWJIMSYwJAYDVQQDDB1OaWNrIEluZm9ybWF0
# aW9uc3RlY2huaWsgR21iSDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
# ANperdsEZyxEKnjFFen+7kV+EfL5NpZUz6Yl4YhkpYYPRHf7z9yBWGvc0cjVlcB4
# Zr9AhqcVPns5EqUjT7TCOJxuGjScN+6vTt1KOxrgOjMlvoUztKrKbOsGsdhL5OhU
# ANOZ2vwOvc0lQM1cMCQsW//iVnsu1noYiC1ju42tTD9yciIiSIC3kfL1mJKBFzW3
# Y0t7tdNyIES5RtmE0KeqaHJBtbA3sbubY1BB/TxTWVTXNjr2HuvsbNuyTUd84C3H
# Hgoed7hrSWv07fZvvDF51Nnn/wZrRU2wtHE/HJfZ+btgctI5PQsxmInBoxPTgL5i
# MuKzfU6Vk04vymc3a6ABXuXfUSUB5OcPZCnan5V8Qa0nK2l+KCD3aW+ZqvZax+F0
# I/ij1MFxtqFgLqKaebOlri8R9Wv3hOhkfGoDD+DNizhQDeznJDQES3c1Bu6FgKl7
# LRdVfaM/qwSq6s817gbOcPGuOe4zkue4vBzrzvKfPceptxtCIgNF/3fQxSick1Gn
# tuhPCzW8i7OFUoDK4PY6jdZtP3tjb3oJQym0Fjs0p1g1BMLU4d31FD+KGeNOO37n
# 8KzVPPm0FZf5zSd/3NeRRZy0fI4ZCJvJMJQguSrMeTjxfLFnTR5m6Na0SBUBLsXd
# ozdWvwhZdxJNt4tYkPLUZUQLR7oSFXOR25ZWm7Wdf8GlAgMBAAGjggGuMIIBqjAf
# BgNVHSMEGDAWgBQO4TqoUzox1Yq+wbutZxoDha00DjAdBgNVHQ4EFgQUq0Q7xQIR
# CzrWxe5EAkrwXkJJi9owDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAwEwYD
# VR0lBAwwCgYIKwYBBQUHAwMwEQYJYIZIAYb4QgEBBAQDAgQQMEoGA1UdIARDMEEw
# NQYMKwYBBAGyMQECAQMCMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5j
# b20vQ1BTMAgGBmeBDAEEATBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnNl
# Y3RpZ28uY29tL1NlY3RpZ29SU0FDb2RlU2lnbmluZ0NBLmNybDBzBggrBgEFBQcB
# AQRnMGUwPgYIKwYBBQUHMAKGMmh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGln
# b1JTQUNvZGVTaWduaW5nQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5z
# ZWN0aWdvLmNvbTAcBgNVHREEFTATgRFhLm5pY2tAbmljay1pdC5kZTANBgkqhkiG
# 9w0BAQsFAAOCAQEAC6KzO/xsS5EkS5KLY873pwHamFGMpOzIEHeoAiqpX7LMy8Gu
# 41Rznsou/ZQGjYS9HpgezYk4kk5AoNGY/+ObcnSIvNFOr7EkYwZt+uTejdzgbY8g
# hDmhdm3XpfjqO+DjJe6xtf8Qfies7bnXhcKvNFTvycIPjikVvxF/tbfFzx9iRqzO
# XCgznnMR2e+VbK6vjZJeMgR0KaHRmXOfXt/jX7cJt1j0TateKpECeFxawKA8fmle
# ZBw2KVXEI+0lDmuxk4oRRkLdH0nUv06mqicgsfwUFbCkU26tgGJemGdmtf5VcVM9
# 03K/4xJkkhuOlwMA1e9XU/is0kSk/KW1G9msvDGCAzIwggMuAgEBMIGQMHwxCzAJ
# BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcT
# B1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDEkMCIGA1UEAxMbU2Vj
# dGlnbyBSU0EgQ29kZSBTaWduaW5nIENBAhAOWThJHf2EAGPmiQKSaTawMAkGBSsO
# AwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEM
# BgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqG
# SIb3DQEJBDEWBBRS2T0SoYaQb75QNLDDEl5I7flPcTANBgkqhkiG9w0BAQEFAASC
# AgAXyJNujgsMtrPrY3U9I5wlOMm+W+/ylMGn6ADAOjHqyLatnuBtQkDN2bodoA1r
# u0uv8GHNv+WtRGO+tOFAVCbiWziGY7bpBx2aR9tgxU0vTzQOEHXZh1lwr+281lZy
# ZKCBLrbfT0pKXY5kNY4MRXqwGORytQJhXerj8OLw7cFocWmVSooSPdNLS0c68qbs
# vOVe5hl7xf5MRrvC6CZcHVs4bIgLUlAeZzGGMUHmmh0t6Im5SFN0HPEMgyzMbuEo
# hKmRxfLcctXKEMaAP8q4bSt02IakjXTXD/7V9JzVFt4wgELAFL+Ammcd/vc79xaS
# TGmHf1Gz3Nu2TsjuIAg8t0scO26cG6qiz2MmSAO6BDzvMxclzj7w7/br6Hn+5WB8
# GjQhjcLY5zsF9DwDCw+5MKn23wr6SNhUtotX/AgaGKwBS/VLCGNSxuUZa+t4KxZe
# ID024jE+c6d9ZVeZF3GnOMgZt6jSZ3XbdcrEQjKXuv/mOCS28SXUxhojjfh8se5Z
# iNnZn5ofD8Au7DDMZEVT35s6ZY7nNFOWWrKviydu0TMwVRHGKVes1H0OshIS1ljf
# cJd39dPkpEroRV+NHrTI8CB9Z7FuC4mFUA8pZMwSIp3nmjtXajjEK1VnN4x5S2L7
# 1hir3t7XWD5EbdNnjVXLZ4aLN9rJD4e9250C5N12VD3lEA==
# SIG # End signature block
