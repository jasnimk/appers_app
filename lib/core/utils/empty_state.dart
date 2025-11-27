import 'package:appers_app/core/config/app_text_styles.dart';
import 'package:appers_app/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  final String? lottiePath;
  final String? imagePath;
  final String message;
  final double size;
  final Color? textColor; // nullable, no default

  const EmptyState({
    super.key,
    this.lottiePath,
    this.imagePath,
    this.size = 180,
    this.message = "No results found",
    this.textColor, // remove default value
  });

  @override
  Widget build(BuildContext context) {
    final resolvedTextColor = textColor ?? AppTheme.getTextPrimary(context);

    Widget visual;

    if (lottiePath != null) {
      visual = Lottie.asset(
        lottiePath!,
        height: size,
        width: size,
        fit: BoxFit.contain,
      );
    } else if (imagePath != null) {
      visual = Image.asset(
        imagePath!,
        height: size,
        width: size,
        fit: BoxFit.contain,
      );
    } else {
      visual = Image.asset(
        'assets/vectors/no_results.png',
        height: size,
        width: size,
        fit: BoxFit.contain,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        visual,
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.poppins(fontSize: 14, color: resolvedTextColor),
        ),
      ],
    );
  }
}
