import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/job.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static const _jobsCountKey = 'sama-jobs-count';
  static const _themeKey = 'sama-theme';
  static const _jobsCacheKey = 'sama-jobs-cache';
  static const _jobsCacheTimeKey = 'sama-jobs-cache-time';

  static Future<SharedPreferences> get _instance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<int> getJobsCount() async {
    final prefs = await _instance;
    return prefs.getInt(_jobsCountKey) ?? 0;
  }

  static Future<void> saveJobsCount(int count) async {
    final prefs = await _instance;
    await prefs.setInt(_jobsCountKey, count);
  }

  static Future<bool> isDarkMode() async {
    final prefs = await _instance;
    return prefs.getBool(_themeKey) ?? false;
  }

  static Future<void> saveDarkMode(bool value) async {
    final prefs = await _instance;
    await prefs.setBool(_themeKey, value);
  }

  // ─── Jobs Cache ──────────────────────────────────────
  static Future<void> saveJobs(List<Job> jobs) async {
    final prefs = await _instance;
    final jsonList = jobs.map((j) => j.toJson()).toList();
    await prefs.setString(_jobsCacheKey, jsonEncode(jsonList));
    await prefs.setInt(_jobsCacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<List<Job>?> getCachedJobs() async {
    final prefs = await _instance;
    final jsonStr = prefs.getString(_jobsCacheKey);
    if (jsonStr == null) return null;
    try {
      final jsonList = jsonDecode(jsonStr) as List;
      return jsonList.map((j) => Job.fromJson(j as Map<String, dynamic>)).toList();
    } catch (_) {
      return null;
    }
  }

  static Future<bool> isCacheFresh({Duration maxAge = const Duration(minutes: 30)}) async {
    final prefs = await _instance;
    final timestamp = prefs.getInt(_jobsCacheTimeKey);
    if (timestamp == null) return false;
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(cacheTime) < maxAge;
  }
}
