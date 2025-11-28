import 'package:flutter/material.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

class SettingsSectionTitle extends StatelessWidget {
  final String title;

  const SettingsSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: AppTextStyles.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppTheme.getPrimaryColor(context),
          ),
        ),
      ),
    );
  }
}
