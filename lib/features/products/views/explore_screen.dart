import 'package:appers_app/core/config/app_theme.dart';
import 'package:appers_app/core/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/product_card.dart';
import '../../../core/widgets/shimmer/shimmers.dart';
import '../../../core/utils/empty_state.dart';
import '../../../core/widgets/staggered_animation.dart';

import '../controllers/products_controller.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_filter_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ScrollController _scrollController = ScrollController();
  late ProductsController controller;
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProductsController());

    // Scroll listeners
    _scrollController.addListener(() {
      // Pagination listener
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        controller.loadMore();
      }

      // Show/hide scroll to top button
      if (_scrollController.offset >= 400 && !_showScrollToTop) {
        setState(() => _showScrollToTop = true);
      } else if (_scrollController.offset < 400 && _showScrollToTop) {
        setState(() => _showScrollToTop = false);
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Explore Products'),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _showScrollToTop ? Offset.zero : const Offset(0, 2),
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _showScrollToTop ? 1.0 : 0.0,
          child: _showScrollToTop
              ? FloatingActionButton(
                  tooltip: "Scroll to top!",
                  mini: true,
                  backgroundColor: AppTheme.getPrimaryColor(context),
                  onPressed: _scrollToTop,
                  elevation: 4,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 28,
                    color: AppTheme.getTextPrimaryColor(context),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
      body: Obx(() {
        // --------------------------
        // Loading initial products
        // --------------------------
        if (controller.isLoading && controller.products.isEmpty) {
          return const ProductGridShimmer(itemCount: 6);
        }

        // --------------------------
        // Error state
        // --------------------------
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

        // --------------------------
        // Empty product list
        // --------------------------
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
                child: Center(child: EmptyState(message: 'No products found')),
              ),
            ],
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refresh,
          child: CustomScrollView(
            controller: _scrollController,
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

              SliverToBoxAdapter(
                child: CategoryFilterWidget(
                  categories: controller.categories,
                  selectedCategory: controller.selectedCategory,
                  onCategorySelected: controller.filterByCategory,
                  isLoading:
                      controller.categories.isEmpty && !controller.hasError,
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.62,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = controller.products[index];
                    return StaggeredAnimation(
                      index: index,
                      child: ProductCard(product: product),
                    );
                  }, childCount: controller.products.length),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              SliverToBoxAdapter(
                child: Obx(() {
                  return controller.isLoadingMore
                      ? Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: AppLoader()),
                        )
                      : const SizedBox.shrink();
                }),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        );
      }),
    );
  }
}
