import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/shimmer/shimmers.dart';
import '../../../core/widgets/product_card_horizontal.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/utils/empty_state.dart';
import '../controllers/product_details_controller.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/product_description_section.dart';
import '../widgets/product_image_header.dart';
import '../widgets/product_info_section.dart';
import '../widgets/product_price_section.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ProductDetailsController(),
      tag: productId.toString(),
    );

    // Fetch product details only once when controller is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.product == null && !controller.isLoading) {
        controller.fetchProductDetails(productId);
      }
    });

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading) {
          return const ProductDetailsShimmer();
        }

        if (controller.hasError) {
          return Center(
            child: EmptyState(
              message: 'Failed to load product',
              subtitle: 'Something went wrong while loading product details',
              size: 140,
              onRetry: () => controller.fetchProductDetails(productId),
            ),
          );
        }

        final product = controller.product;
        if (product == null) {
          return const Center(
            child: EmptyState(
              message: 'Product not found',
              subtitle: 'This product may have been removed or is unavailable',
              size: 140,
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            // Product Image Header with Hero Animation
            ProductImageHeader(productId: product.id, images: product.images),

            // Product Details Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Info (Category, Title, Brand, Rating, Stock)
                    ProductInfoSection(product: product),
                    const SizedBox(height: 16),

                    // Price Section
                    ProductPriceSection(
                      price: product.price,
                      discountPercentage: product.discountPercentage,
                    ),
                    const SizedBox(height: 16),

                    // Description and Tags
                    ProductDescriptionSection(
                      description: product.description,
                      tags: product.tags,
                    ),
                    const SizedBox(height: 24),

                    // Similar Products Section
                    Obx(() {
                      if (controller.isSimilarLoading) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Similar Products',
                              style: AppTextStyles.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const HorizontalProductShimmer(itemCount: 3),
                          ],
                        );
                      }

                      if (controller.similarProducts.isEmpty) {
                        return const SizedBox();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              'Similar Products',
                              style: AppTextStyles.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.similarProducts.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        index <
                                            controller.similarProducts.length -
                                                1
                                        ? 12
                                        : 0,
                                  ),
                                  child: ProductCardHorizontal(
                                    product: controller.similarProducts[index],
                                    heroTag:
                                        'similar-${controller.similarProducts[index].id}',
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }),

                    // const SizedBox(height: 100), // Space for bottom button
                  ],
                ),
              ),
            ),
          ],
        );
      }),

      // Add to Cart Button
      bottomNavigationBar: Obx(() {
        final product = controller.product;
        if (product == null) return const SizedBox();
        return AddToCartButton(product: product);
      }),
    );
  }
}
