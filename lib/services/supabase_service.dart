import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/job.dart';
import '../models/application.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._();
  factory SupabaseService() => _instance;
  SupabaseService._();

  SupabaseClient get _client => Supabase.instance.client;

  static SupabaseClient get client => Supabase.instance.client;

  Future<List<Job>> fetchJobs() async {
    try {
      final response = await _client
          .from('jobs')
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((json) => Job.fromJson(json)).toList();
    } catch (e) {
      debugPrint('fetchJobs error: $e');
      return [];
    }
  }

  /// Upload image and return the STORAGE PATH (not URL)
  Future<String?> uploadImage(String fileName, Uint8List bytes) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final ext = fileName.split('.').last.toLowerCase();
      final safeExt = (ext == 'png' || ext == 'webp' || ext == 'gif') ? ext : 'jpg';
      final safeName = '${timestamp}_${DateTime.now().millisecondsSinceEpoch}.$safeExt';

      debugPrint('=== STORAGE UPLOAD ===');
      debugPrint('Bucket: id-documents | File: $safeName | Size: ${bytes.length} bytes');

      if (kIsWeb) {
        await _client.storage.from('id-documents').uploadBinary(
          safeName,
          bytes,
          fileOptions: FileOptions(
            upsert: true,
            contentType: _contentType(safeExt),
          ),
        );
      } else {
        final tempDir = Directory.systemTemp;
        final tempFile = File('${tempDir.path}/$safeName');
        await tempFile.writeAsBytes(bytes, flush: true);

        await _client.storage.from('id-documents').upload(
          safeName,
          tempFile,
          fileOptions: FileOptions(upsert: true),
        );

        try { await tempFile.delete(); } catch (_) {}
      }

      debugPrint('Upload OK → path: $safeName');
      return safeName; // Return PATH, not URL
    } on StorageException catch (e) {
      debugPrint('Storage error: ${e.statusCode} — ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Upload error: $e');
      return null;
    }
  }

  /// Generate a signed URL from a storage path (expires in 1 hour)
  Future<String?> getSignedUrl(String path) async {
    try {
      final signedUrl = await _client.storage
          .from('id-documents')
          .createSignedUrl(path, 3600); // 1 hour expiry
      return signedUrl;
    } catch (e) {
      debugPrint('Signed URL error: $e');
      return null;
    }
  }

  /// Generate signed URLs for multiple paths
  Future<Map<String, String>> getSignedUrls(List<String> paths) async {
    final result = <String, String>{};
    for (final path in paths) {
      if (path.isEmpty) continue;
      final url = await getSignedUrl(path);
      if (url != null) result[path] = url;
    }
    return result;
  }

  String _contentType(String ext) {
    switch (ext) {
      case 'png': return 'image/png';
      case 'gif': return 'image/gif';
      case 'webp': return 'image/webp';
      default: return 'image/jpeg';
    }
  }

  Future<void> submitApplication(JobApplication app) async {
    try {
      await _client.from('job_applications').insert(app.toJson());
    } on PostgrestException catch (e) {
      debugPrint('submitApplication DB error: ${e.message} (code: ${e.code})');
      rethrow;
    } catch (e) {
      debugPrint('submitApplication error: $e');
      rethrow;
    }
  }

  Future<void> registerFCMToken(String token) async {
    try {
      await _client.from('fcm_tokens').upsert({
        'token': token,
        'platform': 'mobile',
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('registerFCMToken error: $e');
    }
  }

  Future<void> deleteFCMToken(String token) async {
    await _client.from('fcm_tokens').delete().eq('token', token);
  }
}
