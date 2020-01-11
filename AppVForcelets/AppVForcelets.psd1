
#
# Module Manifest for Module 'AppVExtraCmdLets.psd1
#
#      this is a PowerShell module for analysis of App-V packets
#
#      .DESCRIPTION
#      With the help of this module App-V repositories, external scripts 
#      and the internal AppX manifest can be examined. All kinds of information 
#      about a package are provided. For example, you can get a quick overview of 
#      which packages contain scripts and where you might have forgotten to import 
#      a configuration file. Provided, of course, that the file is found
#
#      .NOTES
#      Andreas Nick, 2019/2020
#
#      .LINK
#      https://www.software-virtualisierung.de
# 


@{

# Module Loader File
RootModule = 'loader.psm1'

# Version Number
ModuleVersion = '1.0'

# Unique Module ID
GUID = '39c9e5f1-3fb9-4394-8ae3-156d6709b79f'

# Module Author
Author = 'Andreas Nick'

# Company
CompanyName = 'Nick Informationstechnik GmbH'

# Copyright
Copyright = '(c) 2020 Andreas. All rights reserved.'

# Module Description
Description = 'AppVForcelets'

# Minimum PowerShell Version Required
PowerShellVersion = ''

# Name of Required PowerShell Host
PowerShellHostName = ''

# Minimum Host Version Required
PowerShellHostVersion = ''

# Minimum .NET Framework-Version
DotNetFrameworkVersion = ''

# Minimum CLR (Common Language Runtime) Version
CLRVersion = ''

# Processor Architecture Required (X86, Amd64, IA64)
ProcessorArchitecture = ''

# Required Modules (will load before this module loads)
RequiredModules = @()

# Required Assemblies
RequiredAssemblies = @()

# PowerShell Scripts (.ps1) that need to be executed before this module loads
ScriptsToProcess = @()

# Type files (.ps1xml) that need to be loaded when this module loads
TypesToProcess = @()

# Format files (.ps1xml) that need to be loaded when this module loads
FormatsToProcess = @()

# 
NestedModules = @()

# List of exportable functions
FunctionsToExport = @('Get-AppVUserConfigInfo','Convert-AppVPath','Convert-AppVVFSPath','Get-AppVIconsFromPackage','Get-AppVManifestInfo','Get-AppVDeploymentConfigInfo')

# List of exportable cmdlets
CmdletsToExport = ''

# List of exportable variables
VariablesToExport = '*'

# List of exportable aliases
AliasesToExport = '*'

# List of all modules contained in this module
ModuleList = @()

# List of all files contained in this module
FileList = @()

# Private data that needs to be passed to this module
PrivateData = ''

}