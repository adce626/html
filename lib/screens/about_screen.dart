import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../config/constants.dart';
import 'legal_screen.dart';
import 'faq_screen.dart';
import 'photo_view_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
            title: Text(
              AppStrings.aboutTitle,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ─── HERO ──────────────────────────
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 30, offset: Offset(0, 10)),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Image.asset('assets/logo/logo.jpg', fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(AppStrings.companyName, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                      SizedBox(height: 4),
                      Text(AppStrings.companyDesc, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                      SizedBox(height: 12),
                      Text(
                        AppStrings.aboutCompanyDesc,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ctaBtn(AppStrings.callNow, Icons.phone_rounded, () => launchUrl(Uri.parse('tel:${AppConstants.phone}')), false),
                          SizedBox(width: 10),
                          _ctaBtn(AppStrings.whatsapp, Icons.chat_rounded, () => launchUrl(Uri.parse(AppConstants.whatsapp)), true),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),

                // ─── ABOUT ──────────────────────────
                _buildSectionTitle(AppStrings.aboutHistory, isDark),
                SizedBox(height: 12),
                _contentCard(
                  isDark,
                  AppStrings.aboutHistoryText,
                ),
                SizedBox(height: 10),
                _contentCard(
                  isDark,
                  AppStrings.aboutActivities,
                ),
                SizedBox(height: 10),
                _contentCard(
                  isDark,
                  AppStrings.aboutTransport,
                ),
                SizedBox(height: 24),

                // ─── MILESTONES ──────────────────────
                _buildSectionTitle(AppStrings.achievements, isDark),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _milestoneCard(isDark, Icons.calendar_today_rounded, AppStrings.foundingDate, AppStrings.foundingLabel)),
                    SizedBox(width: 10),
                    Expanded(child: _milestoneCard(isDark, Icons.gavel_rounded, AppStrings.companyLaw, AppStrings.companyLawYear)),
                  ],
                ),
                SizedBox(height: 24),

                // ─── PRINCIPLES ──────────────────────
                _buildSectionTitle(AppStrings.principles, isDark),
                SizedBox(height: 12),
                _principleCard(isDark, Icons.verified_rounded, AppStrings.reliability, AppStrings.reliabilityDesc),
                SizedBox(height: 10),
                _principleCard(isDark, Icons.visibility_rounded, AppStrings.transparency, AppStrings.transparencyDesc),
                SizedBox(height: 10),
                _principleCard(isDark, Icons.auto_awesome_rounded, AppStrings.quality, AppStrings.qualityDesc),
                SizedBox(height: 24),

                // ─── LOCATION ────────────────────────
                _buildSectionTitle(AppStrings.ourLocation, isDark),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.location_on_rounded, color: AppColors.primary, size: 20),
                          ),
                          SizedBox(width: 12),
                          Text(AppStrings.inHeartOfKarbala, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppStrings.locationDesc,
                        style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkSurfaceAlt : AppColors.background,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.borderLight),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.map_rounded, size: 16, color: AppColors.primary),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text('Iraq - Karbala - Al-Amel District - 7th Area', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => PhotoViewScreen(imagePath: 'assets/license.webp', title: AppStrings.officialLicense)));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/license.webp',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // ─── LICENSE ─────────────────────────
                _buildSectionTitle(AppStrings.licenseTitle, isDark),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFC21E2C), AppColors.primaryDeep],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 20, offset: Offset(0, 8))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                            child: Icon(Icons.shield_rounded, color: Colors.white, size: 24),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(AppStrings.licenseDesc, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Text(
                        AppStrings.licenseText1,
                        style: TextStyle(fontSize: 13, height: 1.8, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.9)),
                      ),
                      SizedBox(height: 14),
                      Text(
                        AppStrings.licenseText2,
                        style: TextStyle(fontSize: 13, height: 1.8, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.85)),
                      ),
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _licenseTag(AppStrings.ministryOfLabor),
                          _licenseTag(AppStrings.laborLaw),
                          _licenseTag(AppStrings.laborDirective),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),

                // ─── CONTACT ─────────────────────────
                _buildSectionTitle(AppStrings.contactWithUs, isDark),
                SizedBox(height: 12),
                _contactTile(Icons.phone_outlined, AppStrings.phone, AppConstants.phoneDisplay, () => launchUrl(Uri.parse('tel:${AppConstants.phone}')), isDark),
                SizedBox(height: 10),
                _contactTile(Icons.email_outlined, AppStrings.email, AppConstants.email, () => launchUrl(Uri.parse('mailto:${AppConstants.email}')), isDark),
                SizedBox(height: 10),
                _contactTile(Icons.chat_outlined, AppStrings.whatsapp, '0771 855 9456', () => launchUrl(Uri.parse(AppConstants.whatsapp)), isDark),
                SizedBox(height: 24),

                // ─── SOCIAL ──────────────────────────
                _buildSectionTitle(AppStrings.followUs, isDark),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _socialIcon(Icons.facebook, AppConstants.social['facebook'] ?? '', isDark),
                    _socialIcon(Icons.camera_alt_outlined, AppConstants.social['instagram'] ?? '', isDark),
                    _socialIcon(Icons.close, AppConstants.social['twitter'] ?? '', isDark, isX: true),
                    _socialIcon(Icons.play_circle_outline, AppConstants.social['youtube'] ?? '', isDark),
                  ],
                ),
                SizedBox(height: 20),

                // ─── QUICK LINKS ─────────────────────
                _buildSectionTitle(AppStrings.usefulLinks, isDark),
                SizedBox(height: 12),
                _linkTile(Icons.help_outline_rounded, AppStrings.faq, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => FaqScreen()));
                }, isDark),
                SizedBox(height: 8),
                _linkTile(Icons.description_outlined, AppStrings.termsOfService, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LegalScreen(title: AppStrings.termsOfService, content: LegalScreen.termsOfService)));
                }, isDark),
                SizedBox(height: 8),
                _linkTile(Icons.privacy_tip_outlined, AppStrings.privacyPolicy, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LegalScreen(title: AppStrings.privacyPolicy, content: LegalScreen.privacyPolicy)));
                }, isDark),
                SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ─── WIDGETS ────────────────────────────────────────────

  Widget _buildSectionTitle(String text, bool isDark) {
    return Text(text, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary));
  }

  Widget _contentCard(bool isDark, String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: Text(text, style: TextStyle(fontSize: 13, height: 1.9, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
    );
  }

  Widget _milestoneCard(bool isDark, IconData icon, String value, String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary), textAlign: TextAlign.center),
          SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _principleCard(bool isDark, IconData icon, String title, String desc) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                Text(desc, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _licenseTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
    );
  }

  Widget _ctaBtn(String label, IconData icon, VoidCallback onTap, bool isWhatsApp) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isWhatsApp ? AppColors.whatsapp : AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: (isWhatsApp ? AppColors.whatsapp : AppColors.primary).withValues(alpha: 0.3), blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            SizedBox(width: 6),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _contactTile(IconData icon, String label, String value, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceAlt : AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.borderLight),
        ),
        child: Row(
          children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: AppColors.primary, size: 18)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                  Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url, bool isDark, {bool isX = false}) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        launchUrl(Uri.parse(url));
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceAlt : AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
        ),
        child: isX ? Center(child: Text('X', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary))) : Icon(icon, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary, size: 22),
      ),
    );
  }

  Widget _linkTile(IconData icon, String title, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: () { HapticFeedback.lightImpact(); onTap(); },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(color: isDark ? AppColors.darkSurface : AppColors.background, borderRadius: BorderRadius.circular(12), border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border)),
        child: Row(children: [
          Icon(icon, color: AppColors.primary, size: 20),
          SizedBox(width: 12),
          Expanded(child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary))),
          Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
        ]),
      ),
    );
  }
}
