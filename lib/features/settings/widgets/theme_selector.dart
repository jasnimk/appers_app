import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../../../core/controllers/theme_controller.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThemeController>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.getCardInfoBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Obx(
            () => _buildThemeOption(
              context,
              controller: controller,
              icon: FontAwesomeIcons.sun,
              title: 'Light Mode',
              isSelected: controller.isLightMode,
              onTap: () => controller.setThemeMode(ThemeMode.light),
            ),
          ),
          Divider(height: 1, color: Colors.grey.withValues(alpha: 0.2)),
          Obx(
            () => _buildThemeOption(
              context,
              controller: controller,
              icon: FontAwesomeIcons.moon,
              title: 'Dark Mode',
              isSelected: controller.isDarkMode,
              onTap: () => controller.setThemeMode(ThemeMode.dark),
            ),
          ),
          Divider(height: 1, color: Colors.grey.withValues(alpha: 0.2)),
          Obx(
            () => _buildThemeOption(
              context,
              controller: controller,
              icon: FontAwesomeIcons.circleHalfStroke,
              title: 'System Default',
              isSelected: controller.isSystemMode,
              onTap: () => controller.setSystemMode(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required ThemeController controller,
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: FaIcon(
        icon,
        size: 20,
        color: isSelected ? AppTheme.getPrimaryColor(context) : Colors.grey,
      ),
      title: Text(
        title,
        style: AppTextStyles.poppins(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppTheme.getPrimaryColor(context) : null,
        ),
      ),
      trailing: isSelected
          ? FaIcon(
              FontAwesomeIcons.circleCheck,
              color: AppTheme.getPrimaryColor(context),
              size: 20,
            )
          : null,
    );
  }
}
