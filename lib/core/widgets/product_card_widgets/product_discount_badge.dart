import 'package:flutter/material.dart';
import '../../config/app_text_styles.dart';
import '../../config/app_theme.dart';

class ProductDiscountBadge extends StatelessWidget {
  final double discountPercentage;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const ProductDiscountBadge({
    super.key,
    required this.discountPercentage,
    this.fontSize = 9,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  });

  @override
  Widget build(BuildContext context) {
    if (discountPercentage <= 0) return const SizedBox.shrink();

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppTheme.getPrimaryColor(context),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '-${discountPercentage.toStringAsFixed(0)}%',
        style: AppTextStyles.poppins(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: AppTheme.getTextPrimaryColor(context),
        ),
      ),
    );
  }
}
