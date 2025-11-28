class AppConfig {
  // Base URL for DummyJSON API
  static const String baseUrl = 'https://dummyjson.com';

  // Alternative API
  // static const String baseUrl = 'https://fakestoreapi.com';

  static const String productsEndpoint = '/products';
  static const String categoriesEndpoint = '/products/categories';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // App Info
  static const String appName = 'Appers Shop';
  static const String appVersion = '1.0.0';
}
