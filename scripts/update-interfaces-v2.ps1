$loginBody = @{
    email = "admin@b2bbaby.com"
    password = "admin_password_2026"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8055/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginResponse.data.access_token
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

function Update-Field {
    param($collection, $fieldName, $interface, $options, $required = $false)

    $body = @{
        interface = $interface
        options = $options
        required = $required
    }

    try {
        $response = Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection/$fieldName" -Method PATCH -Body ($body | ConvertTo-Json) -Headers $headers
        Write-Host "OK: $collection.$fieldName"
    } catch {
        Write-Host "FAIL: $collection.$fieldName - $($_.Exception.Message.Split('"')[2])"
    }
}

Write-Host "Configuring Products field interfaces..."

$body = @{ interface = "input"; options = @{placeholder="Product Name"}; required = $true } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/title" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.title"

$body = @{ interface = "input"; options = @{placeholder="English Title"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/title_en" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.title_en"

$body = @{ interface = "select-dropdown"; options = @{choices=@(@("Stroller","Stroller"),@("Safety Gate","Safety Gate"),@("High Chair","High Chair"),@("Bed Rail","Bed Rail"));placeholder="Select category"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/category" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.category"

$body = @{ interface = "textarea"; options = @{placeholder="Product description in Chinese";rows=6} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/description" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.description"

$body = @{ interface = "textarea"; options = @{placeholder="Product description in English";rows=6} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/description_en" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.description_en"

$body = @{ interface = "input"; options = @{placeholder="Minimum Order Quantity";type="number"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/moq" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.moq"

$body = @{ interface = "input"; options = @{placeholder="e.g. 7-10 days"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/lead_time_sample" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.lead_time_sample"

$body = @{ interface = "input"; options = @{placeholder="e.g. 15-25 days"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/lead_time_production" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.lead_time_production"

$body = @{ interface = "tags"; options = @{placeholder="ASTM, CE, CPC"}; special = "json" } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/certifications" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.certifications"

$body = @{ interface = "tags"; options = @{placeholder="US, EU, Canada"}; special = "json" } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/target_markets" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.target_markets"

$body = @{ interface = "file-image"; options = @{}; special = "file" } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/image" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.image"

$body = @{ interface = "files"; options = @{}; special = "files" } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/gallery_images" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.gallery_images"

$body = @{ interface = "repeatable"; options = @{fields=@(@{field="text";name="Feature";type="string";meta=@{interface="input"}}}); special = "json" } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/features" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.features"

$body = @{ interface = "repeatable"; options = @{fields=@(@{field="label";name="Label";type="string";meta=@{interface="input"}},@{field="value";name="Value";type="string";meta=@{interface="input"}})}; special = "json" } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/specs" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.specs"

$body = @{ interface = "repeatable"; options = @{fields=@(@{field="name";name="Option Name";type="string";meta=@{interface="input"}},@{field="price";name="Price";type="decimal";meta=@{interface="input"}})}; special = "json" } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/custom_options" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.custom_options"

$body = @{ interface = "select-dropdown"; options = @{choices=@(@("draft","Draft"),@("published","Published"));placeholder="Select status"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/status" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.status"

$body = @{ interface = "input"; options = @{placeholder="0";type="number"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/products/sort" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: products.sort"

Write-Host ""
Write-Host "Configuring FAQs field interfaces..."

$body = @{ interface = "input"; options = @{placeholder="Question in Chinese"}; required = $true } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/question" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: faqs.question"

$body = @{ interface = "input"; options = @{placeholder="Question in English"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/question_en" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: faqs.question_en"

$body = @{ interface = "textarea"; options = @{placeholder="Answer in Chinese";rows=6} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/answer" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: faqs.answer"

$body = @{ interface = "textarea"; options = @{placeholder="Answer in English";rows=6} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/answer_en" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: faqs.answer_en"

$body = @{ interface = "select-dropdown"; options = @{choices=@(@("Products","Products"),@("Orders","Orders"),@("Shipping","Shipping"),@("Customs","Customs"),@("Payment","Payment"));placeholder="Select category"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/category" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: faqs.category"

$body = @{ interface = "input"; options = @{placeholder="0";type="number"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/faqs/sort" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: faqs.sort"

Write-Host ""
Write-Host "Configuring Blogs field interfaces..."

$body = @{ interface = "input"; options = @{placeholder="Blog Title in Chinese"}; required = $true } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/title" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.title"

$body = @{ interface = "input"; options = @{placeholder="Blog Title in English"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/title_en" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.title_en"

$body = @{ interface = "textarea"; options = @{placeholder="Short summary in Chinese";rows=3} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/excerpt" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.excerpt"

$body = @{ interface = "textarea"; options = @{placeholder="Short summary in English";rows=3} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/excerpt_en" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.excerpt_en"

$body = @{ interface = "textarea"; options = @{placeholder="Blog content in Chinese";rows=10} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/content" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.content"

$body = @{ interface = "textarea"; options = @{placeholder="Blog content in English";rows=10} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/content_en" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.content_en"

$body = @{ interface = "file-image"; options = @{}; special = "file" } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/cover_image" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.cover_image"

$body = @{ interface = "input"; options = @{placeholder="Author Name"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/author" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.author"

$body = @{ interface = "tags"; options = @{placeholder="baby, stroller, safety"}; special = "json" } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/tags" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.tags"

$body = @{ interface = "datetime"; options = @{} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/date_published" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.date_published"

$body = @{ interface = "select-dropdown"; options = @{choices=@(@("draft","Draft"),@("published","Published"));placeholder="Select status"} } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8055/fields/blogs/status" -Method PATCH -Body $body -Headers $headers | Out-Null
Write-Host "OK: blogs.status"

Write-Host ""
Write-Host "All field interfaces configured!"