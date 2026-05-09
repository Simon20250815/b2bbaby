$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json" -TimeoutSec 30
    $token = $loginResponse.data.access_token
    Write-Host "Login successful!"
} catch {
    Write-Host "Login failed: $_"
    exit 1
}

$headers = @{
    Authorization = "Bearer $token"
    "Content-Type" = "application/json"
}

$workflowBody = @{
    name = "Auto Build Frontend"
    description = "Auto trigger frontend build when content updated"
    status = "active"
    trigger = @{
        type = "event"
        event = "items.create,items.update,items.delete"
        collections = @("products", "faqs", "blogs", "about", "home", "oem_odm", "contact", "site_settings")
    }
    operations = @(
        @{
            key = "operation_1"
            name = "Trigger Build API"
            type = "request"
            position_x = 100
            position_y = 100
            options = @{
                url = "http://localhost:4324/api/build"
                method = "POST"
                headers = @{}
                body = ""
            }
        }
    )
} | ConvertTo-Json -Depth 10

try {
    $response = Invoke-RestMethod -Uri "http://localhost:8055/flows/1d12caff-fea9-4e39-80db-800e8b19fae1" -Method PUT -Body $workflowBody -ContentType "application/json" -Headers $headers -TimeoutSec 30
    Write-Host "Workflow updated successfully!"
    Write-Host "Name: $($response.name)"
    Write-Host "Status: $($response.status)"
} catch {
    Write-Host "Failed to update workflow: $_"
}