import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../models/job.dart';
import '../services/supabase_service.dart';
import '../models/application.dart';
import '../widgets/success_dialog.dart';
import '../config/app_strings.dart';
import '../widgets/phone_formatter.dart';

class JobDetailScreen extends StatefulWidget {
  final Job job;
  const JobDetailScreen({super.key, required this.job});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final job = widget.job;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 0,
            pinned: true,
            backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.share_rounded, size: 22),
                onPressed: () { HapticFeedback.lightImpact(); _shareJob(job); },
              ),
            ],
            title: Text(AppStrings.jobDetails, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Title + Status ──
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(job.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, height: 1.3, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary))),
                    SizedBox(width: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: job.isOpen ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                      child: Text(job.isOpen ? AppStrings.jobOpen : AppStrings.jobClosed, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: job.isOpen ? AppColors.success : AppColors.error)),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                if (job.createdAt != null)
                  Text('تاريخ النشر: ${job.createdAt!.day}/${job.createdAt!.month}/${job.createdAt!.year}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                SizedBox(height: 24),

                // ── معلومات الوظيفة ──
                _sectionHeader('معلومات الوظيفة', isDark),
                SizedBox(height: 12),

                // بطاقات معلومات مربعة
                Row(children: [
                  Expanded(child: _infoTile(
                    icon: Icons.location_on_outlined,
                    label: 'مكان العمل',
                    value: job.location ?? AppStrings.notSpecified,
                    color: Color(0xFF22C55E),
                    isDark: isDark,
                  )),
                  SizedBox(width: 12),
                  Expanded(child: _infoTile(
                    icon: Icons.access_time_rounded,
                    label: 'وقت العمل',
                    value: job.employmentType ?? AppStrings.notSpecified,
                    color: Color(0xFF3B82F6),
                    isDark: isDark,
                  )),
                ]),
                SizedBox(height: 12),
                _infoTile(
                  icon: Icons.monetization_on_outlined,
                  label: 'الراتب',
                  value: job.salary ?? AppStrings.notSpecified,
                  color: Color(0xFFF59E0B),
                  isDark: isDark,
                  isFullWidth: true,
                ),

                // ── الشروط ──
                if (job.requirements != null && job.requirements!.trim().isNotEmpty) ...[
                  SizedBox(height: 24),
                  _sectionHeader('الشروط', isDark),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(color: Color(0xFF8B5CF6).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                          child: Icon(Icons.rule_outlined, color: Color(0xFF8B5CF6), size: 18),
                        ),
                        SizedBox(width: 12),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: job.requirements!.split('\n').map((line) => Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('• ', style: TextStyle(fontSize: 14, color: Color(0xFF8B5CF6), fontWeight: FontWeight.w900)),
                                Expanded(child: Text(line.trim(), style: TextStyle(fontSize: 14, height: 1.6, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary))),
                              ],
                            ),
                          )).toList(),
                        )),
                      ],
                    ),
                  ),
                ],

                // ── الوصف ──
                if (job.description != null && job.description!.trim().isNotEmpty) ...[
                  SizedBox(height: 24),
                  _sectionHeader('الوصف', isDark),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
                    ),
                    child: Text(job.description!, style: TextStyle(fontSize: 14, height: 1.8, fontWeight: FontWeight.w600, color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary)),
                  ),
                ],

                SizedBox(height: 32),

                // ── زر التقديم ──
                if (job.isOpen)
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xFFC21E2C), Color(0xFF8B0000)], begin: Alignment.topRight, end: Alignment.bottomLeft),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 16, offset: Offset(0, 8))],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () => _showApplySheet(context, isDark),
                        icon: Icon(Icons.send_rounded, size: 18),
                        label: Text(AppStrings.applyJob, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 18), backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                      ),
                    ),
                  ),
                if (!job.isOpen)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.error.withValues(alpha: 0.2))),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.lock_outline_rounded, color: AppColors.error, size: 18),
                      SizedBox(width: 8),
                      Text(AppStrings.jobClosedNow, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.error)),
                    ]),
                  ),
                SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, bool isDark) {
    return Row(children: [
      Container(width: 4, height: 20, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
      SizedBox(width: 10),
      Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
    ]);
  }

  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isDark,
    bool isFullWidth = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.border),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.06), blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: color, size: 16),
            ),
            SizedBox(width: 8),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
          ]),
          SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: isFullWidth ? 14 : 16, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary), maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  void _shareJob(Job job) async {
    final text = '''
${job.title}
${job.location != null ? '📍 مكان العمل: ${job.location}' : ''}
${job.employmentType != null ? '⏰ وقت العمل: ${job.employmentType}' : ''}
${job.salary != null ? '💰 الراتب: ${job.salary}' : ''}

🔗 ${AppConstants.appName}
📞 ${AppConstants.phoneDisplay}
''';
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.copiedJob), backgroundColor: AppColors.success),
      );
    }
  }

  void _showApplySheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ApplySheet(
        job: widget.job,
        isDark: isDark,
        onSuccess: () {
          Navigator.pop(context);
          SuccessDialog.show(context, message: AppStrings.successSubmit);
        },
      ),
    );
  }
}

