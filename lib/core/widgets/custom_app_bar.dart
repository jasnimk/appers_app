import 'package:flutter/material.dart';
import '../config/app_text_styles.dart';
import 'app_logo.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final bool showLogo;
  final double? logoHeight;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.bottom,
    this.showLogo = false,
    this.logoHeight = 40,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: showLogo
          ? AppLogo(height: logoHeight)
          : Text(
              title,
              style: AppTextStyles.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      bottom: bottom,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
