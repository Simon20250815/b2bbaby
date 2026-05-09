$login = Invoke-RestMethod -Uri 'http://localhost:8055/auth/login' -Method Post -Body (@{email='admin@b2bbaby.com';password='admin_password_2026'} | ConvertTo-Json) -ContentType 'application/json'
$token = $login.data.access_token
$headers = @{
    Authorization="Bearer $token"
    "Content-Type"="application/json"
}

function Set-Field {
    param($collection, $field, $interface, $options)
    $body = @{interface=$interface; options=$options} | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri "http://localhost:8055/fields/$collection/$field" -Method PATCH -Body $body -Headers $headers | Out-Null
        Write-Host "OK: $collection.$field"
    } catch {
        Write-Host "FAIL: $collection.$field - $($_.Exception.Message)"
    }
}

Write-Host "Configuring Products fields..."
Set-Field -collection "products" -field "title" -interface "input" -options @{placeholder="Product Name";trim=$true}
Set-Field -collection "products" -field "title_en" -interface "input" -options @{placeholder="English Title";trim=$true}
Set-Field -collection "products" -field "slug" -interface "input" -options @{placeholder="URL slug";trim=$true}
Set-Field -collection "products" -field "category" -interface "select-dropdown" -options @{choices=@(@("Stroller","Stroller"),@("Safety Gate","Safety Gate"),@("High Chair","High Chair"),@("Bed Rail","Bed Rail"));placeholder="Select category"}
Set-Field -collection "products" -field "description" -interface "textarea" -options @{placeholder="Product description in Chinese";rows=5}
Set-Field -collection "products" -field "description_en" -interface "textarea" -options @{placeholder="Product description in English";rows=5}
Set-Field -collection "products" -field "moq" -interface "input" -options @{placeholder="Minimum Order Quantity";type="number"}
Set-Field -collection "products" -field "lead_time_sample" -interface "input" -options @{placeholder="e.g. 7-10 days"}
Set-Field -collection "products" -field "lead_time_production" -interface "input" -options @{placeholder="e.g. 15-25 days"}
Set-Field -collection "products" -field "certifications" -interface "tags" -options @{placeholder="ASTM, CE, CPC";trim=$true}
Set-Field -collection "products" -field "target_markets" -interface "tags" -options @{placeholder="US, EU, Canada";trim=$true}
Set-Field -collection "products" -field "image" -interface "file-image" -options @{}
Set-Field -collection "products" -field "gallery_images" -interface "files" -options @{}
Set-Field -collection "products" -field "specs" -interface "repeatable" -options @{fields=@(@{field="label";name="Label";type="string";meta=@{interface="input"}},@{field="value";name="Value";type="string";meta=@{interface="input"}})}
Set-Field -collection "products" -field "features" -interface "repeatable" -options @{fields=@(@{field="text";name="Feature";type="string";meta=@{interface="input"}})}
Set-Field -collection "products" -field "custom_options" -interface "repeatable" -options @{fields=@(@{field="name";name="Option Name";type="string";meta=@{interface="input"}},@{field="price";name="Price";type="decimal";meta=@{interface="input"}})}
Set-Field -collection "products" -field "status" -interface "select-dropdown" -options @{choices=@(@("draft","Draft"),@("published","Published"));placeholder="Select status"}
Set-Field -collection "products" -field "sort" -interface "input" -options @{placeholder="0";type="number"}

Write-Host ""
Write-Host "Configuring FAQs fields..."
Set-Field -collection "faqs" -field "question" -interface "input" -options @{placeholder="Question in Chinese";trim=$true}
Set-Field -collection "faqs" -field "question_en" -interface "input" -options @{placeholder="Question in English";trim=$true}
Set-Field -collection "faqs" -field "answer" -interface "textarea" -options @{placeholder="Answer in Chinese";rows=5}
Set-Field -collection "faqs" -field "answer_en" -interface "textarea" -options @{placeholder="Answer in English";rows=5}
Set-Field -collection "faqs" -field "category" -interface "select-dropdown" -options @{choices=@(@("Products","Products"),@("Orders","Orders"),@("Shipping","Shipping"),@("Customs","Customs"),@("Payment","Payment"));placeholder="Select category"}
Set-Field -collection "faqs" -field "sort" -interface "input" -options @{placeholder="0";type="number"}

Write-Host ""
Write-Host "Configuring Blogs fields..."
Set-Field -collection "blogs" -field "title" -interface "input" -options @{placeholder="Blog Title in Chinese";trim=$true}
Set-Field -collection "blogs" -field "title_en" -interface "input" -options @{placeholder="Blog Title in English";trim=$true}
Set-Field -collection "blogs" -field "slug" -interface "input" -options @{placeholder="URL slug";trim=$true}
Set-Field -collection "blogs" -field "excerpt" -interface "textarea" -options @{placeholder="Summary in Chinese";rows=3}
Set-Field -collection "blogs" -field "excerpt_en" -interface "textarea" -options @{placeholder="Summary in English";rows=3}
Set-Field -collection "blogs" -field "content" -interface "textarea" -options @{placeholder="Content in Chinese";rows=10}
Set-Field -collection "blogs" -field "content_en" -interface "textarea" -options @{placeholder="Content in English";rows=10}
Set-Field -collection "blogs" -field "cover_image" -interface "file-image" -options @{}
Set-Field -collection "blogs" -field "author" -interface "input" -options @{placeholder="Author Name"}
Set-Field -collection "blogs" -field "tags" -interface "tags" -options @{placeholder="baby, stroller, safety"}
Set-Field -collection "blogs" -field "date_published" -interface "datetime" -options @{}
Set-Field -collection "blogs" -field "status" -interface "select-dropdown" -options @{choices=@(@("draft","Draft"),@("published","Published"));placeholder="Select status"}

Write-Host ""
Write-Host "All interfaces configured! Please refresh Directus admin page."