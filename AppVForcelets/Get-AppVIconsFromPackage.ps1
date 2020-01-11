#Wenn mal nichts gefunden wird
#Internal
function Get-DefaultImage {
  param($ImageType)
  Add-Type -AssemblyName System.Windows.Forms
  $DefaultIcon = 
@'
AAABAAEAICAAAAEACACoCAAAFgAAACgAAAAgAAAAQAAAAAEACAAAAAAAAAQAAAAAAAAAAAAAAAEA
AAABAAAAAAAACgoKAAAAFwADDREABxkeABISEgASGRoAAAArAAwULQAGFjIACCAoAB4iIgAZIjkA
DTQ+ACEjIwAhLC4ALi4uACYyNAAqNjoAMjIyADg4OAAMLk4ADzpHABA7SAASPk8ADjVXABAzVAAU
P1AAIDFMACw1TgAVPWAAFEFSABpJVwAXR1gAGUlZADNFRwA7R0gAIk9dACFQXgAtU1wAFkJoACRG
agAkVGIAJVhlACZaaQA9WnsAKWBuADpmcQBKT08AVlZWAEhdYQBBbXcAWXN7AGJmZgBqa2sAY2N5
AHJycgAABIEAAAOUAAAApAAECK0ACgquAA0YrAAEBrQAAw62AAgItQAAAL4AAwm4ABARugAfJ7sA
KDS/AEFlgwBBdYAASHaAAEx7hABSdIEAUHuHAFt6hgBae4gAXXubAGR9mAABAcwABgjMAAkMyQAR
FcIAFBnHABYcyAAYHcgAHBzSABcgxQAZIMYAHCLIACQwwgAqKtQAMzPXAEND2gBVVd0AcnLjAFqG
jQBciJAAXYOeAGOEjwBphY8AaYaRAGiJkAB0jJUAY5CVAGiTmABplZoAbpicAHCZngBnjacAa4up
AHKNqgBqkKwAfpehAHObpAB4naUAdp+oAHqfqQBqlLEAdZSxAHGcuQB1oKQAdqOqAH2mrgB+qq8A
fqyzAICepgCCnLYAgqauAIqprQCWp60AkqyuAIWqsQCPrrIAjaO8AISyuQCTsLMAnLO2AKOytACg
ubwAkK7JAJi8wQCetc0AnbbRAKC40gCyudIAm8PJAKHGywCxxsgArM3QALTN0QC/xt0Au9TXAMzM
zADH3N8A09PTANra2gDDz+kAy9fuAMvg5ADd6+4A4+PjAO/v7wDj4/kA5PHyAPn5+QAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/
//8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAApKSkpKSkpKSkpKSkpKSkpKSkpKSkAAAAAAAAAAAACxAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAQFAAAAAAAAAAAaUtLS0tLTgMYGxsbGxsYA05LS0tLS00AAAAAAAAAAABLdnR0
dA8SABsfHx8fHxsAfQZ0dHR0SwAAAAAAAAAAAE11dHR1ETIAHx8fHx8fHwCCAHV0dH1LAAAAAAAA
AAAAZ0ZccHcGhgAfIiIiIiEfAIYGd3V9cEVCAAAAAAAAAACERVdacH2GACEiIiIiIiEDhn19dXlT
UUIAAAAAAAAAFBBPW1daeYIDIiIiIiIiIgqCgoJxVlFSAgAAAAAAAAAAAGUdVlpbHCEiIiIiIiIi
IkyGeVZRP5MUAAAAAAAAAAAAS4UMWlpAKCIiIiIiIiIiCnlXUT8tFAAAAAAAAAAAAAtndYUdPEBA
HiIfIh8iIh8eP1FBUBIOAAAAAAAAAAAAABROgGYJQEBAGRgWGBgYHkBRVHFODqMAAAAAAAAAAAAA
ABRzBBgaQERWb3t7a0dAUUMJdRMAAAAAAAAAAAAAAAAAABQ0DSdvVVZZb3RvVVFAFTQUAAAAAAAA
AAAAAAAAAAAApBBodHQIOzs7BzxRVW9lEKQAAAAAAAAAAAAAAAAAo5sxEG17e3tyXFZSUVZydHQO
DgWjAAAAAAAAAAAAAJ4wJHRrdHt9fn5yVlFXeX58bnR0gA4QAAAAAAAAAACkjCNiMyV9micDKVtR
Wz45J5p8IDNidA6kAAAAAAAAAJ0jSSsqL36nAwI/UVelOjs6pX4vKipJdBAAAAAAAACeC2MsKyVM
j6cpPFFdeKcpPEBejksmKyxiMBAAAAAUFBBqLkp0dGuckl1RXZF9mKelXltdZHR7Si5rDp4AAACL
a0hra5Y2g5A/UTwMf38PAAAMRFtbN5Z0akh0DgAAFIdrbXU2AQGZVlFXeomJiYmJfpWfWkReNzZ1
a2uKFAAUAAAAFAAApUFRV6CXiYmJiYmXpn2IPV1epRQAABQAAAAAAAAAAKVdUUGBdKKhlZSVoaJ9
hRSlXl1epQAAAAAAAAAAAAClXlFdpRSNa5gTABOYa40UAAClXl1epQAAAAAAAAAAAGBYXaUAABQ1
hmpqaoYBAQAAAAClXlJfAAAAAAAAAAAAYWClAAAAAAA4FAAAFAAAAAAAAAClX10AAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AP//////////+AAAP+AAAA/gAAAP4AAAD+AAAA/gAAAP4AAAD+AAAA/wAAAP8AAAH/AAAB/4AAAf
/AAAf/4AAP/+AAD/+AAAP/AAAB/gAAAP4AAAD8AAAAcAAAADAAAAAwAAAAEGAAAD/AAAH/gABg/4
YA8P+Pg/j///////////
'@

  $iconBytes = [Convert]::FromBase64String($DefaultIcon)
  $stream = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
  $stream.Write($iconBytes, 0, $iconBytes.Length);
  $iconImage = [System.Drawing.Image]::FromStream($stream, $true)
  #$iconImage.Save("$env:USERPROFILE\Desktop\test.ico")
  #$img2 = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())
  $ms = new-object System.IO.MemoryStream
  $iconImage.Save($ms, [System.Drawing.Imaging.ImageFormat]::$ImageType)
  $iconBase64 = [Convert]::ToBase64String($ms.GetBuffer())
  $ms.close()
  return  $iconBase64
}

