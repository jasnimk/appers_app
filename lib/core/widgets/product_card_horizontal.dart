import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../config/app_text_styles.dart';
import '../config/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../features/products/models/product_model.dart';

class ProductCardHorizontal extends StatelessWidget {
  final Product product;
  final String? heroTag;

  const ProductCardHorizontal({super.key, required this.product, this.heroTag});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        print('🔵 ProductCardHorizontal tapped!');
        print('🔵 Product ID: ${product.id}');
        print('🔵 Product Title: ${product.title}');
        print('🔵 Current Route: ${Get.currentRoute}');

        // If already on product details, pop first then navigate
        if (Get.currentRoute == AppRoutes.productDetails) {
          print('🔵 Already on product details, popping first');
          Get.back();
          // Use a slight delay to ensure pop completes before navigating
          Future.delayed(const Duration(milliseconds: 100), () {
            print('🔵 Now navigating to product ${product.id}');
            Get.toNamed(AppRoutes.productDetails, arguments: product.id);
          });
        } else {
          print('🔵 Navigating to: ${AppRoutes.productDetails}');
          Get.toNamed(AppRoutes.productDetails, arguments: product.id);
        }

        print('🔵 Navigation logic executed');
      },
      child: Container(
        width: 180,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with lighter background in dark mode - 60% space
            Flexible(
              flex: 6,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.getCardImageBackground(context),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Hero(
                  tag: heroTag ?? 'product-${product.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        child: Center(
                          child: Image.asset(
                            isDark
                                ? 'assets/logo/darklogo.png'
                                : 'assets/logo/light_logo.png',
                            width: 50,
                            height: 50,
                            opacity: const AlwaysStoppedAnimation(0.3),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        child: Center(
                          child: Image.asset(
                            isDark
                                ? 'assets/logo/darklogo.png'
                                : 'assets/logo/light_logo.png',
                            width: 50,
                            height: 50,
                            opacity: const AlwaysStoppedAnimation(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Product Info with darker background in dark mode - 40% space
            Flexible(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.getCardInfoBackground(context),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Rating
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: product.rating,
                              itemBuilder: (context, index) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${product.rating.toStringAsFixed(1)})',
                              style: AppTextStyles.poppins(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Price and Discount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(0)}',
                          style: AppTextStyles.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.getPriceColor(context),
                          ),
                        ),
                        if (product.discountPercentage > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.getPrimaryColor(context),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '-${product.discountPercentage.toStringAsFixed(0)}%',
                              style: AppTextStyles.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.getTextPrimaryColor(context),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
