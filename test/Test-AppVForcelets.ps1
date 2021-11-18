<#
    # Testscript for the Module AppVExtraCmdLet
    # This module allow to analyse yout App-V Depot
#>

Import-Module $PSScriptRoot\..\AppVForcelets -force
$Depot = "C:\AppVPakete"

break
#Get-AppVManifestInfo  "C:\temp\test\PowerDirector12-Spezial.appv" | % {Save-AppVIcons -Path $_.ConfigPath -Iconlist $_.Shortcuts -ImageType ico -DestinationPath $("$env:USERPROFILE\desktop\out\" + $_.name + ".ico")}

#Get All icons ans save
# First create Directory
if(-not (Test-Path $("$env:USERPROFILE\desktop\out\"))) {
  New-Item $("$env:USERPROFILE\desktop\out\") -ItemType Directory  
}

Get-ChildItem "$Depot\*.appv" -Recurse | Get-AppVManifestInfo  | ForEach-Object `
 {Save-AppVIcons -Path $_.ConfigPath -Iconlist $_.Shortcuts -ImageType ico -DestinationPath $("$env:USERPROFILE\desktop\out\" + $_.name + ".ico") -Verbose} 


break

#Get Ifos form the Packages

Write-Host "Test-DeploymentConfig.xml" -ForegroundColor Yellow
Get-AppVDeploymentConfigInfo "$Depot\AcrobatReader_10\AcrobatReader_10_DeploymentConfig.xml"
  
Write-Host "Test-DeploymentConfig.xml with Select-Object" -ForegroundColor Yellow
Get-AppVDeploymentConfigInfo "$Depot\AcrobatReader_10\AcrobatReader_10_DeploymentConfig.xml" | Get-Member PSStandardMembers -force
  
Write-Host "Test-internalManifest.xml" -ForegroundColor Yellow
Get-AppVManifestInfo  "C:\temp\test\PowerDirector12-Spezial.appv" | Select-Object -Property ComMode, Name, HasActiveXComponents, HasSxSAssemblys
  
Write-Host "Test-UserConfig.xml" -ForegroundColor Yellow
Get-AppVUserConfigInfo "$Depot\AcrobatReader_10\AcrobatReader_10_UserConfig.xml"
Get-AppVUserConfigInfo "$Depot\AcrobatReader_10\AcrobatReader_10_UserConfig.xml" | Select-Object -Property Name, HasUserScripts


break

#Extract Images & create html
  
Write-Host "Extract Icons" -ForegroundColor Yellow
  
$IconList = Get-AppVManifestInfo  C:\AppVPakete\FreeAppDeployRepackager\FreeAppDeployRepackager.appv | Select-Object -Property Shortcuts
$result = Get-AppVIconsFromPackage -Path C:\AppVPakete\FreeAppDeployRepackager\FreeAppDeployRepackager.appv -Iconlist $IconList -ImageType png

$result | Where-Object {$_.Target}


#Save Image File zo Disk
$b = [Convert]::FromBase64String($result[1].Base64Image )
$b | Set-Content -Encoding Byte -Path C:\Users\Andreas\Desktop\text.jpeg -Force

Write-Host "Image embedded html" -ForegroundColor Yellow
#<img src="data:image/bmp,ABCDEF..." width="100" height="100" />

$html = @'
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>title</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js"></script>
  </head>
  <body>
    <!-- Content -->
  </body>
</html>
'@
$index = $html.IndexOf('<!-- Content -->')

$result | ForEach-Object {
  $html = $html.Insert($index, $("`r`n" + '<img src="data:image/gif;base64,' + $_.Base64Image + '" width="32" height="32"  title="this will be displayed as a tooltip" />'));
  $index = $html.IndexOf('<!-- Content -->')
}

$html | Set-Content -Encoding UTF8 -Path C:\Users\Andreas\Desktop\text2.html -Force

break

#Analyse Depot
  
#Find greatest files in your App-V Packages
gci "$Depot\*.appv" -Recurse | Get-AppVManifestInfo | Select-Object -Property Name, MaxfileSize, MaxFilePath 


#Find Visual Assemblies in your Packages
Get-ChildItem "$Depot\*.appv" -Recurse | Get-AppVManifestInfo | ? {$_.FileTypeAssociation} | Select-Object -Property Name, FileTypeAssociation

Get-ChildItem "$Depot\*.appv" -Recurse | Get-AppVManifestInfo |Where-Object {$_.HasServices}|  Select-Object -Property Name, HasShellExtensions, HasServices

gci "$Depot\*.appv" -Recurse | Get-AppVManifestInfo | Select-Object -Property Name,HasSxSAssemblys, SxSAssemblys | % { $_.SxSAssemblys } | Select-Object -Unique | Sort-Object

gci "$Depot\*.appv" -Recurse | Get-AppVManifestInfo | Select-Object -Property Name,SxSAssemblys | ? { $_.SxSAssemblys } | Select-Object -Property Name, SxSAssemblys 

Get-ChildItem "$Depot\*.appv" -Recurse | Get-AppVManifestInfo | Where-Object {$_.HasSxSAssemblys } | Select-Object -Property Name,SxSAssemblys 

Get-ChildItem "$Depot\*.appv" -Recurse | Get-AppVManifestInfo | Select-Object -Property Name,SxSAssemblys | % { $_.SxSAssemblys } | Select-Object -Unique | Sort-Object
  
<#
      Microsoft.MSXML2
      Microsoft.MSXML2R
      Microsoft.VC80.ATL
      Microsoft.VC80.CRT
      Microsoft.VC80.MFC
      Microsoft.VC80.MFCLOC
      Microsoft.VC80.OpenMP
      Microsoft.VC90.ATL
      Microsoft.VC90.CRT
      Microsoft.VC90.MFC
      Microsoft.VC90.MFCLOC
      Microsoft.VC90.OpenMP
      policy.8.0.Microsoft.VC80.ATL
      policy.8.0.Microsoft.VC80.CRT
      policy.8.0.Microsoft.VC80.MFC
      policy.8.0.Microsoft.VC80.MFCLOC
      policy.8.0.Microsoft.VC80.OpenMP
      policy.9.0.Microsoft.VC90.ATL
      policy.9.0.Microsoft.VC90.CRT
      policy.9.0.Microsoft.VC90.MFC
      policy.9.0.Microsoft.VC90.MFCLOC
      policy.9.0.Microsoft.VC90.OpenMP
  #>

    

break


Get-ChildItem "$Depot\*deploymentConfig.xml" -Recurse | Get-AppVDeploymentConfigInfo | Where-Object {$_.HasUserScripts -or $_.HasMachineScripts } | Select-Object -Property Name,ConfigPath 

Get-ChildItem "$Depot\*.appv" -Recurse | Get-AppVManifestInfo | Select-Object -Property Name, MaxfileSize, MaxfilePath | Sort-Object -Property MaxfileSize -Descending

