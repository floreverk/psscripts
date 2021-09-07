$targetFolderName = "path to end directory"
$sourceFolderName = "path to start directory"
$csv = Import-csv "path to csv" | select -ExpandProperty filepath


foreach ($itemToCopy in $csv)
{
    $targetPathAndFile =  $itemToCopy.Replace( $sourceFolderName , $targetFolderName )
    $targetfolder = Split-Path $targetPathAndFile -Parent
    
    #If destination folder doesn't exist
    if (!(Test-Path $targetfolder -PathType Container)) {
        #Create destination folder
        New-Item -Path $targetfolder -ItemType Directory -Force
    }

    Copy-Item -Path $itemToCopy -Destination   $targetPathAndFile 

}
