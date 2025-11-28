import 'package:get/get.dart';
import '../../../core/models/product_model.dart';
import '../../../core/models/category_model.dart';
import '../../../core/data/repositories/products_repository.dart';

class ProductsController extends GetxController {
  final ProductsRepository _repository = ProductsRepository();

  final _products = <Product>[].obs;
  final _categories = <Category>[].obs;
  final _categoryNames = <String>[].obs;

  final _isLoading = false.obs;
  final _isLoadingMore = false.obs;

  final _error = ''.obs;

  final _selectedCategory = Rxn<String>();
  final _searchQuery = ''.obs;

  int skip = 0;
  final int limit = 20;
  bool hasMore = true;

  List<Product> get products => _products;
  List<String> get categories => _categoryNames;
  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  String get error => _error.value;
  bool get hasError => _error.value.isNotEmpty;
  String? get selectedCategory => _selectedCategory.value;
  String get searchQuery => _searchQuery.value;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    try {
      _isLoading.value = true;
      _error.value = '';
      skip = 0;
      hasMore = true;

      final response = await _repository.getAllProducts(
        limit: limit,
        skip: skip,
      );

      _products.value = response.products;
      hasMore = _products.length < response.total;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  // Load more products
  Future<void> loadMore() async {
    if (_isLoadingMore.value || !hasMore) return;

    try {
      _isLoadingMore.value = true;
      skip += limit;

      final response = await _repository.getAllProducts(
        limit: limit,
        skip: skip,
      );

      if (response.products.isEmpty) {
        hasMore = false;
        return;
      }

      _products.addAll(response.products);

      hasMore = _products.length < response.total;
    } finally {
      _isLoadingMore.value = false;
    }
  }

  // ---------------------------
  // Searching
  // ---------------------------
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      fetchProducts();
      return;
    }

    try {
      _isLoading.value = true;
      _searchQuery.value = query;
      _selectedCategory.value = null;
      skip = 0;
      hasMore = false;

      final response = await _repository.searchProducts(query);
      _products.value = response.products;
    } finally {
      _isLoading.value = false;
    }
  }

  // ---------------------------
  // Filtering by category
  // ---------------------------
  Future<void> filterByCategory(String? category) async {
    if (category == null || category.isEmpty) {
      fetchProducts();
      return;
    }

    try {
      _isLoading.value = true;
      _selectedCategory.value = category;
      _searchQuery.value = '';
      skip = 0;
      hasMore = false;

      final response = await _repository.getProductsByCategory(category);
      _products.value = response.products;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      final categoriesList = await _repository.getCategories();
      _categories.value = categoriesList;
      _categoryNames.value = categoriesList.map((c) => c.slug).toList();
    } catch (_) {}
  }

  void clearFilters() {
    _searchQuery.value = '';
    _selectedCategory.value = null;
    _error.value = '';
    skip = 0;
    hasMore = true;
    fetchProducts();
  }

  Future<void> refresh() async {
    await fetchProducts();
  }
}
