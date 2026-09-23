import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  const SuccessDialog({
    super.key,
    String? title,
    String? message,
    this.buttonText = '',
    this.onPressed,
  }) : title = title ?? '',
       message = message ?? '';

  static void show(BuildContext context, {String? title, String? message, VoidCallback? onPressed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => SuccessDialog(
        title: title ?? AppStrings.successTitle,
        message: message ?? AppStrings.successMessage,
        onPressed: onPressed ?? () => Navigator.pop(dialogContext),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.check_circle_rounded, color: AppColors.success, size: 48),
            ),
            SizedBox(height: 20),
            Text(title.isNotEmpty ? title : AppStrings.successTitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900), textAlign: TextAlign.center),
            SizedBox(height: 8),
            Text(message.isNotEmpty ? message : AppStrings.successMessage, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary, height: 1.6), textAlign: TextAlign.center),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(14)),
                child: TextButton(
                  onPressed: () { HapticFeedback.lightImpact(); onPressed?.call(); },
                  child: Text(buttonText.isNotEmpty ? buttonText : AppStrings.done, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
