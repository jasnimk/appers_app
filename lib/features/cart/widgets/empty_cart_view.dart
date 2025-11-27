// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/config/app_text_styles.dart';
// import '../../../core/config/app_theme.dart';

// class EmptyCartView extends StatelessWidget {
//   const EmptyCartView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.shopping_cart_outlined,
//             size: 100,
//             color: Colors.grey[300],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Your cart is empty',
//             style: AppTextStyles.poppins(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Add some products to get started',
//             style: AppTextStyles.poppins(fontSize: 14, color: Colors.grey[600]),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: () {
//               // Navigate back to explore tab (index 0)
//               Get.back();
//             },
//             icon: const Icon(Icons.explore, color: Colors.white),
//             label: Text(
//               'Explore Products',
//               style: AppTextStyles.poppins(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppTheme.getPrimaryColor(context),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:appers_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: AppTextStyles.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some products to get started',
            style: AppTextStyles.poppins(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          /// -------------------------------
          ///  REPLACED WITH CustomButton
          /// -------------------------------
          CustomButton(
            text: 'Explore Products',
            prefixIcon: Icon(
              Icons.explore,
              size: 20,
              color: AppTheme.getTextPrimaryColor(context),
            ),

            onPressed: () {
              Get.back(); // Go back to previous screen (Explore tab)
            },
            fontSize: 14,
            fontWeight: FontWeight.bold,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            borderRadius: 12,
            backgroundColor: AppTheme.getPrimaryColor(context),
          ),
        ],
      ),
    );
  }
}
