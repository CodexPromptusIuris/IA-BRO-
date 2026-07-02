param(
    [Parameter(Mandatory = $true)]
    [string]$Host,

    [string]$User = "root",
    [string]$RemotePath = "/opt/ia-bro",
    [string]$Branch = "main"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
& "$scriptDir/deploy-fullstack.ps1" -Target server -Host $Host -User $User -RemotePath $RemotePath -Branch $Branch
