.# 🛒 Grocery Mart - Flutter Mobile Application

A modern, feature-rich grocery shopping mobile application built with Flutter. This app provides a seamless shopping experience with product browsing, search functionality, shopping cart management, and an intuitive user interface.

## 📱 Features

- **Home Screen**: Welcome banner with featured products and category navigation
- **Product Browsing**: Browse products by categories (Fruits & Vegetables, Dairy, Bakery, Snacks, Beverages)
- **Search Functionality**: Real-time product search with category suggestions
- **Product Details**: Detailed product view with quantity selection and add to cart
- **Shopping Cart**: Full cart management with quantity adjustment and checkout
- **Responsive Design**: Optimized for different screen sizes
- **State Management**: Efficient state management using Provider pattern
- **Persistent Storage**: Cart data persisted using SharedPreferences

## 🏗️ Architecture

This application follows the **Provider Pattern** for state management and uses a clean architecture with separation of concerns:

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── product.dart
│   └── cart_item.dart
├── providers/                # State management
│   ├── app_state_provider.dart
│   ├── cart_provider.dart
│   └── product_provider.dart
├── screens/                  # UI screens
│   ├── home_screen.dart
│   ├── categories_screen.dart
│   ├── search_screen.dart
│   ├── product_detail_screen.dart
│   ├── cart_screen.dart
│   └── main_navigation_screen.dart
├── services/                 # Business logic
│   ├── product_service.dart
│   └── cart_service.dart
└── widgets/                  # Reusable components
    └── product_image_widget.dart
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (version 3.0+)
- Dart SDK (version 3.0+)
- Android Studio / VS Code
- Android SDK (for Android development)
- Xcode (for iOS development - macOS only)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd grcery_mart
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Building for Release

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.5.3
  provider: ^6.1.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_launcher_icons: ^0.13.1
  flutter_lints: ^4.0.0
```

## 🎨 Custom App Icon

The app uses a custom grocery-themed icon generated using the `flutter_launcher_icons` package. The icon configuration is in `pubspec.yaml`:

```yaml
flutter_launcher_icons:
  android: "ic_launcher"
  image_path: "assets/images/logo.jpg"
  min_sdk_android: 21
```

To regenerate icons:
```bash
flutter pub run flutter_launcher_icons:main
```

## 📱 Screenshots

<img style = "height:550px;" src = "https://github.com/user-attachments/assets/596b4029-b728-4d0e-93ee-fdfa275d1815"></img>
<img style = "height:550px;" src = "https://github.com/user-attachments/assets/f80417d4-1414-4794-af72-c1cc390bb012"></img>
<img style = "height:550px;" src = "https://github.com/user-attachments/assets/cbeff8b9-1d8a-4c5c-a6b5-7f75d6cbfc25"></img>
<img style = "height:550px;" src = "https://github.com/user-attachments/assets/16efa1dd-6cf8-40f1-918b-dfb061a722ac"></img>
<img style = "height:550px;" src = "https://github.com/user-attachments/assets/f1c2bc7a-2768-445e-ab35-936cb5a0d314"></img>

## 🧪 Testing

Run tests with:
```bash
flutter test
```

The project includes widget tests for:
- App launch functionality
- Navigation between screens
- Search functionality
- Cart operations

## 🔧 Configuration

### Assets
All product images are stored in `assets/images/` and configured in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

### Supported Platforms
- ✅ Android
- ✅ iOS
- ✅ Web (with limitations)

## 📊 Performance Considerations

- **Lazy Loading**: Products loaded on-demand
- **Image Optimization**: Efficient image caching and loading
- **State Management**: Minimal rebuilds using Provider pattern
- **Memory Management**: Proper disposal of controllers and listeners

## 🐛 Known Issues

- Search is currently case-sensitive
- Images are loaded from assets (not network)
- No user authentication system
- Checkout is simulated (no payment integration)

## 🔮 Future Enhancements

- User authentication and profiles
- Online payment integration
- Product reviews and ratings
- Push notifications
- Delivery tracking
- Network-based product catalog
- Offline mode support

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**Your Name**
- Email: your.email@example.com
- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/yourprofile)

## 📞 Support

If you have any questions or need support, please contact:
- Email: support@grocerymart.com
- Issues: [GitHub Issues](https://github.com/yourusername/grocery-mart/issues)

---

⭐ **Star this repository if you found it helpful!**
