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