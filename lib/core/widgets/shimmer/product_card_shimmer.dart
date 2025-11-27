import 'package:flutter/material.dart';
import 'shimmer_base.dart';

/// Shimmer loading effect for product cards
class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerBase(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ShimmerBox(
              width: double.infinity,
              height: 140,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 12),

            // Product Title
            const ShimmerBox(
              width: double.infinity,
              height: 16,
            ),
            const SizedBox(height: 8),

            // Product Description
            ShimmerBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 12,
            ),
            const SizedBox(height: 12),

            // Price and Rating Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShimmerBox(
                  width: 60,
                  height: 20,
                ),
                ShimmerBox(
                  width: 50,
                  height: 16,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Grid view of product card shimmers
class ProductGridShimmer extends StatelessWidget {
  final int itemCount;

  const ProductGridShimmer({
    super.key,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const ProductCardShimmer(),
    );
  }
}
