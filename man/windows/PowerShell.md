
### Win10 下批量把 GBK 文件转成 UTF-8
```shell

Get-ChildItem -Recurse -Include *.txt,*.cpp,*.h,*.cs | ForEach-Object {
    Write-Host "Converting:" $_.FullName
    $content = Get-Content $_.FullName -Encoding Default
    Set-Content $_.FullName -Value $content -Encoding UTF8
}

```
