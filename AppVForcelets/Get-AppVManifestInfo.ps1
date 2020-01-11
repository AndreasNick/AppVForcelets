function Get-AppVManifestInfo{
    <#
        .SYNOPSIS
        Get and anylyse a the AppXanifest.xml inside a App-V Package

        .DESCRIPTION
        Get and anylyse the AppXanifest.xml inside a App-V Package. Supply informations about the package ans skripts

        .PARAMETER Path
        Path to the .appv file

        .EXAMPLE
        Get-AppVManifestInfo -Path paintdotnet.appv

        .NOTES
        Andreas Nick - 2019

        .LINK
        https://www.software-virtualisierung.de
    #>
    
    [CmdletBinding()]
    [Alias()]
    [OutputType('AppxManifestInfo')]
    param( 
      [Parameter( Position=0, Mandatory=$true, ValueFromPipeline=$true)] [System.IO.FileInfo] $Path
    )

    Process
    {
      #CONSTANT
      #Namespaces
      #$NamespaceXmlns = 'http://schemas.microsoft.com/appx/2010/manifest' 
      #$NamespaceAppv = 'http://schemas.microsoft.com/appv/2010/manifest' 
      $NamespaceAppv1_1 = 'http://schemas.microsoft.com/appv/2013/manifest' 
      $NamespaceAppv1_2 = 'http://schemas.microsoft.com/appv/2014/manifest'


      [xml] $appxxml = $NUll
      [xml] $appvStreamMapp = $NUll
      
      $fileCount  = 0
          
      try
      {
        if(Test-Path $Path.FullName){
          [System.IO.Compression.zipArchive] $arc = [System.IO.Compression.ZipFile]::OpenRead($Path.FullName)
          [System.IO.Compression.ZipArchiveEntry]$appxmanifest = $arc.GetEntry("AppxManifest.xml")
      
          $maxfileSize=0
          $maxfileName=""
          $uncompressedSize=0
          $fileCount = $arc.Entries.Count
      
          foreach($file in $arc.Entries){
            if($file.Length -gt $maxfileSize){
              $maxfileSize = $file.Length
              $maxfileName = $file.FullName
            }
            $UncompressedSize += $file.Length
          }
      
          [system.IO.StreamReader]$z = $appxmanifest.Open()
          $appxxml = $z.ReadToEnd()
          $null=$z.Close()
      
          [System.IO.Compression.ZipArchiveEntry] $appxmanifest = $arc.GetEntry("StreamMap.xml")
          [system.IO.StreamReader] $z = $appxmanifest.Open()
          $appvStreamMapp = $z.ReadToEnd()
          $null=$z.Close()
        }
        else {
          Write-Verbose "AppV file not found" 
          throw [System.IO.FileNotFoundException] "$Path not found."
        }
      }
      catch [System.UnauthorizedAccessException]
      {
        [Management.Automation.ErrorRecord]$e = $_

        $info = [PSCustomObject]@{
          Exception = $e.Exception.Message
          Reason    = $e.CategoryInfo.Reason
          Target    = $e.CategoryInfo.TargetName
          Script    = $e.InvocationInfo.ScriptName
          Line      = $e.InvocationInfo.ScriptLineNumber
          Column    = $e.InvocationInfo.OffsetInLine
        }
        return $info
      }

      #$ErrorActionPreference = 'SilentlyContinue'
      #$ErrorActionPreference = 'Continue'
      
      #Create Object
      #AppVInProcExt attribute in Office! #BrowserPlugInsEnabled, Microsoft create a command for disabled PlugIns :-(
      $InfoObj = @("Name, Discription, AppVSchemaVersion, OSMinVersion, OSMaxVersionTested, TargetOSes, MaxfileSize, MaxfilePath, FileCount,
      HasShortcuts, Shortcuts, HasFileTypeAssociation, FileTypeAssociation, UncompressedSize,
      ComMode,InProcessEnabled, OutOfProcessEnabled, FullVFSWriteMode, HasApplicationCapabilities, ApplicationCapabilities,
      AppVInProcExt, AssetIntelligence, HasFonts, HasSxSAssemblys, SxSAssemblys, HasComComponents, HasApplications, Applications,
      HasFB1,  HasShellExtensions, HasEnvironmentVariables, EmptyStreamMap, PackageFullLoad,
      HasActiveXComponents, HasUserScripts, UserScripts, HasMachineScripts, MachineScripts, HasBrowserPlugins, HasBrowserHelpObject, 
      ApplicationCapabilitiesEnabled, EnvironmentVariablesEnabled , ShortCutsEnabled, FileTypeAssociationsEnabled, ObjectsEnabled, ObjectsMode,
      ServicesEnabled, HasServices, Services, RegistryEnabled, FileSystemEnabled, FontsEnabled, SoftwareClientsEnabled".replace("`n", "").replace("`r", "").replace(" ", "").split(','))
      
      $AppxInfo = New-Object PSCustomObject
      $InfoObj | ForEach-Object {$AppxInfo | add-member –membertype NoteProperty –name $_ -Value $null }
              
               
      $AppxInfo.MaxfilePath = $maxfileName
      $AppxInfo.MaxfileSize = $maxfileSize
      $AppxInfo.UncompressedSize = $UncompressedSize
      $AppxInfo.FileCount = $fileCount 

      #Test for Schema
      $Namespaces = @($appxxml.SelectNodes('//namespace::*[not(. = ../../namespace::*)]'))
      $AppxInfo.AppVSchemaVersion = 1

      if($Namespaces.'#Text'.Contains($NamespaceAppv1_1)){
        $AppxInfo.AppVSchemaVersion = 2
      } 

      if($Namespaces.'#Text'.Contains($NamespaceAppv1_2)){
        $AppxInfo.AppVSchemaVersion = 3
      }
   

      #Test for FeatureBlock 1
      $AppxInfo.EmptyStreamMap = $false
      $AppxInfo.PackageFullLoad = $false
      if(($null -ne $appvStreamMapp.StreamMap.FeatureBlock) -and ($appvStreamMapp.StreamMap.FeatureBlock.Id.Contains("PrimaryFeatureBlock"))){
        $AppxInfo.HasFB1 = $true
        foreach($block in $appvStreamMapp.StreamMap.FeatureBlock){
          if($appvStreamMapp.StreamMap.FeatureBlock.GetAttribute("LoadAll") -eq $true){
            $AppxInfo.PackageFullLoad = $true
          }
        }
    
      } else {
        $AppxInfo.HasFB1 = $false
        if($null -eq $appvStreamMapp.StreamMap.FeatureBlock){
          $AppxInfo.EmptyStreamMap = $true
        }
      }
    
      #Basedata
      $AppxInfo.OSMinVersion = $appxxml.Package.Prerequisites.OSMinVersion
      $AppxInfo.OSMaxVersionTested = $appxxml.Package.Prerequisites.OSMaxVersionTested
      $AppxInfo.TargetOSes = $appxxml.Package.Prerequisites.TargetOSes
      $AppxInfo.Discription = $appxxml.Package.Properties.AppVPackageDescription

      #Shortcuts 
      $AppxInfo.HasShortcuts = ([string]($appxxml.Package.Extensions.Extension.Shortcut)).trim().Length -gt 0
      $AppxInfo.Shortcuts = New-Object System.Collections.ArrayList
      
      if($AppxInfo.HasShortcuts ){

        foreach($sub in @($appxxml.Package.Extensions.ChildNodes)){
          if($sub.Category -eq "AppV.Shortcut"){
            $sk = "" | Select-Object -Property Icon, Target, File, Arguments
            $sk.Icon = $sub.shortcut.Icon
            $sk.File = $sub.shortcut.File
            $sk.Arguments = $sub.shortcut.Arguments
            $sk.Target = $sub.shortcut.Target
            $null = $AppxInfo.Shortcuts.add($sk)
          }
        }
      }
     
     #Objects
     
       if($null -ne $appxxml.Package.Extensions.Extension.Objects.NotIsolate){
         $AppxInfo.ObjectsMode = "NotIsolate"
       } else {
        $AppxInfo.ObjectsMode = "Isolate"
       }


      #FileTypeAssosinations
      $AppxInfo.HasFileTypeAssociation = ([string]($appxxml.Package.Extensions.Extension.FileTypeAssociation)).trim().Length -gt 0
      $AppxInfo.FileTypeAssociation = New-Object System.Collections.ArrayList

      if( $AppxInfo.HasFileTypeAssociation){ #Array!
        $AppxInfo.HasFileTypeAssociation = $true
        foreach($sub in @($appxxml.Package.Extensions.ChildNodes)){
          if($sub.Category -eq "AppV.FileTypeAssociation"){
        
            $sk = "" | Select-Object -Property Name, ProcID
            $sk.Name = $sub.FileTypeAssociation.FileExtension.Name
            $sk.ProcID = $sub.FileTypeAssociation.FileExtension.ProgId
      
            $null = $AppxInfo.FileTypeAssociation.add($sk) 
          }
        }
      }

      #Services
      $AppxInfo.HasServices = ([string]($appxxml.Package.Extensions.Extension.Service)).trim().Length -gt 0
      $AppxInfo.Services = New-Object System.Collections.ArrayList
      if($AppxInfo.HasServices){
        $AppxInfo.HasServices = $true
        foreach($sub in @($appxxml.Package.Extensions.ChildNodes)){
          if($sub.Category -eq "AppV.Service"){
            $serObj = "" | Select-Object -Property Name,DisplayName,Description,ImagePath,StartType,ServiceType,ObjectName
            $serObj.Name = $sub.Service.Name
            $serObj.DisplayName = $sub.Service.DisplayName
            $serObj.Description =$sub.Service.Description
            $serObj.ImagePath =$sub.Service.ImagePath
            $serObj.StartType =$sub.Service.StartType
            $serObj.ServiceType =$sub.Service.ServiceType
            $serObj.ObjectName =$sub.Service.ObjectName
            $null = $AppxInfo.Services.Add($serObj)
          }
        }
        $AppxInfo.HasServices = $true
        

      }
      
      #Applications
      $AppxInfo.HasApplications = $false
      $AppxInfo.Applications = New-Object System.Collections.ArrayList

         
      if($null -ne $appxxml.Package.Extensions.Extension.Shortcut){
        $AppxInfo.HasShortcuts = $true
        $AppxInfo.HasApplications = $true
      
        foreach($sub in @($appxxml.Package.Applications.ChildNodes)){
          $sk = "" | Select-Object -Property Icon, Target
          #Generate Application ID Entry
          $sk = "" | Select-Object -Property Name, ID
          $sk.Name = $Sub.VisualElements.Name
          $sk.ID = $sub.Target
          $null = $AppxInfo.Applications.add($sk)
        }
      } 

      #Test for Fonts
      $AppxInfo.HasFonts = ([string]($appxxml.Package.Extensions.Extension.Fonts)).trim().Length -gt 0
  
      #HasComCOmponents?
      $AppxInfo.HasComComponents = ([string]($appxxml.Package.Extensions.Extension.com)).trim().Length -gt 0
      $AppxInfo.Name = $appxxml.package.Properties.DisplayName

      #ActiveX
      $AppxInfo.HasActiveXComponents = ([string]($appxxml.Package.Extensions.Extension.ActiveX.registration)).trim().Length -gt 0

      #BrowserPlugIns
      $AppxInfo.HasBrowserPlugins = ([string]($appxxml.Package.Extensions.Extension.BrowserPlugin)).trim().Length -gt 0
      #BrowerHelpObjects
      if($AppxInfo.HasBrowserPlugins) {
        $AppxInfo.HasBrowserHelpObject =  $appxxml.Package.Extensions.Extension.BrowserPlugin.subcategory.Contains("BrowserHelperObject")
      } else { $AppxInfo.HasBrowserHelpObject  = $false}
  
      $AppxInfo.FullVFSWriteMode = Get-FalseOrTrue -value $appxxml.Package.Properties.FullVFSWriteMode 
      $AppxInfo.AppVInProcExt = Get-FalseOrTrue -value $appxxml.Package.Properties.AppVInProcExt
  
      #ComMode
      $AppxInfo.ComMode = "Isolated"
      $AppxInfo.InProcessEnabled = $true
      $AppxInfo.OutOfProcessEnabled = $false
    
      #Maybe empty
      if(($null -ne $appxxml.Package.ExtensionsConfiguration) -and ($null -ne $appxxml.Package.ExtensionsConfiguration.COM)){
        $AppxInfo.ComMode = $appxxml.Package.ExtensionsConfiguration.COM.Mode
        $AppxInfo.InProcessEnabled = $appxxml.Package.ExtensionsConfiguration.COM.IntegratedCOMAttributes.InProcessEnabled
        $AppxInfo.OutOfProcessEnabled = $appxxml.Package.ExtensionsConfiguration.COM.IntegratedCOMAttributes.OutOfProcessEnabled
      }

      #AssetIntelligence
      $AppxInfo.AssetIntelligence = @()
      
  
      $AppAssets = New-Object PSObject
      foreach($asset in  $appxxml.Package.AssetIntelligence.childNodes ){
        $AppAssets = New-Object PSObject
  
        foreach($item in @("SoftwareCode", "ProductName", "ProductVersion", "Publisher", "ProductID", "Language", "ChannelCode", "InstallDate","RegisteredUser","InstalledLocation","CM_DSLID","VersionMajor","VersionMinor","ServicePack","UpgradeCode","OsComponent" )){
      
          $AppAssets | Add-Member -MemberType NoteProperty -Name $item -Value $($asset."$Item")
        }
        $AppxInfo.AssetIntelligence += $AppAssets
      }
  
      #Assemblies
      $AppxInfo.HasSxSAssemblys =  ([string]($appxxml.Package.Extensions.Extension.SxSAssembly)).trim().Length -gt 0
      $AppxInfo.SxSAssemblys = New-Object System.Collections.ArrayList 

      #Test for Assemblies
      if($AppxInfo.HasSxSAssemblys){

        $AppxInfo.SxSAssemblys = @($appxxml.Package.Extensions.Extension.SxSAssembly.Name)
     
      } else {
        $AppxInfo.HasSxSAssemblys= $false
      }
 
 

      #ApplicationCapabilities with CapabilitiesWow64 hive
      $AppxInfo.ApplicationCapabilities = new-Object System.Collections.ArrayList
      $capBase = $appxxml.Package.Extensions.Extension.ApplicationCapabilities.CapabilityGroup.Capabilities.FileAssociationList
      if($null -eq $capBase){
        $capBase = $appxxml.Package.Extensions.Extension.ApplicationCapabilities.CapabilityGroup.CapabilitiesWOW64.FileAssociationList
      }
   
      #Test for ApplicationCapabilities  - or CapabilitiesWow64
      if($null -ne $capBase){
   
        $AppxInfo.HasApplicationCapabilities = $true
        foreach($item in $capBase.FileAssociation){
          $sk = "" | Select-Object -Property Name, ProcID
          $sk.Name = $Item.Extension
          $sk.ProcID = $Item.ProgId
      
          $null = $AppxInfo.ApplicationCapabilities.add($sk)
        } 
     
      } else {
      
        $AppxInfo.HasApplicationCapabilities = $false
      }   
     
      #Test for Environment
      $AppxInfo.HasEnvironmentVariables =  ([string]($appxxml.Package.Extensions.Extension.EnvironmentVariables)).trim().Length -gt 0

      #Test for ShellExtensions
      $AppxInfo.HasShellExtensions = ([string]($appxxml.Package.Extensions.Extension.ShellExtension)).trim().Length -gt 0

      #UserScripts
      $AppxInfo.HasUserScripts = $false
   
      $UserScriptConstants = @('StartProcess','ExitProcess','StartVirtualEnvironment','TerminateVirtualEnvironment','PublishPackage','UnpublishPackage')
      $AppxInfo.UserScripts = New-Object System.Collections.ArrayList
      $AppxInfo.HasUserScripts=$false

      foreach($sc in  $appxxml.Package.UserScripts){
        $AppxInfo.HasUserScripts=$true
        foreach($type in $UserScriptConstants){
          if($null -ne $sc.$type){

            $sk = "" | Select-Object -Property Path, ApplicationId, Trigger
            $sk.Trigger = $type
            $sk.Path = $sc.$type.Path
            $sk.ApplicationID = $sc.$type.ApplicationID
            $null = $AppxInfo.UserScripts.add($sk)
          }
        }

      }
    
      #MachineScripts
      $AppxInfo.HasMachineScripts = $false
      $UserScriptConstants = @('PublishPackage','UnpublishPackage','AddPackage','RemovePackage')
      $AppxInfo.MachineScripts = New-Object System.Collections.ArrayList
      $AppxInfo.HasMachineScripts=$false

      foreach($sc in  $appxxml.Package.MachineScripts){
        $AppxInfo.HasMachineScripts=$true
        foreach($type in $UserScriptConstants){
          if($null -ne $sc.$type){

            $sk = "" | Select-Object -Property Path, ApplicationId, Trigger
            $sk.Trigger = $type
            $sk.Path = $sc.$type.Path
            $sk.ApplicationID = $sc.$type.ApplicationID
            $null = $AppxInfo.MachineScripts.add($sk)
          }
        }

      }

      #Subsystems Extension configuration
    
      $AppxInfo.ApplicationCapabilitiesEnabled = $true 
      $AppxInfo.EnvironmentVariablesEnabled = $true 
      $AppxInfo.ShortCutsEnabled = $true
      $AppxInfo.FileTypeAssociationsEnabled = $true
      $AppxInfo.ObjectsEnabled = $true
      $AppxInfo.ServicesEnabled = $true
      $AppxInfo.RegistryEnabled = $true
      $AppxInfo.FileSystemEnabled = $true
      $AppxInfo.FontsEnabled = $true
      $AppxInfo.SoftwareClientsEnabled = $true
    
      if($appxxml.Package.ExtensionsConfiguration.ApplicationCapabilities.Enabled  -eq $false){ $AppxInfo.ApplicationCapabilitiesEnabled = $false }  
      if($appxxml.Package.ExtensionsConfiguration.EnvironmentVariables.Enabled  -eq $false){ $AppxInfo.EnvironmentVariablesEnabledEnabled = $false }  
      if($appxxml.Package.ExtensionsConfiguration.ShortCuts.Enabled  -eq $false){ $AppxInfo.ShortCutsEnabled = $false }  
      if($appxxml.Package.ExtensionsConfiguration.FileTypeAssociations.Enabled  -eq $false){ $AppxInfo.ileTypeAssociationsEnabled = $false }  
      if($appxxml.Package.ExtensionsConfiguration.Objects.Enabled  -eq $false){ $AppxInfo.ObjectsEnabled = $false }  
      if($appxxml.Package.ExtensionsConfiguration.Services.Enabled  -eq $false){ $AppxInfo.ServicesEnabled = $false }  
      if($appxxml.Package.ExtensionsConfiguration.Registry.Enabled  -eq $false){ $AppxInfo.RegistryEnabled = $false }     
      if($appxxml.Package.ExtensionsConfiguration.FileSystem.Enabled  -eq $false){ $AppxInfo.FileSystemEnabled = $false }     
      if($appxxml.Package.ExtensionsConfiguration.Fonts.Enabled  -eq $false){ $AppxInfo.FontsEnabled = $false }     
      if($appxxml.Package.ExtensionsConfiguration.SoftwareClients.Enabled  -eq $false){ $AppxInfo.SoftwareClientsEnabled = $false }     
    
  
      return $AppxInfo
    }
      
  }
# SIG # Begin signature block
# MIIetQYJKoZIhvcNAQcCoIIepjCCHqICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUno9SUtph2Ic7qGFvLpQ3Sh+H
# Qpugghm/MIIEhDCCA2ygAwIBAgIQQhrylAmEGR9SCkvGJCanSzANBgkqhkiG9w0B
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
# CQQxFgQUczX7UW+w920ToTlUUn5XPVpnREAwDQYJKoZIhvcNAQEBBQAEggEAQ40k
# t89SlvOY706oH57hrok4s4/HsMdmMZ+t7mL2Uvzpen/SB7v1GDV/lffyntp75bjZ
# PQ8jIEkYNMD+AwgjtkkIaW87ddlL3/aeq9APhrHs/mBYKAeiI2g3LoDPu4aDKxtA
# SBccPWMoJwyDvmF+c8AV5ewRsSewSiC2qx7/Jvqy5HGz4ZlVKtKK/wCysFIuAops
# IZHByUvO6KKppZaDjiDuDF+h/B/sR/GoS/T9w+S26uStWRnWog9HCSsefPSGrrxO
# MUgN7LGr6eE0hBg6KRVC8FQxAjlJ46I5dNF2KB5ewkQcQuy7vDuCqzPY7UtSeDLS
# gxjZv1HrLEwgYnQWgKGCAigwggIkBgkqhkiG9w0BCQYxggIVMIICEQIBATCBjjB6
# MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
# VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDEgMB4GA1UE
# AxMXQ09NT0RPIFRpbWUgU3RhbXBpbmcgQ0ECECtz23RjEUxaWzJK8jBXckkwCQYF
# Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
# MQ8XDTIwMDExMTE2MDQyMlowIwYJKoZIhvcNAQkEMRYEFAPEN96KS0QOyCHafwpm
# OshPb1mnMA0GCSqGSIb3DQEBAQUABIIBADhTtNsSun0pKqXJ3RqIdOLvOnCKmXGu
# QTQyxnRXA9svw526y++Slhwxyj7Rm6DyoPwliaRpPV4ZCme64AB/5UyJzwNwRPqA
# zQjvMOT75cNjzva0ROvw+a9cOW9JLRDCD27v5sEIE3nnaAb4w2wdSvs05dRE56LC
# g0Kq4qNIQZyXOQahDthynWCKdEVdjhwMY+bXXvUFtPDJ25kB6PpVuTB1vdI7t+kZ
# 6uKz4wRcVEKQlkHSusl6Qw3BlDxEv9dduGnWzqoXne68zSBSGYwafzg/s8ENQqJU
# urYuVhKbnjgDzxxLTe7MDY4RnnqU+WuI2FAu3pokL9NkHcKhMrfEsd4=
# SIG # End signature block
