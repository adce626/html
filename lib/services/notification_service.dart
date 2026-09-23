import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Background message: ${message.messageId}');
}

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  String? _currentToken;
  bool _initialized = false;
  StreamSubscription<String>? _tokenSub;
  StreamSubscription<RemoteMessage>? _onMessageSub;
  StreamSubscription<RemoteMessage>? _onOpenedAppSub;

  final _unreadCountController = StreamController<int>.broadcast();
  Stream<int> get unreadCountStream => _unreadCountController.stream;
  int _cachedUnreadCount = 0;
  int get unreadCount => _cachedUnreadCount;

  Timer? _refreshTimer;

  Future<void> init(BuildContext context) async {
    if (_initialized) return;
    _initialized = true;

    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: true,
    );
    debugPrint('Notification permission: ${settings.authorizationStatus}');

    await _initLocalNotifications();

    _currentToken = await _fcm.getToken();
    if (_currentToken != null) {
      await _registerToken(_currentToken!);
    }

    _tokenSub?.cancel();
    _tokenSub = _fcm.onTokenRefresh.listen((newToken) {
      _currentToken = newToken;
      _registerToken(newToken);
    });

    _onMessageSub?.cancel();
    _onMessageSub =
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    _onOpenedAppSub?.cancel();
    _onOpenedAppSub =
        FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    final initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }

    FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler);

    refreshUnreadCount();

    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(Duration(minutes: 1), (_) {
      refreshUnreadCount();
    });
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const settings = InitializationSettings(
        android: androidSettings, iOS: iosSettings);
    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (response) {
      if (response.payload != null) {
        final data = jsonDecode(response.payload!);
        _navigateToNotification(data);
      }
    });

    const androidChannel = AndroidNotificationChannel(
      'sama_high_importance',
      'إشعارات سما',
      description: 'إشعارات تطبيق سما أنوار الهدى',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message: ${message.notification?.title}');
    final notification = message.notification;
    if (notification == null) return;

    _saveNotificationToSupabase(
      title: notification.title ?? '',
      body: notification.body ?? '',
      type: message.data['type'] ?? 'announcement',
      relatedId: message.data['related_id'],
    );

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'sama_high_importance',
          'إشعارات سما',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: jsonEncode(message.data),
    );

    refreshUnreadCount();
  }

  Future<void> _saveNotificationToSupabase({
    required String title,
    required String body,
    required String type,
    String? relatedId,
  }) async {
    try {
      await Supabase.instance.client.from('notifications').insert({
        'title': title,
        'body': body,
        'message': body,
        'type': type,
        'related_id': relatedId,
        'is_read': false,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Save notification error: $e');
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification tap: ${message.data}');
    _navigateToNotification(message.data);
  }

  void _navigateToNotification(Map<String, dynamic> data) {
    _pendingNavigationData = data;
  }

  Map<String, dynamic>? _pendingNavigationData;

  Map<String, dynamic>? consumePendingNavigation() {
    final data = _pendingNavigationData;
    _pendingNavigationData = null;
    return data;
  }

  Future<void> _registerToken(String token) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      await Supabase.instance.client.from('fcm_tokens').upsert({
        'token': token,
        'user_id': userId,
        'platform': 'android',
        'created_at': DateTime.now().toIso8601String(),
      }, onConflict: 'token');
    } catch (e) {
      debugPrint('Register token error: $e');
    }
  }

  Future<void> deleteToken() async {
    if (_currentToken == null) return;
    try {
      await Supabase.instance.client
          .from('fcm_tokens')
          .delete()
          .eq('token', _currentToken!);
    } catch (e) {
      debugPrint('Delete token error: $e');
    }
    _currentToken = null;
  }

  Future<void> refreshUnreadCount() async {
    try {
      final result = await Supabase.instance.client
          .from('notifications')
          .select('id')
          .eq('is_read', false);
      _cachedUnreadCount = result.length;
      _unreadCountController.add(_cachedUnreadCount);
    } catch (e) {
      _unreadCountController.add(_cachedUnreadCount);
    }
  }

  void dispose() {
    _tokenSub?.cancel();
    _onMessageSub?.cancel();
    _onOpenedAppSub?.cancel();
    _refreshTimer?.cancel();
    _unreadCountController.close();
  }
}
