import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/config/app_theme.dart';

class ProductImageHeader extends StatefulWidget {
  final int productId;
  final List<String> images;

  const ProductImageHeader({
    super.key,
    required this.productId,
    required this.images,
  });

  @override
  State<ProductImageHeader> createState() => _ProductImageHeaderState();
}

class _ProductImageHeaderState extends State<ProductImageHeader> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppTheme.getCardImageBackground(context),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'product-${widget.productId}',
          child: Container(
            color: AppTheme.getCardImageBackground(context),
            child: Stack(
              children: [
                // Image PageView
                PageView.builder(
                  controller: _pageController,
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: widget.images[index],
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
                    );
                  },
                ),

                // Page Indicator
                if (widget.images.length > 1)
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: widget.images.length,
                          effect: WormEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Colors.white,
                            dotColor: Colors.white.withValues(alpha: 0.4),
                            spacing: 8,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
