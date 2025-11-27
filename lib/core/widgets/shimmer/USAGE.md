# Shimmer Loading Widgets - Usage Guide

A comprehensive, reusable shimmer loading system for consistent loading states across the app.

## Import

```dart
import 'package:appers_app/core/widgets/shimmer/shimmers.dart';
```

## Available Shimmer Widgets

### 1. ProductCardShimmer
Shimmer effect for product cards in grid/list views.

```dart
// Single product card shimmer
ProductCardShimmer()

// Grid of product shimmers
ProductGridShimmer(itemCount: 6)
```

### 2. BannerShimmer
Shimmer effect for banner carousels.

```dart
BannerShimmer()
```

### 3. ProductImageShimmer
Shimmer for large product detail images.

```dart
ProductImageShimmer(height: 300)
```

### 4. ListItemShimmer
Shimmer for list items with leading image/icon.

```dart
ListItemShimmer()

// Multiple items
ListView.builder(
  itemCount: 5,
  itemBuilder: (context, index) => ListItemShimmer(),
)
```

### 5. HorizontalProductShimmer
Shimmer for horizontal scrolling product lists.

```dart
HorizontalProductShimmer(itemCount: 3)
```

### 6. CartItemShimmer
Shimmer for shopping cart items.

```dart
CartItemShimmer()

// Multiple cart items
ListView.builder(
  itemCount: 3,
  itemBuilder: (context, index) => CartItemShimmer(),
)
```

### 7. TextShimmer
Simple text line shimmer.

```dart
TextShimmer(width: 100, height: 14)
```

### 8. Custom Shimmer (Base Components)

Create custom shimmers using base components:

```dart
ShimmerBase(
  child: Column(
    children: [
      ShimmerBox(width: 200, height: 20),
      SizedBox(height: 8),
      ShimmerCircle(size: 50),
    ],
  ),
)
```

## Usage Examples

### Example 1: Product List Screen

```dart
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return ProductGridShimmer(itemCount: 6);
      }

      return GridView.builder(
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: controller.products[index]);
        },
      );
    });
  }
}
```

### Example 2: Home Screen with Banner

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Banner section
          Obx(() => controller.isBannerLoading
              ? BannerShimmer()
              : BannerCarousel()),

          // Horizontal product list
          Obx(() => controller.isProductsLoading
              ? HorizontalProductShimmer(itemCount: 3)
              : HorizontalProductList()),
        ],
      ),
    );
  }
}
```

### Example 3: Cart Screen

```dart
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => CartItemShimmer(),
        );
      }

      return ListView.builder(
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          return CartItemCard(item: controller.cartItems[index]);
        },
      );
    });
  }
}
```

### Example 4: Product Details

```dart
class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return Column(
          children: [
            ProductImageShimmer(height: 300),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextShimmer(width: 200, height: 24),
                  SizedBox(height: 8),
                  TextShimmer(width: 150, height: 16),
                  SizedBox(height: 16),
                  TextShimmer(width: double.infinity, height: 14),
                  TextShimmer(width: double.infinity, height: 14),
                ],
              ),
            ),
          ],
        );
      }

      return ProductDetailsContent(product: controller.product);
    });
  }
}
```

### Example 5: Custom Shimmer

```dart
ShimmerBase(
  child: Container(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        ShimmerCircle(size: 60),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerBox(width: double.infinity, height: 16),
              SizedBox(height: 8),
              ShimmerBox(width: 120, height: 14),
            ],
          ),
        ),
      ],
    ),
  ),
)
```

## Features

- ✅ **Theme-aware**: Automatically adapts to light/dark mode
- ✅ **Consistent**: Same shimmer effect across all components
- ✅ **Reusable**: Use anywhere in your app
- ✅ **Customizable**: Build custom shimmers with base components
- ✅ **Performance**: Optimized for smooth animations

## Tips

1. **Match your UI**: Shimmer layout should match the actual content layout
2. **Loading states**: Always show shimmer during data fetching
3. **Item counts**: Use realistic item counts (3-6 items) for better UX
4. **Timing**: Remove shimmer as soon as data is available
