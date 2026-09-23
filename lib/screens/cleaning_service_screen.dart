import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../widgets/service_common.dart';

class CleaningServiceScreen extends StatelessWidget {
  const CleaningServiceScreen({super.key});

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
            title: Text(AppStrings.cleaning, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ServiceHero(tag: AppStrings.cleaningHeroTag, icon: Icons.cleaning_services_rounded, title: AppStrings.cleaningHero, desc: AppStrings.cleaningHeroDesc),
                SizedBox(height: 24),
                ServiceStats(stats: ServiceStats.defaultStats),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.cleaningSectors, isDark: isDark),
                SizedBox(height: 4),
                Text(AppStrings.cleaningSectorsDesc, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 16),
                _sectorCard(isDark, Icons.local_hospital_rounded, AppStrings.healthFacilities, AppStrings.healthFacilitiesDesc),
                SizedBox(height: 10),
                _sectorCard(isDark, Icons.account_balance_rounded, AppStrings.govDepartments, AppStrings.govDepartmentsDesc),
                SizedBox(height: 10),
                _sectorCard(isDark, Icons.apartment_rounded, AppStrings.residentialProjects, AppStrings.residentialProjectsDesc),
                SizedBox(height: 10),
                _sectorCard(isDark, Icons.shopping_cart_rounded, AppStrings.commercialFacilities, AppStrings.commercialFacilitiesDesc),
                SizedBox(height: 10),
                _sectorCard(isDark, Icons.home_rounded, AppStrings.homesAndApartments, AppStrings.homesAndApartmentsDesc),
                SizedBox(height: 10),
                _sectorCard(isDark, Icons.business_center_rounded, AppStrings.officesAndCompanies, AppStrings.officesAndCompaniesDesc),
                SizedBox(height: 24),
                ServiceImage(asset: 'assets/images/cleaning1.jpg'),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.cleaningTypes, isDark: isDark),
                SizedBox(height: 4),
                Text(AppStrings.cleaningTypesDesc, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 16),
                _serviceTypeCard(isDark, badge: AppStrings.continuousService, title: AppStrings.dailyCleaning, desc: AppStrings.dailyCleaningDesc, features: [AppStrings.dailyFeature1, AppStrings.dailyFeature2, AppStrings.dailyFeature3, AppStrings.dailyFeature4, AppStrings.dailyFeature5]),
                SizedBox(height: 14),
                _serviceTypeCard(isDark, badge: AppStrings.afterWorks, title: AppStrings.postConstruction, desc: AppStrings.postConstructionDesc, features: [AppStrings.postFeature1, AppStrings.postFeature2, AppStrings.postFeature3, AppStrings.postFeature4, AppStrings.postFeature5]),
                SizedBox(height: 14),
                _serviceTypeCard(isDark, badge: AppStrings.deepCleaning, title: AppStrings.deepCleaningTitle, desc: AppStrings.deepCleaningDesc, features: [AppStrings.deepFeature1, AppStrings.deepFeature2, AppStrings.deepFeature3, AppStrings.deepFeature4, AppStrings.deepFeature5]),
                SizedBox(height: 24),
                ServiceImage(asset: 'assets/images/cleaning2.jpg'),
                SizedBox(height: 32),
                ServiceSectionHeader(title: AppStrings.teamSection, isDark: isDark),
                SizedBox(height: 4),
                Text(AppStrings.teamDesc, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                SizedBox(height: 16),
                _teamCard(isDark, Icons.groups_rounded, AppStrings.specializedTeam, AppStrings.specializedTeamDesc),
                SizedBox(height: 10),
                _teamCard(isDark, Icons.calendar_today_rounded, AppStrings.flexibleContracts, AppStrings.flexibleContractsDesc),
                SizedBox(height: 10),
                _teamCard(isDark, Icons.cleaning_services_rounded, AppStrings.modernEquipment, AppStrings.modernEquipmentDesc),
                SizedBox(height: 10),
                _teamCard(isDark, Icons.support_agent_rounded, AppStrings.continuousSupport, AppStrings.continuousSupportDesc),
                SizedBox(height: 24),
                ServiceImage(asset: 'assets/images/cleaning3.jpg'),
                SizedBox(height: 32),
                ServiceCTA(title: AppStrings.readyForCleanEnv, desc: AppStrings.readyForCleanEnvDesc),
                SizedBox(height: 32),
                OtherServicesSection(excludeKey: 'cleaning'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectorCard(bool isDark, IconData icon, String title, String desc) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                SizedBox(height: 6),
                Text(desc, style: TextStyle(fontSize: 12, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceTypeCard(bool isDark, {required String badge, required String title, required String desc, required List<String> features}) {
    return Container(
      padding: EdgeInsets.all(20),
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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Text(badge, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primary)),
          ),
          SizedBox(height: 14),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
          SizedBox(height: 8),
          Text(desc, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
          SizedBox(height: 16),
          ...features.map((f) => Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 22, height: 22,
                  margin: EdgeInsets.only(top: 1, right: 10),
                  decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                  child: Icon(Icons.check_rounded, size: 14, color: AppColors.success),
                ),
                Expanded(
                  child: Text(f, style: TextStyle(fontSize: 13, height: 1.6, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _teamCard(bool isDark, IconData icon, String title, String desc) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFC21E2C), AppColors.primaryDeep]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                SizedBox(height: 6),
                Text(desc, style: TextStyle(fontSize: 12, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
