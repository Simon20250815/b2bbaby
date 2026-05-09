Write-Host "🔐 Logging in to Directus..."

$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token

Write-Host "✅ Logged in successfully!"
Write-Host ""

function Create-Collection {
    param(
        [string]$name
    )
    Write-Host "📦 Creating $name collection..."
    $body = @{
        collection = $name
        meta = @{ singleton = $false }
        schema = @{ name = $name }
    } | ConvertTo-Json
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/collections" -Method Post -Body $body -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
        Write-Host "   ✓ Created: $name"
    } catch {
        Write-Host "   ⚠️  $name may already exist"
    }
}

function Create-Field {
    param(
        [string]$collection,
        [string]$field,
        [string]$type,
        [bool]$required = $false
    )
    $body = @{
        field = $field
        type = $type
        meta = @{ required = $required }
    } | ConvertTo-Json
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection" -Method Post -Body $body -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" } | Out-Null
        Write-Host "     ✓ $field"
    } catch {
        Write-Host "     ⚠️  $field may already exist"
    }
}

Create-Collection "products"
$productFields = @(
    @{ field = "slug"; type = "string"; required = $true },
    @{ field = "title"; type = "string"; required = $true },
    @{ field = "title_en"; type = "string" },
    @{ field = "category"; type = "string" },
    @{ field = "description"; type = "text" },
    @{ field = "moq"; type = "integer" },
    @{ field = "lead_time_sample"; type = "string" },
    @{ field = "lead_time_production"; type = "string" },
    @{ field = "certifications"; type = "json" },
    @{ field = "target_markets"; type = "json" },
    @{ field = "image"; type = "text" },
    @{ field = "gallery_images"; type = "json" },
    @{ field = "specs"; type = "json" },
    @{ field = "features"; type = "json" },
    @{ field = "custom_options"; type = "json" },
    @{ field = "status"; type = "string" },
    @{ field = "sort"; type = "integer" }
)
foreach ($f in $productFields) {
    Create-Field -collection "products" -field $f.field -type $f.type -required $f.required
}

Write-Host ""
Create-Collection "faqs"
$faqFields = @(
    @{ field = "question"; type = "string"; required = $true },
    @{ field = "question_en"; type = "string" },
    @{ field = "answer"; type = "text" },
    @{ field = "answer_en"; type = "text" },
    @{ field = "category"; type = "string" },
    @{ field = "sort"; type = "integer" }
)
foreach ($f in $faqFields) {
    Create-Field -collection "faqs" -field $f.field -type $f.type -required $f.required
}

Write-Host ""
Create-Collection "blogs"
$blogFields = @(
    @{ field = "slug"; type = "string"; required = $true },
    @{ field = "title"; type = "string"; required = $true },
    @{ field = "title_en"; type = "string" },
    @{ field = "excerpt"; type = "text" },
    @{ field = "content"; type = "text" },
    @{ field = "cover_image"; type = "text" },
    @{ field = "author"; type = "string" },
    @{ field = "tags"; type = "json" },
    @{ field = "date_published"; type = "datetime" },
    @{ field = "status"; type = "string" }
)
foreach ($f in $blogFields) {
    Create-Field -collection "blogs" -field $f.field -type $f.type -required $f.required
}

Write-Host ""
Create-Collection "inquiries"
$inquiryFields = @(
    @{ field = "name"; type = "string"; required = $true },
    @{ field = "email"; type = "string"; required = $true },
    @{ field = "company"; type = "string" },
    @{ field = "phone"; type = "string" },
    @{ field = "product"; type = "string" },
    @{ field = "message"; type = "text" },
    @{ field = "status"; type = "string" }
)
foreach ($f in $inquiryFields) {
    Create-Field -collection "inquiries" -field $f.field -type $f.type -required $f.required
}

Write-Host ""
Write-Host "✅ Directus setup complete!"
Write-Host ""
Write-Host "📋 Collections created:"
Write-Host "   - products"
Write-Host "   - faqs"
Write-Host "   - blogs"
Write-Host "   - inquiries"
Write-Host ""
Write-Host "🌐 Open: http://localhost:8055/admin"