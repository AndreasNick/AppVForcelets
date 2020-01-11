function Convert-AppVVFSPath
  {
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param
    (
      [Parameter(Mandatory=$true, Position=0)] $AppVString,
      [ValidateSet('X64','X86')] $Architektur = 'x64'
    )
    Process{
      foreach($sub in $AppVVFSPathSubstitution.VFSPathSubstitution.ChildNodes){
        #das hier kann schneller werden!
        if($AppVString -match  [Regex]::Escape($($sub.path.ToString())) ){
          [string] $result = $AppVString -replace [Regex]::Escape($sub.path),$sub.$Architektur
          
          if($result.Substring(0,1) -eq '\')
          {
            $result = $result.Substring(1,$result.Length-1)
          }
          break
        }
      }
      return $result
    }
 
  }