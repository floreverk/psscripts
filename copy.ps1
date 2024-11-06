# Pad naar het CSV-bestand
$csvPath = "C:\pad\naar\objectnummer.csv"

# Pad naar de hoofdmap waarin gezocht moet worden naar de bestanden
$searchRoot = "C:\pad\naar\zoekmap"

# Doelmap waar de bestanden naartoe gekopieerd worden
$destinationPath = "C:\pad\naar\doelmap"

# Lijst van bestandsnamen laden vanuit de CSV (exclusief extensie)
$objectNumbers = Import-Csv -Path $csvPath | Select-Object -ExpandProperty objectnummer

# HashSet om bij te houden welke bestanden al zijn gekopieerd
$copiedFiles = @{}

# Door alle submappen zoeken naar bestanden
Get-ChildItem -Path $searchRoot -Recurse -File | ForEach-Object {
    $fileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    
    # Controleer of de bestandsnaam in de lijst staat en nog niet is gekopieerd
    if ($objectNumbers -contains $fileNameWithoutExtension -and -not $copiedFiles.ContainsKey($fileNameWithoutExtension)) {
        # Kopieer het bestand naar de doelmap
        Copy-Item -Path $_.FullName -Destination $destinationPath

        # Voeg de bestandsnaam toe aan de HashSet om duplicaten te voorkomen
        $copiedFiles[$fileNameWithoutExtension] = $true

        Write-Host "Bestand gekopieerd: $($_.FullName)"
    }
}

Write-Host "Bestanden kopiëren voltooid."
