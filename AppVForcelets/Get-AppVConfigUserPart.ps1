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
# MIIVrgYJKoZIhvcNAQcCoIIVnzCCFZsCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUPBqBhWwtqDviNfuRUEaaKrA4
# IQygghHmMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0B
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
# SIb3DQEJBDEWBBQuG5C2sQLhRk3GYBU1QIcdk/8QaDANBgkqhkiG9w0BAQEFAASC
# AgDUQas8kRY9hGSrGIHHUlRzvPI/FXee2PmJjKbyV4MlXzdjGMrVZuKfHzcguynr
# zkWVlDTIDluUUzJgDPzb2ia5WjMHZPeaFtu89xbXdCygfl9stMWzguICoa2CFDnB
# UQqMoS+KoRKVwkNFQ4xLACu49yiHUh022QDjGDugTU1NYKSgRncPno59NcvPEJkk
# mYXyPvjHE8B8PEUbuogcVyhjELAxXkCOT2eoqusMznki4Q/sEV8DYm5qOYh2/MeE
# pBxc+FsSM/qZmbZrCueh1ooN+og6PMb+WuaFJJ5xZLeD9CZP3k53QrFl3yAEE7BS
# ykBjazg+fpSDQSM20I7tY1S3Ir+aP6MNLHPCo4xMaU7xKrthzC6slysy31NvpV+V
# CKQ5Nf72YJeuF5T++4HmyCGDmC3bKIfE9HqdKZKpvM9zqBKtjr7yOQMJhrit6Kmq
# SrZ8RxSZrTU7OcCcNXDegnXkroFfpjmLooqdMIc9GL+UmhdViUuv7uJbV+yIGEcd
# MNe4zZNw4y9BnAUESHnR3E+tRCVqGjUGofZB2BK1gJdlGMk3mXtfaUujGeUMkUPM
# X0FWvx4nDRBMht4RR4fX4o79+WDJ8Mrg8Nuv/hpwnMJZaE7xxKIlj8F6ysCZ5amH
# AEmLi4rRXpDELHfCSJgXXzZ3cjb7pWjrp7sIxhZMvJxQIg==
# SIG # End signature block
