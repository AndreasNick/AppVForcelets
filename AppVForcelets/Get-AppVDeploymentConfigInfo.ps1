function Get-AppVDeploymentConfigInfo{
    <#
        .SYNOPSIS
        Get and anylyse a DelplymentConfig.xml

        .DESCRIPTION
        Get and anylyse a DelplymentConfig.xml. Supply informations about the package ans skripts

        .PARAMETER Path
        Path to the DeploymentConfig.xml

        .EXAMPLE
        Get-AppVManifestInfo -Path Value

        .NOTES
        Andreas Nick - 2019

        .LINK
        https://www.software-virtualisierung.de
    #>
    
    [CmdletBinding()]
    [OutputType('DeploymentConfigObject')]
    
    param( 
      [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)] [System.IO.FileInfo] $Path
    )


    Process{

      [System.Xml.XmlLinkedNode] $appxxml = $NUll
      [xml] $appvStreamMapp = $NUll
  
      try
      {
        if(Test-Path $Path.FullName){
    
          $appvStreamMapp = Get-Content $Path.FullName
      
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
      $ErrorActionPreference = 'Continue'
  
      #Create Object
      #AppVInProcExt attribute in Office!
  
      $AppxInfo = "" | Select-Object -Property Name, ComMode,InProcessEnabled, OutOfProcessEnabled, HasRegistrySettings, HasURLProtocols,
      FontsEnabled, FileSystemEnabled, ServicesEnabled, HasFileTypeAssociation, FileTypeAssociation, FileTypeAssociationEnabled,
      EnvironmentVariablesEnabled, HasEnvironmentVariables, ObjectsEnabled,  RegistryEnabled,
      HasApplications, Applications, HasShortcuts, Shortcuts, ShortcutsEnabled, HasUserScripts, UserScripts,
      #MachinePart
      ApplicationCapabilities, HasApplicationCapabilities, ApplicationCapabilitiesEnabled, HasMachineRegistrySettings,
      MachineScripts, HasMachineScripts, HasTerminateChildProcesses, TerminateChildProcesses
  
  
      ############## User Part ############## 

      #Get Applications
      $Base = ([xml] $appvStreamMapp)
      [System.Xml.XmlLinkedNode] $appxxml = $Base.DeploymentConfiguration
  
      $ns = New-Object System.Xml.XmlNamespaceManager($Base.NameTable)
  
      #http://schemas.microsoft.com/appv/2010/userconfiguration
      $ns.AddNamespace("ns","http://schemas.microsoft.com/appv/2010/deploymentconfiguration") 
      $ConfString = '//ns:DeploymentConfiguration'
  
      #DisplayName
      $DisplayName = ($Base.SelectNodes($ConfString,$ns)).DisplayName
      $AppxInfo.Name = $DisplayName
  
      $ConfString = '//ns:DeploymentConfiguration'+'/ns:UserConfiguration/'
      $AppxInfo = Get-AppVConfigUserPart -AppxInfo $AppxInfo -Appxxml $appxxml -ConfigFileType DeploymentConfiguration
  
      ############## Machine Part ############## 
      
      $ConfString = '//ns:DeploymentConfiguration'+'/ns:MachineConfiguration/'
  
      #ApplicationCapabilities
      $ac64 = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:ApplicationCapabilities/ns:Extensions/ns:Extension/ns:ApplicationCapabilities/ns:CapabilityGroup/ns:CapabilitiesWow64/ns:FileAssociationList',$ns)
      $ac = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:ApplicationCapabilities/ns:Extensions/ns:Extension/ns:ApplicationCapabilities/ns:CapabilityGroup/ns:Capabilities/ns:FileAssociationList',$ns)
      #CapabilitiesWow64?'
      if($ac64.Count -gt 0) {
        $ac = $ac64
      }
      $AppxInfo.HasApplicationCapabilities= $false
      $AppxInfo.ApplicationCapabilities = New-Object System.Collections.ArrayList
      $AppxInfo.ApplicationCapabilitiesEnabled = $true;
      if($ac.Count -gt 0){
       
        $AppxInfo.HasApplicationCapabilities = $true
        $AppxInfo.ApplicationCapabilitiesEnabled = "true" -eq $Base.SelectNodes($ConfString+'ns:Subsystems/ns:ApplicationCapabilities',$ns).Enabled
    
        Foreach($Item in  $ac.FileAssociation){
          $sk = "" | Select-Object -Property Name, ProcID
          $sk.Name = $Item.Extension
          $sk.ProcID = $Item.ProgId
      
          $result = $AppxInfo.ApplicationCapabilities.add($sk)
        }
        
      } 
    
      #Registry
      $Reg = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:Registry',$ns)
   
      if($Reg.Count -gt 0){
      
        $AppxInfo.HasMachineRegistrySettings = ($Base.SelectNodes($ConfString+'ns:Subsystems/ns:Registry/ns:Include',$ns).count -gt 0) -or ($Base.SelectNodes($ConfString+'ns:Subsystems/ns:Registry/ns:Delete',$ns).count -gt 0)
    
      }  
    
  
      #MachineScripts
      $machineScripts = $Base.SelectNodes($ConfString+'ns:MachineScripts',$ns)
  
      $AppxInfo.HasMachineScripts = $false
      $AppxInfo.MachineScripts = New-Object System.Collections.ArrayList
      if($machineScripts.Count -gt 0){
       $machineConstants = @('PublishPackage','UnpublishPackage','AddPackage','RemovePackage')
     
    
        foreach($sc in $machineConstants){
          $us = $Base.SelectNodes($ConfString+'ns:MachineScripts/ns:'+$sc,$ns)
          #Write-Host ">" $us.count
       
          if( $us.count -gt 0){
            $AppxInfo.HasMachineScripts = $true
            $sk = "" | Select-Object -Property Path, ApplicationId, Trigger
            $sk.Trigger = $sc
            $sk.Path = $us.Path
            $sk.ApplicationID = $us.ApplicationID
            $result = $AppxInfo.MachineScripts.add($sk)
          }
      
        }
      
      }
       
      
  
      #TerminateChildProcesses
  
      $terminateChild = $Base.SelectNodes($ConfString+'ns:TerminateChildProcesses',$ns)
  
      $AppxInfo.HasTerminateChildProcesses = $false
      $AppxInfo.TerminateChildProcesses = New-Object System.Collections.ArrayList
      if($terminateChild.Count -gt 0){
      
        Foreach($Item in $terminateChild.Application){
          $result = $AppxInfo.TerminateChildProcesses.add($Item.Path)
        }
      } 
      return $AppxInfo
    }

  }