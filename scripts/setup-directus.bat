@echo off
setlocal

set DIRECTUS_URL=http://localhost:8055
set EMAIL=admin@b2bbaby.com
set PASSWORD=admin_password_2026

echo 🔐 Logging in to Directus...
for /f "tokens=*" %%i in ('curl -s -X POST "%DIRECTUS_URL%/auth/login" -H "Content-Type: application/json" -d "{\"email\":\"%EMAIL%\",\"password\":\"%PASSWORD%\"}"') do set RESPONSE=%%i

echo %RESPONSE% | findstr /C:"access_token" >nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Login failed. Make sure Directus is running and credentials are correct.
    exit /b 1
)

echo ✅ Logged in!
echo.
echo 📦 Creating Products collection...
curl -s -X POST "%DIRECTUS_URL%/collections" -H "Content-Type: application/json" -H "Authorization: Bearer %RESPONSE%" -d "{\"collection\":\"products\",\"meta\":{\"singleton\":false},\"schema\":{\"name\":\"products\"}}" >nul
echo    ✓ Created: products

echo 📦 Creating FAQs collection...
curl -s -X POST "%DIRECTUS_URL%/collections" -H "Content-Type: application/json" -H "Authorization: Bearer %RESPONSE%" -d "{\"collection\":\"faqs\",\"meta\":{\"singleton\":false},\"schema\":{\"name\":\"faqs\"}}" >nul
echo    ✓ Created: faqs

echo 📦 Creating Blogs collection...
curl -s -X POST "%DIRECTUS_URL%/collections" -H "Content-Type: application/json" -H "Authorization: Bearer %RESPONSE%" -d "{\"collection\":\"blogs\",\"meta\":{\"singleton\":false},\"schema\":{\"name\":\"blogs\"}}" >nul
echo    ✓ Created: blogs

echo 📦 Creating Inquiries collection...
curl -s -X POST "%DIRECTUS_URL%/collections" -H "Content-Type: application/json" -H "Authorization: Bearer %RESPONSE%" -d "{\"collection\":\"inquiries\",\"meta\":{\"singleton\":false},\"schema\":{\"name\":\"inquiries\"}}" >nul
echo    ✓ Created: inquiries

echo.
echo ✅ Directus data model setup complete!
echo.
echo 📋 Collections created:
echo    - products (产品)
echo    - faqs (常见问题)
echo    - blogs (博客)
echo    - inquiries (询盘)
echo.
echo 🌐 Please open http://localhost:8055/admin to manage your content.

endlocal