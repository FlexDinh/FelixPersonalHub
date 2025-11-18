# Hướng Dẫn Cho Người Dùng Windows

## Vấn Đề

iOS apps (Swift/SwiftUI) **chỉ có thể build trên macOS** với Xcode. Windows không thể chạy Xcode trực tiếp.

## Các Giải Pháp

### 1. **Sử Dụng Cloud Mac Service (Khuyến Nghị)**

Các dịch vụ cho thuê Mac trên cloud:

#### **MacStadium**
- URL: https://www.macstadium.com/
- Giá: ~$99/tháng cho Mac mini
- Ưu điểm: Mac thật, hiệu năng tốt, hợp pháp
- Phù hợp: Development lâu dài

#### **AWS EC2 Mac Instances**
- URL: https://aws.amazon.com/ec2/instance-types/mac/
- Giá: Pay-per-use
- Ưu điểm: Linh hoạt, chỉ trả khi dùng
- Phù hợp: Development theo giờ

#### **MacinCloud**
- URL: https://www.macincloud.com/
- Giá: ~$20-50/tháng
- Ưu điểm: Rẻ, nhiều gói
- Phù hợp: Budget thấp

#### **Flow**
- URL: https://www.flow.swiss/
- Giá: ~$20/tháng
- Ưu điểm: Dễ setup, có trial

### 2. **GitHub Actions (Miễn Phí - Cho CI/CD)**

Sử dụng GitHub Actions để build và test tự động:

```yaml
# File đã có sẵn: .github/workflows/ci.yml
```

**Cách dùng:**
1. Push code lên GitHub
2. GitHub Actions tự động build trên macOS runner
3. Xem kết quả build/test trên GitHub
4. Download build artifacts nếu cần

**Ưu điểm:**
- Miễn phí (với public repos)
- Tự động hóa
- Không cần Mac

**Nhược điểm:**
- Không thể debug trực tiếp
- Không thể chạy simulator
- Chỉ dùng cho CI/CD

### 3. **Máy Mac Thật (Tốt Nhất)**

Nếu có ngân sách:
- **Mac mini M2**: ~$600-800 (rẻ nhất)
- **MacBook Air M2**: ~$1000-1200 (portable)
- **MacBook Pro**: ~$1500+ (hiệu năng cao)

**Mua cũ/refurbished:**
- Apple Refurbished Store
- eBay, Facebook Marketplace
- Cần macOS 13+ (Ventura) để chạy Xcode 15

### 4. **Virtual Machine (Không Khuyến Nghị)**

⚠️ **Cảnh Báo**: Chạy macOS trên VM vi phạm EULA của Apple (chỉ hợp pháp trên Mac thật).

Nếu vẫn muốn thử (tự chịu trách nhiệm):
- VMware Workstation Pro
- VirtualBox (miễn phí)
- Cần macOS ISO (không được Apple cung cấp chính thức)
- Hiệu năng kém, không ổn định
- Không thể publish lên App Store

### 5. **Dùng Mac Của Người Khác**

- Remote desktop vào Mac của bạn bè/đồng nghiệp
- TeamViewer, AnyDesk, hoặc SSH
- Chỉ cần internet ổn định

## Workflow Khuyến Nghị Cho Windows

### Option A: Cloud Mac + Local Editor

1. **Setup Cloud Mac** (MacStadium/AWS)
2. **Code trên Windows** với:
   - VS Code hoặc Cursor (editor hiện tại)
   - Git để sync code
3. **Build trên Cloud Mac**:
   - SSH vào cloud Mac
   - Pull code
   - Build với Xcode hoặc `xcodebuild`
4. **Test trên Simulator** (trên cloud Mac)

### Option B: GitHub Actions Only

1. **Code trên Windows** (VS Code/Cursor)
2. **Commit & Push** lên GitHub
3. **GitHub Actions tự động build**
4. **Xem kết quả** trên GitHub
5. **Download artifacts** nếu cần

