enum JobStatus {
  open,
  closed,
  draft;

  factory JobStatus.fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'open':
        return JobStatus.open;
      case 'closed':
        return JobStatus.closed;
      case 'draft':
        return JobStatus.draft;
      default:
        return JobStatus.open;
    }
  }

  bool get isOpen => this == JobStatus.open;
  bool get isClosed => this == JobStatus.closed;
  bool get isDraft => this == JobStatus.draft;
}

class Job {
  final String id;
  final String title;
  final String? description;
  final String? location;
  final String? department;
  final String? employmentType;
  final String? salary;
  final String? company;
  final String? requirements;
  final JobStatus status;
  final DateTime? createdAt;

  Job({
    required this.id,
    required this.title,
    this.description,
    this.location,
    this.department,
    this.employmentType,
    this.salary,
    this.company,
    this.requirements,
    this.status = JobStatus.open,
    this.createdAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),
      location: json['location']?.toString(),
      department: json['department']?.toString(),
      employmentType: json['employment_type']?.toString(),
      salary: json['salary']?.toString(),
      company: json['company']?.toString(),
      requirements: json['requirements']?.toString(),
      status: JobStatus.fromString(json['status']?.toString()),
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }

  bool get isOpen => status.isOpen;
  bool get isClosed => status.isClosed;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'department': department,
      'employment_type': employmentType,
      'salary': salary,
      'company': company,
      'requirements': requirements,
      'status': status.name,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
