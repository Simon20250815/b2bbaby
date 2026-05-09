Write-Host "=== B2B Baby Extension Installer ==="
Write-Host ""

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

Write-Host "1. Logging in to Directus..."
try {
    $loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json" -TimeoutSec 30
    $token = $loginResponse.data.access_token
    Write-Host "   OK: Login successful!"
} catch {
    Write-Host "   FAIL: Login failed - $_"
    exit 1
}

$headers = @{
    Authorization = "Bearer $token"
    "Content-Type" = "application/json"
}

Write-Host ""
Write-Host "2. Checking installed extensions..."
try {
    $extensions = Invoke-RestMethod -Uri "http://localhost:8055/extensions" -Headers $headers -TimeoutSec 30
    Write-Host "   OK: Found $($extensions.data.Count) installed extensions"
} catch {
    Write-Host "   WARN: Cannot list extensions - $_"
}

Write-Host ""
Write-Host "3. Installing recommended extensions..."

$extensionsToInstall = @(
    @{name = "CKEditor 5"; package = "@directus/extension-richtext-ckeditor"}
)

foreach ($ext in $extensionsToInstall) {
    Write-Host "   Installing $($ext.name)..."
    try {
        $installBody = @{ package = $ext.package } | ConvertTo-Json
        $response = Invoke-RestMethod -Uri "http://localhost:8055/extensions/install" -Method POST -Body $installBody -ContentType "application/json" -Headers $headers -TimeoutSec 120
        Write-Host "   OK: $($ext.name) installed!"
    } catch {
        Write-Host "   WARN: $($ext.name) installation failed or already installed - $_"
    }
}

Write-Host ""
Write-Host "4. Enabling extensions..."
try {
    $extensions = Invoke-RestMethod -Uri "http://localhost:8055/extensions" -Headers $headers -TimeoutSec 30
    foreach ($ext in $extensions.data) {
        if ($ext.status -eq "installed") {
            Write-Host "   Enabling $($ext.name)..."
            $updateBody = @{status = "enabled"} | ConvertTo-Json
            Invoke-RestMethod -Uri "http://localhost:8055/extensions/$($ext.id)" -Method PATCH -Body $updateBody -ContentType "application/json" -Headers $headers | Out-Null
            Write-Host "   OK: $($ext.name) enabled"
        }
    }
} catch {
    Write-Host "   WARN: Error enabling extensions - $_"
}

Write-Host ""
Write-Host "=== Extension installation complete ==="
Write-Host ""
Write-Host "Please refresh Directus admin page and configure new field types in data model."