import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  static const _faqs = [
    {
      'q': 'كيف أطلب خدمة تنظيف؟',
      'a': 'يمكنك الطلب مباشرة من تطبيقنا عن طريق اختيار خدمة التنظيف وملء النموذج المطلوب. سنتواصل معك خلال ساعة لتأكيد الطلب.',
    },
    {
      'q': 'ما هي مناطق الخدمة؟',
      'a': 'نغطي جميع مناطق محافظة كربلاء المقدسة والمناطق المجاورة.',
    },
    {
      'q': 'هل توجد ضمانات على الخدمات؟',
      'a': 'نعم، نقدم ضمان على جودة الخدمات. إذا لم تكن راضياً، سنعيد التنفيذ مجاناً.',
    },
    {
      'q': 'كيف يمكنني الدفع؟',
      'a': 'نقبل الدفع نقداً عند الانتهاء من الخدمة. قريباً سنوفر خيارات الدفع الإلكتروني.',
    },
    {
      'q': 'هل يمكنني حجز خدمة لوقت محدد؟',
      'a': 'نعم، يمكنك تحديد التاريخ والوقت المناسب عند تقديم الطلب.',
    },
    {
      'q': 'ماذا أفعل إذا لم يصل العامل في الموعد؟',
      'a': 'تواصل معنا فوراً عبر الهاتف أو الواتساب وسنتواصل مع مزود الخدمة لحل المشكلة.',
    },
    {
      'q': 'هل تقدمون خدمات طوارئ؟',
      'a': 'نعم، لدينا فرق جاهزة للطوارئ. اتصل بنا مباشرة على الرقم المجاني.',
    },
    {
      'q': 'كيف أتقدم لوظيفة؟',
      'a': 'يمكنك تصفح الوظائف المتاحة في تبويب "الوظائف" وتقديم طلبك مباشرة من التطبيق.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppStrings.faq, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: _faqs.length,
        itemBuilder: (_, i) => _faqItem(isDark, _faqs[i]['q']!, _faqs[i]['a']!),
      ),
    );
  }

  Widget _faqItem(bool isDark, String q, String a) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        iconColor: AppColors.primary,
        collapsedIconColor: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
        title: Text(q, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
        children: [
          Text(a, style: TextStyle(fontSize: 13, height: 1.8, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
        ],
      ),
    );
  }
}
