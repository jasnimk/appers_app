import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/app_theme.dart';
import '../../routes/app_routes.dart';
import '../models/product_model.dart';
import 'product_card_widgets/product_image.dart';
import 'product_card_widgets/product_info.dart';
import 'bouncing_widget.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final String? heroTag;

  const ProductCard({super.key, required this.product, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onTap: () => Get.toNamed(AppRoutes.productDetails, arguments: product.id),
      child: Card(
        elevation: Theme.of(context).brightness == Brightness.dark ? 4 : 2,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 7,
              child: ProductImage(product: product, heroTag: heroTag),
            ),
            Flexible(flex: 6, child: ProductInfo(product: product)),
          ],
        ),
      ),
    );
  }
}
