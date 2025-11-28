import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_theme.dart';
import '../../models/product_model.dart';
import '../../../features/cart/controllers/cart_controller.dart';
import '../custom_button.dart';
import 'quantity_controls.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;
  final double size;
  final bool showText;

  const AddToCartButton({
    super.key,
    required this.product,
    this.size = 32,
    this.showText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cartController = Get.find<CartController>();
      final quantity = cartController.getQuantity(product.id);
      final isInCart = quantity > 0;

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: isInCart
            ? QuantityControls(
                key: ValueKey('quantity-${product.id}'),
                quantity: quantity,
                size: size,
                onIncrement: () => cartController.incrementQuantity(product.id),
                onDecrement: () => cartController.decrementQuantity(product.id),
              )
            : showText
            ? CustomButton(
                key: ValueKey('add-${product.id}'),
                width: double.infinity,
                text: 'Add to Cart',
                onPressed: () => cartController.addToCart(product),
                prefixIcon: Icon(
                  Icons.add_shopping_cart_rounded,
                  color: AppTheme.getTextPrimaryColor(context),
                  size: 16,
                ),
                fontSize: 10,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 2,
                ),
                borderRadius: 8,
                elevation: 1,
              )
            : GestureDetector(
                key: ValueKey('add-${product.id}'),
                onTap: () => cartController.addToCart(product),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: AppTheme.getPrimaryColor(context),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add_shopping_cart_rounded,
                    color: AppTheme.getTextPrimaryColor(context),
                    size: size * 0.5,
                  ),
                ),
              ),
      );
    });
  }
}
