$login = Invoke-RestMethod -Uri 'http://localhost:8055/auth/login' -Method Post -Body (@{email='admin@b2bbaby.com';password='admin_password_2026'} | ConvertTo-Json) -ContentType 'application/json'
$token = $login.data.access_token
$headers = @{
    Authorization="Bearer $token"
    "Content-Type"="application/json"
}

Write-Host "=== Checking Data Collections ==="
Write-Host ""

$collections = @("products", "faqs", "blogs", "about", "home", "oem_odm", "contact", "site_settings")

foreach ($coll in $collections) {
    try {
        $items = Invoke-RestMethod -Uri "http://localhost:8055/items/$coll" -Headers $headers
        Write-Host "$coll : $($items.data.Count) items"
    } catch {
        Write-Host "$coll : ERROR - $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host "=== Checking Image Field Configuration ==="

$imageFields = @(
    @("products", "image"),
    @("products", "gallery_images"),
    @("about", "image"),
    @("home", "hero_image")
)

foreach ($field in $imageFields) {
    $coll = $field[0]
    $fname = $field[1]
    try {
        $fconfig = Invoke-RestMethod -Uri "http://localhost:8055/fields/$coll/$fname" -Headers $headers
        Write-Host "$coll.$fname :"
        Write-Host "  - type: $($fconfig.type)"
        Write-Host "  - interface: $($fconfig.interface)"
        Write-Host "  - special: $($fconfig.special)"
    } catch {
        Write-Host "$coll.$fname : ERROR - $($_.Exception.Message)"
    }
}