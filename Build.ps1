$ErrorActionPreference = "Stop"

Write-Host "--- Build started ---" -ForegroundColor Yellow

if (Test-Path "Game.exe") {
    Remove-Item "Game.exe" -Force
}

$sources = Get-ChildItem -Path "Sources/Runtime" -Filter "*.hylo" -Recurse | ForEach-Object { $_.FullName }

$currentDir = Get-Location

$env:LIB = "$currentDir\Libraries"
$env:LIB += ";C:\Program Files\Microsoft Visual Studio\18\Community\VC\Tools\MSVC\14.50.35717\lib\x64"
$env:LIB += ";C:\Program Files (x86)\Windows Kits\10\Lib\10.0.26100.0\um\x64"
$env:LIB += ";C:\Program Files (x86)\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64"

$env:LINK = "/DEFAULTLIB:SDL3"

& hc $sources `
  --experimental-parallel-typechecking `
  -O `
  -o "Game.exe"

if (Test-Path "Game.exe") {
    Write-Host "--- Build succeeded ---" -ForegroundColor Green
} else {
    Write-Error "--- Build failed ---"
}
