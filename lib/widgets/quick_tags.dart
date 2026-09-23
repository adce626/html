import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../config/theme.dart';

class QuickSearchTags extends StatelessWidget {
  final Function(String) onTagSelected;
  final String? activeKeyword;

  const QuickSearchTags({
    super.key,
    required this.onTagSelected,
    this.activeKeyword,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: AppConstants.quickSearchTags.length,
        separatorBuilder: (_, __) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tag = AppConstants.quickSearchTags[index];
          final isActive = activeKeyword == tag['keyword'];

          return GestureDetector(
            onTap: () => onTagSelected(tag['keyword']!),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary
                    : (isDark ? AppColors.darkSurface : AppColors.background),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isActive
                      ? AppColors.primary
                      : (isDark ? AppColors.darkBorder : AppColors.border),
                  width: 1.2,
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getIcon(tag['icon']!),
                    size: 16,
                    color: isActive
                        ? Colors.white
                        : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                  ),
                  SizedBox(width: 6),
                  Text(
                    tag['label']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isActive
                          ? Colors.white
                          : (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getIcon(String name) {
    const icons = <String, IconData>{
      'restaurant': Icons.restaurant_rounded,
      'hotel': Icons.hotel_rounded,
      'store': Icons.store_rounded,
      'business': Icons.business_rounded,
      'local_hospital': Icons.local_hospital_rounded,
      'school': Icons.school_rounded,
      'local_pharmacy': Icons.local_pharmacy_rounded,
      'warehouse': Icons.warehouse_rounded,
      'cleaning_services': Icons.cleaning_services_rounded,
      'delivery_dining': Icons.delivery_dining_rounded,
      'local_shipping': Icons.local_shipping_rounded,
      'groups': Icons.groups_rounded,
    };
    return icons[name] ?? Icons.search;
  }
}
