function Get-AppVConfigUserPart{
    param( 
      [Parameter(Position=0, Mandatory=$true)] $AppxInfo,
      [Parameter(Position=1, Mandatory=$true)] [System.Xml.XmlLinkedNode] $Appxxml,
      [ValidateSet('DeploymentConfiguration','UserConfiguration')] [String] $ConfigFileType
    )
  
    process{
      [System.Xml.XmlLinkedNode] $appxxml = $NUll
      [xml] $appvStreamMapp = $NUll

      #$ErrorActionPreference = 'SilentlyContinue'
      $ErrorActionPreference = 'Continue'
  

      if($ConfigFileType -eq "DeploymentConfiguration"){
        $ConfString = '//ns:'+$ConfigFileType+'/ns:UserConfiguration/'
      } else {
        $ConfString = '//ns:'+$ConfigFileType+'/'
      }
  
  
      #Select all Shortcuts
      $Shortcuts = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:Shortcuts/ns:Extensions',$ns)
      $AppxInfo.HasShortcuts = $false
  
      $AppxInfo.Shortcuts = New-Object System.Collections.ArrayList
      
      if($Shortcuts.Count -gt 0){

        $AppxInfo.HasShortcuts = $true
        $AppxInfo.ShortcutsEnabled = $true
        if($null -ne $Base.SelectNodes($ConfString+'ns:Subsystems/ns:Shortcuts',$ns).Enabled) #sometimes missing in Serverconfig!
        {
          $AppxInfo.ShortcutsEnabled =  "true" -eq  $Base.SelectNodes($ConfString+'ns:Subsystems/ns:Shortcuts',$ns).Enabled
        }
        
    
        Foreach($Item in  $Shortcuts.Extension){
          $sk = "" | Select-Object -Property Icon, Target, File, Arguments
          $sk.Icon = $Item.Shortcut.Icon
          $sk.Target = $Item.Shortcut.Target
          $sk.File = $Item.shortcut.File
          $sk.Arguments = $Item.shortcut.Arguments
      
          $result = $AppxInfo.Shortcuts.add($sk)
        }
    
      }
  
      #FileTypeAssociation
      $fta = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:FileTypeAssociations/ns:Extensions',$ns)
      $AppxInfo.HasFileTypeAssociation = $false
      $AppxInfo.FileTypeAssociation = New-Object System.Collections.ArrayList
      if($fta.Count -gt 0){

        $AppxInfo.HasFileTypeAssociation= $true
        $AppxInfo.FileTypeAssociationEnabled = "true" -eq $Base.SelectNodes($ConfString+'ns:Subsystems/ns:FileTypeAssociations',$ns).Enabled
    
        Foreach($Item in  $fta.Extension){
          $sk = "" | Select-Object -Property Name, ProcID
          $sk.Name = $Item.FileTypeAssociation.FileExtension.Name
          $sk.ProcID = $Item.FileTypeAssociation.FileExtension.ProgId
      
          $result = $AppxInfo.FileTypeAssociation.add($sk) 
        }
      }
  
      #URL Protokoll
      $url = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:URLProtocols/ns:Extensions',$ns)
     
      if($url.Count -gt 0){
        $AppxInfo.HasURLProtocols = $true
      } else {
        $AppxInfo.HasURLProtocols = $false
      }
  
      #
      
      $com = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:COM',$ns)
      $com = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:COM',$ns)
  
      if($com.Count -gt 0){
        $AppxInfo.ComMode = $com.Mode
        $AppxInfo.InProcessEnabled = $com.IntegratedCOMAttributes.InProcessEnabled
        $AppxInfo.OutOfProcessEnabled = $com.IntegratedCOMAttributes.OutOfProcessEnabled
      } else {
        $AppxInfo.ComMode = "NotDefined"
        $AppxInfo.InProcessEnabled = "NotDefined"
        $AppxInfo.OutOfProcessEnabled = "NotDefined"
      }
  
      #Objects
      $objects = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:Objects',$ns)
     
      if($objects.Count -gt 0){
 
        $AppxInfo.ObjectsEnabled = "true" -eq $objects.Enabled
    
      } else {

        $AppxInfo.ObjectsEnabled = "NotDefined"
      }
      
   
      #Registry
      $Reg = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:Registry',$ns)
    
      $AppXInfo.HasRegistrySettings = "NotDefined"
      $AppXInfo.RegistryEnabled =  "NotDefined"
   
      if($Reg.Count -gt 0){
 
        $AppxInfo.RegistryEnabled = "true" -eq $Reg.Enabled
        $AppxInfo.HasRegistrySettings = ($Base.SelectNodes($ConfString+'ns:Subsystems/ns:Registry/ns:Include',$ns).count -gt 0) -or ($Base.SelectNodes($ConfString+'ns:Subsystems/ns:Registry/ns:Delete',$ns).count -gt 0)
    
      }   

      #FileSystem
      $fileSystem = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:FileSystem',$ns)
      $AppxInfo.FileSystemEnabled =  "NotDefined"
      if( $fileSystem.Count -gt 0){
 
        $AppxInfo.FileSystemEnabled = "true" -eq  $fileSystem.Enabled
    
      }
    
      #Fonts
      $Fonts = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:Fonts',$ns)
      $AppxInfo.FontsEnabled =  "NotDefined"
      if($Fonts.Count -gt 0){
        $AppxInfo.FontsEnabled = "true" -eq  $Fonts.Enabled
      }
  
      #EnvironmentVariables
      $env = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:EnvironmentVariables',$ns)
      $AppXInfo.HasEnvironmentVariables =  "NotDefined"
      $AppXInfo.EnvironmentVariablesEnabled =  "NotDefined"
      if($env.Count -gt 0){
        $AppxInfo.EnvironmentVariablesEnabled = "true" -eq $Reg.Enabled
        $AppxInfo.HasEnvironmentVariables = ($Base.SelectNodes($ConfString+'ns:Subsystems/ns:EnvironmentVariables/ns:Include',$ns).count -gt 0) -or ($Base.SelectNodes($ConfString+'ns:Subsystems/ns:EnvironmentVariables/ns:Delete',$ns).count -gt 0)
      }  
  
      #Services   
   
      $Services = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:Services',$ns)
      #Count = 0 not found ! default is enabled
      $AppxInfo.ServicesEnabled =  "NotDefined"

      if($Services.Count -gt 0){
        $AppxInfo.ServicesEnabled = "true" -eq  $Services.Enabled
      }  
  
      #Applications
      $apps = $Base.SelectNodes($ConfString+'ns:Applications',$ns)
      $AppxInfo.HasApplications = "NotDefined"
      $AppxInfo.Applications = New-Object System.Collections.ArrayList
  
      if($apps.Count -gt 0){
      
        $AppxInfo.HasApplications = $true
    
        Foreach($Item in  $apps.Application){
          $sk = "" | Select-Object -Property Name, ID
          $sk.Name = $Item.VisualElements.Name
          $sk.ID = $Item.Id
      
          $result = $AppxInfo.Applications.add($sk)
        }
      }
  
      #UserScripts
      $userScripts = $Base.SelectNodes($ConfString+'ns:UserScripts',$ns)
  
      $AppxInfo.HasUserScripts = $false
      $AppxInfo.UserScripts = New-Object System.Collections.ArrayList
      if($userScripts.Count -gt 0){
        $UserScriptConstants = @('StartProcess','ExitProcess','StartVirtualEnvironment','TerminateVirtualEnvironment','PublishPackage','UnpublishPackage')
     
    
        foreach($sc in $UserScriptConstants){
          $us = $Base.SelectNodes($ConfString+'ns:UserScripts/ns:'+$sc,$ns)
          #Write-Host ">" $us.count
       
          if( $us.count -gt 0){
            $AppxInfo.HasUserScripts = $true
            $sk = "" | Select-Object -Property Path, ApplicationId, Trigger
            $sk.Trigger = $sc
            $sk.Path = $us.Path
            $sk.ApplicationID = $us.ApplicationID
            $result = $AppxInfo.UserScripts.add($sk)
          }
        }
      } 
      return $AppxInfo
    }
  }