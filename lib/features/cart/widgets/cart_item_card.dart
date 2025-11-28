import 'package:appers_app/core/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../controllers/cart_controller.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: cartItem.product.thumbnail,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: Center(child: AppLoader()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.error, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.title,
                    style: AppTextStyles.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cartItem.product.category,
                    style: AppTextStyles.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${cartItem.product.price.toStringAsFixed(2)}',
                    style: AppTextStyles.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.getPriceColor(context),
                    ),
                  ),
                ],
              ),
            ),

            // Quantity Controls
            Column(
              children: [
                // Remove Button
                IconButton(
                  onPressed: () =>
                      cartController.removeFromCart(cartItem.product.id),
                  icon: const Icon(Icons.delete_outline),
                  color: AppTheme.getPriceColor(context),
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(height: 8),

                // Quantity Controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Decrement Button
                      InkWell(
                        onTap: cartItem.quantity > 1
                            ? () => cartController.decrementQuantity(
                                cartItem.product.id,
                              )
                            : null,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.remove,
                            size: 16,
                            color: cartItem.quantity > 1
                                ? AppTheme.getPriceColor(context)
                                : Colors.grey[700],
                          ),
                        ),
                      ),

                      // Quantity Display
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${cartItem.quantity}',
                          style: AppTextStyles.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Increment Button
                      InkWell(
                        onTap: cartItem.quantity < cartItem.product.stock
                            ? () => cartController.incrementQuantity(
                                cartItem.product.id,
                              )
                            : null,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.add,
                            size: 16,
                            color: cartItem.quantity < cartItem.product.stock
                                ? AppTheme.getPriceColor(context)
                                : Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
