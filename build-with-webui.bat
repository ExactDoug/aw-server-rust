@echo off
set "PATH=%USERPROFILE%\.cargo\bin;%PATH%"
set "AW_WEBUI_DIR=C:\dev\projects\github\aw-server-rust\aw-webui\dist"
echo AW_WEBUI_DIR=[%AW_WEBUI_DIR%]

cd /d C:\dev\projects\github\aw-server-rust\aw-webui

echo === Prebuild: copying logo files to static/ ===
if not exist static mkdir static
copy /Y media\logo\logo.png static\logo.png
copy /Y media\logo\logo.svg static\logo.svg

echo === Building webui ===
call npm run build
if errorlevel 1 exit /b 1

cd /d C:\dev\projects\github\aw-server-rust
echo === Cleaning aw-server build ===
cargo clean -p aw-server
del /f /q target\release\aw-server.exe 2>nul

echo === Building aw-server with embedded webui ===
cargo build --release -p aw-server
