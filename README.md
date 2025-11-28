# Appers Shop - Flutter E-Commerce App

A modern, feature-rich e-commerce mobile application built with Flutter, showcasing beautiful UI/UX, smooth animations, and clean architecture.

![Flutter](https://img.shields.io/badge/Flutter-3.10.1-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## 📱 Screenshots

> https://drive.google.com/drive/folders/1QTeAoFb04fxTqCGR1m-EFP18h5_rVFFx

---

## 🎯 Assignment Overview

This project was developed as part of a Flutter Developer assignment with the following requirements:
- Product Listing Screen (grid/list with image, title, price, rating)
- Product Details Screen (hero animation, description, category, price)
- Cart Screen (local state, add/remove items, total price)
- State management implementation
- Beautiful UI with responsive layouts and animations

**⚠️ Note on API Choice:**
The assignment suggested using **FakeStoreAPI**, however, I encountered intermittent connectivity issues and error responses during development. To ensure a reliable and smooth user experience, I switched to **[DummyJSON API](https://dummyjson.com/)**, which provides similar e-commerce data with better stability and additional features like pagination, search, and filtering.

---

## ✨ Features

### Core Features (Required)
- ✅ **Product Listing Screen**
  - Grid layout with product cards
  - Displays image, title, price, rating, and discount
  - Smooth scrolling with pagination
  - Shimmer loading placeholders

- ✅ **Product Details Screen**
  - Hero animation transitions
  - Image carousel with smooth page indicators
  - Full product description, category, stock info
  - Add to cart functionality
  - Related products section

- ✅ **Cart Screen**
  - Add/remove items with quantity controls
  - Real-time total price calculation
  - Empty cart state with animations
  - Persistent cart using SharedPreferences

### Bonus Features Implemented
- ✅ **Dark Mode Support**
  - System-aware theme switching
  - Persistent theme preference
  - Smooth theme transitions
  - Optimized colors for both modes

- ✅ **Advanced Animations**
  - Hero animations for product images
  - Staggered grid animations
  - Page transition animations (fade)
  - Bouncing button feedback
  - Animated FAB for scroll-to-top
  - Smooth cart item animations

- ✅ **Skeleton Loaders & Shimmer Effects**
  - Product grid shimmer
  - Horizontal product shimmer
  - Details screen shimmer
  - Category filter shimmer

- ✅ **Additional Features**
  - **Home Screen**: Curated banners, category navigation, featured products
  - **Explore Screen**: Search, category filters, infinite scroll
  - **Settings Screen**: Dark mode toggle, app info
  - **Bottom Navigation**: 4 tabs (Home, Explore, Cart, Settings)
  - **Splash Screen**: Custom animated splash for light/dark modes
  - **Empty States**: Lottie animations for empty cart/no results
  - **Pull to Refresh**: All screens support pull-to-refresh
  - **Scroll to Top**: FAB button on explore screen
  - **Error Handling**: Graceful error states with retry options

---

## 🏗️ Architecture & Design Choices

### State Management
**GetX** - Chosen for its:
- Lightweight and high-performance reactive state management
- Built-in dependency injection
- Simple navigation with route management
- Minimal boilerplate compared to BLoC/Provider
- Perfect for rapid development with clean code

### Project Structure
```
lib/
├── core/                      # Shared resources
│   ├── config/               # Theme, colors, text styles
│   ├── data/                 # API clients, repositories
│   ├── models/               # Data models
│   ├── utils/                # Helpers, constants, utilities
│   └── widgets/              # Reusable UI components
│       └── product_card_widgets/  # Modular product components
├── features/                  # Feature modules
│   ├── cart/                 # Cart feature
│   ├── home/                 # Home screen
│   ├── product_details/      # Product details
│   ├── products/             # Product listing & explore
│   └── settings/             # Settings & profile
└── routes/                   # Navigation & routing

Total: 76 Dart files
```

### Design Patterns
1. **Repository Pattern**: Data layer abstraction with Retrofit
2. **Modular Widgets**: Reusable product card components
3. **Feature-First Structure**: Each feature is self-contained
4. **Reactive Programming**: GetX observables for state updates
5. **Dependency Injection**: Controllers managed by GetX

### Key Technical Decisions

#### 1. **Modular Product Widgets**
Created a comprehensive library of reusable product card components:
- `ProductImage` - Cached image with Hero animation
- `ProductRating` - Star rating display
- `ProductPriceRow` - Price with discount badge
- `AddToCartButton` - Smart cart controls
- `QuantityControls` - Increment/decrement buttons

This approach ensures:
- DRY principle (Don't Repeat Yourself)
- Easy maintenance and updates
- Consistent UI across screens
- Better testability

#### 2. **Networking Layer**
```
Dio + Retrofit + Pretty Logger
```
- Type-safe API calls
- Automatic JSON serialization
- Request/response logging
- Error interceptors

#### 3. **Theme System**
- Centralized `AppTheme` class
- Google Fonts (Poppins) for modern typography
- Dynamic color schemes for light/dark modes
- Shared preferences for theme persistence

#### 4. **Performance Optimizations**
- `cached_network_image` for efficient image loading
- Pagination to limit API calls
- Shimmer placeholders to improve perceived performance
- Lazy loading with scroll listeners

---

## 🛠️ Tech Stack

### Core Dependencies
| Package | Purpose |
|---------|---------|
| `get` | State management & navigation |
| `dio` | HTTP client |
| `retrofit` | Type-safe API client |
| `cached_network_image` | Image caching |
| `shimmer` | Loading placeholders |
| `google_fonts` | Typography (Poppins) |
| `shared_preferences` | Local storage (cart, theme) |
| `flutter_rating_bar` | Star ratings |
| `smooth_page_indicator` | Carousel indicators |

### Dev Dependencies
- `build_runner` - Code generation
- `json_serializable` - JSON parsing
- `retrofit_generator` - API client generation
- `flutter_launcher_icons` - Custom app icon
- `flutter_native_splash` - Splash screen

---

## 📦 Installation & Setup

### Prerequisites
- Flutter SDK: 3.10.1 or higher
- Dart SDK: 3.0 or higher
- Android Studio / VS Code
- Android device or emulator

### Steps
1. **Clone the repository**
   ```bash
   git clone https://github.com/jasnimk/appers_app.git
   cd appers_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run build_runner** (for code generation)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🎨 UI/UX Highlights

### Design Philosophy
- **Minimalist & Modern**: Clean interfaces with ample whitespace
- **Consistent**: Unified color scheme and typography
- **Responsive**: Adapts to different screen sizes
- **Delightful**: Micro-interactions and smooth animations

### Color Palette
- **Primary**: Dark Red (`#8B0000`)
- **Accent**: Complementary shades
- **Dark Mode**: True black (`#121212`) with elevated surfaces

### Typography
- **Font Family**: Poppins (Google Fonts)
- **Hierarchy**: Clear size and weight variations

---

## 🚀 Features Breakdown

### 1. Home Screen
- Hero banner carousel with smooth indicators
- Category grid with random product images
- Multiple product sections by category
- "See All" navigation to filtered explore view

### 2. Explore Screen
- Search functionality
- Category filter chips
- Infinite scroll pagination
- Staggered grid animations
- Scroll-to-top FAB button

### 3. Product Details
- Hero animation from product card
- Image carousel (multiple product images)
- Stock availability indicator
- Add to cart with quantity controls
- Discount percentage display

### 4. Cart Screen
- Persistent cart state
- Quantity increment/decrement
- Real-time subtotal calculation
- Clear cart option

### 5. Settings Screen
- Dark mode toggle
- App version display

---


## 🔄 Future Enhancements

- [ ] User authentication (login/signup)
- [ ] Wishlist/favorites feature
- [ ] Payment gateway integration
- [ ] Order history
- [ ] Product reviews and ratings
- [ ] Multi-language support
- [ ] Push notifications
- [ ] Offline mode support

---

## 🐛 Known Issues / Limitations

- Cart data is stored locally (no backend sync)
- No user authentication system
- Limited to products from DummyJSON API

---

## 📝 API Documentation

**Base URL**: `https://dummyjson.com`

### Endpoints Used
- `GET /products` - All products with pagination
- `GET /products/{id}` - Single product details
- `GET /products/category/{category}` - Products by category
- `GET /products/categories` - All categories
- `GET /products/search?q={query}` - Search products

---


## 👨‍💻 Developer

**[Your Name]**
- GitHub: https://github.com/jasnimk
- LinkedIn: https://www.linkedin.com/in/jasni-m-k-17056190/
- Email: mkjasni@gmail.com

---

## 🙏 Acknowledgments

- [DummyJSON](https://dummyjson.com/) for providing a reliable API


## 📸 Demo Video

>https://drive.google.com/drive/folders/1nkYEUL8L60baKSWbO1vd2fxVgp5tCEXg

---

**Built with ❤️ using Flutter**
