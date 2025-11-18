# Sửa Lỗi GitHub Actions

## Vấn Đề

### Lỗi 1: Invalid developer directory
`xcode-select: error: invalid developer directory '/Applications/Xcode_15.0.app/Contents/Developer'`

**Nguyên nhân**: GitHub Actions runner có thể không có Xcode 15.0, hoặc đường dẫn khác.

### Lỗi 2: Simulator not found
`Unable to find a device matching the provided destination specifier: { platform:iOS Simulator, name:iPhone 15 }`

**Nguyên nhân**: 
- Simulator "iPhone 15" không có sẵn trên runner
- Xcode RC version (26.1) có thể không ổn định
- iOS platform chưa được cài đặt

## Giải Pháp

### Option 1: Dùng Workflow Đã Sửa (Khuyến Nghị) ✅

File `.github/workflows/ci.yml` đã được sửa để:
- Dùng Xcode 15.4 (stable, không phải RC)
- Tự động tìm và dùng simulator có sẵn
- Fallback về generic SDK build nếu không có simulator
- Boot simulator nếu cần

**Workflow mới sẽ:**
1. Tự động setup Xcode latest-stable
2. Hiển thị Xcode version để debug
3. List available simulators
4. Build và test project

### Option 2: Build Only (Không Cần Simulator) ✅

File `ci-build-only.yml`:
- Build với generic iOS Simulator SDK
- Không cần simulator cụ thể
- Phù hợp khi chỉ cần validate build
- Nhanh và ổn định nhất

### Option 3: Workflow Đơn Giản

File `ci-simple.yml`:
- Dùng Xcode 15.4 stable
- Tự động tìm simulator
- Fallback về SDK build nếu không có simulator

### Option 4: Workflow Minimal (Chỉ Validate)

File `ci-minimal.yml`:
- Chỉ check syntax Swift files
- Không build thật
- Dùng để validate code structure

## Cách Dùng

### 1. Dùng Workflow Chính (Đã Sửa)

File `.github/workflows/ci.yml` đã được update. Chỉ cần:
```bash
git add .github/workflows/ci.yml
git commit -m "Fix GitHub Actions Xcode setup"
git push
```

### 2. Hoặc Dùng Workflow Đơn Giản

Nếu workflow chính vẫn lỗi, đổi tên:
```bash
# Backup workflow cũ
mv .github/workflows/ci.yml .github/workflows/ci-backup.yml

# Dùng workflow đơn giản
mv .github/workflows/ci-simple.yml .github/workflows/ci.yml

git add .
git commit -m "Use simpler CI workflow"
git push
```

### 3. Hoặc Dùng Minimal Workflow

Chỉ validate code:
```bash
mv .github/workflows/ci.yml .github/workflows/ci-full.yml
mv .github/workflows/ci-minimal.yml .github/workflows/ci.yml

git add .
git commit -m "Use minimal CI workflow"
git push
```

## Troubleshooting

### Lỗi: "Scheme not found"

**Nguyên nhân**: Xcode project file chưa được add đúng vào repo, hoặc scheme chưa được share.

**Giải pháp**:
1. Mở project trong Xcode (trên Mac)
2. Product → Scheme → Manage Schemes
3. Check "Shared" cho scheme FelixPersonalHub
4. Commit file `.xcodeproj/xcshareddata/xcschemes/FelixPersonalHub.xcscheme`

### Lỗi: "No such simulator" hoặc "Unable to find a device"

**Nguyên nhân**: 
- Simulator name không có sẵn trên runner
- Xcode RC version không ổn định
- iOS platform chưa được cài

**Giải pháp 1**: Dùng workflow build-only (không cần simulator):
```bash
mv .github/workflows/ci.yml .github/workflows/ci-backup.yml
mv .github/workflows/ci-build-only.yml .github/workflows/ci.yml
```

**Giải pháp 2**: Build với generic SDK (không chỉ định simulator):
```yaml
xcodebuild build -sdk iphonesimulator
```

**Giải pháp 3**: Tự động tìm simulator có sẵn (đã có trong workflow mới):
```yaml
# Workflow tự động tìm và dùng simulator có sẵn
SIMULATOR=$(xcrun simctl list devices available | grep -i "iPhone" | head -1)
```

### Lỗi: "Code signing required"

**Giải pháp**: Đã có flags trong workflow:
```yaml
CODE_SIGN_IDENTITY=""
CODE_SIGNING_REQUIRED=NO
```

Nếu vẫn lỗi, thêm:
```yaml
DEVELOPMENT_TEAM=""
PROVISIONING_PROFILE_SPECIFIER=""
```

### Lỗi: "Project file not found"

**Nguyên nhân**: Xcode project chưa được commit.

**Giải pháp**: Đảm bảo file `.xcodeproj` được add vào git:
```bash
git add FelixPersonalHub.xcodeproj
git commit -m "Add Xcode project"
git push
```

## Test Workflow Locally (Nếu Có Mac)

Cài `act` để chạy GitHub Actions local:
```bash
brew install act
act -l  # List workflows
act push  # Run workflow
```

## Workflow Files

1. **ci.yml** - Workflow chính (đã sửa, tự động tìm simulator)
2. **ci-build-only.yml** - Build only, không cần simulator ⭐ (Khuyến nghị nếu simulator lỗi)
3. **ci-simple.yml** - Workflow đơn giản với fallback
4. **ci-minimal.yml** - Chỉ validate (backup)

## Khuyến Nghị

**Nếu gặp lỗi simulator**, dùng `ci-build-only.yml`:
```bash
git mv .github/workflows/ci.yml .github/workflows/ci-full.yml
git mv .github/workflows/ci-build-only.yml .github/workflows/ci.yml
git commit -m "Use build-only workflow to avoid simulator issues"
git push
```

Workflow này sẽ build thành công mà không cần simulator cụ thể.

## Next Steps

1. ✅ Push code với workflow đã sửa
2. ✅ Vào GitHub → Actions tab
3. ✅ Xem build logs
4. ✅ Nếu vẫn lỗi, thử workflow đơn giản hơn

---

**Lưu ý**: GitHub Actions runner có Xcode pre-installed, nhưng version có thể khác. Dùng `setup-xcode` action là cách tốt nhất để đảm bảo version đúng.

