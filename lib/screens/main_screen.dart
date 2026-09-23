import 'dart:async';
import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/app_strings.dart';
import '../services/connectivity_service.dart';
import '../services/notification_service.dart';
import 'home_screen.dart';
import 'services_screen.dart';
import 'jobs_screen.dart';
import 'worker_request_screen.dart';
import '../widgets/bottom_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();

  static _MainScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MainScreenState>();
  }
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _isOffline = false;
  StreamSubscription<bool>? _sub;
  final Map<int, Widget> _screenCache = {};

  Widget _buildScreen(int index) {
    _screenCache.putIfAbsent(index, () {
      switch (index) {
        case 0: return HomeScreen(key: _tabs[0]);
        case 1: return ServicesScreen(key: _tabs[1]);
        case 2: return JobsScreen(key: _tabs[2]);
        case 3: return WorkerRequestScreen(key: _tabs[3]);
        default: return HomeScreen(key: _tabs[0]);
      }
    });
    return _screenCache[index]!;
  }

  @override
  void initState() {
    super.initState();
    _isOffline = !ConnectivityService().currentStatus;
    _sub = ConnectivityService().isConnected.listen((connected) {
      if (mounted && _isOffline != !connected) {
        setState(() => _isOffline = !connected);
      }
    });
    // Initialize notifications
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService().init(context);
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void switchTab(int index) {
    if (index >= 0 && index < _tabs.length) {
      setState(() => _currentIndex = index);
    }
  }

  static const _tabs = [
    ValueKey('tab-home'),
    ValueKey('tab-services'),
    ValueKey('tab-jobs'),
    ValueKey('tab-worker'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (_isOffline)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.error,
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off_rounded, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text(AppStrings.noInternet, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                  ],
                ),
              ),
            ),
          Expanded(
            child: _buildScreen(_currentIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
