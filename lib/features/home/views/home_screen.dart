import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/config/app_text_styles.dart';
import '../controllers/home_controller.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/category_products_section.dart';
import '../widgets/category_grid_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Appers Shop',
        showLogo: true,
        centerTitle: true,
        logoHeight: 65,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: Obx(() {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Categories Grid Row
                CategoryGridRow(
                  categories: controller.allCategories,
                  categoryImages: controller.categoryImages,
                  onCategoryTap: controller.navigateToExploreWithCategory,
                  isLoading:
                      controller.isLoading && controller.allCategories.isEmpty,
                ),
                const SizedBox(height: 20),

                // Banner Carousel
                const BannerCarousel(),
                const SizedBox(height: 14),

                // Show shimmer while loading
                if (controller.isLoading &&
                    controller.categorySections.isEmpty) ...[
                  CategoryProductsSection(
                    title: 'Loading...',
                    products: const [],
                    isLoading: true,
                    onSeeAll: null,
                  ),
                  const SizedBox(height: 14),
                  CategoryProductsSection(
                    title: 'Loading...',
                    products: const [],
                    isLoading: true,
                    onSeeAll: null,
                  ),
                  const SizedBox(height: 14),
                  CategoryProductsSection(
                    title: 'Loading...',
                    products: const [],
                    isLoading: true,
                    onSeeAll: null,
                  ),
                ] else
                  // Dynamic Category Sections
                  ...controller.categorySections.map((section) {
                    return Column(
                      children: [
                        CategoryProductsSection(
                          title: section.categoryName,
                          products: section.products,
                          isLoading: false,
                          onSeeAll: () {
                            controller.navigateToExploreWithCategory(
                              section.categorySlug,
                            );
                          },
                        ),
                        const SizedBox(height: 14),
                      ],
                    );
                  }),

                const SizedBox(height: 8),
              ],
            ),
          );
        }),
      ),
    );
  }
}
