clear

Import-Module "d:\GithubProjekte\AppVForcelets\AppVForcelets" -force


foreach($av in  (Get-ChildItem "C:\AppVPakete\pain*.appv" -Recurse | Select-Object -First 4) ){

  Write-Host $av.FullName -ForegroundColor Green
  $ii = Get-AppVManifestInfo $av.FullName  
  
  $ii.Shortcuts
  
  $iinfo = Get-AppVImageFromPackage -Path $av.FullName  -Iconlist $ii.Shortcuts -ImageResolutions 128 -Verbose 
  

  foreach ($imageinfo in $iinfo){
    $name = Split-path $imageinfo.icon -Leaf
    $imageinfo.image.Save("$env:userprofile\Desktop\out\$($name).png", [System.Drawing.Imaging.ImageFormat]::Png)
  }
}




