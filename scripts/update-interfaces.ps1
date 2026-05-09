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
        Write-Host "FAIL: $collection.$fieldName - $($_.Exception.Message)"
    }
}

Write-Host "Configuring Products field interfaces..."
Update-Field -collection "products" -fieldName "title" -interface "input" -options (@{placeholder="Product Name";trim=true} | ConvertTo-Json) -required $true
Update-Field -collection "products" -fieldName "title_en" -interface "input" -options (@{placeholder="English Title";trim=true} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "category" -interface "select-dropdown" -options (@{choices=@(@("Stroller","Stroller"),@("Safety Gate","Safety Gate"),@("High Chair","High Chair"),@("Bed Rail","Bed Rail"));placeholder="Select category"} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "description" -interface "textarea" -options (@{placeholder="Product description in Chinese";rows=6;trim=true} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "description_en" -interface "textarea" -options (@{placeholder="Product description in English";rows=6;trim=true} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "moq" -interface "input" -options (@{placeholder="Minimum Order Quantity";type="number"} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "lead_time_sample" -interface "input" -options (@{placeholder="e.g. 7-10 days";trim=true} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "lead_time_production" -interface "input" -options (@{placeholder="e.g. 15-25 days";trim=true} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "certifications" -interface "tags" -options (@{placeholder="ASTM, CE, CPC";trim=true} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "target_markets" -interface "tags" -options (@{placeholder="US, EU, Canada";trim=true} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "image" -interface "file-image" -options (@{} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "gallery_images" -interface "files" -options (@{} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "features" -interface "repeatable" -options (@{fields=@(@{field="text";name="Feature";type="string";meta=@{interface="input";options=@{placeholder="Feature text";trim=true}}})} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "specs" -interface "repeatable" -options (@{fields=@(@{field="label";name="Label";type="string";meta=@{interface="input";options=@{placeholder="Label";trim=true}}},@{field="value";name="Value";type="string";meta=@{interface="input";options=@{placeholder="Value";trim=true}}})} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "custom_options" -interface "repeatable" -options (@{fields=@(@{field="name";name="Option Name";type="string";meta=@{interface="input";options=@{placeholder="Option name";trim=true}}},@{field="price";name="Price";type="decimal";meta=@{interface="input";options=@{placeholder="Additional price";type="decimal"}}})} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "status" -interface "select-dropdown" -options (@{choices=@(@("draft","Draft"),@("published","Published"));placeholder="Select status"} | ConvertTo-Json)
Update-Field -collection "products" -fieldName "sort" -interface "input" -options (@{placeholder="0";type="number"} | ConvertTo-Json)

Write-Host ""
Write-Host "Configuring FAQs field interfaces..."
Update-Field -collection "faqs" -fieldName "question" -interface "input" -options (@{placeholder="Question in Chinese";trim=true} | ConvertTo-Json) -required $true
Update-Field -collection "faqs" -fieldName "question_en" -interface "input" -options (@{placeholder="Question in English";trim=true} | ConvertTo-Json)
Update-Field -collection "faqs" -fieldName "answer" -interface "textarea" -options (@{placeholder="Answer in Chinese";rows=6;trim=true} | ConvertTo-Json)
Update-Field -collection "faqs" -fieldName "answer_en" -interface "textarea" -options (@{placeholder="Answer in English";rows=6;trim=true} | ConvertTo-Json)
Update-Field -collection "faqs" -fieldName "category" -interface "select-dropdown" -options (@{choices=@(@("Products","Products"),@("Orders","Orders"),@("Shipping","Shipping"),@("Customs","Customs"),@("Payment","Payment"));placeholder="Select category"} | ConvertTo-Json)
Update-Field -collection "faqs" -fieldName "sort" -interface "input" -options (@{placeholder="0";type="number"} | ConvertTo-Json)

Write-Host ""
Write-Host "Configuring Blogs field interfaces..."
Update-Field -collection "blogs" -fieldName "title" -interface "input" -options (@{placeholder="Blog Title in Chinese";trim=true} | ConvertTo-Json) -required $true
Update-Field -collection "blogs" -fieldName "title_en" -interface "input" -options (@{placeholder="Blog Title in English";trim=true} | ConvertTo-Json)
Update-Field -collection "blogs" -fieldName "excerpt" -interface "textarea" -options (@{placeholder="Short summary in Chinese";rows=3;trim=true} | ConvertTo-Json)
Update-Field -collection "blogs" -fieldName "excerpt_en" -interface "textarea" -options (@{placeholder="Short summary in English";rows=3;trim=true} | ConvertTo-Json)
Update-Field -collection "blogs" -fieldName "content" -interface "textarea" -options (@{placeholder="Blog content in Chinese";rows=10;trim=true} | ConvertTo-Json)
Update-Field -collection "blogs" -fieldName "content_en" -interface "textarea" -options (@{placeholder="Blog content in English";rows=10;trim=true} | ConvertTo-Json)
Update-Field -collection "blogs" -fieldName "cover_image" -interface "file-image" -options (@{} | ConvertTo-Json)
Update-Field -collection "blogs" -fieldName "author" -interface "input" -options (@{placeholder="Author Name";trim=true} | ConvertTo-Json)
Update-Field -collection "blogs" -fieldName "tags" -interface "tags" -options (@{placeholder="baby, stroller, safety";trim=true} | ConvertTo-Json)
Update-Field -collection "blogs" -fieldName "date_published" -interface "datetime" -options (@{placeholder="Publication date"} | ConvertTo-Json)
Update-Field -collection "blogs" -fieldName "status" -interface "select-dropdown" -options (@{choices=@(@("draft","Draft"),@("published","Published"));placeholder="Select status"} | ConvertTo-Json)

Write-Host ""
Write-Host "All field interfaces configured!"