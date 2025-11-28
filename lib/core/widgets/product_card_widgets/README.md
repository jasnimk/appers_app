# Product Card Widgets

This folder contains modular, reusable components for building product cards in the application.

## Structure

```
product_card_widgets/
├── README.md                      # This file
├── widgets.dart                   # Barrel export file (import all widgets)
├── add_to_cart_button.dart       # Add to cart button with quantity controls
├── product_discount_badge.dart   # Discount percentage badge
├── product_image.dart            # Product image with Hero animation
├── product_image_placeholder.dart # Placeholder for loading/error states
├── product_info.dart             # Product information section
├── product_price_row.dart        # Price display with discount badge
├── product_rating.dart           # Star rating display
└── quantity_controls.dart        # Increment/decrement quantity controls
```

## Common Widgets

These widgets are shared between `ProductCard` and `ProductCardHorizontal`:

### ProductRating
Displays star ratings with numeric value.

**Usage:**
```dart
ProductRating(
  rating: 4.5,
  itemSize: 12,      // Star size (default: 12)
  fontSize: 10,      // Rating text size (default: 10)
)
```

### ProductDiscountBadge
Shows discount percentage in a styled badge.

**Usage:**
```dart
ProductDiscountBadge(
  discountPercentage: 15.5,
  fontSize: 9,       // Text size (default: 9)
  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
)
```

### ProductPriceRow
Displays price with optional discount badge.

**Usage:**
```dart
ProductPriceRow(
  price: 29.99,
  discountPercentage: 15.5,
  fontSize: 15,      // Price text size (default: 15)
  decimalPlaces: 2,  // Decimal places for price (default: 2)
)
```

### ProductImagePlaceholder
Placeholder shown during image loading or on error.

**Usage:**
```dart
ProductImagePlaceholder(
  isDark: true,      // Dark mode flag
  width: 60,         // Logo width (default: 60)
  height: 60,        // Logo height (default: 60)
  opacity: 0.3,      // Logo opacity (default: 0.3)
)
```

### ProductImage
Product image with cached network loading and Hero animation.

**Usage:**
```dart
ProductImage(
  product: product,
  heroTag: 'custom-hero-tag',  // Optional custom hero tag
  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
  fit: BoxFit.contain,         // Default: contain, can be cover
)
```

### ProductInfo
Complete product information section (used in ProductCard).

**Usage:**
```dart
ProductInfo(
  product: product,
  showAddToCart: true,  // Show "Add to Cart" button (default: true)
)
```

### AddToCartButton
Smart button that switches between "Add to Cart" and quantity controls.

**Usage:**
```dart
AddToCartButton(
  product: product,
  size: 32,           // Button size (default: 32)
  showText: false,    // Show text button vs icon button (default: false)
)
```

### QuantityControls
Increment/decrement controls for cart quantity.

**Usage:**
```dart
QuantityControls(
  quantity: 3,
  size: 32,
  onIncrement: () => controller.incrementQuantity(productId),
  onDecrement: () => controller.decrementQuantity(productId),
)
```

## Import Methods

### Individual Import
```dart
import 'package:appers_app/core/widgets/product_card_widgets/product_rating.dart';
import 'package:appers_app/core/widgets/product_card_widgets/product_price_row.dart';
```

### Barrel Import (All Widgets)
```dart
import 'package:appers_app/core/widgets/product_card_widgets/widgets.dart';
```

## Benefits

1. **Modularity**: Each component is isolated and can be reused independently
2. **Maintainability**: Changes to a component only affect that single file
3. **Testability**: Easier to write unit tests for individual widgets
4. **Consistency**: Shared components ensure UI consistency across the app
5. **Flexibility**: Components accept parameters for customization

## Used In

- [product_card.dart](../product_card.dart) - Vertical product card for grid layouts
- [product_card_horizontal.dart](../product_card_horizontal.dart) - Horizontal product card for scrollable lists
