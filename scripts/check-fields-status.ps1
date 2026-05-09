$login = Invoke-RestMethod -Uri 'http://localhost:8055/auth/login' -Method Post -Body (@{email='admin@b2bbaby.com';password='admin_password_2026'} | ConvertTo-Json) -ContentType 'application/json'
$token = $login.data.access_token
$headers = @{Authorization="Bearer $token"}

Write-Host "Products Fields:"
$fields = Invoke-RestMethod -Uri 'http://localhost:8055/fields/products' -Headers $headers
$fields.data | Select-Object field, type, interface | Format-Table

Write-Host ""
Write-Host "FAQs Fields:"
$faqs = Invoke-RestMethod -Uri 'http://localhost:8055/fields/faqs' -Headers $headers
$faqs.data | Select-Object field, type, interface | Format-Table