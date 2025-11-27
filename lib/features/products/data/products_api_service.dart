import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/config/app_config.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

part 'products_api_service.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio, {String baseUrl}) = _ProductsApiService;

  // Get all products with pagination
  @GET(AppConfig.productsEndpoint)
  Future<ProductResponse> getAllProducts({
    @Query('limit') int? limit,
    @Query('skip') int? skip,
  });

  // Get single product
  @GET('${AppConfig.productsEndpoint}/{id}')
  Future<Product> getProduct(@Path('id') int id);

  // Search products
  @GET('${AppConfig.productsEndpoint}/search')
  Future<ProductResponse> searchProducts(@Query('q') String query);

  // Get products by category
  @GET('${AppConfig.productsEndpoint}/category/{category}')
  Future<ProductResponse> getProductsByCategory(
    @Path('category') String category,
  );

  // Get all categories
  @GET(AppConfig.categoriesEndpoint)
  Future<List<Category>> getCategories();
}
