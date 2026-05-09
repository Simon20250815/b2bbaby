Write-Host "🔐 Logging in to Directus..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in successfully!"
Write-Host ""

function Add-Field {
    param(
        [string]$collection,
        [string]$field,
        [string]$type,
        [string]$label
    )
    Write-Host "   Adding $field..."
    $body = @{
        field = $field
        type = $type
        meta = @{ label = $label }
    } | ConvertTo-Json
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection" -Method POST -Body $body -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
        Write-Host "     ✓ Added: $label"
    } catch {
        Write-Host "     ⚠️  $field may already exist"
    }
}

Write-Host "📦 Adding missing fields to Products..."
Add-Field -collection "products" -field "export_batches" -type "integer" -label "出口批次"
Add-Field -collection "products" -field "zero_return_rate" -type "boolean" -label "零退货率"
Add-Field -collection "products" -field "packaging" -type "text" -label "包装信息"
Add-Field -collection "products" -field "applications" -type "json" -label "应用场景"
Add-Field -collection "products" -field "test_report_number" -type "string" -label "检测报告编号"

Write-Host ""
Write-Host "✅ 字段添加完成!"
Write-Host ""
Write-Host "Now updating Astro to fetch data from Directus..."