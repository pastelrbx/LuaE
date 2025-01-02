REM Warning: This file was created using AI, and I don't use Windows. If you have any problems with this file and you have Windows, and you know how to fix it, please create a pull request.

@echo off
if not exist "luau.exe" (
    for /f "delims=" %%i in ('powershell -NoProfile -Command " \
        $os = if ($env:OS -like '*Windows_NT*') { 'windows' } else { 'macos' }; \
        $release = Invoke-RestMethod -Uri 'https://api.github.com/repos/luau-lang/luau/releases/latest'; \
        $asset = $release.assets | Where-Object { $_.name -like '*luau-' + $os + '*.zip' } | Select-Object -First 1; \
        if ($asset) { $asset.browser_download_url } else { exit 1 }"') do (
        powershell -NoProfile -Command "Invoke-WebRequest -Uri '%%i' -OutFile 'luau.zip'; Expand-Archive -Path 'luau.zip' -DestinationPath '.' -Force; Remove-Item 'luau.zip';"
    )
)
luau.exe _wrapper.luau -a %*