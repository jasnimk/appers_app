import 'package:appers_app/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit fit;

  const AppLogo({
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Image.asset(
      isDarkMode ? 'assets/logo/darklogo.png' : 'assets/logo/light_logo.png',
      height: height,
      width: width,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Text(
          'Appers Avenue',
          style: AppTextStyles.poppins(
            fontSize: height != null ? height! * 0.6 : 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}
