import 'package:flutter/material.dart';
import '../config/theme.dart';

class LegalScreen extends StatelessWidget {
  final String title;
  final String content;

  const LegalScreen({super.key, required this.title, required this.content});

  static const String termsOfService = '''
سياسة الاستخدام والشروط

مرحباً بك في تطبيق سما انوار الهدى للخدمات العامة.

١. القبول بالشروط
باستخدامك لتطبيقنا، فإنك توافق على هذه الشروط والأحكام. إذا لا توافق على أي شروط، يرجى عدم استخدام التطبيق.

٢. الخدمات المقدمة
يوفر التطبيق منصة لربط العملاء بمزودي الخدمات في مجالات التنظيف، التغذية، النقل، التوصيل، وتشغيل الأيدي العاملة.

٣. التزامات المستخدم
- تقديم معلومات صحيحة ودقيقة
- عدم استخدام التطبيق لأي أغراض غير قانونية
- احترام المزودين والعمال

٤. الخصوصية
نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية. لا نشارك بياناتك مع أطراف ثالثة إلا بموافقتك.

٥. المسؤولية
لا يتحمل التطبيق المسؤولية عن أي أضرار ناتجة عن استخدام الخدمات المقدمة عبر المنصة.

٦. التعديلات
نحتفظ بالحق في تعديل هذه الشروط في أي وقت. سيتم إعلامك بأي تغييرات جوهرية.

٧. التواصل
لأي استفسارات، يرجى التواصل معنا عبر:
- الهاتف: ${'+9647718559456'}'
- البريد الإلكتروني: info@sama-huda.com
''';

  static const String privacyPolicy = '''
سياسة الخصوصية

في سما انوار الهدى، نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية.

١. المعلومات التي نجمعها
- الاسم الكامل
- رقم الهاتف
- صورة الهوية (لأغراض التحقق)
- موقعك التقريبي

٢. كيف نستخدم معلوماتك
- للتواصل معك بخصوص طلباتك
- لتحسين خدماتنا
- لإرسال إشعارات مهمة

٣. حماية البيانات
- نستخدم تقنيات تشفير متقدمة
- لا نشارك بياناتك مع أطراف ثالثة
- نحتفظ ببياناتك فقط للمدة اللازمة

٤. حقوقك
- حق الوصول إلى بياناتك
- حق تعديل بياناتك
- حق حذف بياناتك

٥. التواصل
لأي استفسارات حول الخصوصية، يرجى التواصل معنا عبر البريد الإلكتروني: info@sama-huda.com
''';

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
        title: Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Text(
          content,
          style: TextStyle(
            fontSize: 14,
            height: 2.0,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
