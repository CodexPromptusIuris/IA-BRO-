# IA,BRO deployment

Use these scripts to deploy IA,BRO locally or on a remote server.

## Local deployment

Windows:

```bat
deploy\local-deploy.bat
```

PowerShell:

```powershell
pwsh ./deploy/local-deploy.ps1
```

Linux/macOS:

```bash
bash ./deploy/local-deploy.sh
```

## Remote deployment

```powershell
pwsh ./deploy/server-deploy.ps1 -Host your-server-ip
```
