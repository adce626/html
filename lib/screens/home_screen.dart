import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_colors.dart';
import '../config/app_strings.dart';
import '../models/job.dart';
import '../providers/theme_provider.dart';
import '../screens/main_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/job_detail_screen.dart';
import '../services/notification_service.dart';
import '../screens/cleaning_service_screen.dart';
import '../screens/catering_service_screen.dart';
import '../screens/transport_service_screen.dart';
import '../screens/delivery_service_screen.dart';
import '../screens/workforce_service_screen.dart';
import '../screens/advertising_service_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Job> _featuredJobs = [];
  bool _isLoadingJobs = true;

  @override
  void initState() {
    super.initState();
    _loadFeaturedJobs();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadFeaturedJobs() async {
    try {
      final result = await Supabase.instance.client
          .from('jobs')
          .select()
          .order('created_at', ascending: false)
          .limit(3);
      if (mounted) {
        setState(() {
          _featuredJobs = (result as List).map((j) => Job.fromJson(j)).toList();
          _isLoadingJobs = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingJobs = false);
    }
  }

  void _onSearchSubmit(String query) {
    if (query.trim().isEmpty) return;
    MainScreen.of(context)?.switchTab(2);
  }

  Future<void> _onRefresh() async {
    await _loadFeaturedJobs();
    if (mounted) setState(() {});
  }

  void _navigateToService(String key) {
    final screens = {
      'catering': () => const CateringServiceScreen(),
      'cleaning': () => const CleaningServiceScreen(),
      'transport': () => const TransportServiceScreen(),
      'delivery': () => const DeliveryServiceScreen(),
      'workforce': () => const WorkforceServiceScreen(),
      'advertising': () => const AdvertisingServiceScreen(),
    };
    final builder = screens[key];
    if (builder != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => builder()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.primary,
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(isDark),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 32),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildHeroSection(isDark),
                  SizedBox(height: 28),
                  _buildQuickActionsSection(isDark),
                  SizedBox(height: 32),
                  _buildFeaturedJobsSection(isDark),
                  SizedBox(height: 32),
                  _buildPartnersSection(isDark),
                  SizedBox(height: 32),
                  _buildCTACard(isDark),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── SLIVER APP BAR ──────────────────────────────────
  Widget _buildSliverAppBar(bool isDark) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 60,
      leading: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Image.asset(
          'assets/logo/logo.webp',
          width: 40,
          height: 40,
          errorBuilder: (_, __, ___) => Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.business_rounded, color: AppColors.primary, size: 22),
          ),
        ),
      ),
      title: Text(
        AppStrings.appName,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
        ),
      ),
      actions: [
        // Theme toggle
        Container(
          margin: EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurfaceAlt : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                key: ValueKey(isDark),
                size: 22,
                color: isDark ? AppColors.primaryLight : AppColors.textPrimary,
              ),
            ),
          ),
        ),
        // Notifications bell with badge
        StreamBuilder<int>(
          stream: NotificationService().unreadCountStream,
          initialData: NotificationService().unreadCount,
          builder: (context, snapshot) {
            final count = snapshot.data ?? 0;
            return Container(
              margin: EdgeInsets.only(left: 4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurfaceAlt : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.notifications_outlined,
                      size: 22,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                    ),
                  ),
                  if (count > 0)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        width: count > 9 ? 20 : 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? AppColors.darkBg : AppColors.background,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            count > 9 ? '9+' : '$count',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        // Search
        IconButton(
          onPressed: () => MainScreen.of(context)?.switchTab(2),
          icon: Icon(
            Icons.search_rounded,
            size: 24,
            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  // ─── HERO SECTION ────────────────────────────────────
  Widget _buildHeroSection(bool isDark) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [AppColors.darkSurface, AppColors.darkBg]
              : [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'كل خدماتك وفرصك\nفي مكان واحد',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.4,
            ),
          ),
          SizedBox(height: 8),
          Text(
            AppStrings.homeDesc,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.6,
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceAlt : Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onSubmitted: _onSearchSubmit,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'ابحث عن وظيفة، خدمة...',
                hintStyle: TextStyle(
                  color: isDark ? AppColors.darkTextMuted : AppColors.textTertiary,
                  fontWeight: FontWeight.w600,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        icon: Icon(Icons.close_rounded, size: 20),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── QUICK ACTIONS SECTION ────────────────────────────
  Widget _buildQuickActionsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(AppStrings.ourServices, isDark),
        SizedBox(height: 16),
        _buildActionGrid(isDark),
      ],
    );
  }

  Widget _buildActionGrid(bool isDark) {
    final actions = [
      _GridItem('الوظائف', Icons.work_rounded, AppColors.infoBlue, () => MainScreen.of(context)?.switchTab(2)),
      _GridItem('طلب عامل', Icons.person_add_rounded, AppColors.infoPurple, () => MainScreen.of(context)?.switchTab(3)),
      _GridItem('التنظيف', Icons.cleaning_services_rounded, AppColors.infoGreen, () => _navigateToService('cleaning')),
      _GridItem('التغذية', Icons.restaurant_rounded, AppColors.infoAmber, () => _navigateToService('catering')),
      _GridItem('النقل والتوصيل', Icons.local_shipping_rounded, AppColors.infoBlue, () => _navigateToService('transport')),
      _GridItem('خدمات أخرى', Icons.apps_rounded, AppColors.primary, () => MainScreen.of(context)?.switchTab(1)),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.6,
        children: actions.map((item) => _buildActionCard(item, isDark)).toList(),
      ),
    );
  }

  Widget _buildActionCard(_GridItem item, bool isDark) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          item.onTap();
        },
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.border,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: item.color, size: 22),
                ),
                Spacer(),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── FEATURED JOBS SECTION ──────────────────────────
  Widget _buildFeaturedJobsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(AppStrings.latestJobs, isDark, onSeeAll: () => MainScreen.of(context)?.switchTab(2)),
        SizedBox(height: 16),
        _buildFeaturedJobs(isDark),
      ],
    );
  }

  Widget _buildFeaturedJobs(bool isDark) {
    if (_isLoadingJobs) {
      return SizedBox(
        height: 155,
        child: Center(child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2)),
      );
    }

    return SizedBox(
      height: 155,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: _featuredJobs.length,
        itemBuilder: (context, index) => _buildJobCard(_featuredJobs[index], isDark),
      ),
    );
  }

  Widget _buildJobCard(Job job, bool isDark) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => JobDetailScreen(job: job),
        ));
      },
      child: Container(
        width: 220,
        margin: EdgeInsets.only(left: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary.withValues(alpha: 0.15), AppColors.primaryDeep.withValues(alpha: 0.1)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.work_rounded, color: AppColors.primary, size: 18),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    job.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Spacer(),
            if (job.company != null)
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  job.company!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 14, color: AppColors.textTertiary),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    job.location ?? AppStrings.notSpecified,
                    style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── PARTNERS SECTION ────────────────────────────────
  Widget _buildPartnersSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('شركاؤنا', isDark),
        SizedBox(height: 16),
        _buildPartners(isDark),
      ],
    );
  }

  Widget _buildPartners(bool isDark) {
    final partners = [
      _PartnerData('zain-logo.jpg'),
      _PartnerData('674270140_122100880724732726_7279384173595269326_n.jpg'),
      _PartnerData('images (1).jpg'),
      _PartnerData('images.jpg'),
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: partners.length,
        itemBuilder: (context, index) {
          final p = partners[index];
          return Container(
            width: 150,
            margin: EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.border,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Image.asset(
                'assets/images/${p.image}',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Center(
                  child: Icon(Icons.business_rounded, color: AppColors.textTertiary, size: 32),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── CTA CARD ────────────────────────────────────────
  Widget _buildCTACard(bool isDark) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primaryLight.withValues(alpha: 0.6)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.person_add_rounded, color: Colors.white, size: 22),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.requestWorker,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      AppStrings.requestWorkerDesc,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => MainScreen.of(context)?.switchTab(3),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text(
                AppStrings.requestWorker,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── SECTION HEADER ──────────────────────────────────
  Widget _buildSectionHeader(String title, bool isDark, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            ),
          ),
          Spacer(),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'عرض الكل',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── HELPER MODELS ──────────────────────────────────────
class _GridItem {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  _GridItem(this.label, this.icon, this.color, this.onTap);
}

class _PartnerData {
  final String image;
  _PartnerData(this.image);
}
