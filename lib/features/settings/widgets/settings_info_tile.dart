import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/config/app_text_styles.dart';
import '../../../core/config/app_theme.dart';

class SettingsInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final dynamic subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SettingsInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.getCardInfoBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.getPrimaryColor(context).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: FaIcon(
              icon,
              size: 18,
              color: AppTheme.getPrimaryColor(context),
            ),
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle is Widget
            ? subtitle
            : Text(
                subtitle.toString(),
                style: AppTextStyles.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
        trailing: trailing,
      ),
    );
  }
}
