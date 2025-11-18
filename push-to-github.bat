@echo off
REM Batch script để push code lên GitHub (Windows)
REM Chạy: push-to-github.bat

echo.
echo ========================================
echo  Felix Personal Hub - GitHub Setup
echo ========================================
echo.

REM Kiểm tra Git
git --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git chưa được cai dat!
    echo Tai Git tai: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo [OK] Git da duoc cai dat
echo.

REM Init git nếu chưa có
if not exist .git (
    echo [INFO] Khoi tao Git repository...
    git init
    echo.
)

REM Add files
echo [INFO] Dang them files...
git add .

REM Commit
echo.
set /p commit_msg="Nhap commit message (hoac Enter de dung mac dinh): "
if "%commit_msg%"=="" set commit_msg=Initial commit: Felix Personal Hub iOS app
git commit -m "%commit_msg%"

REM Hỏi repo URL
echo.
echo ========================================
echo  GitHub Repository Setup
echo ========================================
echo.
echo 1. Tao repository moi tren GitHub: https://github.com/new
echo 2. Dat ten: FelixPersonalHub
echo 3. KHONG tao README, .gitignore, hoac license
echo.
set /p repo_url="Nhap GitHub repository URL (vi du: https://github.com/username/FelixPersonalHub.git): "

if "%repo_url%"=="" (
    echo.
    echo [WARNING] Bo qua push. Ban co the push sau bang:
    echo    git remote add origin ^<your-repo-url^>
    echo    git branch -M main
    echo    git push -u origin main
    pause
    exit /b 0
)

REM Add remote
echo.
echo [INFO] Dang them remote origin...
git remote remove origin 2>nul
git remote add origin "%repo_url%"

REM Set branch
echo [INFO] Dang dat branch thanh main...
git branch -M main

REM Push
echo.
echo [INFO] Dang push len GitHub...
git push -u origin main

if errorlevel 1 (
    echo.
    echo [ERROR] Push that bai! Kiem tra:
    echo    - Repository URL dung chua?
    echo    - Da login GitHub chua?
    echo    - Co quyen truy cap repository khong?
) else (
    echo.
    echo [SUCCESS] Code da duoc push len GitHub!
    echo [LINK] Xem tai: %repo_url%
    echo.
    echo Next steps:
    echo    1. Vao GitHub Actions tab de xem build tu dong
    echo    2. Code tiep va push: git push
)

echo.
pause

