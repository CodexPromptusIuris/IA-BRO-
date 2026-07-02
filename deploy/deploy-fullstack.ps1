param(
    [ValidateSet("local", "server")]
    [string]$Target = "local",

    [string]$Host,
    [string]$User = "root",
    [string]$RemotePath = "/opt/ia-bro",
    [string]$Branch = "main",
    [int]$Port = 4200
)

$ErrorActionPreference = "Stop"
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$composeFile = Join-Path $repoRoot "docker-compose.yml"

if (-not (Test-Path $composeFile)) {
    throw "Docker compose file not found at $composeFile"
}

Write-Host "Deploy target: $Target"

function Invoke-LocalDeploy {
    Write-Host "Starting local deployment..."
    Push-Location $repoRoot
    try {
        if (Test-Path (Join-Path $repoRoot ".env")) {
            Write-Host "Using .env file for configuration"
        }
        else {
            Write-Warning "No .env file found. The app may start with default environment values."
        }

        docker compose -f $composeFile up -d --build
        Write-Host "Deployment completed successfully."
        Write-Host "Open http://localhost:$Port"
    }
    finally {
        Pop-Location
    }
}

function Invoke-ServerDeploy {
    if (-not $Host) {
        throw "Host is required when Target is 'server'."
    }

    Write-Host "Deploying to server $User@$Host"

    $remoteScript = @"
set -e
mkdir -p $RemotePath
cd $RemotePath
if [ -d .git ]; then
  git fetch origin $Branch
  git checkout $Branch
  git pull origin $Branch
else
  echo 'Repository is not initialized on the remote host.'
  exit 1
fi
docker compose up -d --build
"@

    $remoteScript | ssh "$User@$Host" "bash -s"
    Write-Host "Remote deployment completed successfully."
}

switch ($Target) {
    "local" { Invoke-LocalDeploy }
    "server" { Invoke-ServerDeploy }
}
