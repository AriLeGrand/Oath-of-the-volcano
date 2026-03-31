param (
    [string]$BuildName = "Weekly-Build",
    # This magic line finds the real Downloads folder for the current user
    [string]$OutputPath = "$HOME\Downloads" 
)

# 1. FIND THE ENGINE (Now with 3-way Auto-Detect)
Write-Host "Searching for Unreal Engine 5.6..."
$UE_PATH = ""
$RegPaths = @(
    "HKLM:\SOFTWARE\EpicGames\Unreal Engine\5.6",
    "HKCU:\Software\Epic Games\Unreal Engine\Builds"
)

foreach ($Path in $RegPaths) {
    $Dir = (Get-ItemProperty -Path $Path -ErrorAction SilentlyContinue).InstalledDirectory
    if ($Dir) { $UE_PATH = Join-Path $Dir "Engine\Build\BatchFiles\RunUAT.bat"; break }
}

# Final Fallback: Common School Install Path
if (-not (Test-Path $UE_PATH)) {
    $UE_PATH = "C:\Program Files\Epic Games\UE_5.6\Engine\Build\BatchFiles\RunUAT.bat"
}

if (-not (Test-Path $UE_PATH)) {
    Write-Error "CRITICAL: Could not find UE 5.6. Check if it's installed!"
    exit 1
}

# 2. RESOLVE PROJECT
# Finds the .uproject file automatically in the root of your repo
$PROJECT_FILE = Get-ChildItem -Path "$PSScriptRoot\..\..\*.uproject" | Select-Object -First 1
if (-not $PROJECT_FILE) { Write-Error "No .uproject file found!"; exit 1 }

$FINAL_PATH = Join-Path $OutputPath "UE5_Builds\$BuildName"

Write-Host "--- BUILD CONFIG ---"
Write-Host "Engine: $UE_PATH"
Write-Host "Project: $($PROJECT_FILE.FullName)"
Write-Host "Output: $FINAL_PATH"

# 3. CLEAN OLD DATA
if (Test-Path $FINAL_PATH) { Remove-Item -Recurse -Force $FINAL_PATH }
New-Item -ItemType Directory -Path $FINAL_PATH -Force | Out-Null

# 4. RUN UNREAL BUILD (The heavy lifting)
& $UE_PATH BuildCookRun `
-project="$($PROJECT_FILE.FullName)" `
-noP4 -platform=Win64 -clientconfig=Development `
-cook -allmaps -build -stage -pak -archive `
-archivedirectory="$FINAL_PATH"

# 5. ZIP FOR SUBMISSION
$ZipFile = Join-Path $OutputPath "$BuildName.zip"
Write-Host "Zipping build to $ZipFile..."
if (Test-Path $ZipFile) { Remove-Item $ZipFile }
Compress-Archive -Path "$FINAL_PATH\Windows\*" -DestinationPath $ZipFile

Write-Host "--- FINISHED ---"
Write-Host "Success! Check your Downloads folder."
