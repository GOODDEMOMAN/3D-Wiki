@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -Filter '_*' | Rename-Item -NewName {$_.Name -replace '^_', ''}"
echo Готово!
pause