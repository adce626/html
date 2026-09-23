import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../services/supabase_service.dart';
import '../models/application.dart';
import '../widgets/success_dialog.dart';
import '../widgets/phone_formatter.dart';
import '../config/app_strings.dart';

class WorkerRequestScreen extends StatefulWidget {
  const WorkerRequestScreen({super.key});

  @override
  State<WorkerRequestScreen> createState() => _WorkerRequestScreenState();
}

class _WorkerRequestScreenState extends State<WorkerRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _jobTypeController = TextEditingController();
  final _workersCountController = TextEditingController(text: '1');
  final _salaryController = TextEditingController();
  final _workTimeController = TextEditingController(text: '8 صباحاً - 5 مساءً');
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isSubmitting = false;
  bool _hasUnsavedChanges = false;

  void _markDirty(String _) {
    if (!_hasUnsavedChanges) setState(() => _hasUnsavedChanges = true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _jobTypeController.dispose();
    _workersCountController.dispose();
    _salaryController.dispose();
    _workTimeController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: !_hasUnsavedChanges,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final nav = Navigator.of(context);
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(AppStrings.exitConfirm, style: TextStyle(fontWeight: FontWeight.w800)),
            content: Text(AppStrings.exitConfirmDesc, style: TextStyle(fontWeight: FontWeight.w600)),
            actions: [
              TextButton(onPressed: () => nav.pop(false), child: Text(AppStrings.cancel)),
              TextButton(onPressed: () => nav.pop(true), child: Text(AppStrings.exit, style: TextStyle(color: AppColors.error))),
            ],
          ),
        );
        if (shouldPop == true && mounted) nav.pop();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isDark),
                SizedBox(height: 20),
                _buildHero(isDark),
                SizedBox(height: 28),
                _buildFormSection(isDark),
                SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Row(
      children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.25), blurRadius: 10, offset: Offset(0, 3))]),
          child: ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset('assets/logo/logo.jpg', fit: BoxFit.cover)),
        ),
        SizedBox(width: 12),
        Text(AppStrings.workerRequest, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildHero(bool isDark) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFC21E2C), AppColors.primaryDeep, AppColors.primaryDarkest], begin: Alignment.topRight, end: Alignment.bottomLeft),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.5), blurRadius: 24, offset: Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
            child: Text(AppStrings.workerRequest, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white)),
          ),
          SizedBox(height: 16),
          Text(AppStrings.workerHeroTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, height: 1.4)),
          SizedBox(height: 8),
          Text(AppStrings.workerHeroDesc, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.85), height: 1.6)),
          SizedBox(height: 18),
          Row(children: [
            _heroBtn(AppStrings.callNow, Icons.phone_rounded, () => launchUrl(Uri.parse('tel:${AppConstants.phone}'))),
            SizedBox(width: 10),
            _heroBtn(AppStrings.whatsapp, Icons.chat_rounded, () => launchUrl(Uri.parse(AppConstants.whatsapp))),
          ]),
        ],
      ),
    );
  }

  Widget _heroBtn(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: () { HapticFeedback.lightImpact(); onTap(); },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withValues(alpha: 0.3))),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 16, color: Colors.white), SizedBox(width: 6), Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white))]),
      ),
    );
  }

  Widget _buildFormSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(width: 4, height: 24, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
          SizedBox(width: 10),
          Text(AppStrings.requestForm, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
        ]),
        SizedBox(height: 6),
        Padding(
          padding: EdgeInsets.only(right: 14),
          child: Text(AppStrings.requestFormDesc, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
        ),
        SizedBox(height: 20),

        // ── معلومات شخصية ──
        _sectionLabel('المعلومات الشخصية', isDark),
        SizedBox(height: 12),
        _buildClearField(
          controller: _nameController,
          label: 'الاسم الكامل',
          hint: 'أدخل الاسم الكامل',
          icon: Icons.person_outline_rounded,
          isDark: isDark,
          isRequired: true,
          onChanged: _markDirty,
          validator: (v) => v == null || v.trim().isEmpty ? AppStrings.nameRequired : null,
        ),
        SizedBox(height: 14),
        _buildClearField(
          controller: _phoneController,
          label: 'رقم الهاتف / واتساب',
          hint: '0782 586 5514',
          icon: Icons.phone_outlined,
          isDark: isDark,
          isRequired: true,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          inputFormatters: [PhoneFormatter()],
          onChanged: _markDirty,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return AppStrings.phoneRequired;
            final cleaned = v.replaceAll(RegExp(r'[\s\-]'), '');
            if (!RegExp(r'^07[3-9]\d{8}$').hasMatch(cleaned)) return AppStrings.phoneInvalid;
            return null;
          },
        ),

        SizedBox(height: 24),

        // ── تفاصيل العامل ──
        _sectionLabel('تفاصيل العامل المطلوب', isDark),
        SizedBox(height: 12),
        _buildClearField(
          controller: _jobTypeController,
          label: 'نوع العامل',
          hint: 'مثال: عامل نظافة، طباخ، سائق...',
          icon: Icons.construction_rounded,
          isDark: isDark,
          isRequired: true,
          onChanged: _markDirty,
          validator: (v) => v == null || v.trim().isEmpty ? AppStrings.workerTypeRequired : null,
        ),
        SizedBox(height: 14),
        Row(children: [
          Expanded(child: _buildClearField(
            controller: _workersCountController,
            label: 'عدد العمال',
            hint: '1',
            icon: Icons.groups_rounded,
            isDark: isDark,
            keyboardType: TextInputType.number,
            onChanged: _markDirty,
          )),
          SizedBox(width: 12),
          Expanded(child: _buildClearField(
            controller: _salaryController,
            label: 'الراتب المقترح',
            hint: 'اختياري',
            icon: Icons.monetization_on_outlined,
            isDark: isDark,
            onChanged: _markDirty,
          )),
        ]),

        SizedBox(height: 24),

        // ── تفاصيل العمل ──
        _sectionLabel('تفاصيل العمل', isDark),
        SizedBox(height: 12),
        Row(children: [
          Expanded(child: _buildClearField(
            controller: _workTimeController,
            label: 'وقت العمل',
            hint: '8 صباحاً - 5 مساءً',
            icon: Icons.access_time_rounded,
            isDark: isDark,
            onChanged: _markDirty,
          )),
          SizedBox(width: 12),
          Expanded(child: _buildClearField(
            controller: _locationController,
            label: 'موقع العمل',
            hint: 'الكربلاء',
            icon: Icons.location_on_outlined,
            isDark: isDark,
            onChanged: _markDirty,
          )),
        ]),
        SizedBox(height: 14),
        _buildClearField(
          controller: _dateController,
          label: 'تاريخ بدء العمل',
          hint: 'اختر التاريخ',
          icon: Icons.calendar_today_rounded,
          isDark: isDark,
          readOnly: true,
          onTap: () => _pickDate(isDark),
        ),

        SizedBox(height: 24),

        // ── ملاحظات ──
        _sectionLabel('ملاحظات إضافية', isDark),
        SizedBox(height: 12),
        _buildClearField(
          controller: _notesController,
          label: 'ملاحظات',
          hint: 'أي تفاصيل إضافية تريد إضافتها...',
          icon: Icons.notes_rounded,
          isDark: isDark,
          maxLines: 3,
          onChanged: _markDirty,
        ),

        SizedBox(height: 28),

        // ── زر الإرسال ──
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFC21E2C), AppColors.primaryDeep], begin: Alignment.topRight, end: Alignment.bottomLeft),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 16, offset: Offset(0, 8))],
            ),
            child: ElevatedButton.icon(
              onPressed: _isSubmitting ? null : _submit,
              icon: _isSubmitting ? SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : Icon(Icons.send_rounded, size: 18),
              label: Text(_isSubmitting ? AppStrings.sending : AppStrings.submitRequest, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 18), backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(String text, bool isDark) {
    return Row(children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
      SizedBox(width: 8),
      Text(text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
    ]);
  }

  Widget _buildClearField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    bool isRequired = false,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    TextDirection? textDirection,
    int maxLines = 1,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label row
        Row(children: [
          Icon(icon, size: 16, color: AppColors.primary),
          SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
          if (isRequired) ...[
            SizedBox(width: 4),
            Text('*', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.primary)),
          ],
        ]),
        SizedBox(height: 8),
        // Input box
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textDirection: textDirection,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          inputFormatters: inputFormatters,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary.withValues(alpha: 0.6)),
            filled: true,
            fillColor: isDark ? AppColors.darkSurface : Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: maxLines > 1 ? 16 : 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.border, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.border, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.error, width: 2),
            ),
            suffixIcon: readOnly ? Icon(Icons.arrow_drop_down, color: AppColors.textSecondary) : null,
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate(bool isDark) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: AppColors.primary),
          dialogBackgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      _dateController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      final app = JobApplication(
        jobId: 'worker-request',
        jobTitle: 'طلب عامل - ${_jobTypeController.text.trim()}',
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        source: 'app',
      );
      await SupabaseService().submitApplication(app);
      if (mounted) {
        setState(() => _hasUnsavedChanges = false);
        SuccessDialog.show(
          context,
          message: AppStrings.successWorker,
          onPressed: () {
            Navigator.pop(context);
            _formKey.currentState!.reset();
            _workersCountController.text = '1';
            _workTimeController.text = '8 صباحاً - 5 مساءً';
          },
        );
      }
    } catch (e) {
      if (mounted) {
        String msg = AppStrings.errorTryAgain;
        if (e is PostgrestException) {
          if (e.code == '42P01') {
            msg = 'جدول الطلبات غير موجود — نفّذ 004_job_applications.sql';
          } else if (e.code == '42501') {
            msg = 'لا توجد صلاحية للإرسال — تأكد من سياسة INSERT';
          } else {
            msg = 'خطأ في قاعدة البيانات: ${e.message}';
          }
        } else {
          msg = 'حدث خطأ: $e';
        }
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(children: [
              Icon(Icons.error_outline_rounded, color: AppColors.error, size: 24),
              SizedBox(width: 8),
              Text('خطأ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
            ]),
            content: Text(msg, style: TextStyle(fontSize: 14, height: 1.6, fontWeight: FontWeight.w600)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('حسناً', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primary)),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
