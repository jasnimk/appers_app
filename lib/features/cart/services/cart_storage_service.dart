import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/product_model.dart';
import '../controllers/cart_controller.dart';

/// Service for persisting cart data to local storage
class CartStorageService {
  static const String _cartKey = 'cart_items';

  /// Save cart items to local storage
  Future<void> saveCart(Map<int, CartItem> cartItems) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Convert cart items to JSON
      final cartJson = cartItems.map((key, item) {
        return MapEntry(
          key.toString(),
          {
            'product': item.product.toJson(),
            'quantity': item.quantity,
          },
        );
      });

      final jsonString = jsonEncode(cartJson);
      await prefs.setString(_cartKey, jsonString);
      print('✅ Cart saved: ${cartItems.length} items');
    } catch (e) {
      print('❌ Error saving cart: $e');
    }
  }

  /// Load cart items from local storage
  Future<Map<int, CartItem>> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartString = prefs.getString(_cartKey);

      print('📦 Loading cart from storage...');

      if (cartString == null || cartString.isEmpty) {
        print('📭 No saved cart found');
        return {};
      }

      print('📄 Cart data found: ${cartString.substring(0, cartString.length > 100 ? 100 : cartString.length)}...');

      final Map<String, dynamic> cartJson = jsonDecode(cartString);

      // Convert JSON back to CartItem objects
      final cartItems = <int, CartItem>{};
      cartJson.forEach((key, value) {
        final product = Product.fromJson(value['product']);
        final quantity = value['quantity'] as int;
        cartItems[product.id] = CartItem(
          product: product,
          quantity: quantity,
        );
      });

      print('✅ Cart loaded: ${cartItems.length} items');
      return cartItems;
    } catch (e) {
      print('❌ Error loading cart: $e');
      return {};
    }
  }

  /// Clear all cart data from local storage
  Future<void> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cartKey);
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }
}
