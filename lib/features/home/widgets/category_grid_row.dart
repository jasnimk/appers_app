import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';
import '../../../core/models/category_model.dart';

class CategoryGridRow extends StatelessWidget {
  final List<Category> categories;
  final Map<String, String> categoryImages; // category slug -> image URL
  final Function(String categorySlug) onCategoryTap;
  final bool isLoading;

  const CategoryGridRow({
    super.key,
    required this.categories,
    required this.categoryImages,
    required this.onCategoryTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildShimmerLoading(context);
    }

    return SizedBox(
      height: 120, // Square cards: 100x100 + padding
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final imageUrl = categoryImages[category.slug];

          return Padding(
            padding: EdgeInsets.only(
              right: index < categories.length - 1 ? 12 : 0,
            ),
            child: _buildCategoryCard(context, category, imageUrl),
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    Category category,
    String? imageUrl,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onCategoryTap(category.slug),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppTheme.getCardImageBackground(context),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Image section (70% of card)
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
                child: imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                          child: Center(
                            child: Image.asset(
                              isDark
                                  ? 'assets/logo/darklogo.png'
                                  : 'assets/logo/light_logo.png',
                              width: 30,
                              height: 30,
                              opacity: const AlwaysStoppedAnimation(0.3),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                          child: Center(
                            child: Image.asset(
                              isDark
                                  ? 'assets/logo/darklogo.png'
                                  : 'assets/logo/light_logo.png',
                              width: 30,
                              height: 30,
                              opacity: const AlwaysStoppedAnimation(0.2),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        child: Center(
                          child: Image.asset(
                            isDark
                                ? 'assets/logo/darklogo.png'
                                : 'assets/logo/light_logo.png',
                            width: 30,
                            height: 30,
                            opacity: const AlwaysStoppedAnimation(0.2),
                          ),
                        ),
                      ),
              ),
            ),

            // Category name section (30% of card)
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.getCardInfoBackground(context),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(6),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Center(
                  child: Text(
                    _formatCategoryName(category.name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index < 7 ? 12 : 0),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatCategoryName(String name) {
    // Capitalize first letter
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1);
  }
}
