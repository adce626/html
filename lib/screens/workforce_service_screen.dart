import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../widgets/service_common.dart';

class WorkforceServiceScreen extends StatelessWidget {
  const WorkforceServiceScreen({super.key});

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
            title: Text(AppStrings.labor, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ServiceHero(tag: AppStrings.workforceHeroTag, icon: Icons.groups_rounded, title: AppStrings.labor, desc: AppStrings.workforceHeroDesc),
                SizedBox(height: 24),
                ServiceStats(stats: ServiceStats.defaultStats),
                SizedBox(height: 32),
                ServiceImage(asset: 'assets/images/workforce1.jpg'),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.overview, isDark: isDark),
                SizedBox(height: 4),
                Text(AppStrings.workforceDesc1, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 12),
                Text(AppStrings.workforceDesc2, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 12),
                Text(AppStrings.workforceDesc3, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.whatWeOffer, isDark: isDark),
                SizedBox(height: 16),
                ServiceFeatureCard(text: AppStrings.workforceP1, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.workforceP2, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.workforceP3, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.workforceP4, isDark: isDark),
                SizedBox(height: 32),
                ServiceImage(asset: 'assets/images/workforce2.jpg'),
                SizedBox(height: 32),
                ServiceCTA(title: AppStrings.workforceReady, desc: AppStrings.workforceReadyDesc),
                SizedBox(height: 32),
                OtherServicesSection(excludeKey: 'workforce'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
