import 'package:appers_app/core/config/app_text_styles.dart';
import 'package:appers_app/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  final String? lottiePath;
  final String? imagePath;
  final String message;
  final String? subtitle;
  final double size;
  final Color? textColor;
  final VoidCallback? onRetry;
  final String? retryButtonText;

  const EmptyState({
    super.key,
    this.lottiePath,
    this.imagePath,
    this.size = 180,
    this.message = "No results found",
    this.subtitle,
    this.textColor,
    this.onRetry,
    this.retryButtonText = 'Retry',
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
        const SizedBox(height: 24),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: resolvedTextColor,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: AppTextStyles.poppins(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
        if (onRetry != null) ...[
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 20),
            label: Text(retryButtonText!),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.getPrimaryColor(context),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 14,
              ),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
