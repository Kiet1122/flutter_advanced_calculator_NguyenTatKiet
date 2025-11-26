# Testing Documentation - Advanced Calculator Flutter App

## 🧪 Tổng quan Testing Strategy

```
Unit Tests (Logic & Parser) → Widget Tests (UI) → Integration Tests (E2E)
```

## 📁 Cấu trúc Test Files

```
test/
├── advanced_calculator_logic_test.dart    # Test logic tính toán
├── advanced_expression_parser_test.dart   # Test parser biểu thức  
├── widget_test.dart                       # Test UI components
└── integration_test.dart                  # Test end-to-end
```

## ✅ Unit Tests

### Calculator Logic Tests
**File:** `advanced_calculator_logic_test.dart`

**Test cases:**
- Các phép toán cơ bản: +, -, ×, ÷
- Phép toán khoa học: sin, cos, tan, √, ^, !
- Phép toán lập trình: AND, OR, XOR, NOT
- Xử lý lỗi: chia cho 0, biểu thức không hợp lệ
- Chuyển đổi hệ số: DEC, HEX, OCT, BIN

### Expression Parser Tests  
**File:** `advanced_expression_parser_test.dart`

**Test cases:**
- Validate biểu thức hợp lệ
- Phân tích token đúng
- Xử lý biểu thức phức tạp
- Bắt lỗi cú pháp

## 🎯 Widget Tests

**File:** `widget_test.dart`

**Test cases:**
- Hiển thị đúng nút bấm
- Cập nhật màn hình khi nhấn nút
- Chuyển đổi chế độ hoạt động
- Hiển thị lịch sử tính toán
- Theme dark/light hoạt động

## 🔄 Integration Tests

**File:** `integration_test.dart`

**Test cases:**
- Luồng tính toán hoàn chỉnh
- Lưu và tải lịch sử
- Chuyển đổi giữa các chế độ
- Cài đặt theme persistent

## 🎯 Test Coverage Targets

- **Logic tính toán:** 90%+
- **UI Components:** 80%+  
- **End-to-end:** 80%+
- **Tổng coverage:** 83%+

## 🔧 Running Tests

```bash
# Chạy tất cả tests
flutter test

# Chạy unit tests
flutter test test/advanced_calculator_logic_test.dart
flutter test test/advanced_expression_parser_test.dart

# Chạy widget tests  
flutter test test/widget_test.dart

# Chạy integration tests
flutter test test/integration_test.dart

# Chạy với coverage
flutter test --coverage
```

## 📊 Test Results

- ✅ **Logic Tests:** Kiểm tra độ chính xác tính toán
- ✅ **Parser Tests:** Đảm bảo xử lý biểu thức đúng
- ✅ **Widget Tests:** Đảm bảo UI hoạt động chính xác  
- ✅ **Integration Tests:** Đảm bảo luồng ứng dụng hoàn chỉnh

## 🚨 Error Handling Tests

- Biểu thức không hợp lệ
- Chia cho 0
- Tràn số
- Đầu vào rỗng
- Lỗi chuyển đổi hệ số