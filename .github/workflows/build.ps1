param (
    [string]$BuildName = "ManualBuild"
)

$UE_PATH = "C:\Program Files\Epic Games\UE_5.6\Engine\Build\BatchFiles\RunUAT.bat"
$PROJECT_PATH = "$PSScriptRoot\..\..\YourProjectName.uproject"
$BASE_ARCHIVE_PATH = "$PSScriptRoot\..\..\Builds"
$FINAL_PATH = "$BASE_ARCHIVE_PATH\$BuildName"

Write-Host "Starting Build: $BuildName"

# 1. Clean old build folder if it exists
if (Test-Path $FINAL_PATH) { Remove-Item -Recurse -Force $FINAL_PATH }

# 2. Run the actual Unreal Build
& $UE_PATH BuildCookRun `
-project=$PROJECT_PATH `
-noP4 -platform=Win64 -clientconfig=Development `
-cook -allmaps -build -stage -pak -archive `
-archivedirectory=$FINAL_PATH

# 3. Zip it up for easy sharing
$ZipFile = "$BASE_ARCHIVE_PATH\$BuildName.zip"
if (Test-Path $ZipFile) { Remove-Item $ZipFile }
Compress-Archive -Path "$FINAL_PATH\Windows\*" -DestinationPath $ZipFile

Write-Host "Done! Your build is zipped at $ZipFile"
