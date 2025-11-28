import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../config/app_text_styles.dart';

class ProductRating extends StatelessWidget {
  final double rating;
  final double itemSize;
  final double fontSize;

  const ProductRating({
    super.key,
    required this.rating,
    this.itemSize = 12,
    this.fontSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) =>
              const Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: itemSize,
        ),
        const SizedBox(width: 4),
        Text(
          '(${rating.toStringAsFixed(1)})',
          style: AppTextStyles.poppins(fontSize: fontSize, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
