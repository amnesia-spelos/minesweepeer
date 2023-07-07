$customStoryName = "minesweeper"
$uniqueId = "2eb09"
$dirName = "$customStoryName-$uniqueId"
$archiveName = "amnesia-$customStoryName-$uniqueId.7zip"

# Check if directory exists, if so delete it
if(Test-Path -Path $dirName)
{
    Remove-Item -Recurse -Force $dirName
}

# Check if archive exists, if so delete it
if(Test-Path -Path $archiveName)
{
    Remove-Item -Force $archiveName
}

# Create a new directory
New-Item -ItemType Directory -Path $dirName

# Copy directories and files into new directory preserving directory structure
Copy-Item -Path ../entities -Destination $dirName -Recurse
Copy-Item -Path ../maps -Destination $dirName -Recurse
Copy-Item -Path ../music -Destination $dirName -Recurse
Copy-Item -Path ../extra_english.lang -Destination $dirName
Copy-Item -Path ../customstory.png -Destination $dirName
Copy-Item -Path ../custom_story_settings.cfg -Destination $dirName
Copy-Item -Path ../LICENSE -Destination $dirName

try {
    $null = (where.exe 7z)
    $is7zipAvailable = $true
} catch {
    $is7zipAvailable = $false
}

# Check if 7zip is available on the system, if so use it to archive the directory
if($is7zipAvailable)
{
    & '7z' a -t7z -r $archiveName $dirName"\*"
}
