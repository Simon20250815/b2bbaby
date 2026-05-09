Write-Host "🔐 Logging in..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in"
Write-Host ""

Write-Host "📋 All roles:"
$roles = Invoke-RestMethod -Uri "http://localhost:8055/roles" -Method Get -Headers @{ Authorization = "Bearer $token" }
foreach ($role in $roles.data) {
    Write-Host "ID: $($role.id), Name: '$($role.name)', Public: $($role.public), Admin: $($role.admin_access)"
}

Write-Host ""
Write-Host "🔍 Public role details:"
$publicRole = $roles.data | Where-Object { $_.public -eq $true }
if ($publicRole) {
    Write-Host "Found public role: $($publicRole | ConvertTo-Json)"
} else {
    Write-Host "No public role found!"
}

Write-Host ""
Write-Host "📊 Permissions count:"
$perms = Invoke-RestMethod -Uri "http://localhost:8055/permissions" -Method Get -Headers @{ Authorization = "Bearer $token" }
Write-Host "Total permissions: $($perms.data.Count)"

Write-Host ""
Write-Host "🔍 Permissions for public role:"
if ($publicRole) {
    $publicPerms = $perms.data | Where-Object { $_.role -eq $publicRole.id }
    if ($publicPerms) {
        foreach ($perm in $publicPerms) {
            Write-Host "Collection: $($perm.collection), Action: $($perm.action)"
        }
    } else {
        Write-Host "No permissions found for public role"
    }
}