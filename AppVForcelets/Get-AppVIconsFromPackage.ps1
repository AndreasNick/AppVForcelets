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
# SIG # Begin signature block
# MIIetQYJKoZIhvcNAQcCoIIepjCCHqICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUB4gFptBlw83PK1/BANTBECqv
# ixmgghm/MIIEhDCCA2ygAwIBAgIQQhrylAmEGR9SCkvGJCanSzANBgkqhkiG9w0B
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
# CQQxFgQUfKxyIJAo60Ttc3GsDQRkKy3zGsAwDQYJKoZIhvcNAQEBBQAEggEAoZqz
# bTlBPGDQrS5V/ZjG2nJ/vIEqjh/x+bUwXcnsT+7lPRyBtVXeIE2l50AQmToSWSiQ
# hSQ27QZFt6Uux6NhKBk8JNE7C8td4s4x7n3qZXFtJ9eT09p96FIm6EvKUb6qSQ2i
# rV5+5jt2vIPR6RvUa6raAs5obisg2m4kmVDy5pFBHJLlIxrzfK+xh/6yvqLrMnQk
# 5PREB3A/j31XCHl5GiSrn1yVdfOOlZ7O1oeMnRgCI7FJAix3S6yzKG+t3TnOBQgO
# tH5BlmcPsFTn6IExikLx/c4gwyVv0vWwoavxDe3e4eLgDwo4mV46KdG8k6SFKlCD
# rT5Io3gsmfHOhI4RY6GCAigwggIkBgkqhkiG9w0BCQYxggIVMIICEQIBATCBjjB6
# MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
# VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDEgMB4GA1UE
# AxMXQ09NT0RPIFRpbWUgU3RhbXBpbmcgQ0ECECtz23RjEUxaWzJK8jBXckkwCQYF
# Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
# MQ8XDTIwMDExMTE2MDUwMVowIwYJKoZIhvcNAQkEMRYEFFgbcV+msLOLlehkzVj6
# DhCqiBrZMA0GCSqGSIb3DQEBAQUABIIBAEjEMDGiMbKnspz3/b1IMj9J0ofMoi5j
# SdGW4w76rDMg0cNmxByHB0pywlDp8OgO3FKaVSlG9K+IuFbIJoN5AfxIQ5ZIO7SE
# nCl5wVu6UzbOrFkOHIGlrLmK0g8DM1DBFa09LUScH9rCWsFuBoiIMhnpSW0T9VuP
# PjJ3JA8JJr+PXXP01oSQjCmfuXHmSNNG5iCJuU9e5Et7hq0mWBFmzaDAjz/Ar2aj
# zXHtQ9uuPvVHq3xpAfgYMfwYC4DkNH0a54SCSJl4jDsnAqxOYdWLlsdmc97H+dZ1
# 4xenhhB9QQNttVtikhLbQBZTutdkdt/qVMfBwVNuV8uLpPOcVNGi+8A=
# SIG # End signature block
