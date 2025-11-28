import 'dart:math';
import 'package:get/get.dart';
import '../../../core/models/product_model.dart';
import '../../../core/models/category_model.dart';
import '../../../core/data/repositories/products_repository.dart';
import '../../products/controllers/products_controller.dart';
import 'shell_controller.dart';

class CategorySection {
  final String categorySlug;
  final String categoryName;
  final List<Product> products;

  CategorySection({
    required this.categorySlug,
    required this.categoryName,
    required this.products,
  });
}

class HomeController extends GetxController {
  final ProductsRepository _repository = ProductsRepository();

  final _isLoading = false.obs;
  final _categorySections = <CategorySection>[].obs;
  final _allCategories = <Category>[].obs;
  final _categoryImages = <String, String>{}.obs; // category slug -> random image URL

  bool get isLoading => _isLoading.value;
  List<CategorySection> get categorySections => _categorySections;
  List<Category> get allCategories => _allCategories;
  Map<String, String> get categoryImages => _categoryImages;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    try {
      _isLoading.value = true;

      // Fetch all available categories
      final allCategories = await _repository.getCategories();

      if (allCategories.isEmpty) {
        return;
      }

      // Store all categories for the category grid
      _allCategories.value = allCategories;

      // Pick 4-5 random categories for sections
      final random = Random();
      final numberOfCategories = 4 + random.nextInt(2); // 4 or 5
      final shuffled = List<Category>.from(allCategories)..shuffle();
      final selectedCategories = shuffled.take(numberOfCategories).toList();

      // Fetch products for each selected category and get random images for all categories
      final sections = <CategorySection>[];
      final images = <String, String>{};

      for (final category in allCategories) {
        try {
          final response = await _repository.getProductsByCategory(category.slug);

          // Get a random product image for the category grid
          if (response.products.isNotEmpty) {
            final randomProduct = response.products[random.nextInt(response.products.length)];
            images[category.slug] = randomProduct.thumbnail;
          }

          // If this is one of the selected categories, add it to sections
          if (selectedCategories.any((c) => c.slug == category.slug)) {
            sections.add(CategorySection(
              categorySlug: category.slug,
              categoryName: category.name,
              products: response.products.take(10).toList(),
            ));
          }
        } catch (e) {
          print('Error fetching products for ${category.name}: $e');
        }
      }

      _categoryImages.value = images;
      _categorySections.value = sections;
    } catch (e) {
      print('Error fetching home data: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    await fetchHomeData();
  }

  void navigateToExploreWithCategory(String categorySlug) {
    // Get the ProductsController and apply the category filter
    final productsController = Get.find<ProductsController>();
    productsController.filterByCategory(categorySlug);

    // Switch to Explore tab (index 1)
    Get.find<ShellController>().changeTab(1);
  }
}
