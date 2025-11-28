import 'package:appers_app/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../core/config/app_theme.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../cart/views/cart_screen.dart';
import '../../products/views/explore_screen.dart';
import '../../settings/views/settings_screen.dart';
import '../controllers/shell_controller.dart';
import 'home_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  DateTime? _lastBackPressed;

  Future<bool> _onWillPop(ShellController controller) async {
    // If not on home tab, navigate to home
    if (controller.currentIndex != 0) {
      controller.changeTab(0);
      return false; // Don't exit app
    }

    // If on home tab, check for double back press
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      SnackbarUtils.showWarning(context, 'Press back again to exit');
      return false; // Don't exit app
    }

    return true; // Exit app
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShellController());

    final List<Widget> screens = [
      const HomeScreen(),
      ExploreScreen(),
      const CartScreen(),
      const SettingsScreen(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldPop = await _onWillPop(controller);
          if (shouldPop) {
            SystemNavigator.pop();
          }
        }
      },
      child: Obx(
        () => Scaffold(
          body: IndexedStack(index: controller.currentIndex, children: screens),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: controller.changeTab,
            selectedItemColor: AppTheme.getPrimaryColor(context),
            unselectedItemColor: Colors.grey,

            selectedIconTheme: IconThemeData(
              color: AppTheme.getPrimaryColor(context),
              size: 26,
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.grey,
              size: 22,
            ),

            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: AppTextStyles.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: AppTextStyles.poppins(
              fontWeight: FontWeight.normal,
              fontSize: 10,
            ),
            elevation: 8,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(FontAwesomeIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(FontAwesomeIcons.compass),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                activeIcon: Icon(FontAwesomeIcons.cartShopping),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                activeIcon: Icon(FontAwesomeIcons.gear),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
