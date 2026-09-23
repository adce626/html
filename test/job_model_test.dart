import 'package:flutter_test/flutter_test.dart';
import 'package:sama_app/models/job.dart';
import 'package:sama_app/models/application.dart';

void main() {
  group('Job Model', () {
    test('parses from JSON correctly', () {
      final json = {
        'id': '1',
        'title': 'عمال',
        'description': 'عمال في مطعم',
        'location': 'كربلاء',
        'department': 'خدمة',
        'employment_type': 'دوام كامل',
        'salary': '500,000 دينار',
        'company': 'سما',
        'status': 'open',
        'created_at': '2025-01-01T00:00:00Z',
      };

      final job = Job.fromJson(json);

      expect(job.id, '1');
      expect(job.title, 'عمال');
      expect(job.description, 'عمال في مطعم');
      expect(job.location, 'كربلاء');
      expect(job.department, 'خدمة');
      expect(job.employmentType, 'دوام كامل');
      expect(job.salary, '500,000 دينار');
      expect(job.company, 'سما');
      expect(job.isOpen, true);
      expect(job.isClosed, false);
      expect(job.createdAt, isNotNull);
    });

    test('handles missing fields', () {
      final json = <String, dynamic>{};
      final job = Job.fromJson(json);

      expect(job.id, '');
      expect(job.title, '');
      expect(job.description, isNull);
      expect(job.isOpen, true);
    });

    test('parses closed status', () {
      final json = {'id': '2', 'title': 'Test', 'status': 'closed'};
      final job = Job.fromJson(json);

      expect(job.isOpen, false);
      expect(job.isClosed, true);
    });
  });

  group('JobStatus enum', () {
    test('fromString returns correct status', () {
      expect(JobStatus.fromString('open'), JobStatus.open);
      expect(JobStatus.fromString('closed'), JobStatus.closed);
      expect(JobStatus.fromString('draft'), JobStatus.draft);
      expect(JobStatus.fromString('unknown'), JobStatus.open);
      expect(JobStatus.fromString(null), JobStatus.open);
    });
  });

  group('JobApplication Model', () {
    test('serializes to JSON correctly', () {
      final app = JobApplication(
        jobId: '1',
        jobTitle: 'عمال',
        fullName: 'أحمد',
        phone: '07825865514',
        source: 'mobile',
      );

      final json = app.toJson();

      expect(json['job_id'], '1');
      expect(json['job_title'], 'عمال');
      expect(json['full_name'], 'أحمد');
      expect(json['phone'], '07825865514');
      expect(json['source'], 'mobile');
      expect(json['status'], 'جديد');
    });
  });
}
