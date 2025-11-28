import 'package:get/get.dart';
import '../../products/controllers/products_controller.dart';

class ShellController extends GetxController {
  final _currentIndex = 0.obs;
  int _previousIndex = 0;

  int get currentIndex => _currentIndex.value;

  void changeTab(int index) {
    // If switching away from Explore tab (index 1), clear filters
    if (_previousIndex == 1 && index != 1) {
      try {
        final productsController = Get.find<ProductsController>();
        productsController.clearFilters();
      } catch (e) {
        // ProductsController not initialized yet, safe to ignore
      }
    }

    _previousIndex = _currentIndex.value;
    _currentIndex.value = index;
  }
}
