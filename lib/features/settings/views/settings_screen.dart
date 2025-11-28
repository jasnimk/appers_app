import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/controllers/theme_controller.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../core/config/app_text_styles.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../home/controllers/shell_controller.dart';
import '../widgets/settings_header.dart';
import '../widgets/settings_section_title.dart';
import '../widgets/settings_info_tile.dart';
import '../widgets/theme_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _navigateToCart(BuildContext context) {
    final shellController = Get.find<ShellController>();
    shellController.changeTab(2);
  }

  void _showComingSoon(BuildContext context) {
    SnackbarUtils.showInfo(
      context,
      'Coming in future updates',
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // App Logo and Name
            const SettingsHeader(),
            const SizedBox(height: 30),

            // Cart & Orders Section (First)
            const SettingsSectionTitle(title: 'Shopping'),
            SettingsInfoTile(
              icon: FontAwesomeIcons.cartShopping,
              title: 'Cart Items',
              subtitle: Obx(
                () => Text(
                  '${cartController.itemCount} items',
                  style: AppTextStyles.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              onTap: () => _navigateToCart(context),
              trailing: const Icon(Icons.chevron_right, size: 20),
            ),
            SettingsInfoTile(
              icon: FontAwesomeIcons.boxOpen,
              title: 'My Orders',
              subtitle: 'View your order history',
              onTap: () => _showComingSoon(context),
              trailing: const Icon(Icons.chevron_right, size: 20),
            ),
            const SizedBox(height: 24),

            // Theme Settings Section
            const SettingsSectionTitle(title: 'Appearance'),
            const ThemeSelector(),
            const SizedBox(height: 24),

            // App Info Section
            const SettingsSectionTitle(title: 'About'),
            const SettingsInfoTile(
              icon: FontAwesomeIcons.mobileScreen,
              title: 'App Version',
              subtitle: '1.0.0',
            ),
            const SizedBox(height: 24),

            // Developer Info
            const SettingsSectionTitle(title: 'Developer'),
            const SettingsInfoTile(
              icon: FontAwesomeIcons.user,
              title: 'Developed by',
              subtitle: 'Jasni',
            ),
            const SettingsInfoTile(
              icon: FontAwesomeIcons.envelope,
              title: 'Contact',
              subtitle: 'mkjasni@gmail.com',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
