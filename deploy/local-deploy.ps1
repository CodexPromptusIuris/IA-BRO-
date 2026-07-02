Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
& "$scriptDir/deploy-fullstack.ps1" -Target local
