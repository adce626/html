import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../widgets/service_common.dart';

class AdvertisingServiceScreen extends StatelessWidget {
  const AdvertisingServiceScreen({super.key});

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
            title: Text(AppStrings.advertising, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ServiceHero(tag: AppStrings.advertisingHeroTag, icon: Icons.campaign_rounded, title: AppStrings.advertising, desc: AppStrings.advertisingHeroDesc),
                SizedBox(height: 24),
                ServiceStats(stats: [
                  {'num': '100+', 'label': AppStrings.adStat1},
                  {'num': '50+', 'label': AppStrings.adStat2},
                  {'num': '24/7', 'label': AppStrings.adStat3},
                  {'num': '100%', 'label': AppStrings.adStat4},
                ]),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.advertising, isDark: isDark),
                SizedBox(height: 12),
                Text(AppStrings.advertisingDesc1, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 12),
                Text(AppStrings.advertisingDesc2, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 12),
                Text(AppStrings.advertisingDesc3, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 24),
                ServiceSectionHeader(title: AppStrings.whatWeOffer, isDark: isDark),
                SizedBox(height: 12),
                ServiceFeatureCard(text: AppStrings.advertisingP1, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.advertisingP2, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.advertisingP3, isDark: isDark),
                SizedBox(height: 10),
                ServiceFeatureCard(text: AppStrings.advertisingP4, isDark: isDark),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.advertisingServicesTitle, isDark: isDark),
                SizedBox(height: 4),
                Text(AppStrings.advertisingServicesSub, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 16),
                _buildServicesGrid(isDark),
                SizedBox(height: 32),
                ServiceImage(asset: 'assets/images/advertising1.jpg'),
                SizedBox(height: 32),
                ServiceImage(asset: 'assets/images/advertising2.jpg'),
                SizedBox(height: 32),
                ServiceCTA(title: AppStrings.adCtaTitle, desc: AppStrings.adCtaDesc),
                SizedBox(height: 32),
                OtherServicesSection(excludeKey: 'advertising'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(bool isDark) {
    final services = [
      {'icon': Icons.video_call_rounded, 'title': AppStrings.adSvc1Title, 'desc': AppStrings.adSvc1Desc},
      {'icon': Icons.movie_rounded, 'title': AppStrings.adSvc2Title, 'desc': AppStrings.adSvc2Desc},
      {'icon': Icons.camera_alt_rounded, 'title': AppStrings.adSvc3Title, 'desc': AppStrings.adSvc3Desc},
      {'icon': Icons.celebration_rounded, 'title': AppStrings.adSvc4Title, 'desc': AppStrings.adSvc4Desc},
      {'icon': Icons.share_rounded, 'title': AppStrings.adSvc5Title, 'desc': AppStrings.adSvc5Desc},
      {'icon': Icons.palette_rounded, 'title': AppStrings.adSvc6Title, 'desc': AppStrings.adSvc6Desc},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final svc = services[index];
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: Offset(0, 4))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFFC21E2C), AppColors.primaryDeep]),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(svc['icon'] as IconData, color: Colors.white, size: 24),
              ),
              SizedBox(height: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(svc['title'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                    SizedBox(height: 8),
                    Expanded(
                      child: Text(svc['desc'] as String, style: TextStyle(fontSize: 12, height: 1.6, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary), overflow: TextOverflow.ellipsis, maxLines: 4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
