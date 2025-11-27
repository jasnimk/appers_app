import 'package:flutter/material.dart';
import 'shimmer_base.dart';

/// Shimmer loading effect for list items
class ListItemShimmer extends StatelessWidget {
  const ListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerBase(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Leading image/icon
            const ShimmerCircle(size: 60),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 16,
                  ),
                  const SizedBox(height: 8),
                  ShimmerBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 12,
                  ),
                  const SizedBox(height: 8),
                  const ShimmerBox(
                    width: 80,
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal product list shimmer
class HorizontalProductShimmer extends StatelessWidget {
  final int itemCount;

  const HorizontalProductShimmer({
    super.key,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ShimmerBase(
            child: Container(
              width: 180,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(
                    width: 180,
                    height: 132,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  const SizedBox(height: 8),
                  const ShimmerBox(
                    width: double.infinity,
                    height: 14,
                  ),
                  const SizedBox(height: 6),
                  const ShimmerBox(
                    width: 80,
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Cart item shimmer
class CartItemShimmer extends StatelessWidget {
  const CartItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerBase(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Product image
            ShimmerBox(
              width: 80,
              height: 80,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(width: 12),

            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 16,
                  ),
                  const SizedBox(height: 8),
                  const ShimmerBox(
                    width: 60,
                    height: 20,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ShimmerBox(
                        width: 100,
                        height: 32,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Delete button
            const ShimmerCircle(size: 36),
          ],
        ),
      ),
    );
  }
}

/// Generic text shimmer
class TextShimmer extends StatelessWidget {
  final double? width;
  final double height;

  const TextShimmer({
    super.key,
    this.width,
    this.height = 14,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerBase(
      child: ShimmerBox(
        width: width,
        height: height,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
