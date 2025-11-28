import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../../../core/models/product_model.dart';

class ProductInfoSection extends StatelessWidget {
  final Product product;

  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Badge & Stock
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product.category.toUpperCase(),
                  style: AppTextStyles.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getPrimaryColor(context),
                  ),
                ),
              ),
              _buildStockBadge(),
            ],
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            product.title,
            style: AppTextStyles.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Brand & Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (product.brand != null)
                Expanded(
                  child: Text(
                    'by ${product.brand}',
                    style: AppTextStyles.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: product.rating,
                    itemBuilder: (context, index) =>
                        const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${product.rating.toStringAsFixed(1)})',
                    style: AppTextStyles.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockBadge() {
    final isInStock = product.stock > 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isInStock
            ? AppTheme.accentColor.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isInStock ? 'In Stock (${product.stock})' : 'Out of Stock',
        style: AppTextStyles.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isInStock ? AppTheme.accentColor : Colors.red,
        ),
      ),
    );
  }
}
