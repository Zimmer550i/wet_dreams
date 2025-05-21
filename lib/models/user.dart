class User {
  final int id;
  final String fullName;
  final String email;
  final String? profilePic;
  final bool isVerified;
  final bool isActive;
  final bool isStaff;
  final bool isSuperuser;
  final DateTime createdOn;
  final DateTime updatedOn;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profilePic,
    required this.isVerified,
    required this.isActive,
    required this.isStaff,
    required this.isSuperuser,
    required this.createdOn,
    required this.updatedOn,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      profilePic: json['profile_pic'],
      isVerified: json['is_verified'],
      isActive: json['is_active'],
      isStaff: json['is_staff'],
      isSuperuser: json['is_superuser'],
      createdOn: DateTime.parse(json['created_on']),
      updatedOn: DateTime.parse(json['updated_on']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'profile_pic': profilePic,
      'is_verified': isVerified,
      'is_active': isActive,
      'is_staff': isStaff,
      'is_superuser': isSuperuser,
      'created_on': createdOn.toIso8601String(),
      'updated_on': updatedOn.toIso8601String(),
    };
  }
}