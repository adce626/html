import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'config/supabase_config.dart';
import 'config/theme.dart';
import 'config/app_strings.dart';
import 'providers/jobs_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/welcome_screen.dart';
import 'services/connectivity_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  // Global error handler → Crashlytics
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterError(details);
  };

  // Run with zone guard for async errors
  runZonedGuarded(
    () async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FlutterError.onError = (FlutterErrorDetails details) {
        FirebaseCrashlytics.instance.recordFlutterError(details);
      };
      await Supabase.initialize(
        url: SupabaseConfig.url,
        anonKey: SupabaseConfig.anonKey,
      );
      ConnectivityService().init();
      runApp(const SamaApp());
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    },
  );
}

class SamaApp extends StatelessWidget {
  const SamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => JobsProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          if (themeProvider.isLoading) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: AppColors.background,
                body: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
            );
          }

          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeProvider.themeMode,
            locale: Locale('ar', 'IQ'),
            supportedLocales: [
              Locale('ar', 'IQ'),
              Locale('en', 'US'),
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              ErrorWidget.builder = (FlutterErrorDetails details) {
                FirebaseCrashlytics.instance.recordFlutterError(details);
                return Material(
                  child: Container(
                    color: AppColors.background,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline_rounded, size: 48, color: AppColors.error),
                            SizedBox(height: 16),
                            Text(AppStrings.errorTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                            SizedBox(height: 8),
                            Text(AppStrings.errorDesc, textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () => Navigator.of(context).maybePop(),
                              icon: Icon(Icons.refresh_rounded, size: 18),
                              label: Text(AppStrings.retry),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              };
              return child!;
            },
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}

