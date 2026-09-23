import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum NotificationType {
  jobMatch,
  applicationUpdate,
  workerRequestUpdate,
  message,
  announcement,
}

extension NotificationTypeX on NotificationType {
  String get label {
    switch (this) {
      case NotificationType.jobMatch:
        return 'وظيفة جديدة';
      case NotificationType.applicationUpdate:
        return 'تحديث طلب توظيف';
      case NotificationType.workerRequestUpdate:
        return 'تحديث طلب عامل';
      case NotificationType.message:
        return 'رسالة من الإدارة';
      case NotificationType.announcement:
        return 'إعلان عام';
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.jobMatch:
        return Icons.work_outline_rounded;
      case NotificationType.applicationUpdate:
        return Icons.assignment_turned_in_outlined;
      case NotificationType.workerRequestUpdate:
        return Icons.engineering_outlined;
      case NotificationType.message:
        return Icons.mail_outline_rounded;
      case NotificationType.announcement:
        return Icons.campaign_outlined;
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.jobMatch:
        return AppColors.primary;
      case NotificationType.applicationUpdate:
        return AppColors.success;
      case NotificationType.workerRequestUpdate:
        return AppColors.primary;
      case NotificationType.message:
        return AppColors.infoBlue;
      case NotificationType.announcement:
        return AppColors.warning;
    }
  }

  /// Parse from database string value
  static NotificationType fromString(String? value) {
    switch (value) {
      case 'job_match':
        return NotificationType.jobMatch;
      case 'application_update':
        return NotificationType.applicationUpdate;
      case 'worker_request_update':
        return NotificationType.workerRequestUpdate;
      case 'message':
        return NotificationType.message;
      case 'announcement':
        return NotificationType.announcement;
      default:
        return NotificationType.announcement;
    }
  }

  /// Convert to database string value
  String get dbValue {
    switch (this) {
      case NotificationType.jobMatch:
        return 'job_match';
      case NotificationType.applicationUpdate:
        return 'application_update';
      case NotificationType.workerRequestUpdate:
        return 'worker_request_update';
      case NotificationType.message:
        return 'message';
      case NotificationType.announcement:
        return 'announcement';
    }
  }
}
