function Convert-AppVPath
  {
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param
    (
      [Parameter(Mandatory=$true,
          ValueFromPipelineByPropertyName=$true,
      Position=0)] $AppVString 
    )
    
    process
    {
      foreach($sub in $AppVPathSubstitution.AppVPathSubstitution.ChildNodes){
        #das hier kann schneller werden!
        if($AppVString -match  [Regex]::Escape($($sub.Substitution.ToString())) ){
          $result = $AppVString -replace [Regex]::Escape($sub.Substitution),$sub.path
          break
        }
      }
      return $result
    }
  }