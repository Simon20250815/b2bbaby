$login = Invoke-RestMethod -Uri 'http://localhost:8055/auth/login' -Method Post -Body (@{email='admin@b2bbaby.com';password='admin_password_2026'} | ConvertTo-Json) -ContentType 'application/json'
$token = $login.data.access_token
$headers = @{
    Authorization="Bearer $token"
    "Content-Type"="application/json"
}

function Create-Collection {
    param($name, $singular, $plural)
    $body = @{
        collection=$name
        meta=@{
            icon="box"
            note="$name collection"
            singular=$singular
            plural=$plural
            translations=@(
                @{language="en-US";translation=$singular}
                @{language="zh-CN";translation=$singular}
            )
        }
    } | ConvertTo-Json -Depth 3
    try {
        Invoke-RestMethod -Uri 'http://localhost:8055/collections' -Method Post -Body $body -Headers $headers | Out-Null
        Write-Host "OK: $name collection"
    } catch {
        Write-Host "Skip: $name - $($_.Exception.Message.Split("`n")[0])"
    }
}

Write-Host "Creating missing collections..."
Create-Collection -name "about" -singular "About Us" -plural "About Us"
Create-Collection -name "home" -singular "Home Page" -plural "Home Pages"
Create-Collection -name "oem_odm" -singular "OEM/ODM" -plural "OEM/ODM"
Create-Collection -name "contact" -singular "Contact" -plural "Contacts"
Create-Collection -name "site_settings" -singular "Settings" -plural "Settings"

Write-Host ""
Write-Host "Collections created! Now restarting Directus..."