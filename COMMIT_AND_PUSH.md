# Lệnh Commit và Push

## Lệnh Cơ Bản

### 1. Kiểm tra trạng thái
```bash
git status
```

### 2. Thêm tất cả files đã thay đổi
```bash
git add .
```

### 3. Commit với message
```bash
git commit -m "Fix GitHub Actions: Use build-only workflow and stable Xcode version"
```

### 4. Push lên GitHub
```bash
git push
```

Nếu lần đầu push:
```bash
git push -u origin main
```

---

## Lệnh Đầy Đủ (Copy & Paste)

```bash
# Kiểm tra status
git status

# Thêm tất cả files
git add .

# Commit
git commit -m "Fix GitHub Actions: Use stable Xcode and build-only workflow"

# Push
git push
```

---

## Nếu Chưa Có Remote

Nếu chưa kết nối với GitHub:

```bash
# Thêm remote (thay YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/FelixPersonalHub.git

# Đặt branch thành main
git branch -M main

# Push lần đầu
git push -u origin main
```

---

## Nếu Có Lỗi

### Lỗi: "Updates were rejected"
```bash
# Pull code mới trước
git pull origin main

# Sau đó push lại
git push
```

### Lỗi: "Authentication failed"
- Dùng Personal Access Token thay vì password
- Hoặc setup SSH keys

---

## Quick One-Liner

```bash
git add . && git commit -m "Fix CI workflow" && git push
```