// ─── APPLY SHEET ──────────────────────────────────────────────
class _ApplySheet extends StatefulWidget {
  final Job job;
  final bool isDark;
  final VoidCallback? onSuccess;
  const _ApplySheet({required this.job, required this.isDark, this.onSuccess});

  @override
  State<_ApplySheet> createState() => _ApplySheetState();
}

class _ApplySheetState extends State<_ApplySheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _picker = ImagePicker();
  Uint8List? _idFrontBytes;
  Uint8List? _idBackBytes;
  String? _idFrontName;
  String? _idBackName;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isFront) async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (_) => _sourceDialog(),
    );
    if (source == null || !mounted) return;
    final picked = await _picker.pickImage(source: source, imageQuality: 80, maxWidth: 1024);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      if (mounted) {
        setState(() {
          if (isFront) {
            _idFrontBytes = bytes;
            _idFrontName = picked.name;
          } else {
            _idBackBytes = bytes;
            _idBackName = picked.name;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final mq = MediaQuery.of(context);

    return PopScope(
      canPop: !_isSubmitting,
      child: Container(
        constraints: BoxConstraints(maxHeight: mq.size.height * 0.92),
        decoration: BoxDecoration(color: isDark ? AppColors.darkBg : AppColors.background, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: isDark ? AppColors.darkBorder : AppColors.border, borderRadius: BorderRadius.circular(2)))),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFC21E2C), Color(0xFF8B0000)]), borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.work_rounded, color: Colors.white, size: 22),
                ),
                SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(AppStrings.applyJob, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
                  Text(widget.job.title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary), maxLines: 1, overflow: TextOverflow.ellipsis),
                ])),
              ]),
            ),
            Divider(height: 24, color: isDark ? AppColors.darkBorder : AppColors.borderLight),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24, 0, 24, mq.viewInsets.bottom + 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildClearField(
                        controller: _nameController,
                        label: 'الاسم الكامل',
                        hint: 'أدخل الاسم الكامل',
                        icon: Icons.person_outline_rounded,
                        isDark: isDark,
                        isRequired: true,
                        validator: (v) => v == null || v.trim().isEmpty ? AppStrings.nameRequired : null,
                      ),
                      SizedBox(height: 16),
                      _buildClearField(
                        controller: _phoneController,
                        label: 'رقم الهاتف',
                        hint: '0782 586 5514',
                        icon: Icons.phone_outlined,
                        isDark: isDark,
                        isRequired: true,
                        keyboardType: TextInputType.phone,
                        textDirection: TextDirection.ltr,
                        inputFormatters: [PhoneFormatter()],
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return AppStrings.phoneRequired;
                          final cleaned = v.replaceAll(RegExp(r'[\s\-]'), '');
                          if (!RegExp(r'^07[3-9]\d{8}$').hasMatch(cleaned)) return AppStrings.phoneInvalid;
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      _buildImageUpload(
                        label: AppStrings.idFront,
                        isDark: isDark,
                        imageBytes: _idFrontBytes,
                        onTap: () => _pickImage(true),
                        onRemove: () => setState(() { _idFrontBytes = null; _idFrontName = null; }),
                      ),
                      SizedBox(height: 16),
                      _buildImageUpload(
                        label: AppStrings.idBack,
                        isDark: isDark,
                        imageBytes: _idBackBytes,
                        onTap: () => _pickImage(false),
                        onRemove: () => setState(() { _idBackBytes = null; _idBackName = null; }),
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Color(0xFFC21E2C), Color(0xFF8B0000)], begin: Alignment.topRight, end: Alignment.bottomLeft),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 16, offset: Offset(0, 8))],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: _isSubmitting ? null : _submit,
                            icon: _isSubmitting ? SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : Icon(Icons.send_rounded, size: 18),
                            label: Text(_isSubmitting ? AppStrings.sending : AppStrings.submitApplication, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                            style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 18), backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    Widget? suffixWidget,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textDirection: textDirection,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          inputFormatters: inputFormatters,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary.withValues(alpha: 0.6)),
            filled: true,
            fillColor: isDark ? AppColors.darkSurface : Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.border, width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.border, width: 1.5)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.primary, width: 2)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.error, width: 1.5)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.error, width: 2)),
            suffixIcon: suffixWidget ?? (readOnly ? Icon(Icons.arrow_drop_down, color: AppColors.textSecondary) : null),
          ),
        ),
      ],
    );
  }

  Widget _buildImageUpload({
    required String label,
    required bool isDark,
    required Uint8List? imageBytes,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.credit_card_rounded, size: 16, color: AppColors.primary),
          SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
          SizedBox(width: 4),
          Text('*', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.primary)),
        ]),
        SizedBox(height: 8),
        GestureDetector(
          onTap: imageBytes != null ? null : onTap,
          child: Container(
            width: double.infinity,
            height: imageBytes != null ? 200 : 120,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: imageBytes != null ? AppColors.success.withValues(alpha: 0.4) : (isDark ? AppColors.darkBorder : AppColors.border),
                width: imageBytes != null ? 2 : 1.5,
              ),
            ),
            child: imageBytes != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.memory(
                            imageBytes,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: isDark ? AppColors.darkSurfaceAlt : AppColors.surface,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.broken_image_rounded, color: AppColors.error, size: 32),
                                  SizedBox(height: 8),
                                  Text(AppStrings.imageFormat, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8, left: 8,
                        child: GestureDetector(
                          onTap: onRemove,
                          child: Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), shape: BoxShape.circle),
                            child: Icon(Icons.close_rounded, color: Colors.white, size: 18),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8, right: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(8)),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.check_circle_rounded, color: AppColors.success, size: 14),
                            SizedBox(width: 4),
                            Text(AppStrings.imageSelected, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                          ]),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(14)),
                        child: Icon(Icons.camera_alt_rounded, color: AppColors.primary, size: 24),
                      ),
                      SizedBox(height: 10),
                      Text(label == AppStrings.idFront ? AppStrings.tapToUploadFront : AppStrings.tapToUploadBack,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
                      ),
                      SizedBox(height: 4),
                      Text(AppStrings.imageFormat, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textTertiary)),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _sourceDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppStrings.chooseSource, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
            SizedBox(height: 16),
            ListTile(
              tileColor: isDark ? AppColors.darkSurfaceAlt : AppColors.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: Icon(Icons.camera_alt_rounded, color: AppColors.primary),
              title: Text(AppStrings.camera, style: TextStyle(fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            SizedBox(height: 8),
            ListTile(
              tileColor: isDark ? AppColors.darkSurfaceAlt : AppColors.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: Icon(Icons.photo_library_rounded, color: AppColors.primary),
              title: Text(AppStrings.gallery, style: TextStyle(fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary)),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  void _showError(String msg) {
    if (!mounted) return;
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

  Future<void> _submit() async {
    if (!mounted) return;
    if (!_formKey.currentState!.validate()) return;

    if (_idFrontBytes == null || _idBackBytes == null) {
      _showError('ارفع صورة الهوية الأمامية والخلفية قبل الإرسال');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final frontUrl = await SupabaseService().uploadImage(_idFrontName ?? 'front.jpg', _idFrontBytes!);
      final backUrl = await SupabaseService().uploadImage(_idBackName ?? 'back.jpg', _idBackBytes!);

      if (frontUrl == null || backUrl == null) {
        _showError('فشل رفع صور الهوية — تأكد من تنفيذ 006_secure_bucket.sql في Supabase SQL Editor');
        return;
      }

      final app = JobApplication(
        jobId: widget.job.id,
        jobTitle: widget.job.title,
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        idImageUrl: frontUrl,
        idImageBackUrl: backUrl,
        source: 'app',
      );
      await SupabaseService().submitApplication(app);
      if (mounted) {
        widget.onSuccess?.call();
      }
    } on PostgrestException catch (e) {
      debugPrint('DB error: ${e.message} (code: ${e.code})');
      String msg = AppStrings.errorTryAgain;
      if (e.code == '42P01') {
        msg = 'جدول الطلبات غير موجود — نفّذ 004_job_applications.sql في Supabase';
      } else if (e.code == '42501') {
        msg = 'لا توجد صلاحية للإرسال — تأكد من وجود سياسة INSERT على job_applications';
      } else if (e.message.contains('duplicate')) {
        msg = 'تم تقديم هذا الطلب مسبقاً';
      } else if (e.message.contains('violates')) {
        msg = 'خطأ في البيانات — تحقق من صحة الحقول';
      } else {
        msg = 'خطأ في قاعدة البيانات: ${e.message}';
      }
      _showError(msg);
    } catch (e) {
      debugPrint('Submit error: $e');
      _showError('حدث خطأ: $e');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
