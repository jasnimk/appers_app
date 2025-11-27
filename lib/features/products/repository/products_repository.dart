import '../../../core/network/dio_client.dart';
import '../data/products_api_service.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

class ProductsRepository {
  late final ProductsApiService _apiService;

  ProductsRepository() {
    _apiService = ProductsApiService(DioClient.instance);
  }

  Future<ProductResponse> getAllProducts({int? limit, int? skip}) {
    return _apiService.getAllProducts(limit: limit, skip: skip);
  }

  Future<Product> getProduct(int id) {
    return _apiService.getProduct(id);
  }

  Future<ProductResponse> searchProducts(String query) {
    return _apiService.searchProducts(query);
  }

  Future<ProductResponse> getProductsByCategory(String category) {
    return _apiService.getProductsByCategory(category);
  }

  Future<List<Category>> getCategories() {
    return _apiService.getCategories();
  }
}
