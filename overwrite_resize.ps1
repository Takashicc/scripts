$dirs = Get-ChildItem -Dir
foreach ($__dir in $dirs) {
    $dir_name = "$($__dir.FullName)"
    $resize_dir_name = Join-Path -Path "$($dir_name)" -ChildPath "resize"
    $resize_dir_exists = Test-Path -LiteralPath "$($resize_dir_name)" -PathType Container
    if ($resize_dir_exists) {
        Write-Host "Resize folder exists, At $($dir_name)" -ForegroundColor Green
    } else {
        Write-Host "Resize folder does not exists, At $($dir_name)" -ForegroundColor Red
        continue
    }

    Write-Host "Remove all files located at the dir(parent of the resize dir)."
    $parent_files = Get-ChildItem -LiteralPath "$($dir_name)" -File
    $parent_files | %{
        Remove-Item -LiteralPath "$($_.FullName)"
    }

    Write-Host "Move all files located at resize directory."
    Write-Host "Move $($resize_dir_name)/* -> $($dir_name)/*"
    $resize_files = Get-ChildItem -LiteralPath "$($resize_dir_name)" -File
    $resize_files | % {
        $filename = "$($_.Name)"
        $distination = Join-Path -Path "$($dir_name)" -ChildPath "$($filename)"
        Move-Item -LiteralPath "$($_.FullName)" -Destination "$($distination)"
    }

    $resize_dir_is_empty = (Get-ChildItem -LiteralPath "$($resize_dir_name)").Count -eq 0
    if ($resize_dir_is_empty) {
        Write-Host "Resize folder is empty. Deleting $($resize_dir_name)" -ForegroundColor Green
        Remove-Item -LiteralPath "$($resize_dir_name)"
    } else {
        Write-Host "Resize folder is not empty. Delete manually. $($resize_dir_name)" -ForegroundColor Red
    }
}
Write-Host "Abort..." -ForegroundColor Red
