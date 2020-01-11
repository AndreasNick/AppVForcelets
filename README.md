# AppVForcelets
Additional PowerShell Commands for Microsoft App-V (currently primarily for package analysis)

##what's the point?
The module currently has some primary functions to make information from the internal AppXManifest (and the external configuration files) of an .appv file visible and searchable. This includes the possibility to search an App-V package directory for specific data. For example: Find all packages with ShellExtensions

## How does it work?

irst the module must be imported. This can also be in the module memory, for example. I am also planning to store a version in the PowerShell gallery.

```powershell
#In the Script folder
Import-Module $($PSScriptRoot +'\AppVForcelets')
Import-Module 'YOURPATH\'+'\AppVForcelets') 

````
###Example: Find packages with ShellextEnsions and Services

```powershell
GetChildItem "$Depot\*.appv" -Recurse | Get-AppVManifestInfo | Select-Object -Property Name, HasShellExtensions, 
HasServices

Name                       HasShellExtensions HasServices
----                       ------------------ -----------
Adobe Acrobat DC                         True        True
AcrobatReader_10                        False        True
AdobeDigitEd2                           False       False
Adobe_PS_CS4                            False        True
Acrobat_Pro_2015                         True        True
````
