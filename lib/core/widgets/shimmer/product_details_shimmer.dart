import 'package:flutter/material.dart';
import 'shimmer_base.dart';

/// Shimmer loading effect for product details screen
class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerBase(
      child: CustomScrollView(
        slivers: [
          // Image Header Shimmer
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ShimmerBox(
                width: double.infinity,
                height: 300,
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),

          // Content Shimmer
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category badge
                  ShimmerBox(
                    width: 100,
                    height: 24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  const SizedBox(height: 12),

                  // Title
                  ShimmerBox(
                    width: double.infinity,
                    height: 28,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  ShimmerBox(
                    width: 200,
                    height: 28,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 16),

                  // Brand and Rating Row
                  Row(
                    children: [
                      ShimmerBox(
                        width: 80,
                        height: 20,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const Spacer(),
                      ShimmerBox(
                        width: 120,
                        height: 20,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Price Section
                  ShimmerBox(
                    width: 150,
                    height: 36,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  ShimmerBox(
                    width: 100,
                    height: 20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 24),

                  // Description Title
                  ShimmerBox(
                    width: 120,
                    height: 20,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 12),

                  // Description Lines
                  ShimmerBox(
                    width: double.infinity,
                    height: 16,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  ShimmerBox(
                    width: double.infinity,
                    height: 16,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  ShimmerBox(
                    width: 250,
                    height: 16,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 24),

                  // Tags
                  Row(
                    children: [
                      ShimmerBox(
                        width: 80,
                        height: 32,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      const SizedBox(width: 8),
                      ShimmerBox(
                        width: 100,
                        height: 32,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      const SizedBox(width: 8),
                      ShimmerBox(
                        width: 70,
                        height: 32,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
