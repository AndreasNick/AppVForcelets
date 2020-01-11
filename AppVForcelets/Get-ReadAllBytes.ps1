function Get-ReadAllBytes([System.IO.BinaryReader] $reader){
  
    $bufferSize = 4096
    $ms = New-object System.IO.MemoryStream
    $buffer = new-Object byte[] $bufferSize
    $count = 0
    do {
      $count = $reader.Read($buffer, 0, $buffer.Length)
      If ($count -gt 0){ 
        $ms.Write($buffer, 0, $count)
      }
    } While ($count -ne 0)

    
    $ms.Close()
    return $ms.ToArray()
  }