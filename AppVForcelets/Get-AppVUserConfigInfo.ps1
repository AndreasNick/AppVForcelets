function Get-AppVUserConfigInfo{
    <#
        .SYNOPSIS
        Get and anylyse a UserConfig.xml

        .DESCRIPTION
        Get and anylyse a UserConfig.xml. Supply informations about the package ans skripts

        .PARAMETER Path
        Path to the UserConfig.xml

        .EXAMPLE
        Get-AppVManifestInfo -Path Value

        .NOTES
        Place additional notes here.

        .LINK
        https://www.software-virtualisierung.de
    #>
    [CmdletBinding()]
    [OutputType('UserConfigObject')]
    param( 
      [Parameter(       
          Position=0, 
          Mandatory=$true, 
      ValueFromPipeline=$true)] [System.IO.FileInfo] $Path
    )
    
    begin{
      Add-Type -AssemblyName System.IO
      Add-Type -AssemblyName System.IO.Compression
      Add-Type -AssemblyName System.IO.Compression.FileSystem
    }
    
    process
    {

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
      HasApplications, Applications, HasShortcuts, Shortcuts, ShortcutsEnabled, HasUserScripts, UserScripts
  
      ############## User Part ############## 

      #Get Applications
      $Base = ([xml] $appvStreamMapp)
      [System.Xml.XmlLinkedNode] $appxxml = $Base.UserConfiguration
  
      $ns = New-Object System.Xml.XmlNamespaceManager($Base.NameTable)
  
      #http://schemas.microsoft.com/appv/2010/userconfiguration
      $ns.AddNamespace("ns","http://schemas.microsoft.com/appv/2010/userconfiguration") 
      $ConfString = '//ns:UserConfiguration'
  
      #DisplayName
      $DisplayName = ($Base.SelectNodes($ConfString,$ns)).DisplayName
      $AppxInfo.Name = $DisplayName
  
      $AppxInfo = Get-AppVConfigUserPart -AppxInfo $AppxInfo -Appxxml $appxxml -ConfigFileType UserConfiguration
  
      return $AppxInfo
    }
  }