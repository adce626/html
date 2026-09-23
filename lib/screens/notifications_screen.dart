import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../models/notification_type.dart';
import '../screens/notification_detail_screen.dart';
import '../services/notification_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await Supabase.instance.client
          .from('notifications')
          .select('*')
          .order('created_at', ascending: false)
          .limit(50);
      setState(() {
        _notifications = List<Map<String, dynamic>>.from(result);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = AppStrings.errorTryAgain;
      });
    }
  }

  Future<void> _markAsRead(String id) async {
    try {
      await Supabase.instance.client
          .from('notifications')
          .update({'is_read': true}).eq('id', id);
      setState(() {
        final index = _notifications.indexWhere((n) => n['id'] == id);
        if (index != -1) _notifications[index]['is_read'] = true;
      });
      NotificationService().refreshUnreadCount();
    } catch (e) {
      debugPrint('Mark read error: $e');
    }
  }

  Future<void> _markAllAsRead() async {
    try {
      await Supabase.instance.client
          .from('notifications')
          .update({'is_read': true}).eq('is_read', false);
      setState(() {
        for (var n in _notifications) {
          n['is_read'] = true;
        }
      });
      NotificationService().refreshUnreadCount();
    } catch (e) {
      debugPrint('Mark all read error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasUnread = _notifications.any((n) => n['is_read'] == false);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.background,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppStrings.notifications,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
        actions: [
          if (hasUnread)
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(AppStrings.readAll,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary)),
            ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: AppColors.primary))
          : _error != null
              ? _errorState(isDark)
              : _notifications.isEmpty
                  ? _emptyState(isDark)
                  : RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: _fetchNotifications,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: _notifications.length,
                        itemBuilder: (context, index) =>
                            _notificationCard(_notifications[index], isDark),
                      ),
                    ),
    );
  }

  Widget _errorState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded,
              size: 48, color: AppColors.error),
          SizedBox(height: 12),
          Text(_error!,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary)),
          SizedBox(height: 12),
          TextButton(
              onPressed: _fetchNotifications,
              child: Text(AppStrings.retry)),
        ],
      ),
    );
  }

  Widget _emptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.notifications_off_rounded,
                size: 42,
                color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          SizedBox(height: 20),
          Text(AppStrings.noNotifications,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary)),
          SizedBox(height: 8),
          Text(AppStrings.noNotificationsDesc,
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary.withValues(alpha: 0.6))),
        ],
      ),
    );
  }

  Widget _notificationCard(Map<String, dynamic> notification, bool isDark) {
    final isRead = notification['is_read'] == true;
    final createdAt =
        DateTime.tryParse(notification['created_at'] ?? '');
    final timeAgo = createdAt != null ? _formatTimeAgo(createdAt) : '';
    final type = NotificationTypeX.fromString(notification['type']);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (!isRead) _markAsRead(notification['id']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                NotificationDetailScreen(notification: notification),
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isRead
              ? (isDark ? AppColors.darkSurface : Colors.white)
              : type.color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isRead
                ? (isDark ? AppColors.darkBorder : AppColors.border)
                : type.color.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: type.color.withValues(alpha: isRead ? 0.08 : 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(type.icon, size: 22, color: type.color),
            ),
            SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification['title'] ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                isRead ? FontWeight.w600 : FontWeight.w800,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    notification['message'] ?? notification['body'] ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (timeAgo.isNotEmpty) ...[
                    SizedBox(height: 6),
                    Text(timeAgo,
                        style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary
                                .withValues(alpha: 0.5))),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'الآن';
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
    if (diff.inDays == 1) return 'أمس';
    if (diff.inDays < 7) return 'منذ ${diff.inDays} أيام';
    return '${date.day}/${date.month}/${date.year}';
  }
}
