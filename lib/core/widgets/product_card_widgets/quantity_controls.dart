import 'package:flutter/material.dart';
import '../../config/app_text_styles.dart';
import '../../config/app_theme.dart';

class QuantityControls extends StatelessWidget {
  final int quantity;
  final double size;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityControls({
    super.key,
    required this.quantity,
    required this.size,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      decoration: BoxDecoration(
        color: AppTheme.getPrimaryColor(context),
        borderRadius: BorderRadius.circular(size / 3.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton(
            icon: Icons.remove,
            onTap: onDecrement,
            context: context,
          ),
          Text(
            quantity.toString(),
            style: AppTextStyles.poppins(
              fontSize: size * 0.4375,
              fontWeight: FontWeight.bold,
              color: AppTheme.getTextPrimaryColor(context),
            ),
          ),
          _buildButton(icon: Icons.add, onTap: onIncrement, context: context),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Icon(
          icon,
          color: AppTheme.getTextPrimaryColor(context),
          size: size * 0.5,
        ),
      ),
    );
  }
}
