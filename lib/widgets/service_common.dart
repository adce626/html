import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../config/app_strings.dart';

// ─── SERVICE HERO ──────────────────────────────────────
class ServiceHero extends StatelessWidget {
  final String tag;
  final IconData icon;
  final String title;
  final String desc;

  const ServiceHero({
    super.key,
    required this.tag,
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFC21E2C), AppColors.primaryDeep, AppColors.primaryDarkest],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.5), blurRadius: 24, offset: Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
            child: Text(tag, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white)),
          ),
          SizedBox(height: 20),
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(18)),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, height: 1.3)),
          SizedBox(height: 6),
          Text(AppStrings.companyName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.85))),
          SizedBox(height: 12),
          Text(desc, style: TextStyle(fontSize: 13, height: 1.7, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.8))),
        ],
      ),
    );
  }
}

// ─── SERVICE STATS ─────────────────────────────────────
class ServiceStats extends StatelessWidget {
  final List<Map<String, String>> stats;

  const ServiceStats({super.key, required this.stats});

  static const defaultStats = [
    {'num': '+500', 'label': 'عميلة مخدومة'},
    {'num': '+50', 'label': 'كوادر متخصصة'},
    {'num': '24/7', 'label': 'خدمة على مدار الساعة'},
    {'num': '100%', 'label': 'رضا العملاء'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: stats.map((s) => Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
          ),
          child: Column(children: [
            Text(s['num']!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary)),
            SizedBox(height: 4),
            Text(s['label']!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textSecondary), textAlign: TextAlign.center),
          ]),
        ),
      )).toList(),
    );
  }
}

// ─── SECTION HEADER ────────────────────────────────────
class ServiceSectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;

  const ServiceSectionHeader({super.key, required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 4, height: 24, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
        SizedBox(width: 10),
        Expanded(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary))),
      ],
    );
  }
}

// ─── FEATURE CARD (checkmark) ──────────────────────────
class ServiceFeatureCard extends StatelessWidget {
  final String text;
  final bool isDark;

  const ServiceFeatureCard({super.key, required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
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
            width: 22, height: 22,
            margin: EdgeInsets.only(top: 1, right: 10),
            decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
            child: Icon(Icons.check_rounded, size: 14, color: AppColors.success),
          ),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 13, height: 1.6, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
          ),
        ],
      ),
    );
  }
}

// ─── FEATURE CARD (icon) ───────────────────────────────
class ServiceIconCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;

  const ServiceIconCard({super.key, required this.icon, required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
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
            child: Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
          ),
        ],
      ),
    );
  }
}

// ─── SERVICE IMAGE (with errorBuilder) ─────────────────
class ServiceImage extends StatelessWidget {
  final String asset;
  final double height;

  const ServiceImage({super.key, required this.asset, this.height = 200});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        asset,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
          ),
          child: Icon(Icons.image_outlined, size: 48, color: AppColors.textTertiary),
        ),
      ),
    );
  }
}

// ─── SERVICE CTA ───────────────────────────────────────
class ServiceCTA extends StatelessWidget {
  final String title;
  final String desc;

  const ServiceCTA({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF141414), Color(0xFF1A1A1F)], begin: Alignment.topRight, end: Alignment.bottomLeft),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white, height: 1.4)),
          SizedBox(height: 8),
          Text(desc, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.7), height: 1.6)),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _ctaBtn(AppStrings.callNow, Icons.phone_rounded, () => launchUrl(Uri.parse('tel:${AppConstants.phone}')), false)),
              SizedBox(width: 12),
              Expanded(child: _ctaBtn(AppStrings.whatsapp, Icons.chat_rounded, () => launchUrl(Uri.parse(AppConstants.whatsapp)), true)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ctaBtn(String label, IconData icon, VoidCallback onTap, bool isWhatsApp) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isWhatsApp ? AppColors.whatsapp : AppColors.primary,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: (isWhatsApp ? AppColors.whatsapp : AppColors.primary).withValues(alpha: 0.3), blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            SizedBox(width: 8),
            Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

// ─── OTHER SERVICES SECTION ────────────────────────────
class OtherServicesSection extends StatelessWidget {
  final String excludeKey;

  const OtherServicesSection({super.key, required this.excludeKey});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final allServices = [
      {'key': 'catering', 'num': '01', 'title': AppStrings.catering, 'desc': AppStrings.cateringDesc, 'icon': Icons.restaurant_rounded},
      {'key': 'cleaning', 'num': '02', 'title': AppStrings.cleaning, 'desc': AppStrings.cleaningDesc, 'icon': Icons.cleaning_services_rounded},
      {'key': 'transport', 'num': '03', 'title': AppStrings.transport, 'desc': AppStrings.transportDesc, 'icon': Icons.local_shipping_rounded},
      {'key': 'delivery', 'num': '04', 'title': AppStrings.delivery, 'desc': AppStrings.deliveryDesc, 'icon': Icons.bolt_rounded},
      {'key': 'workforce', 'num': '05', 'title': AppStrings.labor, 'desc': AppStrings.laborDesc, 'icon': Icons.groups_rounded},
      {'key': 'advertising', 'num': '06', 'title': AppStrings.advertising, 'desc': AppStrings.advertisingDesc, 'icon': Icons.campaign_rounded},
    ];

    final services = allServices.where((s) => s['key'] != excludeKey).toList();
    for (var i = 0; i < services.length; i++) {
      services[i] = Map.from(services[i])..['num'] = (i + 1).toString().padLeft(2, '0');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServiceSectionHeader(title: AppStrings.companySections, isDark: isDark),
        SizedBox(height: 4),
        Text(AppStrings.discoverServices, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
        SizedBox(height: 4),
        Text(AppStrings.oneSectionNote, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
        SizedBox(height: 16),
        ...services.map((s) => _otherServiceCard(isDark, s)),
      ],
    );
  }

  Widget _otherServiceCard(bool isDark, Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(14)),
            child: Center(child: Text(service['num'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.primary))),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service['title'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                SizedBox(height: 4),
                Text(service['desc'], style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
              ],
            ),
          ),
          Icon(service['icon'] as IconData, color: AppColors.primary, size: 22),
        ],
      ),
    );
  }
}
