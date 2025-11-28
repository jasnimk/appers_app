import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/product_card.dart';
import '../../../core/widgets/shimmer/shimmers.dart';
import '../../../core/utils/empty_state.dart';
import '../controllers/products_controller.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_filter_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Explore Products',
      ),
      body: Obx(() {
        if (controller.isLoading && controller.products.isEmpty) {
          return const ProductGridShimmer(itemCount: 6);
        }

        if (controller.hasError) {
          return Center(
            child: EmptyState(
              message: 'Unable to load products',
              subtitle: 'Check your connection and try again',
              size: 140,
              onRetry: controller.refresh,
            ),
          );
        }

        if (controller.products.isEmpty) {
          return Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SearchBarWidget(
                  onSearch: controller.searchProducts,
                  onClear: controller.clearFilters,
                  initialQuery: controller.searchQuery,
                ),
              ),
              const SizedBox(height: 12),
              CategoryFilterWidget(
                categories: controller.categories,
                selectedCategory: controller.selectedCategory,
                onCategorySelected: controller.filterByCategory,
                isLoading: false,
              ),
              const Expanded(
                child: Center(
                  child: EmptyState(
                    message: 'No products found',
                  ),
                ),
              ),
            ],
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refresh,
          child: CustomScrollView(
            slivers: [
              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: SearchBarWidget(
                    onSearch: controller.searchProducts,
                    onClear: controller.clearFilters,
                    initialQuery: controller.searchQuery,
                  ),
                ),
              ),

              // Category Filter
              SliverToBoxAdapter(
                child: CategoryFilterWidget(
                  categories: controller.categories,
                  selectedCategory: controller.selectedCategory,
                  onCategorySelected: controller.filterByCategory,
                  isLoading: controller.categories.isEmpty && !controller.hasError,
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Products Grid or Loading Shimmer
              if (controller.isLoading && controller.products.isNotEmpty)
                // Show shimmer overlay when filtering
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.65,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const ProductCardShimmer(),
                      childCount: 6,
                    ),
                  ),
                )
              else
                // Products Grid
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.65,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = controller.products[index];
                        return ProductCard(product: product);
                      },
                      childCount: controller.products.length,
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        );
      }),
    );
  }
}
