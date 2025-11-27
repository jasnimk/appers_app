import 'package:appers_app/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/config/app_text_styles.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_summary.dart';
import '../widgets/empty_cart_view.dart';
import '../../../core/widgets/dialog_box.dart'; // <-- add this import

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Cart',
        actions: [
          Obx(() {
            if (cartController.cartItems.isEmpty) return const SizedBox();
            return TextButton(
              onPressed: () {
                DialogBox.show(
                  context: context,
                  title: "Clear Cart",
                  message:
                      "Are you sure you want to remove all items from your cart?",
                  confirmText: "Clear",
                  cancelText: "Cancel",
                  onConfirm: () {
                    cartController.clearCart();
                  },
                );
              },
              child: Text(
                'Clear',
                style: AppTextStyles.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.getPriceColor(context),
                ),
              ),
            );
          }),
        ],
      ),

      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const EmptyCartView();
        }

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: Text(
                '${cartController.cartItems.length} ${cartController.cartItems.length == 1 ? 'item' : 'items'} in cart',
                style: AppTextStyles.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartController.cartItems[index];
                  return CartItemCard(cartItem: cartItem);
                },
              ),
            ),
          ],
        );
      }),

      bottomNavigationBar: Obx(() {
        if (cartController.cartItems.isEmpty) return const SizedBox();
        return const CartSummary();
      }),
    );
  }
}