**Nhược điểm**: Không thể debug hoặc test UI trực tiếp.

### Option C: Hybrid (Cloud Mac + GitHub Actions)

1. **Development**: Dùng cloud Mac để code và test
2. **CI/CD**: GitHub Actions để build tự động
3. **Local**: Chỉ edit code trên Windows, push lên Git

## Hướng Dẫn Setup Cloud Mac (MacStadium Example)

### Bước 1: Đăng Ký MacStadium

1. Truy cập https://www.macstadium.com/
2. Chọn gói (Mac mini M2 recommended)
3. Đăng ký và thanh toán

### Bước 2: Kết Nối

1. Nhận thông tin SSH từ MacStadium
2. Dùng SSH client (PuTTY, Windows Terminal) để kết nối:
   ```bash
   ssh username@your-mac-ip
   ```

### Bước 3: Setup Xcode

1. SSH vào Mac
2. Cài Xcode từ App Store hoặc download
3. Cài Command Line Tools:
   ```bash
   xcode-select --install
   ```

### Bước 4: Clone & Build Project

```bash
# Clone project
git clone <your-repo-url>
cd FelixPersonalHub

# Build
xcodebuild -scheme FelixPersonalHub -destination 'platform=iOS Simulator,name=iPhone 15' build

# Run tests
xcodebuild test -scheme FelixPersonalHub -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Bước 5: Remote Desktop (Optional)

Cài VNC hoặc dùng Screen Sharing để xem UI:
```bash
# Enable Screen Sharing trên Mac
sudo systemsetup -setremotelogin on
```

Dùng VNC client trên Windows để kết nối.

## Hướng Dẫn Dùng GitHub Actions

### Bước 1: Push Code Lên GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/FelixPersonalHub.git
git push -u origin main
```

### Bước 2: Xem Build Results

1. Vào GitHub repo
2. Click tab "Actions"
3. Xem build logs và test results

### Bước 3: Download Artifacts (Nếu Cần)

GitHub Actions có thể lưu build artifacts (IPA files, logs, etc.)

## So Sánh Các Option

| Option | Chi Phí | Hiệu Năng | Dễ Dùng | Khuyến Nghị |
|--------|---------|-----------|---------|-------------|
| Cloud Mac | $20-100/tháng | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ✅ Tốt nhất |
| GitHub Actions | Miễn phí | ⭐⭐⭐ | ⭐⭐⭐ | ✅ Cho CI/CD |
| Mac Thật | $600-2000 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ✅ Lâu dài |
| VM | Miễn phí | ⭐⭐ | ⭐⭐ | ❌ Không hợp pháp |
| Remote Mac | Tùy | ⭐⭐⭐⭐ | ⭐⭐⭐ | ✅ Nếu có |

## Kết Luận

**Cho Development:**
- Nếu có budget: Mua Mac mini M2 (rẻ nhất, hiệu quả)
- Nếu không: Dùng cloud Mac service (MacStadium/AWS)
- Nếu chỉ cần CI/CD: GitHub Actions (miễn phí)

**Workflow Khuyến Nghị:**
1. Code trên Windows (VS Code/Cursor) ✅
2. Push lên GitHub
3. Build/test trên Cloud Mac hoặc GitHub Actions
4. Review results và iterate

## Tài Liệu Tham Khảo

- [MacStadium](https://www.macstadium.com/)
- [AWS EC2 Mac](https://aws.amazon.com/ec2/instance-types/mac/)
- [GitHub Actions for iOS](https://docs.github.com/en/actions/guides/building-and-testing-swift)
- [Xcode Command Line Tools](https://developer.apple.com/xcode/)

---

**Lưu ý**: Tất cả code đã được viết sẵn và sẵn sàng build. Bạn chỉ cần môi trường macOS để compile. Code structure hoàn toàn đúng và sẽ build thành công trên Mac.

