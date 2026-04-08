# Script quét thư mục và tạo file data.js
$files = Get-ChildItem -Exclude "index.html", "Update.ps1", "data.js"
$jsContent = "const myFiles = ["

foreach ($f in $files) {
    $type = "other"
    $ext = $f.Extension.ToLower()

    if ($f.Attributes -match "Directory") { 
        $type = "folder" 
        $size = "Folder"
    } else {
        if ($ext -eq ".iso") { $type = "iso" }
        elseif ($ext -eq ".zip" -or $ext -eq ".rar" -or $ext -eq ".7z") { $type = "archive" }
        elseif ($ext -eq ".exe" -or $ext -eq ".msi") { $type = "code" }
        $size = ($f.Length / 1MB).ToString("F2") + " MB"
    }

    $jsContent += "{ name: '$($f.Name)', type: '$type', link: './$($f.Name)', size: '$size' },"
}

$jsContent = $jsContent.TrimEnd(",") + "];"
$jsContent | Out-File -FilePath "data.js" -Encoding utf8
Write-Host "--- THANH CONG ---" -ForegroundColor Green
Write-Host "Da cap nhat danh sach file vao giao dien." -ForegroundColor White