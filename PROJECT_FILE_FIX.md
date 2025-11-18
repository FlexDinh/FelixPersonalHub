# Fix Xcode Project File Issue

## Vấn Đề Hiện Tại

Xcode project file (`project.pbxproj`) đang reference các file ở đường dẫn sai:
- Tìm: `FelixPersonalHub/ContentView.swift` 
- Thực tế: `FelixPersonalHub/Views/ContentView.swift`

- Tìm: `FelixPersonalHub/FelixPersonalHubApp.swift`
- Thực tế: `FelixPersonalHub/App/FelixPersonalHubApp.swift`

- Tìm: `FelixPersonalHub/AppDelegate.swift` (không tồn tại)

## Giải Pháp

### Tạm Thời: Dùng Validate-Only Workflow

Workflow `ci-validate-only.yml` sẽ chỉ check file structure, không build. Để dùng:

```bash
git mv .github/workflows/ci-simple.yml .github/workflows/ci-simple-backup.yml
git mv .github/workflows/ci-validate-only.yml .github/workflows/ci.yml
git commit -m "Use validate-only workflow until project file is fixed"
git push
```

### Lâu Dài: Fix Project File (Cần Mac)

**Bước 1**: Mở project trong Xcode
```bash
open FelixPersonalHub.xcodeproj
```

**Bước 2**: Xóa file references sai
- Trong Project Navigator, xóa:
  - `AppDelegate.swift` (nếu có)
  - `ContentView.swift` ở root level
  - `FelixPersonalHubApp.swift` ở root level

**Bước 3**: Add files đúng cách
1. Right-click `FelixPersonalHub` folder
2. Select "Add Files to FelixPersonalHub..."
3. Chọn các folders:
   - `App/`
   - `Views/`
   - `Features/`
   - `Services/`
   - `ViewModels/`
   - `Models/`
   - `Utils/`
4. Đảm bảo:
   - ✅ "Create groups" (không phải "Create folder references")
   - ✅ "Add to targets: FelixPersonalHub"
   - ✅ "Copy items if needed" = UNCHECKED (files đã có sẵn)

**Bước 4**: Verify
- Build project (Cmd+B)
- Nếu build thành công, commit project file:
```bash
git add FelixPersonalHub.xcodeproj
git commit -m "Fix project file: Add all source files with correct paths"
git push
```

## Workaround Cho Windows Users

Vì bạn đang trên Windows, không thể mở Xcode. Options:

1. **Dùng Cloud Mac** để mở Xcode và fix project file
2. **Dùng validate-only workflow** tạm thời
3. **Nhờ ai đó có Mac** fix project file và commit

## Kiểm Tra Project File

Sau khi fix, project file nên có references đến:
- `App/FelixPersonalHubApp.swift`
- `Views/ContentView.swift`
- `Views/DashboardView.swift`
- `Features/Study/IELTSView.swift`
- `Services/PersistenceService.swift`
- etc.

Và KHÔNG có:
- `AppDelegate.swift` (không cần cho SwiftUI)
- Files ở root level (trừ Info.plist, Assets.xcassets)

