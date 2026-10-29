param([ValidateSet('windows','android','ios')][string]$Target = 'windows')
$ErrorActionPreference = 'Stop'
if ($Target -eq 'windows' -and (Test-Path -LiteralPath (Join-Path $PSScriptRoot 'build-windows/.vm-test-in-use.json'))) {
    throw 'A Windows VM regression is active. Finish the test process before rebuilding.'
}
$buildRoot = Join-Path $PSScriptRoot ('build-' + $Target)
New-Item -ItemType Directory -Force -Path $buildRoot | Out-Null
$runtimeRoot = 'C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23'
$igor = Join-Path $runtimeRoot 'bin/igor/windows/x64/Igor.exe'
$buildArgs = @(
    "--project=$PSScriptRoot/project/nuclearthronemobile.yyp",
    "--runtimePath=$runtimeRoot",
    '--user=C:/Users/ArkinTide/AppData/Roaming/GameMakerStudio2-LTS2026/liutianhao683_5123854',
    "--cache=$buildRoot/cache", "--temp=$buildRoot/temp",
    "--of=$buildRoot/game.$Target", "--tf=$buildRoot/game.$Target",
    '--runtime=VM', $Target, 'Compile'
)
if ($Target -eq 'android') {
    $buildArgs = $buildArgs | Where-Object { $_ -notlike '--user=*' }
    $buildArgs = @("--user=$PSScriptRoot/platforms/android/user", "--licencefile=C:/Users/ArkinTide/AppData/Roaming/GameMakerStudio2-LTS2026/liutianhao683_5123854/licence.plist") + $buildArgs
    $buildArgs[-1] = 'Package'
    $toolchainRoot = Join-Path (Split-Path $PSScriptRoot) 'ntte-complete/android-delivery/toolchain'
    $env:JAVA_HOME = (Get-ChildItem -LiteralPath $toolchainRoot -Directory -Filter 'jdk-17*' | Select-Object -First 1).FullName
    $env:ANDROID_HOME = Join-Path $toolchainRoot 'sdk'
    $env:ANDROID_SDK_ROOT = $env:ANDROID_HOME
    $env:GRADLE_USER_HOME = "$PSScriptRoot/platforms/android/gradle-home"
    $env:GRADLE_OPTS = '-Dorg.gradle.daemon=false'
    $env:PATH = "$env:JAVA_HOME/bin;$env:PATH"
}
& $igor @buildArgs > (Join-Path $PSScriptRoot ('build-' + $Target + '.log')) 2>&1
$buildExit = $LASTEXITCODE
Get-Content -LiteralPath (Join-Path $PSScriptRoot ('build-' + $Target + '.log')) -Tail 12
if ($buildExit -ne 0) { throw "Igor exited with code $buildExit" }
