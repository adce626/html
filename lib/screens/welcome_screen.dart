import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _fadeOutController;

  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _fadeOutOpacity;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Interval(0.0, 0.6)),
    );

    _textController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    _fadeOutController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _fadeOutOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(Duration(milliseconds: 200));
    _logoController.forward();

    await Future.delayed(Duration(milliseconds: 500));
    _textController.forward();

    await Future.delayed(Duration(milliseconds: 1800));
    if (!mounted) return;
    _fadeOutController.forward();
    await Future.delayed(Duration(milliseconds: 300));
    _navigateToHome();
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _fadeOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeOutOpacity,
        child: Stack(
          children: [
            // ─── DECORATIVE CIRCLES ─────────────────────
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryLight,
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFAFAF8),
                  border: Border.all(color: Color(0xFFF0EDE6), width: 1),
                ),
              ),
            ),

            // ─── MAIN CONTENT ───────────────────────────
            SafeArea(
              child: Column(
                children: [
                  Spacer(flex: 3),

                  // ─── LOGO ──────────────────────────────
                  ScaleTransition(
                    scale: _logoScale,
                    child: FadeTransition(
                      opacity: _logoFade,
                      child: Container(
                        width: 128,
                        height: 128,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.textPrimary,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.18),
                              blurRadius: 28,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo/logo.jpg',
                            width: 122,
                            height: 122,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.business_rounded, color: AppColors.primary, size: 40),
                                  SizedBox(height: 4),
                                  Text(
                                    'SAMA',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.textPrimary,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 32),

                  // ─── TEXT SECTION ───────────────────────
                  SlideTransition(
                    position: _textSlide,
                    child: FadeTransition(
                      opacity: _textFade,
                      child: Column(
                        children: [
                          // SAMA
                          Text(
                            'SAMA',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                              letterSpacing: 4,
                            ),
                          ),

                          SizedBox(height: 14),

                          // Divider
                          Container(
                            width: 36,
                            height: 3,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),

                          SizedBox(height: 18),

                          // مرحباً بك في سما
                          Text(
                            'مرحباً بك في سما',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),

                          SizedBox(height: 10),

                          // Company name
                          Text(
                            'شركة سما أنوار الهدى للخدمات العامة',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),

                          SizedBox(height: 4),

                          // Location
                          Text(
                            'كربلاء، العراق',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Spacer(flex: 4),

                  // ─── PROGRESS DOTS ─────────────────────
                  FadeTransition(
                    opacity: _textFade,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Active dot (extended)
                        Container(
                          width: 20,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        SizedBox(width: 8),
                        // Inactive dot 1
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.border,
                          ),
                        ),
                        SizedBox(width: 8),
                        // Inactive dot 2
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.border,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
