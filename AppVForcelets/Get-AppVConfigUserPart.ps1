﻿function Get-AppVConfigUserPart{
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
    $fta = $Base.SelectNodes($ConfString + 'ns:Subsystems/ns:FileTypeAssociations/ns:Extensions', $ns)
    $AppxInfo.HasFileTypeAssociation = $false
    $AppxInfo.FileTypeAssociation = New-Object System.Collections.ArrayList
    if ($fta.Count -gt 0) {

      $AppxInfo.HasFileTypeAssociation = $true
      $AppxInfo.FileTypeAssociationEnabled = "true" -eq $Base.SelectNodes($ConfString + 'ns:Subsystems/ns:FileTypeAssociations', $ns).Enabled
    
      Foreach ($Item in  $fta.Extension) 
      {
        if ($null -ne $Item.FileTypeAssociation.FileExtension.Name) 
        {
          $sk = "" | Select-Object -Property Name, ProcID
          $sk.Name = $Item.FileTypeAssociation.FileExtension.Name
          $sk.ProcID = $Item.FileTypeAssociation.FileExtension.ProgId
      
          $result = $AppxInfo.FileTypeAssociation.add($sk) 
        }
      }
    }
  
      #URL Protokoll
      $url = $Base.SelectNodes($ConfString+'ns:Subsystems/ns:URLProtocols/ns:Extensions',$ns)
     
      if($url.Count -gt 0){
        $AppxInfo.HasURLProtocols = $true
      } 
      else 
      {
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
     
      if($objects.Count -gt 0)
      {
 
        $AppxInfo.ObjectsEnabled = "true" -eq $objects.Enabled
    
      } else 
      {

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
# SIG # Begin signature block
# MIIetQYJKoZIhvcNAQcCoIIepjCCHqICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUPBqBhWwtqDviNfuRUEaaKrA4
# IQygghm/MIIEhDCCA2ygAwIBAgIQQhrylAmEGR9SCkvGJCanSzANBgkqhkiG9w0B
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
# CQQxFgQULhuQtrEC4UZNxmAVNUCHHZP/EGgwDQYJKoZIhvcNAQEBBQAEggEAM9cR
# LfSezdVdEfEdJr8aoL26HvgUkLo75yR/TPDOP6HffJlqW4zYqtToPORU63ADQXAO
# 1LGZUos2ydwKGJd1h82q3nPL0QcQNpBtsS5ERMx/4wY6lxCS8HScjpEl72F42LKN
# bjgheaILtG0ztlY21OCjh9nLwWlP5/JsazoOPzZhjIhWu/FKsK9s7FV2hYOeHVP8
# DYVL9KdMGx/o7aWpevZd7371g1357aL3Xx+UqBcj3nAeoZeuSA1QpA9lOx+qcxIK
# NQ4DrXA2viJkNry8oZCwh44QY5XDP0kEdD5XaZyDNYYzKxrBngIqEOq0SE4XaxnI
# FX4Enz8PrD4WJUyS2KGCAigwggIkBgkqhkiG9w0BCQYxggIVMIICEQIBATCBjjB6
# MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
# VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDEgMB4GA1UE
# AxMXQ09NT0RPIFRpbWUgU3RhbXBpbmcgQ0ECECtz23RjEUxaWzJK8jBXckkwCQYF
# Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
# MQ8XDTIwMDEyMjE0MTIzMFowIwYJKoZIhvcNAQkEMRYEFHHaarp+ucoIWZRx51Xp
# uIZ+zsZUMA0GCSqGSIb3DQEBAQUABIIBAKSGCpCXJQFntS/DAssrc0wlxXBX9wzY
# fXWf4Chxq4ZTY0hu4n38Gykn7YtasBhhAwh/hTvgRcpIixTD/TvR1Wv/ylwWuV1O
# YHP5LzkF+ewqJYhKum6YPgUFFPe6j1D28/WjCsSraxzIuWSQ8NYevOiPgDmNv3hM
# S9fwRiktvPS6MBXgGClaVstgTuasOgtgIIoWLW0d5ajmNO2s3CUL+Avxn+94/MYW
# HKM1dMWoQBE3Z+lBx+Rsan3Si5A94b9ANeHqdLif629iiDVRqcM0AWV8QdGOgBCC
# NduCPagnamMO2IYBh65aBLACFMG/g+M8F7vfkVJ5UZdIXzqKgc1BQSs=
# SIG # End signature block
