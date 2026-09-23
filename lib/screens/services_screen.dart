import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../config/constants.dart';
import '../widgets/page_transitions.dart';
import 'cleaning_service_screen.dart';
import 'catering_service_screen.dart';
import 'transport_service_screen.dart';
import 'delivery_service_screen.dart';
import 'workforce_service_screen.dart';
import 'advertising_service_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredServices = [];
  Timer? _debounce;

  static final _serviceData = [
    {
      'key': 'cleaning',
      'title': 'التنظيف',
      'titleEn': 'Cleaning Services',
      'icon': Icons.cleaning_services_rounded,
      'color': Color(0xFF3b82f6),
      'bgColor': Color(0xFFeff6ff),
      'darkBgColor': Color(0xFF1e293b),
      'desc': 'تنظيف احترافي للمنازل والمكاتب والمرافق العامة بمعايير عالمية وأحدث تقنيات التنظيف ومواد آمنة.',
      'features': ['تنظيف المنازل والشقق', 'تنظيف المكاتب والشركات', 'تنظيف المستشفيات والمرافق الصحية', 'طواقم مدربة ومواد آمنة'],
    },
    {
      'key': 'catering',
      'title': 'التغذية',
      'titleEn': 'Catering & Food Services',
      'icon': Icons.restaurant_rounded,
      'color': Color(0xFFd97706),
      'bgColor': Color(0xFFfffbeb),
      'darkBgColor': Color(0xFF292524),
      'desc': 'إعداد وتقديم الطعام للمناسبات والمؤسسات مع وجبات يومية طازجة وبأسعار منافسة.',
      'features': ['وجبات يومية طازجة للشركات', 'تقديم الطعام للمناسبات والحفلات', 'التزام بمعايير النظافة وسلامة الغذاء', 'مرونة في القوائم وتجهيز حسب الطلب'],
    },
    {
      'key': 'transport',
      'title': 'النقل العام',
      'titleEn': 'General Transport',
      'icon': Icons.local_shipping_rounded,
      'color': Color(0xFF8b5cf6),
      'bgColor': Color(0xFFf5f3ff),
      'darkBgColor': Color(0xFF1e1b2e),
      'desc': 'خدمات نقل موظفين وطلاب ورحلات خاصة بأسطول حديث وسائقين محترفين.',
      'features': ['نقل موظفين الشركات', 'نقل الطلاب والمدارس', 'رحلات خاصة وسياحية', 'أسطول حديث ومكيف'],
    },
    {
      'key': 'delivery',
      'title': 'التوصيل السريع',
      'titleEn': 'Express Delivery',
      'icon': Icons.bolt_rounded,
      'color': Color(0xFF14b8a6),
      'bgColor': Color(0xFFf0fdfa),
      'darkBgColor': Color(0xFF0f2a2a),
      'desc': 'خدمة توصيل سريعة وموثوقة للطرود والطلبات في كربلاء والمناطق المجاورة.',
      'features': ['توصيل الطرود والطلبات', 'تغطية كربلاء والمناطق المجاورة', 'أسعار منافسة', 'تتبع الطلب لحظياً'],
    },
    {
      'key': 'workforce',
      'title': 'تشغيل الأيدي العاملة',
      'titleEn': 'Workforce Staffing',
      'icon': Icons.engineering_rounded,
      'color': Color(0xFF16a34a),
      'bgColor': Color(0xFFf0fdf4),
      'darkBgColor': Color(0xFF0f2918),
      'desc': 'توفير وإدارة الأيدي العاملة المتخصصة للمؤسسات والشركات بمختلف التخصصات.',
      'features': ['توفير عمالة متخصصة', 'إدارة وتدريب العمال', 'حلول مرنة حسب الحاجة', 'عقود مرنة قصيرة وطويلة الأمد'],
    },
    {
      'key': 'advertising',
      'title': 'الإعلان والترويج',
      'titleEn': 'Advertising & Promotion',
      'icon': Icons.campaign_rounded,
      'color': Color(0xFFC21E2C),
      'bgColor': Color(0xFFfef2f2),
      'darkBgColor': Color(0xFF2a0f12),
      'desc': 'خدمات إعلانية وترويجية متكاملة لتعزيز حضور علامتك التجارية ووصولك لعملائك.',
      'features': ['إدارة حملات إعلانية', 'تصميم مواد إعلانية', 'الترويج عبر وسائل التواصل', 'حلول تسويقية متكاملة'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredServices = _serviceData;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _filterServices(String query) {
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 400), () {
      setState(() {
        if (query.isEmpty) {
          _filteredServices = _serviceData;
        } else {
          final q = query.toLowerCase();
          _filteredServices = _serviceData.where((s) {
            return s['title'].toString().contains(q) || s['titleEn'].toString().toLowerCase().contains(q) || s['desc'].toString().contains(q);
          }).toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHero(isDark)),
          SliverToBoxAdapter(child: _buildSearchBar(isDark)),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _serviceCard(_filteredServices[index], isDark),
                childCount: _filteredServices.length,
              ),
            ),
          ),
          SliverToBoxAdapter(child: _buildWorkerCTA(isDark)),
          SliverToBoxAdapter(child: _buildCTA(isDark)),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }

  Widget _buildHero(bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 24, 16, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.darkBg, AppColors.darkSurface, AppColors.darkBg],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(AppStrings.servicesHeroLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.5), letterSpacing: 1.2)),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, height: 1.3),
              children: [
                TextSpan(text: AppStrings.servicesHeroTitle1),
                TextSpan(text: AppStrings.servicesHeroTitle2, style: TextStyle(color: AppColors.primary)),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            AppStrings.servicesHeroDesc,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.6), height: 1.6),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border, width: 1.5),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _filterServices,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: 'ابحث عن خدمة...',
            hintStyle: TextStyle(color: AppColors.textTertiary, fontWeight: FontWeight.w500, fontSize: 14),
            prefixIcon: Icon(Icons.search_rounded, color: AppColors.textTertiary, size: 18),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(icon: Icon(Icons.close_rounded, size: 18, color: AppColors.textTertiary), onPressed: () { _searchController.clear(); _filterServices(''); })
                : null,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          ),
        ),
      ),
    );
  }

  Widget _serviceCard(Map<String, dynamic> service, bool isDark) {
    final color = service['color'] as Color;
    final bgColor = isDark ? (service['darkBgColor'] as Color) : (service['bgColor'] as Color);
    final features = service['features'] as List<String>;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _navigateToService(service['key']);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.background,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06), blurRadius: 16, offset: Offset(0, 4))],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                border: Border(bottom: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.border)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(color: color.withValues(alpha: isDark ? 0.2 : 0.1), borderRadius: BorderRadius.circular(14)),
                    child: Icon(service['icon'] as IconData, color: color, size: 24),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(service['title'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                        SizedBox(height: 2),
                        Text(service['titleEn'], style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textTertiary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service['desc'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary, height: 1.7)),
                  SizedBox(height: 14),
                  ...features.map((f) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_rounded, size: 16, color: AppColors.success),
                        SizedBox(width: 10),
                        Expanded(child: Text(f, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary))),
                      ],
                    ),
                  )),
                  SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _navigateToService(service['key']);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('التفاصيل', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_left_rounded, size: 16, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerCTA(bool isDark) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 4, 16, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary, Color(0xFFa11622)]),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
              ),
              child: Icon(Icons.person_add_rounded, color: Colors.white, size: 24),
            ),
            SizedBox(height: 14),
            Text('تحتاج عامل؟', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
            SizedBox(height: 6),
            Text('أرسل طلبك الآن ونوفر لك العامل المناسب في أسرع وقت', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.75), height: 1.6), textAlign: TextAlign.center),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () { HapticFeedback.lightImpact(); Navigator.push(context, PageTransitions.slideRight(WorkforceServiceScreen())); },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
                      child: Center(child: Text('أرسل الطلب', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary))),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => launchUrl(Uri.parse('tel:${AppConstants.phone}')),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(100), border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5)),
                      child: Center(child: Text('اتصل بنا', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTA(bool isDark) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Text('هل تحتاج خدمة معينة؟', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
          SizedBox(height: 6),
          Text('تواصل معنا وسنوفر لك الحل المناسب', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.75))),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => launchUrl(Uri.parse('tel:${AppConstants.phone}')),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.phone_rounded, size: 16, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text('اتصل الآن', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary)),
                    ]),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => launchUrl(Uri.parse(AppConstants.whatsapp)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(100), border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.chat_rounded, size: 16, color: Colors.white),
                      SizedBox(width: 8),
                      Text('واتساب', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToService(String key) {
    switch (key) {
      case 'cleaning':
        Navigator.push(context, PageTransitions.slideRight(CleaningServiceScreen()));
        break;
      case 'catering':
        Navigator.push(context, PageTransitions.slideRight(CateringServiceScreen()));
        break;
      case 'transport':
        Navigator.push(context, PageTransitions.slideRight(TransportServiceScreen()));
        break;
      case 'delivery':
        Navigator.push(context, PageTransitions.slideRight(DeliveryServiceScreen()));
        break;
      case 'workforce':
        Navigator.push(context, PageTransitions.slideRight(WorkforceServiceScreen()));
        break;
      case 'advertising':
        Navigator.push(context, PageTransitions.slideRight(AdvertisingServiceScreen()));
        break;
    }
  }
}
