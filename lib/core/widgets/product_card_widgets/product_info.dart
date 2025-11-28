import 'package:flutter/material.dart';
import '../../config/app_text_styles.dart';
import '../../config/app_theme.dart';
import '../../models/product_model.dart';
import 'product_rating.dart';
import 'product_price_row.dart';
import 'add_to_cart_button.dart';

class ProductInfo extends StatelessWidget {
  final Product product;
  final bool showAddToCart;

  const ProductInfo({
    super.key,
    required this.product,
    this.showAddToCart = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.getCardInfoBackground(context),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              ProductRating(rating: product.rating),
            ],
          ),
          const SizedBox(height: 4),
          ProductPriceRow(
            price: product.price,
            discountPercentage: product.discountPercentage,
          ),
          if (showAddToCart) ...[
            const SizedBox(height: 6),
            Expanded(child: AddToCartButton(product: product, showText: true)),
          ],
        ],
      ),
    );
  }
}