function Get-AppVIconsFromPackage {
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
 type to return

.EXAMPLE
  $IconList = Get-AppVManifestInfo  C:\temp\test\PowerDirector12-Spezial.appv | Select-Object -Property Shortcuts
  Get-AppVIconsFromPackage -Path C:\temp\test\PowerDirector12-Spezial.appv -Iconlist $IconList

.NOTES
 https://www.software-virtualisierung.de
 Andreas Nick, 2019/2020
#>
  [CmdletBinding()]
  [Alias()]
  [OutputType('AppVIconObject')]
  param( 
    [Parameter( Position = 0, Mandatory = $true, ValueFromPipeline = $true)] [System.IO.FileInfo] $Path,
    [Parameter( Position = 1, Mandatory = $true, ValueFromPipeline = $true)] [PSCustomObject[]] $Iconlist, #from the Shortcut Info
    [ValidateSet('Bmp', 'Emf', 'Gif',  'Jpeg', 'Png', 'Tiff', 'Wmf')][string] $ImageType = "Png"
  )

  Process {
    $resultlist = @()
    try {
      $ResultList = new-Object System.Collections.ArrayList
      if (Test-Path $Path.FullName) {
        [System.IO.Compression.zipArchive] $arc = [System.IO.Compression.ZipFile]::OpenRead($Path.FullName)
         
        foreach ($icon in @($Iconlist)) {
          $ix = $null
          if ($icon.Icon -ne "") { #Sometimes there is no icon :-(
            $iPath = "Root/" + $(Convert-AppVVFSPath (Convert-AppVPath  $icon.Icon)).Replace('\', '/')
            $iPath = [uri]::EscapeUriString($iPath ) 
            Write-Verbose "Extract from package path : $iPath" -Verbose
            [System.IO.Compression.ZipArchiveEntry] $ix = $arc.GetEntry($iPath) 
          }
          Else {
            Write-Verbose "Target $($icon.Targer) has no icon!" 
          }

          $iconBase64 = $null
          
          if($null -eq $ix ) #Not Found ! Get default Icon
          {
            Write-Verbose "Image not fond in the archiv! Is the file deletet? User default yoda.icon $iPath" -Verbose 
            $iconBase64 = Get-DefaultImage -ImageType $ImageType
          } else {
          
            [System.IO.binaryreader] $appvfile = $ix.Open()
            [byte[]] $bytes = Get-ReadAllBytes -reader $appvfile
            
            write-verbose $("Extract icon file " + $icon.Icon + " with " + $bytes.count + " bytes") -Verbose
            #$b = [Convert]::FromBase64String($iconBase64 )
            #$b | Add-Content -Encoding Byte -Path C:\Users\Andreas\Desktop\text.ico
            #We convert all to a little bitmap. Need an other solutions for hight resultion pictures!
            #sorry, we need a file fpr this
            $bytes | Set-Content -Encoding byte  -Path "$env:temp\tempicofile.ico" -Force
            #
            write-verbose $("Convert it to a Bmp") -Verbose
            #
            $bmp=$null
            
            [System.Drawing.Image] $bmp = ([System.Drawing.Icon]::ExtractAssociatedIcon("$env:temp\tempicofile.ico")).ToBitmap() #round about 5K

            $ms = new-object System.IO.MemoryStream
            $bmp.Save($ms, [System.Drawing.Imaging.ImageFormat]::$ImageType)
            $iconBase64 = [Convert]::ToBase64String($ms.GetBuffer())
            $ms.close()
            $appvfile.Close()
          }
            
          $AppvIconInfo = "" | Select-Object -Property  Target, Base64Image, ImageType, Icon, File, Arguments
          $AppvIconInfo.Base64Image = $iconBase64
          $AppvIconInfo.Target = $icon.Target
          $AppvIconInfo.Icon = $icon.Icon
          $AppvIconInfo.ImageType = $ImageType
          $AppvIconInfo.File = $icon.File
          $AppvIconInfo.Arguments = $icon.Arguments
          $null = $resultlist.add($AppvIconInfo)
        }
          
      }
      else {
        Write-Verbose "AppV file not found" 
        throw [System.IO.FileNotFoundException] "$Path not found."
      }
    }
    catch [System.UnauthorizedAccessException] {
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
    return $resultlist
  }
}