import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/app_text_styles.dart';
import '../config/app_theme.dart';
import '../../routes/app_routes.dart';
import '../models/product_model.dart';
import 'product_card_widgets/product_image.dart';
import 'product_card_widgets/product_rating.dart';
import 'product_card_widgets/product_price_row.dart';
import 'product_card_widgets/add_to_cart_button.dart';
import 'bouncing_widget.dart';

class ProductCardHorizontal extends StatelessWidget {
  final Product product;
  final String? heroTag;

  const ProductCardHorizontal({super.key, required this.product, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onTap: () {
        if (Get.currentRoute == AppRoutes.productDetails) {
          Get.back();
          Future.delayed(const Duration(milliseconds: 100), () {
            Get.toNamed(AppRoutes.productDetails, arguments: product.id);
          });
        } else {
          Get.toNamed(AppRoutes.productDetails, arguments: product.id);
        }
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: AppTheme.getPrimaryColor(context),
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 6,
                child: _HorizontalProductImage(
                  product: product,
                  heroTag: heroTag,
                ),
              ),
              Flexible(
                flex: 4,
                child: _HorizontalProductInfo(product: product),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HorizontalProductImage extends StatelessWidget {
  final Product product;
  final String? heroTag;

  const _HorizontalProductImage({required this.product, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProductImage(product: product, heroTag: heroTag, fit: BoxFit.cover),
        Positioned(
          bottom: 8,
          right: 8,
          child: AddToCartButton(product: product, size: 28),
        ),
      ],
    );
  }
}

class _HorizontalProductInfo extends StatelessWidget {
  final Product product;

  const _HorizontalProductInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.getCardInfoBackground(context),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          ProductRating(rating: product.rating),
          ProductPriceRow(
            price: product.price,
            discountPercentage: product.discountPercentage,
            fontSize: 16,
            decimalPlaces: 0,
          ),
        ],
      ),
    );
  }
}
