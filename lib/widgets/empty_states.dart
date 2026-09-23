import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';

class EmptyStates {
  static Widget noJobs(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return _buildState(isDark: isDark, icon: Icons.work_off_outlined, title: AppStrings.emptyNoJobs, subtitle: AppStrings.emptyFollowUs);
  }

  static Widget noSearchResults(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return _buildState(isDark: isDark, icon: Icons.search_off_rounded, title: AppStrings.emptyNoResults, subtitle: AppStrings.emptyTryDifferent);
  }

  static Widget noServices(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return _buildState(isDark: isDark, icon: Icons.room_service_outlined, title: AppStrings.emptyNoServices, subtitle: AppStrings.emptyComingSoon);
  }

  static Widget error(BuildContext context, {VoidCallback? onRetry}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return _buildState(isDark: isDark, icon: Icons.wifi_off_rounded, title: AppStrings.emptyCheckConnection, subtitle: AppStrings.emptyRetry, onRetry: onRetry);
  }

  static Widget _buildState({required bool isDark, required IconData icon, required String title, required String subtitle, VoidCallback? onRetry}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 88, height: 88, decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(28)), child: Icon(icon, size: 44, color: AppColors.primary)),
            SizedBox(height: 24),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary), textAlign: TextAlign.center),
            SizedBox(height: 8),
            Text(subtitle, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary), textAlign: TextAlign.center),
            if (onRetry != null) ...[
              SizedBox(height: 24),
              ElevatedButton.icon(onPressed: onRetry, icon: Icon(Icons.refresh_rounded, size: 18), label: Text(AppStrings.retry)),
            ],
          ],
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatefulWidget {
  final Widget child;
  const ShimmerLoading({super.key, required this.child});

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Opacity(opacity: 0.4 + (_animation.value * 0.6), child: child),
      child: widget.child,
    );
  }
}

Widget shimmerCard(bool isDark) {
  return ShimmerLoading(
    child: Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: isDark ? AppColors.darkSurface : AppColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: isDark ? AppColors.darkBorder : AppColors.border, borderRadius: BorderRadius.circular(12))),
            SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(height: 14, width: 120, decoration: BoxDecoration(color: isDark ? AppColors.darkBorder : AppColors.border, borderRadius: BorderRadius.circular(4))),
              SizedBox(height: 6),
              Container(height: 10, width: 80, decoration: BoxDecoration(color: isDark ? AppColors.darkBorder : AppColors.border, borderRadius: BorderRadius.circular(4))),
            ])),
          ]),
        ],
      ),
    ),
  );
}
