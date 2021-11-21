
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.IO.Compression
Import-Module $PSScriptRoot\Lib\IconLib.dll


function Get-AppVImageFromPackage {
  <#
      .SYNOPSIS
      Short description

      .DESCRIPTION
      Long description

      .PARAMETER Path
      Parameter description

      .PARAMETER Iconlist
      Get pscustomObjects from Get-AppV<>info 
      {@{Icon=[{Windows}]\Installer\{AC76BA86-7AD7-1031-7B44-AA1000000001}\SC_Reader.ico; Target=[{AppVPackageRoot}]\Reader\AcroRd32.exe}, 
      @{Icon=[{Windows}]\Installer\{AC76BA86-7AD7-1031-7B44-AA1000000001}\SC_Reader.ico; Target=[{AppVPackageRoot}]\Reader\AcroRd32.exe}} 

      .PARAMETER Type  
      Image type: bmp, jpg etc.

      .PARAMETER ImageResolutions
      ImageResolutions

      .EXAMPLE
      $IconList = Get-AppVManifestInfo  C:\temp\test\PowerDirector12-Spezial.appv | Select-Object -Property Shortcuts
      Get-AppVImageFromPackage -Path C:\temp\test\PowerDirector12-Spezial.appv -Iconlist $IconList

      .NOTES
      https://www.software-virtualisierung.de
      Andreas Nick, 2021
  #>
  
  
  [CmdletBinding()]
  [Alias()]
  [OutputType('AppVIconObject')]
  param( 
   
    [Parameter( Position = 0, Mandatory = $true, ValueFromPipelineByPropertyName = $True)] 
    [Alias('ConfigPath')] [System.IO.FileInfo] $Path,
   
    [Parameter( Position = 1, Mandatory = $false, ValueFromPipelineByPropertyName = $True)] [Alias('Shortcuts')]
    [PSCustomObject[]]  $Iconlist = $null, #from the Shortcut Info
    
    #NOT SUPPORTED, we set a format only on weiting a Bitmap!
    [ValidateSet('Bmp', 'Emf', 'Gif', 'Jpeg', 'Png', 'Tiff', 'Wmf', 'ico')][string] $ImageType = "Png", 
    
    [ValidateSet(16, 32, 48, 64, 72, 128)][string] $ImageResolutions = 32
  )


  Process {
    
    #
    # Achtung, bei leerer Liste! Cannot bind argument to parameter 'Iconlist' because it is an empty arra
    #
    
    
    if($null -eq $Iconlist ){
      Write-Verbose "WARNING: Empty icon list, null result"
      Return $null
    }
     
    $resultlist = @()
    try {
      $ResultList = new-Object System.Collections.ArrayList
      if (Test-Path $Path.FullName) {
        [System.IO.Compression.zipArchive] $arc = [System.IO.Compression.ZipFile]::OpenRead($Path.FullName)
        foreach ($icon in @($Iconlist)) {

          $ix = $null
    
          if ($icon.Icon -ne "") {
            #Sometimes there is no icon :-(
            $iPath = "Root/" + $(Convert-AppVVFSPath (Convert-AppVPath  $icon.Icon)).Replace('\', '/')
            $iPath = [uri]::EscapeUriString($iPath ) 
            Write-Verbose "Extract from AppV Package path path : $iPath"
            [System.IO.Compression.ZipArchiveEntry] $ix = $arc.GetEntry($iPath) 
          }

          if ($null -eq $ix ) { #Not Found ! Get default Icon
            Write-Verbose "WARNING: Image for $($icon.Target) not fond in the archiv! Is the file deletet? Use default yoda.icon $iPath"
          }
          else {
            try {
              $name = $ix.Name
              $multiIcon = New-Object System.Drawing.IconLib.MultiIcon 
              [System.IO.binaryreader] $appvfile = $ix.Open()

              # Muss das so sein?    
              # Den Stream direkt übergeben funktioniert leider nicht
              #

              $bufferSize = 4096
              $ms = New-object System.IO.MemoryStream
              $buffer = new-Object byte[] $bufferSize
              $count = 0
              do {
                $count = $appvfile.Read($buffer, 0, $buffer.Length)
                If ($count -gt 0) { 
                  $ms.Write($buffer, 0, $count)
                }
              } While ($count -ne 0)
              #$buffer = $null
        
        
              $multiIcon = New-Object System.Drawing.IconLib.MultiIcon
              $multiIcon.Load($ms)
              $ms.Close()
              $ms.Dispose()
              $appvfile.Close()
        
              $found = $false
              [System.Drawing.Bitmap] $bm = $null #Bitmap Image

              foreach ($iconImage in $multiIcon[0]) {
          
                if ($iconImage.Size.Width -eq $ImageResolutions) {
                  $bm = $iconImage.Icon.ToBitmap()
                  $found = $true
                }
              }

              if (-not $found) {
                Write-Verbose "INFO: No $($ImageResolutions)x$($ImageResolutions) Image found for $name search for a new max"

                #Find Max
                $max = 0
                $sindex = -1
                        
                for ($index = 0; $index -lt $multiIcon[0].Count; $index++) {
                  if ($multiIcon[0][$index].size.width -ge $max) {
                    $max = $multiIcon[0][$index].size.width
                    $sindex = $index 
                  }
                }
                $bm = New-Object System.Drawing.Bitmap ($multiIcon[0][$sindex].Icon.ToBitmap(), (New-Object System.Drawing.Size($ImageResolutions, $ImageResolutions) ))
                Write-Verbose "INFO: Found $($max)x$($max) Image for $name - we resize the result image"
              }

              #Speicher im Block behalten!
                            

                            
        
              $AppvIconInfo = "" | Select-Object -Property  Target, Image, ImageType, Icon, File, Arguments
              $AppvIconInfo.Image = $bm
              $AppvIconInfo.Target = $icon.Target
              $AppvIconInfo.Icon = $icon.Icon
              $AppvIconInfo.ImageType = $null # $ImageType
              $AppvIconInfo.File = $icon.File
              $AppvIconInfo.Arguments = $icon.Arguments
              $null = $resultlist.add($AppvIconInfo)
          
    
            } catch [System.UnauthorizedAccessException] {
              [Management.Automation.ErrorRecord]$e = $_

              $info = [PSCustomObject]@{
                Exception = $e.Exception.Message
                Reason    = $e.CategoryInfo.Reason
                Target    = $e.CategoryInfo.TargetName
                Script    = $e.InvocationInfo.ScriptName
                Line      = $e.InvocationInfo.ScriptLineNumber
                Column    = $e.InvocationInfo.OffsetInLine
              }

            }

                        
          } #else

        } #Foreach
                    
        return $resultlist
                    
      } #Test-Path for App-V File
      else {
        Write-Verbose "ERRORAppV file not found" 
        throw [System.IO.FileNotFoundException] "$Path not found."
      }

    } catch [System.UnauthorizedAccessException] 
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

    }
  } #Process

} #Function
