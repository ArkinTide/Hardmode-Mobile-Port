$ErrorActionPreference = 'Stop'
if (Test-Path 'H:/') { throw 'H: is in use; refusing to replace it.' }
& subst.exe H: $PSScriptRoot
if ($LASTEXITCODE -ne 0) { throw 'Could not map workspace path.' }
try {
    $toolchainRoot = Join-Path (Split-Path $PSScriptRoot) 'ntte-complete/android-delivery/toolchain'
    $env:JAVA_HOME = (Get-ChildItem -LiteralPath $toolchainRoot -Directory -Filter 'jdk-17*' | Select-Object -First 1).FullName
    $env:ANDROID_HOME = 'H:/platforms/android/sdk'
    $env:ANDROID_SDK_ROOT = $env:ANDROID_HOME
    $env:GRADLE_USER_HOME = 'H:/platforms/android/gradle-home'
    New-Item -ItemType Directory -Force 'H:/platforms/android/tmp' | Out-Null
    $env:TEMP = 'H:/platforms/android/tmp'
    $env:TMP = $env:TEMP
    $env:JAVA_TOOL_OPTIONS = '-Duser.home=H:/platforms/android/user-home -Djava.io.tmpdir=H:/platforms/android/tmp'
    $env:PATH = "$env:JAVA_HOME/bin;$env:PATH"
    & "$toolchainRoot/gradle-8.9/bin/gradle.bat" -p 'H:/platforms/android/gradle-project' --offline --no-daemon --max-workers=2 --console=plain assembleRelease > "$PSScriptRoot/platforms/android/gradle-build.log" 2>&1
    $buildExit = $LASTEXITCODE
    Get-Content -LiteralPath "$PSScriptRoot/platforms/android/gradle-build.log" -Tail 24
    if ($buildExit -ne 0) { throw "APK assembly failed with exit code $buildExit" }
} finally {
    & subst.exe H: /D
}
