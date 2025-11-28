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
  final _error = ''.obs;
  final _selectedCategory = Rxn<String>();
  final _searchQuery = ''.obs;

  List<Product> get products => _products;
  List<String> get categories => _categoryNames;
  bool get isLoading => _isLoading.value;
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

  Future<void> fetchProducts({int limit = 30}) async {
    try {
      _isLoading.value = true;
      _error.value = '';
      _selectedCategory.value = null;
      _searchQuery.value = '';

      final response = await _repository.getAllProducts(limit: limit);
      _products.value = response.products;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      final categoriesList = await _repository.getCategories();
      _categories.value = categoriesList;
      _categoryNames.value = categoriesList.map((c) => c.slug).toList();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      fetchProducts();
      return;
    }

    try {
      _isLoading.value = true;
      _error.value = '';
      _searchQuery.value = query;
      _selectedCategory.value = null;

      final response = await _repository.searchProducts(query);
      _products.value = response.products;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> filterByCategory(String? category) async {
    if (category == null || category.isEmpty) {
      fetchProducts();
      return;
    }

    try {
      _isLoading.value = true;
      _error.value = '';
      _selectedCategory.value = category;
      _searchQuery.value = '';

      final response = await _repository.getProductsByCategory(category);
      _products.value = response.products;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  void clearFilters() {
    _selectedCategory.value = null;
    _searchQuery.value = '';
    fetchProducts();
  }

  Future<void> refresh() async {
    if (_searchQuery.value.isNotEmpty) {
      await searchProducts(_searchQuery.value);
    } else if (_selectedCategory.value != null) {
      await filterByCategory(_selectedCategory.value);
    } else {
      await fetchProducts();
    }
  }
}
