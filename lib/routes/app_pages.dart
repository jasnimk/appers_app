import 'package:get/get.dart';
import '../features/home/views/shell_screen.dart';
import '../features/product_details/views/product_details_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.shell,
      page: () => const ShellScreen(),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () {
        final productId = Get.arguments as int;
        return ProductDetailsScreen(productId: productId);
      },
    ),
  ];
}
