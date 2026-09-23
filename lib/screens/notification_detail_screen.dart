import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../models/job.dart';
import '../models/notification_type.dart';
import '../services/notification_service.dart';
import '../screens/job_detail_screen.dart';
import '../screens/worker_request_screen.dart';

class NotificationDetailScreen extends StatefulWidget {
  final Map<String, dynamic> notification;
  const NotificationDetailScreen({super.key, required this.notification});

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  late bool _isRead;

  @override
  void initState() {
    super.initState();
    _isRead = widget.notification['is_read'] == true;
    if (!_isRead) {
      _markAsRead();
    }
  }

  Future<void> _markAsRead() async {
    try {
      await Supabase.instance.client
          .from('notifications')
          .update({'is_read': true})
          .eq('id', widget.notification['id']);
      setState(() => _isRead = true);
      NotificationService().refreshUnreadCount();
    } catch (e) {
      debugPrint('Mark read error: $e');
    }
  }

  void _navigateToRelated() {
    final type = NotificationTypeX.fromString(widget.notification['type']);
    final relatedId = widget.notification['related_id'];

    switch (type) {
      case NotificationType.jobMatch:
        if (relatedId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => JobDetailScreen(
                job: Job(
                  id: relatedId,
                  title: widget.notification['title'] ?? '',
                  description: widget.notification['message'] ?? '',
                ),
              ),
            ),
          );
        }
        break;
      case NotificationType.workerRequestUpdate:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WorkerRequestScreen()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final createdAt =
        DateTime.tryParse(widget.notification['created_at'] ?? '');
    final dateStr = createdAt != null
        ? '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')} ${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}'
        : '';
    final type =
        NotificationTypeX.fromString(widget.notification['type']);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppStrings.notificationDetails,
            style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: type.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(type.icon, size: 14, color: type.color),
                  SizedBox(width: 6),
                  Text(
                    type.label,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: type.color),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Title
            Text(
              widget.notification['title'] ?? '',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                  height: 1.4),
            ),
            SizedBox(height: 12),

            // Date
            if (dateStr.isNotEmpty)
              Row(children: [
                Icon(Icons.access_time_rounded,
                    size: 14, color: AppColors.textSecondary),
                SizedBox(width: 6),
                Text(dateStr,
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ]),
            SizedBox(height: 24),

            // Message body
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.border),
              ),
              child: Text(
                widget.notification['message'] ??
                    widget.notification['body'] ??
                    '',
                style: TextStyle(
                    fontSize: 15,
                    height: 1.8,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary),
              ),
            ),

            // Action button
            if (widget.notification['related_id'] != null) ...[
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColors.primary,
                      AppColors.primaryDark
                    ]),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _navigateToRelated,
                    icon: Icon(Icons.open_in_new_rounded, size: 18),
                    label: Text(AppStrings.viewDetails,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800)),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
