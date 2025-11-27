import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../../../core/widgets/product_card_horizontal.dart';
import '../../../core/widgets/shimmer/shimmers.dart';
import '../../products/models/product_model.dart';

class CategoryProductsSection extends StatelessWidget {
  final String title;
  final List<Product> products;
  final bool isLoading;
  final VoidCallback? onSeeAll;

  const CategoryProductsSection({
    super.key,
    required this.title,
    required this.products,
    this.isLoading = false,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (onSeeAll != null)
                TextButton(
                  onPressed: onSeeAll,
                  child: Text(
                    'See All',
                    style: AppTextStyles.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppTheme.getPrimaryColor(context),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Products List
        if (isLoading)
          _buildShimmerLoading()
        else if (products.isEmpty)
          _buildEmptyState()
        else
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < products.length - 1 ? 12 : 0,
                  ),
                  child: ProductCardHorizontal(
                    product: products[index],
                    heroTag: 'home-product-${products[index].id}',
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return const HorizontalProductShimmer(itemCount: 3);
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 240,
      child: Center(
        child: Text(
          'No products available',
          style: AppTextStyles.poppins(fontSize: 14, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
