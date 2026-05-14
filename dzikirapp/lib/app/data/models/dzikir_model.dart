class DzikirModel {
  final int? id;
  final DateTime? createdAt;
  final String? userId;
  final String ucapan;
  final int target;
  final int jumlah;

  DzikirModel({
    this.id,
    this.createdAt,
    this.userId,
    required this.ucapan,
    required this.target,
    required this.jumlah,
  });

  factory DzikirModel.fromJson(Map<String, dynamic> json) {
    return DzikirModel(
      id: json['id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      userId: json['user_id'],
      ucapan: json['ucapan'] ?? '',
      target: json['target'] ?? 0,
      jumlah: json['jumlah'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'ucapan': ucapan,
      'target': target,
      'jumlah': jumlah,
    };
  }

  DzikirModel copyWith({
    int? id,
    DateTime? createdAt,
    String? userId,
    String? ucapan,
    int? target,
    int? jumlah,
  }) {
    return DzikirModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      ucapan: ucapan ?? this.ucapan,
      target: target ?? this.target,
      jumlah: jumlah ?? this.jumlah,
    );
  }
}
