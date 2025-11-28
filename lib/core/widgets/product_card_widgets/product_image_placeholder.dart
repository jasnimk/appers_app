import 'package:flutter/material.dart';

class ProductImagePlaceholder extends StatelessWidget {
  final bool isDark;
  final double width;
  final double height;
  final double opacity;

  const ProductImagePlaceholder({
    super.key,
    required this.isDark,
    this.width = 60,
    this.height = 60,
    this.opacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? Colors.grey[500] : Colors.grey[200],
      child: Center(
        child: Image.asset(
          isDark ? 'assets/logo/darklogo.png' : 'assets/logo/light_logo.png',
          width: width,
          height: height,
          opacity: AlwaysStoppedAnimation(opacity),
        ),
      ),
    );
  }
}
