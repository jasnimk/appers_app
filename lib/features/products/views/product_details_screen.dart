import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Product Details',
      ),
      body: Center(
        child: Text('Product Details Screen - ID: $productId'),
      ),
    );
  }
}
