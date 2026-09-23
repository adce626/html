import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBg : AppColors.background,
        border: Border(top: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.border, width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(context, 0, Icons.home_rounded, Icons.home_outlined, AppStrings.navHome),
              _navItem(context, 1, Icons.room_service_rounded, Icons.room_service_outlined, AppStrings.navServices),
              _navItem(context, 2, Icons.work_rounded, Icons.work_outline_rounded, AppStrings.navJobs),
              _navItem(context, 3, Icons.person_add_rounded, Icons.person_add_outlined, AppStrings.navWorker),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final isActive = currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Active indicator line above icon
                if (isActive)
                  Positioned(
                    top: -10,
                    child: Container(
                      width: 24,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: Icon(
                    isActive ? activeIcon : inactiveIcon,
                    key: ValueKey(isActive),
                    size: isActive ? 24 : 22,
                    color: isActive ? AppColors.primary : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isActive ? AppColors.primary : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
