import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../models/product_model.dart';
import 'product_image_placeholder.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  final String? heroTag;
  final BorderRadius borderRadius;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.product,
    this.heroTag,
    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(12)),
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.getCardImageBackground(context),
        borderRadius: borderRadius,
      ),
      child: Hero(
        tag: heroTag ?? 'product-${product.id}',
        child: ClipRRect(
          borderRadius: borderRadius,
          child: CachedNetworkImage(
            imageUrl: product.thumbnail,
            width: double.infinity,
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                ProductImagePlaceholder(isDark: isDark),
            errorWidget: (context, url, error) =>
                ProductImagePlaceholder(isDark: isDark),
          ),
        ),
      ),
    );
  }
}
