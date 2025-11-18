# Hướng Dẫn Đẩy Code Lên GitHub

## Cách 1: Dùng Script Tự Động (Dễ Nhất) ⭐

### Windows PowerShell:

1. Mở PowerShell trong thư mục `FelixPersonalHub`
2. Chạy:
   ```powershell
   .\push-to-github.ps1
   ```
3. Làm theo hướng dẫn trên màn hình

### Windows Command Prompt:

1. Mở CMD trong thư mục `FelixPersonalHub`
2. Chạy:
   ```cmd
   push-to-github.bat
   ```
3. Làm theo hướng dẫn

---

## Cách 2: Làm Thủ Công (Từng Bước)

### Bước 1: Cài Git (Nếu Chưa Có)

Tải và cài Git từ: https://git-scm.com/download/win

Kiểm tra đã cài:
```bash
git --version
```

### Bước 2: Cấu Hình Git (Lần Đầu)

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Bước 3: Tạo Repository Trên GitHub

1. Vào https://github.com/new
2. Đặt tên: `FelixPersonalHub` (hoặc tên bạn muốn)
3. **QUAN TRỌNG**: 
   - ❌ KHÔNG check "Add a README file"
   - ❌ KHÔNG check "Add .gitignore"
   - ❌ KHÔNG check "Choose a license"
4. Click "Create repository"

### Bước 4: Khởi Tạo Git Trong Project

Mở terminal trong thư mục `FelixPersonalHub`:

```bash
# Khởi tạo repository
git init

# Thêm tất cả files
git add .

# Commit
git commit -m "Initial commit: Felix Personal Hub iOS app"
```

### Bước 5: Kết Nối Với GitHub

```bash
# Thêm remote (thay YOUR_USERNAME bằng username GitHub của bạn)
git remote add origin https://github.com/YOUR_USERNAME/FelixPersonalHub.git

# Đổi branch thành main
git branch -M main

# Push lên GitHub
git push -u origin main
```

### Bước 6: Xác Thực

Nếu được hỏi username/password:
- **Username**: GitHub username của bạn
- **Password**: Dùng **Personal Access Token** (không dùng password thật)

**Tạo Personal Access Token:**
1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token
3. Chọn quyền: `repo` (full control)
4. Copy token và dùng làm password

---

## Cách 3: Dùng GitHub Desktop (GUI)

1. Tải GitHub Desktop: https://desktop.github.com/
2. Login với GitHub account
3. File → Add Local Repository
4. Chọn thư mục `FelixPersonalHub`
5. Publish repository lên GitHub

---

## Sau Khi Push

### 1. Xem Code Trên GitHub

Vào: `https://github.com/YOUR_USERNAME/FelixPersonalHub`

### 2. Xem Build Tự Động (GitHub Actions)

1. Vào tab **"Actions"** trên GitHub
2. Xem workflow tự động build và test
3. Click vào từng run để xem chi tiết

### 3. Tiếp Tục Development

```bash
# Sau khi sửa code, commit và push:
git add .
git commit -m "Your commit message"
git push
```

---

## Troubleshooting

### Lỗi: "remote origin already exists"

```bash
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/FelixPersonalHub.git
```

### Lỗi: "Authentication failed"

- Dùng Personal Access Token thay vì password
- Hoặc setup SSH keys (xem bên dưới)

### Lỗi: "Permission denied"

- Kiểm tra bạn có quyền truy cập repository
- Repository phải là public hoặc bạn là collaborator

### Setup SSH (Tùy Chọn - An Toàn Hơn)

1. Tạo SSH key:
   ```bash
   ssh-keygen -t ed25519 -C "your.email@example.com"
   ```

2. Copy public key:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```

3. Thêm vào GitHub:
   - Settings → SSH and GPG keys → New SSH key
   - Paste key và save

4. Dùng SSH URL:
   ```bash
   git remote set-url origin git@github.com:YOUR_USERNAME/FelixPersonalHub.git
   ```

---

## Quick Commands Reference

```bash
# Check status
git status

# Add files
git add .

# Commit
git commit -m "Message"

# Push
git push

# Pull (lấy code mới từ GitHub)
git pull

# Xem remote
git remote -v

# Xem branches
git branch
```

---

## Next Steps Sau Khi Push

1. ✅ **Xem GitHub Actions**: Tab "Actions" để xem build tự động
2. ✅ **Share Repository**: Gửi link cho người khác xem code
3. ✅ **Continue Coding**: Code trên Windows, push lên GitHub
4. ✅ **Setup Cloud Mac** (nếu cần): Để build và test app

---

**Lưu ý**: Repository sẽ public nếu bạn chọn public. Nếu muốn private, chọn "Private" khi tạo repository trên GitHub.

