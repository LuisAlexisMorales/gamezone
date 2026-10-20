$ErrorActionPreference = 'Stop'
Set-Location (Split-Path $PSScriptRoot -Parent)

function DesbloquearTemporales {
    foreach ($directorio in @('ios/Flutter/ephemeral', 'macos/Flutter/ephemeral')) {
        if (Test-Path -LiteralPath $directorio) {
            Get-Item -LiteralPath $directorio -Force | ForEach-Object {
                $_.Attributes = $_.Attributes -band (-bnot [IO.FileAttributes]::ReadOnly)
            }
            Get-ChildItem -LiteralPath $directorio -Force -Recurse | ForEach-Object {
                $_.Attributes = $_.Attributes -band (-bnot [IO.FileAttributes]::ReadOnly)
            }
        }
    }
}

DesbloquearTemporales
flutter pub get
if ($LASTEXITCODE -ne 0) { throw 'No se pudieron instalar las dependencias.' }
DesbloquearTemporales
flutter run -d chrome --no-pub
