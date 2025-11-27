import 'package:flutter/material.dart';
import 'shimmer_base.dart';

/// Shimmer loading effect for banner carousel
class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerBase(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ShimmerBox(
              width: double.infinity,
              height: 180,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Indicators
        ShimmerBase(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                width: index == 0 ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Shimmer for product details hero image
class ProductImageShimmer extends StatelessWidget {
  final double height;

  const ProductImageShimmer({
    super.key,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerBase(
      child: ShimmerBox(
        width: double.infinity,
        height: height,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
    );
  }
}
