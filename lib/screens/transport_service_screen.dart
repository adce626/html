import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../widgets/service_common.dart';

class TransportServiceScreen extends StatelessWidget {
  const TransportServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(AppStrings.transport, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ServiceHero(tag: AppStrings.transportHeroTag, icon: Icons.local_shipping_rounded, title: AppStrings.transport, desc: AppStrings.transportHeroDesc),
                SizedBox(height: 24),
                ServiceStats(stats: ServiceStats.defaultStats),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.transportOverview, isDark: isDark),
                SizedBox(height: 12),
                Text(AppStrings.transportDesc1, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 12),
                Text(AppStrings.transportDesc2, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 12),
                Text(AppStrings.transportDesc3, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.transportWhy, isDark: isDark),
                SizedBox(height: 16),
                ServiceIconCard(icon: Icons.check_circle_rounded, text: AppStrings.transportP1, isDark: isDark),
                SizedBox(height: 10),
                ServiceIconCard(icon: Icons.check_circle_rounded, text: AppStrings.transportP2, isDark: isDark),
                SizedBox(height: 10),
                ServiceIconCard(icon: Icons.check_circle_rounded, text: AppStrings.transportP3, isDark: isDark),
                SizedBox(height: 10),
                ServiceIconCard(icon: Icons.check_circle_rounded, text: AppStrings.transportP4, isDark: isDark),
                SizedBox(height: 32),
                ServiceCTA(title: AppStrings.transportReady, desc: AppStrings.transportReadyDesc),
                SizedBox(height: 32),
                OtherServicesSection(excludeKey: 'transport'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
