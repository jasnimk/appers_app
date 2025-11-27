import 'package:flutter/material.dart';
import 'package:appers_app/core/config/app_text_styles.dart';
import 'package:appers_app/core/widgets/custom_button.dart';

class DialogBox {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
  }) {
    final theme = Theme.of(context);

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          backgroundColor: theme.colorScheme.surface, // ADAPTS TO THEME
          surfaceTintColor: Colors.transparent, // removes M3 weird tint
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            height: 220,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface, // adaptive background
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TITLE
                  Text(
                    title,
                    style: AppTextStyles.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface, // adaptive text color
                    ),
                  ),

                  const SizedBox(height: 22),

                  // CONTENT / MESSAGE
                  content ??
                      Text(
                        message ?? "",
                        style: AppTextStyles.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),

                  const SizedBox(height: 28),

                  // BUTTONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // CANCEL
                      Expanded(
                        child: CustomButton(
                          text: cancelText,
                          // height: 46,
                          backgroundColor: theme.colorScheme.surfaceVariant,
                          textColor: theme.colorScheme.onSurfaceVariant,
                          fontSize: 12,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 2,
                          ),
                          borderRadius: 10,
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // CONFIRM
                      Expanded(
                        child: CustomButton(
                          text: confirmText,
                          // height: 46,
                          fontSize: 12,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 2,
                          ),
                          borderRadius: 10,
                          onPressed: () {
                            onConfirm?.call();
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
