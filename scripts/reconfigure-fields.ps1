$login = Invoke-RestMethod -Uri 'http://localhost:8055/auth/login' -Method Post -Body (@{email='admin@b2bbaby.com';password='admin_password_2026'} | ConvertTo-Json) -ContentType 'application/json'
$token = $login.data.access_token
$headers = @{
    Authorization="Bearer $token"
    "Content-Type"="application/json"
}

function Set-FieldConfig {
    param($collection, $field, $type, $interface, $special, $options)
    Write-Host "Setting $collection.$field..."
    
    $body = @{
        type = $type
        interface = $interface
        special = $special
        options = $options
    } | ConvertTo-Json -Depth 5
    
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection/$field" -Method PATCH -Body $body -Headers $headers | Out-Null
        Write-Host "  OK"
    } catch {
        Write-Host "  FAIL: $($_.Exception.Message)"
    }
}

Write-Host "=== Reconfiguring Products collection ==="
Set-FieldConfig -collection "products" -field "image" -type "string" -interface "file-image" -special "file" -options @{}
Set-FieldConfig -collection "products" -field "gallery_images" -type "string" -interface "files" -special "files" -options @{}
Set-FieldConfig -collection "products" -field "title" -type "string" -interface "input" -special $null -options @{placeholder="Product Title"}
Set-FieldConfig -collection "products" -field "title_en" -type "string" -interface "input" -special $null -options @{placeholder="Product Title (English)"}
Set-FieldConfig -collection "products" -field "description" -type "text" -interface "textarea" -special $null -options @{placeholder="Description"; rows=5}
Set-FieldConfig -collection "products" -field "description_en" -type "text" -interface "textarea" -special $null -options @{placeholder="Description (English)"; rows=5}
Set-FieldConfig -collection "products" -field "category" -type "string" -interface "input" -special $null -options @{placeholder="Category"}
Set-FieldConfig -collection "products" -field "moq" -type "string" -interface "input" -special $null -options @{placeholder="MOQ"}
Set-FieldConfig -collection "products" -field "price" -type "string" -interface "input" -special $null -options @{placeholder="Price"}
Set-FieldConfig -collection "products" -field "certifications" -type "string" -interface "tags" -special $null -options @{placeholder="Certifications"}
Set-FieldConfig -collection "products" -field "target_markets" -type "string" -interface "tags" -special $null -options @{placeholder="Target Markets"}

Write-Host ""
Write-Host "=== Reconfiguring About collection ==="
Set-FieldConfig -collection "about" -field "image" -type "string" -interface "file-image" -special "file" -options @{}
Set-FieldConfig -collection "about" -field "gallery_images" -type "string" -interface "files" -special "files" -options @{}
Set-FieldConfig -collection "about" -field "company_name" -type "string" -interface "input" -special $null -options @{placeholder="Company Name"}
Set-FieldConfig -collection "about" -field "description" -type "text" -interface "textarea" -special $null -options @{placeholder="Description"; rows=5}

Write-Host ""
Write-Host "=== Reconfiguring Home collection ==="
Set-FieldConfig -collection "home" -field "hero_image" -type "string" -interface "file-image" -special "file" -options @{}
Set-FieldConfig -collection "home" -field "hero_title" -type "string" -interface "input" -special $null -options @{placeholder="Hero Title"}
Set-FieldConfig -collection "home" -field "hero_subtitle" -type "text" -interface "textarea" -special $null -options @{placeholder="Hero Subtitle"; rows=3}

Write-Host ""
Write-Host "=== Reconfiguring OEM/ODM collection ==="
Set-FieldConfig -collection "oem_odm" -field "image" -type "string" -interface "file-image" -special "file" -options @{}
Set-FieldConfig -collection "oem_odm" -field "gallery_images" -type "string" -interface "files" -special "files" -options @{}
Set-FieldConfig -collection "oem_odm" -field "title" -type "string" -interface "input" -special $null -options @{placeholder="Title"}
Set-FieldConfig -collection "oem_odm" -field "description" -type "text" -interface "textarea" -special $null -options @{placeholder="Description"; rows=5}

Write-Host ""
Write-Host "=== Reconfiguring Blogs collection ==="
Set-FieldConfig -collection "blogs" -field "cover_image" -type "string" -interface "file-image" -special "file" -options @{}
Set-FieldConfig -collection "blogs" -field "title" -type "string" -interface "input" -special $null -options @{placeholder="Blog Title"}
Set-FieldConfig -collection "blogs" -field "content" -type "text" -interface "textarea" -special $null -options @{placeholder="Content"; rows=8}

Write-Host ""
Write-Host "=== Reconfiguring Site Settings collection ==="
Set-FieldConfig -collection "site_settings" -field "logo" -type "string" -interface "file-image" -special "file" -options @{}
Set-FieldConfig -collection "site_settings" -field "favicon" -type "string" -interface "file-image" -special "file" -options @{}
Set-FieldConfig -collection "site_settings" -field "site_title" -type "string" -interface "input" -special $null -options @{placeholder="Site Title"}

Write-Host ""
Write-Host "=== Reconfiguring FAQs collection ==="
Set-FieldConfig -collection "faqs" -field "question" -type "string" -interface "input" -special $null -options @{placeholder="Question"}
Set-FieldConfig -collection "faqs" -field "question_en" -type "string" -interface "input" -special $null -options @{placeholder="Question (English)"}
Set-FieldConfig -collection "faqs" -field "answer" -type "text" -interface "textarea" -special $null -options @{placeholder="Answer"; rows=4}
Set-FieldConfig -collection "faqs" -field "answer_en" -type "text" -interface "textarea" -special $null -options @{placeholder="Answer (English)"; rows=4}

Write-Host ""
Write-Host "=== Reconfiguring Contact collection ==="
Set-FieldConfig -collection "contact" -field "company_name" -type "string" -interface "input" -special $null -options @{placeholder="Company Name"}
Set-FieldConfig -collection "contact" -field "address" -type "text" -interface "textarea" -special $null -options @{placeholder="Address"; rows=3}
Set-FieldConfig -collection "contact" -field "phone" -type "string" -interface "input" -special $null -options @{placeholder="Phone"}
Set-FieldConfig -collection "contact" -field "email" -type "string" -interface "input" -special $null -options @{placeholder="Email"}

Write-Host ""
Write-Host "✅ All fields reconfigured! Please refresh Directus admin page."