import 'package:appers_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../controllers/cart_controller.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(() {
      final subtotal = cartController.totalPrice;
      final tax = subtotal * 0.1; // 10% tax
      final total = subtotal + tax;

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Subtotal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: AppTextStyles.poppins(
                      fontSize: 14,
                      color: AppTheme.getPriceSecColor(context),
                    ),
                  ),
                  Text(
                    '\$${subtotal.toStringAsFixed(2)}',
                    style: AppTextStyles.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Tax
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tax (10%)',
                    style: AppTextStyles.poppins(
                      fontSize: 14,
                      color: AppTheme.getPriceSecColor(context),
                    ),
                  ),
                  Text(
                    '\$${tax.toStringAsFixed(2)}',
                    style: AppTextStyles.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              const Divider(),
              const SizedBox(height: 8),

              // Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: AppTextStyles.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: AppTextStyles.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.getPrimaryColor(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // // Checkout Button
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: cartController.cartItems.isNotEmpty
              //         ? () {
              //             SnackbarUtils.showInfo(
              //               context,
              //               'Proceeding to checkout with ${cartController.cartItems.length} items',
              //             );
              //           }
              //         : null,
              //     style: ElevatedButton.styleFrom(
              //       padding: const EdgeInsets.symmetric(vertical: 16),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //     child: Text(
              //       'Proceed to Checkout',
              //       style: AppTextStyles.poppins(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              // Checkout Button
              CustomButton(
                height: 40,
                text: 'Proceed to Checkout',
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                onPressed: cartController.cartItems.isNotEmpty
                    ? () {
                        SnackbarUtils.showInfo(
                          context,
                          'Proceeding to checkout with ${cartController.cartItems.length} items',
                        );
                      }
                    : null,
                backgroundColor: AppTheme.getPrimaryColor(context),
                // textColor: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                borderRadius: 12,
              ),
            ],
          ),
        ),
      );
    });
  }
}
