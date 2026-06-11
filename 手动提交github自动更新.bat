@echo off
chcp 65001 >nul
title B2Bbaby 自动部署脚本

echo ==============================================
echo          B2Bbaby 代码提交与自动部署
echo ==============================================
echo.

set "commit_msg=更新代码"

:INPUT
set /p "commit_msg=请输入本次更新的描述（默认：更新代码）："
if "%commit_msg%"=="" set "commit_msg=更新代码"

echo.
echo --------------------------
echo 开始执行代码提交...
echo --------------------------
echo.

cd /d D:\b2bbaby

echo [1/4] 添加所有修改的文件...
git add .
if %errorlevel% equ 0 (
    echo      ✓ 添加成功
) else (
    echo      ✗ 添加失败
    pause
    exit /b 1
)

echo.
echo [2/4] 提交代码...
git commit -m "%commit_msg%"
if %errorlevel% equ 0 (
    echo      ✓ 提交成功
) else (
    echo      ✗ 提交失败（可能没有需要提交的更改）
    pause
    exit /b 1
)

echo.
echo [3/4] 推送到 GitHub...
echo      本地分支: master -^> 远程分支: main
git push origin master:main
if %errorlevel% equ 0 (
    echo      ✓ 推送成功
) else (
    echo      ✗ 推送失败
    pause
    exit /b 1
)

echo.
echo [4/4] 触发自动部署...
echo      请打开 GitHub Actions 查看部署状态:
echo      https://github.com/Simon20250815/b2bbaby/actions
echo.

echo --------------------------
echo ✓ 操作完成！
echo --------------------------
echo.
echo 部署流程:
echo   1. GitHub Actions 自动构建项目
echo   2. 自动上传到服务器
echo   3. 自动重启 PM2 服务
echo.
echo 预计等待时间: 1-2 分钟
echo.
pause