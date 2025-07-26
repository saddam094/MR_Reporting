class ProfileModel {
  final String email;
  final String role;
  final String name;
  final String phone;
  final String mrId;

  ProfileModel({
    required this.email,
    required this.role,
    required this.name,
    required this.phone,
    required this.mrId,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      mrId: json['mr_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
      'name': name,
      'phone': phone,
      'mr_id': mrId,
    };
  }
}
