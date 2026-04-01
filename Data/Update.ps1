# Quét tất cả file trừ chính nó và file html
$files = Get-ChildItem -Exclude "index.html", "Update.ps1", "data.js"
$jsContent = "const myFiles = ["

foreach ($f in $files) {
    $type = "code"
    if ($f.Extension -eq ".iso") { $type = "iso" }
    elseif ($f.Attributes -match "Directory") { $type = "folder" }
    elseif ($f.Extension -eq ".zip" -or $f.Extension -eq ".rar" -or $f.Extension -eq ".7z") { $type = "archive" }
    
    $size = ($f.Length / 1MB).ToString("F2") + " MB"
    if ($f.Attributes -match "Directory") { $size = "Folder" }

    $jsContent += "{ name: '$($f.Name)', type: '$type', link: './$($f.Name)', size: '$size' },"
}

$jsContent = $jsContent.TrimEnd(",") + "];"
$jsContent | Out-File -FilePath "data.js" -Encoding utf8
Write-Host "Success! Da cap nhat danh sach file." -ForegroundColor Green