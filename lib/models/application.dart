class JobApplication {
  final String? id;
  final String jobId;
  final String jobTitle;
  final String fullName;
  final String phone;
  final String? idImageUrl;
  final String? idImageBackUrl;
  final String status;
  final String source;
  final DateTime? createdAt;

  JobApplication({
    this.id,
    required this.jobId,
    required this.jobTitle,
    required this.fullName,
    required this.phone,
    this.idImageUrl,
    this.idImageBackUrl,
    this.status = 'جديد',
    this.source = 'app',
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'job_title': jobTitle,
      'full_name': fullName,
      'phone': phone,
      'id_image_url': idImageUrl,
      'id_image_back_url': idImageBackUrl,
      'status': status,
      'source': source,
    };
  }

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['id']?.toString(),
      jobId: json['job_id']?.toString() ?? '',
      jobTitle: json['job_title']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      idImageUrl: json['id_image_url']?.toString(),
      idImageBackUrl: json['id_image_back_url']?.toString(),
      status: json['status']?.toString() ?? 'جديد',
      source: json['source']?.toString() ?? 'app',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }
}
