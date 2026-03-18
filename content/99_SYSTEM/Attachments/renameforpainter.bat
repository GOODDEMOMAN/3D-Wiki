@echo off
:: Переходим в папку, где лежит сам батник
cd /d "%~dp0"

powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -Filter '_*' | Rename-Item -NewName {$_.Name -replace '^_', ''}"

echo Готово! Все файлы в папке %cd% обработаны.
pause