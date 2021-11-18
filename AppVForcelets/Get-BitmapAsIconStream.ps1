
function Get-BitmapAsIconStream
{
    <#
    .SYNOPSIS
    Helper funtions. Icons are not supportet from a dotnet class    
    
    .DESCRIPTION
     Helper funtions. Icons are not supportet from a dotnet class   
    
    .PARAMETER SourceBitmap
    A Bitmap Image
    
    .PARAMETER Fs
    fs [System.IO.MemoryStream
    
    .NOTES
    https://stackoverflow.com/questions/11434673/bitmap-save-to-save-an-icon-actually-saves-a-png
    #>
    
    param (
        [Parameter( Position = 0, Mandatory = $true, ValueFromPipelineByPropertyName=$True)] 
        [System.Drawing.Bitmap] $SourceBitmap, 
        [Parameter( Position = 1, Mandatory = $true, ValueFromPipelineByPropertyName=$True)] 
        [System.IO.MemoryStream] $Fs
    )
    
    # ICO header
    $Fs.WriteByte(0)
    $Fs.WriteByte(0)
    $Fs.WriteByte(1) 
    $Fs.WriteByte(0)
    $Fs.WriteByte(1) 
    $Fs.WriteByte(0)

    # Image size
    $Fs.WriteByte([byte] $SourceBitmap.Width)
    
    $Fs.WriteByte([byte] $SourceBitmap.Height)
    # Palette
    $Fs.WriteByte(0)
    # Reserved
    $Fs.WriteByte(0)
    # Number of color planes
    $Fs.WriteByte(0)
    $Fs.WriteByte(0)
    # Bits per pixel
    $Fs.WriteByte(32)
    $Fs.WriteByte(0)

    # Data size, will be written after the data
    $Fs.WriteByte(0)
    $Fs.WriteByte(0)
    $Fs.WriteByte(0)
    $Fs.WriteByte(0)

    # Offset to image data, fixed at 22
    $Fs.WriteByte(22)
    $Fs.WriteByte(0)
    $Fs.WriteByte(0)
    $Fs.WriteByte(0)

    # Writing actual data
    $null = $SourceBitmap.Save($Fs, [System.Drawing.Imaging.ImageFormat]::png)

    # Getting data length (file length minus header)
    [long] $Len = $FS.Length - 22

    # Write it in the correct place
    $null = $Fs.Seek(14, [System.IO.SeekOrigin]::Begin)
    $Fs.WriteByte([byte] ($Len -band 0x00ff))
    $Fs.WriteByte([byte] ($Len -shr 8))
    $Fs.WriteByte([byte] ($Len -shr 16))
    $Fs.WriteByte([byte] ($Len -shr 25))

    #$Fs.Close()
}


# SIG # Begin signature block
# MIIVrgYJKoZIhvcNAQcCoIIVnzCCFZsCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUv4DfrCvQHwau7bXDifKI/xD4
# hOagghHmMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0B
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
# SIb3DQEJBDEWBBQdp2rWZFtw7TweNGGisdF7AWgLojANBgkqhkiG9w0BAQEFAASC
# AgB/MJBgEOyg0MGy+DaAn/km8f1jtepFUij6rMTDIoh8YYtU6bk/1b5syMUtnyDX
# Exz23pRt1cfMclRD0EsaIuRWqEfwpXvpQKCZLVYHuxIYw6rw40TgO11ZMtT5G464
# 7RWTTMKG71HBUfYQPuIypUnm+uyy8+VKHsOCL4rl0sLv4qdDPz+aA5kE5kAg0ipf
# y8TVa+8bAwS08xvjBZ3uWxHeNGJg8CkyKDmjsnwZwdilLQDN1Qq9LpkD8jtUvacy
# lw/v/S2YO3RUy1zOBIsqgtdpupGuEZ+qKbku1UEmQGDltTbMfMZf6qh4HJSK91f1
# Kl3EZaJOb0yOO6hvVnE6wJ49zpfiLBe3Gu0jSsl+1CtkqXx4HzQdh7ACNjylokdj
# IDj0YYwDHmCVYM7HrHTQNkNGYbfpIOpQe+Z0y+ceyg2rLYs3Od38mULVl40e+mNF
# SftNz/eansvnVeRICqZCjUdm9M0wzWAk1SZBOiYuSv2ThZEn5vP38h54SmrhZpFQ
# aEd6RE0kqMPBwL1NGE2cY98eJs9MMRn/QAv9eCb1RpU6jlSPMJHVV/RuTw/HgFXG
# pcTK9cRDaC3GgilMTdFWNGKhhWcvxkog7yPPeELv/Wsqxz/eWEYxo9+ay2kcHw8u
# gcwJXrbIqJf0OIexq/AGsdvxiW4pIvbgPK7Svq9w+Q9sAA==
# SIG # End signature block
