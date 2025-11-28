import 'package:appers_app/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import '../config/app_text_styles.dart';

enum SnackbarType { success, error, warning, info }

class SnackbarUtils {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    Color backgroundColor;
    Color textColor = Colors.white;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = AppTheme.getPrimaryColor(context);
        textColor = Colors.white;
        icon = Icons.check_circle;
        break;

      case SnackbarType.error:
        backgroundColor = AppTheme.getPrimaryColor(context);
        textColor = Colors.white;
        icon = Icons.error;
        break;

      case SnackbarType.warning:
        backgroundColor = AppTheme.getPrimaryColor(context);
        textColor = Colors.white;
        icon = Icons.warning;
        break;

      case SnackbarType.info:
        backgroundColor = AppTheme.getPrimaryColor(context);
        textColor = Colors.white;
        icon = Icons.info;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: AppTheme.getTextPrimaryColor(context), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.poppins(
                  fontSize: 14,
                  color: AppTheme.getTextPrimaryColor(context),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: Colors.white,
                onPressed: onAction ?? () {},
              )
            : null,
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    show(context, message: message, type: SnackbarType.error);
  }

  static void showSuccess(BuildContext context, String message) {
    show(context, message: message, type: SnackbarType.success);
  }

  static void showWarning(BuildContext context, String message) {
    show(context, message: message, type: SnackbarType.warning);
  }

  static void showInfo(BuildContext context, String message) {
    show(context, message: message, type: SnackbarType.info);
  }
}
