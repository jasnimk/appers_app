import 'package:get/get.dart';
import '../../../core/models/product_model.dart';
import '../services/cart_storage_service.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class CartController extends GetxController {
  final _cartItems = <int, CartItem>{}.obs;
  final CartStorageService _storageService = CartStorageService();

  List<CartItem> get cartItems => _cartItems.values.toList();

  int get itemCount =>
      _cartItems.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _cartItems.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool isInCart(int productId) => _cartItems.containsKey(productId);

  int getQuantity(int productId) => _cartItems[productId]?.quantity ?? 0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _loadCartFromStorage();
  }

  /// Load cart from local storage on initialization
  Future<void> _loadCartFromStorage() async {
    final savedCart = await _storageService.loadCart();
    if (savedCart.isNotEmpty) {
      _cartItems.value = savedCart;
      _cartItems.refresh();
    }
  }

  /// Save cart to local storage
  Future<void> _saveCartToStorage() async {
    await _storageService.saveCart(_cartItems);
  }

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!.quantity++;
    } else {
      _cartItems[product.id] = CartItem(product: product);
    }
    _cartItems.refresh();
    _saveCartToStorage();
  }

  void removeFromCart(int productId) {
    _cartItems.remove(productId);
    _cartItems.refresh();
    _saveCartToStorage();
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
    } else if (_cartItems.containsKey(productId)) {
      _cartItems[productId]!.quantity = quantity;
      _cartItems.refresh();
      _saveCartToStorage();
    }
  }

  void incrementQuantity(int productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId]!.quantity++;
      _cartItems.refresh();
      _saveCartToStorage();
    }
  }

  void decrementQuantity(int productId) {
    if (_cartItems.containsKey(productId)) {
      final item = _cartItems[productId]!;
      if (item.quantity > 1) {
        item.quantity--;
        _cartItems.refresh();
        _saveCartToStorage();
      } else {
        removeFromCart(productId);
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
    _storageService.clearCart();
  }
}
