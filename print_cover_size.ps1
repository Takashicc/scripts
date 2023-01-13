Add-Type -AssemblyName System.Drawing

$dirs = Get-ChildItem -Directory
foreach ($dir in $dirs) {
    $cover_image_path = Join-Path "$dir" "0001.jpg"
    if ( -not (Test-Path -LiteralPath "$cover_image_path" -Type Leaf)) {
        Write-Host "The cover file does not exists.($($cover_image_path))" -ForegroundColor Red
        continue
    }

    $cover_image_info = New-Object System.Drawing.Bitmap "$cover_image_path"
    Write-Host "Width x Height: $($cover_image_info.Width) X $($cover_image_info.Height), Filepath: $($cover_image_path)"
}
