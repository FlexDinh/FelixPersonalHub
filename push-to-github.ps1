# PowerShell Script để Push Code Lên GitHub
# Chạy script này trong PowerShell: .\push-to-github.ps1

Write-Host "🚀 Felix Personal Hub - GitHub Setup" -ForegroundColor Cyan
Write-Host ""

# Kiểm tra Git đã cài chưa
try {
    $gitVersion = git --version
    Write-Host "✅ Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git chưa được cài đặt!" -ForegroundColor Red
    Write-Host "Tải Git tại: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

# Kiểm tra đã có .git chưa
if (Test-Path .git) {
    Write-Host "⚠️  Repository đã được khởi tạo" -ForegroundColor Yellow
    $continue = Read-Host "Bạn có muốn tiếp tục? (y/n)"
    if ($continue -ne "y") {
        exit 0
    }
} else {
    Write-Host "📦 Khởi tạo Git repository..." -ForegroundColor Cyan
    git init
}

# Thêm tất cả files
Write-Host "📝 Adding files..." -ForegroundColor Cyan
git add .

# Commit
Write-Host "💾 Creating commit..." -ForegroundColor Cyan
$commitMessage = Read-Host "Nhập commit message (hoặc Enter để dùng mặc định)"
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    $commitMessage = "Initial commit: Felix Personal Hub iOS app"
}
git commit -m $commitMessage

# Hỏi GitHub repo URL
Write-Host ""
Write-Host "🔗 GitHub Repository Setup" -ForegroundColor Cyan
Write-Host "1. Tạo repository mới trên GitHub: https://github.com/new" -ForegroundColor Yellow
Write-Host "2. Đặt tên: FelixPersonalHub (hoặc tên bạn muốn)" -ForegroundColor Yellow
Write-Host "3. KHÔNG tạo README, .gitignore, hoặc license (đã có sẵn)" -ForegroundColor Yellow
Write-Host ""

$repoUrl = Read-Host "Nhập GitHub repository URL (ví dụ: https://github.com/username/FelixPersonalHub.git)"

if ([string]::IsNullOrWhiteSpace($repoUrl)) {
    Write-Host "⚠️  Bỏ qua push. Bạn có thể push sau bằng:" -ForegroundColor Yellow
    Write-Host "   git remote add origin <your-repo-url>" -ForegroundColor Cyan
    Write-Host "   git branch -M main" -ForegroundColor Cyan
    Write-Host "   git push -u origin main" -ForegroundColor Cyan
    exit 0
}

# Thêm remote
Write-Host "🔗 Adding remote origin..." -ForegroundColor Cyan
git remote remove origin 2>$null
git remote add origin $repoUrl

# Đổi branch thành main
Write-Host "🌿 Setting branch to main..." -ForegroundColor Cyan
git branch -M main

# Push
Write-Host "⬆️  Pushing to GitHub..." -ForegroundColor Cyan
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Success! Code đã được push lên GitHub!" -ForegroundColor Green
    Write-Host "🔗 Xem tại: $repoUrl" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📋 Next steps:" -ForegroundColor Yellow
    Write-Host "   1. Vào GitHub Actions tab để xem build tự động" -ForegroundColor White
    Write-Host "   2. Code tiếp trên Windows và push: git push" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "❌ Push failed. Kiểm tra:" -ForegroundColor Red
    Write-Host "   - Repository URL đúng chưa?" -ForegroundColor Yellow
    Write-Host "   - Đã login GitHub chưa? (git config --global user.name/email)" -ForegroundColor Yellow
    Write-Host "   - Có quyền truy cập repository không?" -ForegroundColor Yellow
}

