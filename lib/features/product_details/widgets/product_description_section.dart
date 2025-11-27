import 'package:flutter/material.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

class ProductDescriptionSection extends StatelessWidget {
  final String description;
  final List<String> tags;

  const ProductDescriptionSection({
    super.key,
    required this.description,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          Text(
            'Description',
            style: AppTextStyles.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTextStyles.poppins(
              fontSize: 13,
              height: 1.5,
              color: isDark ? Colors.grey[400] : Colors.grey[700],
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.justify,
          ),

          // Tags
          if (tags.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              'Tags',
              style: AppTextStyles.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.grey[800]
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? Colors.grey[700]!
                          : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: AppTextStyles.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
