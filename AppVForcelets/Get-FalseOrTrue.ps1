function Get-FalseOrTrue{
    <#
        .SYNOPSIS
        Describe purpose of "Get-FalseOrTrue" in 1-2 sentences.
    #>


    param ($value)
    if($value -eq $true){return $true}
    else {return $false}

  }