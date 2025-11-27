import 'package:flutter/material.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

class CategoryFilterWidget extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final Function(String?) onCategorySelected;
  final bool isLoading;

  const CategoryFilterWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: index == 0 ? 16 : 0, right: 8),
              child: Container(
                width: 80,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ),
      );
    }

    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1, // +1 for "All" chip
        itemBuilder: (context, index) {
          if (index == 0) {
            // "All" chip
            final isSelected = selectedCategory == null;
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: _buildChip(
                context: context,
                label: 'All',
                isSelected: isSelected,
                onTap: () => onCategorySelected(null),
              ),
            );
          }

          final category = categories[index - 1];
          final isSelected = selectedCategory == category;

          return Padding(
            padding: EdgeInsets.only(
              right: index == categories.length ? 16 : 8,
            ),
            child: _buildChip(
              context: context,
              label: _formatCategoryName(category),
              isSelected: isSelected,
              onTap: () => onCategorySelected(category),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.getPrimaryColor(context)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppTheme.getPrimaryColor(context)
                : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.poppins(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? AppTheme.getTextPrimaryColor(context)
                  : Colors.grey[800],
            ),
          ),
        ),
      ),
    );
  }

  String _formatCategoryName(String category) {
    // Convert "beauty" to "Beauty", "smartphones" to "Smartphones"
    return category
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
