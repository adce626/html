import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../widgets/service_common.dart';

class DeliveryServiceScreen extends StatelessWidget {
  const DeliveryServiceScreen({super.key});

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
            title: Text(AppStrings.delivery, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ServiceHero(tag: AppStrings.deliveryHeroTag, icon: Icons.bolt_rounded, title: AppStrings.delivery, desc: AppStrings.deliveryHeroDesc),
                SizedBox(height: 24),
                ServiceStats(stats: ServiceStats.defaultStats),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.overview, isDark: isDark),
                SizedBox(height: 12),
                Text(AppStrings.deliveryDesc1, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 12),
                Text(AppStrings.deliveryDesc2, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 12),
                Text(AppStrings.deliveryDesc3, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.whatWeOffer, isDark: isDark),
                SizedBox(height: 16),
                ServiceFeatureCard(text: AppStrings.deliveryP1, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.deliveryP2, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.deliveryP3, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.deliveryP4, isDark: isDark),
                SizedBox(height: 32),
                ServiceCTA(title: AppStrings.deliveryReady, desc: AppStrings.deliveryReadyDesc),
                SizedBox(height: 32),
                OtherServicesSection(excludeKey: 'delivery'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
