Write-Host "Starting export-import"
$PictLoc = gci "C:\Personal\KassaKassa" -Recurse
$Dest = "c:\Personal\Export\"

$fotos = Import-Csv -Path .\KassaKassa_Export_SetFull.csv

foreach ($foto in $fotos) {
  # Write-Host "Checking CSV-record"
  # Write-Host $foto.object_number

  foreach ($picture in $PictLoc) {
    # Write-Host $picture
    if ($picture.Name.StartsWith($foto.object_number)) {
      Write-Host "Copying CSV-record"
      Copy-Item ".\KassaKassa\$picture" -Destination $Dest -Recurse -Verbose
    }
  }
}
Write-Host "Finished export-import"
