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

Write-Host "Configuring About Us fields..."
Set-Field -collection "about" -field "company_name" -interface "input" -options @{placeholder="Company Name";trim=$true}
Set-Field -collection "about" -field "company_name_en" -interface "input" -options @{placeholder="English Company Name";trim=$true}
Set-Field -collection "about" -field "description" -interface "textarea" -options @{placeholder="Company Description in Chinese";rows=5}
Set-Field -collection "about" -field "description_en" -interface "textarea" -options @{placeholder="Company Description in English";rows=5}
Set-Field -collection "about" -field "story" -interface "textarea" -options @{placeholder="Company Story in Chinese";rows=8}
Set-Field -collection "about" -field "story_en" -interface "textarea" -options @{placeholder="Company Story in English";rows=8}
Set-Field -collection "about" -field "founded" -interface "input" -options @{placeholder="Founded Year"}
Set-Field -collection "about" -field "employees" -interface "input" -options @{placeholder="Number of Employees";type="number"}
Set-Field -collection "about" -field "factories" -interface "input" -options @{placeholder="Number of Factories";type="number"}
Set-Field -collection "about" -field "export_countries" -interface "input" -options @{placeholder="Export Countries";type="number"}
Set-Field -collection "about" -field "address" -interface "textarea" -options @{placeholder="Company Address in Chinese"}
Set-Field -collection "about" -field "address_en" -interface "textarea" -options @{placeholder="Company Address in English"}
Set-Field -collection "about" -field "phone" -interface "input" -options @{placeholder="Phone Number"}
Set-Field -collection "about" -field "email" -interface "input" -options @{placeholder="Email Address"}
Set-Field -collection "about" -field "certifications" -interface "tags" -options @{placeholder="ASTM, CE, CPC"}
Set-Field -collection "about" -field "image" -interface "file-image" -options @{}
Set-Field -collection "about" -field "gallery_images" -interface "files" -options @{}
Set-Field -collection "about" -field "status" -interface "select-dropdown" -options @{choices=@(@("draft","Draft"),@("published","Published"))}

Write-Host ""
Write-Host "Configuring Home Page fields..."
Set-Field -collection "home" -field "hero_title" -interface "input" -options @{placeholder="Hero Title in Chinese"}
Set-Field -collection "home" -field "hero_title_en" -interface "input" -options @{placeholder="Hero Title in English"}
Set-Field -collection "home" -field "hero_subtitle" -interface "textarea" -options @{placeholder="Hero Subtitle in Chinese";rows=3}
Set-Field -collection "home" -field "hero_subtitle_en" -interface "textarea" -options @{placeholder="Hero Subtitle in English";rows=3}
Set-Field -collection "home" -field "hero_cta" -interface "input" -options @{placeholder="CTA Button Text in Chinese"}
Set-Field -collection "home" -field "hero_cta_en" -interface "input" -options @{placeholder="CTA Button Text in English"}
Set-Field -collection "home" -field "hero_image" -interface "file-image" -options @{}
Set-Field -collection "home" -field "featured_title" -interface "input" -options @{placeholder="Featured Title in Chinese"}
Set-Field -collection "home" -field "featured_title_en" -interface "input" -options @{placeholder="Featured Title in English"}
Set-Field -collection "home" -field "featured_description" -interface "textarea" -options @{placeholder="Featured Description in Chinese";rows=4}
Set-Field -collection "home" -field "featured_description_en" -interface "textarea" -options @{placeholder="Featured Description in English";rows=4}
Set-Field -collection "home" -field "status" -interface "select-dropdown" -options @{choices=@(@("draft","Draft"),@("published","Published"))}

Write-Host ""
Write-Host "Configuring OEM/ODM fields..."
Set-Field -collection "oem_odm" -field "title" -interface "input" -options @{placeholder="Title in Chinese"}
Set-Field -collection "oem_odm" -field "title_en" -interface "input" -options @{placeholder="Title in English"}
Set-Field -collection "oem_odm" -field "description" -interface "textarea" -options @{placeholder="Description in Chinese";rows=5}
Set-Field -collection "oem_odm" -field "description_en" -interface "textarea" -options @{placeholder="Description in English";rows=5}
Set-Field -collection "oem_odm" -field "services" -interface "tags" -options @{placeholder="OEM Services"}
Set-Field -collection "oem_odm" -field "process_steps" -interface "repeatable" -options @{fields=@(@{field="step";name="Step";type="string";meta=@{interface="input"}})}
Set-Field -collection "oem_odm" -field "min_order" -interface "input" -options @{placeholder="Minimum Order";type="number"}
Set-Field -collection "oem_odm" -field "lead_time" -interface "input" -options @{placeholder="Lead Time"}
Set-Field -collection "oem_odm" -field "contact_email" -interface "input" -options @{placeholder="Contact Email"}
Set-Field -collection "oem_odm" -field "image" -interface "file-image" -options @{}
Set-Field -collection "oem_odm" -field "gallery_images" -interface "files" -options @{}
Set-Field -collection "oem_odm" -field "status" -interface "select-dropdown" -options @{choices=@(@("draft","Draft"),@("published","Published"))}

Write-Host ""
Write-Host "Configuring Contact fields..."
Set-Field -collection "contact" -field "company_name" -interface "input" -options @{placeholder="Company Name in Chinese"}
Set-Field -collection "contact" -field "company_name_en" -interface "input" -options @{placeholder="Company Name in English"}
Set-Field -collection "contact" -field "address" -interface "textarea" -options @{placeholder="Address in Chinese"}
Set-Field -collection "contact" -field "address_en" -interface "textarea" -options @{placeholder="Address in English"}
Set-Field -collection "contact" -field "phone" -interface "input" -options @{placeholder="Phone Number"}
Set-Field -collection "contact" -field "email" -interface "input" -options @{placeholder="Email"}
Set-Field -collection "contact" -field "business_hours" -interface "input" -options @{placeholder="Business Hours"}
Set-Field -collection "contact" -field "map_location" -interface "input" -options @{placeholder="Map Location (URL)"}
Set-Field -collection "contact" -field "status" -interface "select-dropdown" -options @{choices=@(@("draft","Draft"),@("published","Published"))}

Write-Host ""
Write-Host "Configuring Site Settings fields..."
Set-Field -collection "site_settings" -field "site_title" -interface "input" -options @{placeholder="Site Title in Chinese"}
Set-Field -collection "site_settings" -field "site_title_en" -interface "input" -options @{placeholder="Site Title in English"}
Set-Field -collection "site_settings" -field "site_description" -interface "textarea" -options @{placeholder="Site Description in Chinese";rows=3}
Set-Field -collection "site_settings" -field "site_description_en" -interface "textarea" -options @{placeholder="Site Description in English";rows=3}
Set-Field -collection "site_settings" -field "logo" -interface "file-image" -options @{}
Set-Field -collection "site_settings" -field "favicon" -interface "file-image" -options @{}
Set-Field -collection "site_settings" -field "social_links" -interface "tags" -options @{placeholder="Social Links"}
Set-Field -collection "site_settings" -field "copyright" -interface "input" -options @{placeholder="Copyright in Chinese"}
Set-Field -collection "site_settings" -field "copyright_en" -interface "input" -options @{placeholder="Copyright in English"}

Write-Host ""
Write-Host "All fields configured! Now you can refresh Directus admin!"