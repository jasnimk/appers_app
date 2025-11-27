import 'package:get/get.dart';

class ShellController extends GetxController {
  final _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void changeTab(int index) {
    _currentIndex.value = index;
  }
}
