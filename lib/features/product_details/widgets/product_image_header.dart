import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/config/app_theme.dart';

class ProductImageHeader extends StatelessWidget {
  final int productId;
  final String imageUrl;

  const ProductImageHeader({
    super.key,
    required this.productId,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppTheme.getCardImageBackground(context),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'product-$productId',
          child: Container(
            color: AppTheme.getCardImageBackground(context),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              placeholder: (context, url) => Center(
                child: Image.asset(
                  isDark
                      ? 'assets/logo/darklogo.png'
                      : 'assets/logo/light_logo.png',
                  width: 80,
                  height: 80,
                  opacity: const AlwaysStoppedAnimation(0.3),
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Image.asset(
                  isDark
                      ? 'assets/logo/darklogo.png'
                      : 'assets/logo/light_logo.png',
                  width: 80,
                  height: 80,
                  opacity: const AlwaysStoppedAnimation(0.2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
