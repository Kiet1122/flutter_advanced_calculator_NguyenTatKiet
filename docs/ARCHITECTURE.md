# Architecture Documentation - Advanced Calculator Flutter App

## 🏗️ Tổng quan kiến trúc

Ứng dụng sử dụng **Layered Architecture** với **Provider** cho state management.

```
Presentation Layer (UI)
├── Screens
├── Widgets  
└── Providers (State)

Business Logic Layer
├── Utils (Calculator logic)
└── Services (Storage)

Data Layer
└── Models (Data structure)
```

## 📁 Cấu trúc chi tiết

### 1. Data Layer (Models)
- `CalculationHistory`: Lưu lịch sử tính toán
- `CalculatorMode`: 3 chế độ (Basic, Scientific, Programmer)  
- `CalculatorSettings`: Cài đặt theme

### 2. Business Logic Layer
**Services:**
- `StorageService`: Lưu trữ local (history, settings)

**Utils:**
- `CalculatorLogic`: Xử lý tính toán 3 chế độ
- `ExpressionParser`: Phân tích biểu thức
- `Constants`: Hằng số ứng dụng

### 3. Presentation Layer
**Providers:**
- `CalculatorProvider`: Quản lý state máy tính
- `HistoryProvider`: Quản lý lịch sử
- `ThemeProvider`: Quản lý theme

**Screens:**
- `CalculatorScreen`: Màn hình chính
- `HistoryScreen`: Lịch sử
- `SettingsScreen`: Cài đặt

**Widgets:**
- `CalculatorButton`: Nút bấm
- `DisplayArea`: Hiển thị
- `ModeSelector`: Chuyển chế độ
- `ButtonGrid`: Bố cục nút

## 🔄 Luồng dữ liệu

```
User Input → Button → Provider → Logic → Update UI
```

## 🎯 Design Patterns

1. **Provider Pattern**: State management
2. **Repository Pattern**: Data access  
3. **Strategy Pattern**: Các thuật toán tính toán
4. **Factory Pattern**: Tạo calculator theo mode

## 🗂️ File Structure

```
lib/
├── main.dart
├── models/           # Data classes
├── providers/        # State management  
├── screens/          # Full pages
├── services/         # Storage
├── utils/            # Business logic
└── widgets/          # UI components
```

## 🧪 Testing Strategy

- **Unit Test**: Logic tính toán
- **Widget Test**: UI components  
- **Integration Test**: End-to-end flow

## ⚡ Performance Optimization

- Selective rebuild với Consumer
- Const constructors
- Efficient state updates

## 🔒 Error Handling

- Validate biểu thức
- Xử lý lỗi tính toán
- Error boundaries

Kiến trúc đảm bảo: **Dễ bảo trì, Dễ test, Hiệu suất tốt**