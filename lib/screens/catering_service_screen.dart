import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../widgets/service_common.dart';

class CateringServiceScreen extends StatelessWidget {
  const CateringServiceScreen({super.key});

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
            title: Text(AppStrings.catering, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ServiceHero(tag: AppStrings.cateringHeroTag, icon: Icons.restaurant_rounded, title: AppStrings.catering, desc: AppStrings.cateringHeroDesc),
                SizedBox(height: 24),
                ServiceStats(stats: ServiceStats.defaultStats),
                SizedBox(height: 32),
                ServiceImage(asset: 'assets/images/catering1.png'),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.cateringOverview, isDark: isDark),
                SizedBox(height: 4),
                Text(AppStrings.cateringDesc1, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 12),
                Text(AppStrings.cateringDesc2, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 12),
                Text(AppStrings.cateringDesc3, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.cateringWhy, isDark: isDark),
                SizedBox(height: 16),
                ServiceFeatureCard(text: AppStrings.cateringP1, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.cateringP2, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.cateringP3, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.cateringP4, isDark: isDark),
                SizedBox(height: 24),
                ServiceImage(asset: 'assets/images/catering2.png'),
                SizedBox(height: 32),
                ServiceCTA(title: AppStrings.readyForCleanEnv, desc: AppStrings.readyForCleanEnvDesc),
                SizedBox(height: 32),
                OtherServicesSection(excludeKey: 'catering'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
