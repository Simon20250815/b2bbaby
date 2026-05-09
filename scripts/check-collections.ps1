$login = Invoke-RestMethod -Uri 'http://localhost:8055/auth/login' -Method Post -Body (@{email='admin@b2bbaby.com';password='admin_password_2026'} | ConvertTo-Json) -ContentType 'application/json'
$token = $login.data.access_token
$headers = @{Authorization="Bearer $token"}

Write-Host "=== All Collections ==="
$cols = Invoke-RestMethod -Uri 'http://localhost:8055/collections' -Headers $headers
$cols.data | Where-Object { $_.collection -notlike 'directus_*' } | Select-Object collection | Format-Table