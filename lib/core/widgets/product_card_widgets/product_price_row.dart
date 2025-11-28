import 'package:flutter/material.dart';
import '../../config/app_text_styles.dart';
import '../../config/app_theme.dart';
import 'product_discount_badge.dart';

class ProductPriceRow extends StatelessWidget {
  final double price;
  final double discountPercentage;
  final double fontSize;
  final int decimalPlaces;

  const ProductPriceRow({
    super.key,
    required this.price,
    required this.discountPercentage,
    this.fontSize = 15,
    this.decimalPlaces = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${price.toStringAsFixed(decimalPlaces)}',
          style: AppTextStyles.poppins(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppTheme.getPriceColor(context),
          ),
        ),
        ProductDiscountBadge(discountPercentage: discountPercentage),
      ],
    );
  }
}
