param (
    [string]$BuildName = "Weekly-Build",
    [string]$OutputPath = "$PSScriptRoot\..\..\Builds" # Default location
)

# 1. FIND THE ENGINE (Auto-detect)
$RegPath = "HKLM:\SOFTWARE\EpicGames\Unreal Engine\5.6"
$InstallDir = (Get-ItemProperty -Path $RegPath -ErrorAction SilentlyContinue).InstalledDirectory
$UE_PATH = Join-Path $InstallDir "Engine\Build\BatchFiles\RunUAT.bat"

if (-not (Test-Path $UE_PATH)) {
    Write-Error "Unreal Engine 5.6 not found. Please check your installation."
    exit 1
}

# 2. SET UP DIRECTORIES
$PROJECT_PATH = Resolve-Path "$PSScriptRoot\..\..\*.uproject" # Auto-finds your .uproject file
$FINAL_PATH = Join-Path $OutputPath $BuildName

Write-Host "--- BUILD STARTING ---"
Write-Host "Project: $PROJECT_PATH"
Write-Host "Destination: $FINAL_PATH"

# 3. CLEAN OLD DATA
if (Test-Path $FINAL_PATH) { Remove-Item -Recurse -Force $FINAL_PATH }
New-Item -ItemType Directory -Path $FINAL_PATH -Force | Out-Null

# 4. RUN UNREAL BUILD
& $UE_PATH BuildCookRun `
-project=$PROJECT_PATH `
-noP4 -platform=Win64 -clientconfig=Development `
-cook -allmaps -build -stage -pak -archive `
-archivedirectory=$FINAL_PATH

# 5. ZIP FOR SUBMISSION
$ZipFile = Join-Path $OutputPath "$BuildName.zip"
if (Test-Path $ZipFile) { Remove-Item $ZipFile }
Compress-Archive -Path "$FINAL_PATH\Windows\*" -DestinationPath $ZipFile

Write-Host "--- FINISHED ---"
Write-Host "Your build is ready at: $ZipFile"
