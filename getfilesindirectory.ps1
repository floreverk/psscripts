Get-ChildItem -Path "R:\Collectie HVA" -Recurse -include ('*.tif', '*.jpg', '*.wav', '*.mov', '*.mp3', '*.mp4', '*.tiff', '*.JPG', '*.TIF') |`
foreach{
$Item = $_.BaseName
$Path = $_.FullName
$Filesize = $_.length

$Path | Select-Object `
    @{n="objectnummer";e={$Item}},`
    @{n="path";e={$Path}},`
    @{n="filesize";e={$Filesize}}`
}| Export-Csv C:\Users\Verkesfl\Documents\Documenten\Results.csv -NoTypeInformation
