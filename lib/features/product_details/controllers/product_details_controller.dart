import 'package:get/get.dart';
import '../../../core/models/product_model.dart';
import '../../../core/data/repositories/products_repository.dart';

class ProductDetailsController extends GetxController {
  final ProductsRepository _repository = ProductsRepository();

  final _product = Rx<Product?>(null);
  final _similarProducts = <Product>[].obs;
  final _isLoading = false.obs;
  final _isSimilarLoading = false.obs;
  final _error = ''.obs;

  Product? get product => _product.value;
  List<Product> get similarProducts => _similarProducts;
  bool get isLoading => _isLoading.value;
  bool get isSimilarLoading => _isSimilarLoading.value;
  String get error => _error.value;
  bool get hasError => _error.value.isNotEmpty;

  Future<void> fetchProductDetails(int productId) async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final productData = await _repository.getProduct(productId);
      _product.value = productData;

      // Fetch similar products from the same category
      if (productData.category.isNotEmpty) {
        fetchSimilarProducts(productData.category, productId);
      }
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> fetchSimilarProducts(
    String category,
    int currentProductId,
  ) async {
    try {
      _isSimilarLoading.value = true;

      final response = await _repository.getProductsByCategory(category);

      // Filter out the current product and take up to 10 similar products
      _similarProducts.value = response.products
          .where((p) => p.id != currentProductId)
          .take(10)
          .toList();
    } catch (e) {
      _similarProducts.value = [];
    } finally {
      _isSimilarLoading.value = false;
    }
  }
}
