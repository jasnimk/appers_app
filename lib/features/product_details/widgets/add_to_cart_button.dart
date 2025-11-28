import 'package:appers_app/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../core/widgets/custom_button.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../home/controllers/shell_controller.dart';
import '../../../core/models/product_model.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;

  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final bool isAvailable = product.stock > 0;

    return Obx(() {
      final bool isInCart = cartController.isInCart(product.id);
      final int quantity = cartController.getQuantity(product.id);

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: isInCart
              ? Row(
                  children: [
                    // Quantity indicator
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.getPrimaryColor(
                          context,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.getPrimaryColor(context),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: AppTheme.getPrimaryColor(context),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$quantity',
                            style: AppTextStyles.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.getPrimaryColor(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // View Bag button
                    Expanded(
                      child: CustomButton(
                        text: 'View Bag',
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        onPressed: () {
                          // Navigate to shell and switch to cart tab (index 2)
                          final shellController = Get.find<ShellController>();
                          shellController.changeTab(2);
                          Get.offAllNamed('/');
                        },
                        backgroundColor: AppTheme.getPrimaryColor(context),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        borderRadius: 12,
                      ),
                    ),
                  ],
                )
              : CustomButton(
                  text: isAvailable ? 'Add to Cart' : 'Out of Stock',
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  onPressed: isAvailable
                      ? () {
                          cartController.addToCart(product);
                          SnackbarUtils.showSuccess(
                            context,
                            '${product.title} added to cart',
                          );
                        }
                      : null,
                  backgroundColor: isAvailable
                      ? AppTheme.getPrimaryColor(context)
                      : Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  borderRadius: 12,
                ),
        ),
      );
    });
  }
}
