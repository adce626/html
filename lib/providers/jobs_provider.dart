import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/job.dart';
import '../services/supabase_service.dart';
import '../services/storage_service.dart';

class JobsProvider extends ChangeNotifier {
  final SupabaseService _api = SupabaseService();

  List<Job> _allJobs = [];
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;
  int _retryCount = 0;
  static const int _maxRetries = 3;

  List<Job> get allJobs => _allJobs;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Timer? _debounce;

  List<Job> get filteredJobs {
    if (_searchQuery.isEmpty) return _allJobs;
    final q = _searchQuery.toLowerCase();
    return _allJobs.where((job) {
      return (job.title.toLowerCase().contains(q)) ||
          (job.description?.toLowerCase().contains(q) ?? false) ||
          (job.location?.toLowerCase().contains(q) ?? false) ||
          (job.department?.toLowerCase().contains(q) ?? false) ||
          (job.company?.toLowerCase().contains(q) ?? false);
    }).toList();
  }

  void updateSearch(String query) {
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 400), () {
      _searchQuery = query;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> fetchJobs() async {
    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    _retryCount = 0;
    notifyListeners();

    // Try cache first
    if (_allJobs.isEmpty) {
      final cached = await StorageService.getCachedJobs();
      if (cached != null && cached.isNotEmpty) {
        _allJobs = cached;
        _isLoading = false;
        notifyListeners();
      }
    }

    // Fetch from network
    while (_retryCount <= _maxRetries) {
      try {
        _allJobs = await _api.fetchJobs();
        await StorageService.saveJobs(_allJobs);
        await StorageService.saveJobsCount(_allJobs.length);
        _isLoading = false;
        _error = null;
        notifyListeners();
        return;
      } catch (e) {
        _retryCount++;
        if (_retryCount > _maxRetries) {
          if (_allJobs.isEmpty) {
            _error = e.toString();
          }
          _isLoading = false;
          notifyListeners();
          return;
        }
        await Future.delayed(Duration(seconds: _retryCount * 2));
      }
    }
  }
}
