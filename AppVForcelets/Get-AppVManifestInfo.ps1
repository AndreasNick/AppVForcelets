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
    
    [Alias()]
    [OutputType('AppxManifestInfo')]
    param( 
      [Parameter( Position=0, Mandatory, ValueFromPipeline)] [System.IO.FileInfo] $Path
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
          $z = $null
          #$null=$z.Close()
          
          #$z.Dispose()

          [System.IO.Compression.ZipArchiveEntry] $appxmanifest = $arc.GetEntry("StreamMap.xml")
          [system.IO.StreamReader] $z = $appxmanifest.Open()
          $appvStreamMapp = $z.ReadToEnd()
          $z = $null
          #$null=$z.Close()
          #$z.Dispose()
          $arc.Dispose()
      
          
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
      $InfoObj = @("Name, Discription, ConfigPath, AppVSchemaVersion, PackageVersion, PackageId, VersionId, OSMinVersion, OSMaxVersionTested, TargetOSes, MaxfileSize, MaxfilePath, FileCount,
      HasShortcuts, Shortcuts, HasFileTypeAssociation, FileTypeAssociation, UncompressedSize,
      ComMode,InProcessEnabled, OutOfProcessEnabled, FullVFSWriteMode, HasApplicationCapabilities, ApplicationCapabilities,
      AppVInProcExt, AssetIntelligence, HasFonts, HasSxSAssemblys, SxSAssemblys, HasComComponents, HasApplications, Applications,
      HasFB1,  HasShellExtensions, HasEnvironmentVariables, EmptyStreamMap, PackageFullLoad,
      HasActiveXComponents, HasUserScripts, UserScripts, HasMachineScripts, MachineScripts, HasBrowserPlugins, HasBrowserHelpObject, 
      ApplicationCapabilitiesEnabled, EnvironmentVariablesEnabled , ShortCutsEnabled, FileTypeAssociationsEnabled, ObjectsEnabled, ObjectsMode,
      ServicesEnabled, HasServices, Services, RegistryEnabled, FileSystemEnabled, FontsEnabled, SoftwareClientsEnabled".replace("`n", "").replace("`r", "").replace(" ", "").split(','))
      
      $AppxInfo = New-Object PSCustomObject
      $InfoObj | ForEach-Object {$AppxInfo | add-member -membertype NoteProperty -name $_ -Value $null }
              
               
      $AppxInfo.MaxfilePath = $maxfileName
      $AppxInfo.MaxfileSize = $maxfileSize
      $AppxInfo.UncompressedSize = $UncompressedSize
      $AppxInfo.FileCount = $fileCount 

      

      $AppxInfo.ConfigPath =  $Path

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
        foreach($block in $appvStreamMapp.StreamMap.FeatureBlock){                             #Hier ist ein Fehler!
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
      $AppxInfo.PackageId = $appxxml.Package.Identity.PackageId
      $AppxInfo.VersionId = $appxxml.Package.Identity.VersionId
      $AppxInfo.PackageVersion = $appxxml.Package.Identity.Version

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

    if ( $AppxInfo.HasFileTypeAssociation) {
      #Array!
      $AppxInfo.HasFileTypeAssociation = $true
      foreach ($sub in @($appxxml.Package.Extensions.ChildNodes)) {
        if ($sub.Category -eq "AppV.FileTypeAssociation") {
          if ($null -ne $sub.FileTypeAssociation.FileExtension.Name) {
            $sk = "" | Select-Object -Property Name, ProcID
            $sk.Name = $sub.FileTypeAssociation.FileExtension.Name
            $sk.ProcID = $sub.FileTypeAssociation.FileExtension.ProgId
          
      
            $null = $AppxInfo.FileTypeAssociation.add($sk) 
          }
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
# MIIVrgYJKoZIhvcNAQcCoIIVnzCCFZsCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUGovLsiR+gg/PDMbvyHnFE1Bl
# LAqgghHmMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0B
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
# SIb3DQEJBDEWBBSm/sXUZsa61iHjhQSHPc4lqxE8fjANBgkqhkiG9w0BAQEFAASC
# AgB6d8uaypvB1Q6B3lClZVfgf7woCuYhJkazMG2Mw5YPoOpf9MQIYjB2M4O7bzSU
# 1yVt9j0pzDFtzA6mvPjA3ChqS0ULIMj5Nb/kiMclDCE4NelkbskwTg/9Zso96dIE
# oABaQE3EpFQhfJXtzzkOdyLoGYGtuH/oLyKrM+YsaQ1M12mt5RTFvWymfXVXMu81
# J9Miz9nvnGzlJzVzTrORFBwBSFliPBW1HiaPxRk6Ex8HNxWE2YkL2NP9yh5OXptk
# lM9iV+Bkqza7tOlfFEsxEu2TAwYAFFQWlhR9m0L5m2UiH3DBaq6K5jXKwFIaS8gG
# 2vqu3eTofy87V7pozoKGaaM6WctX3ugCqnUdKpFhkioVQPzx0F4sGPOhixxIVrOH
# ImWRHY+JWesyRzAZsOZOTBSrkJswrN6YTk6gADKBmok4CN6PuYVB+8pUEOphlyUG
# xwLZZzJN5RUR/RXaA4g39YrDwQjnZ7zzr3Sf8tnVesN6/Nv4EIkDKtSeCuI0L6Lt
# 1PsG/P7FkwSbcbPvKLQsvbD9BtGUecWpanPkCvbz9mcKO+dy9e5km2+SXqoyx0YL
# ctaRXnsrpmwV9GsflLoP44DEkXV11qAt/4ksSuoQUp5nRVfjDsy7MY1/yEriPGIv
# qn5qGxarO6WTbGEAkjGfbwDqgb8ptdcOtJQ46wyMejRZ4w==
# SIG # End signature block
