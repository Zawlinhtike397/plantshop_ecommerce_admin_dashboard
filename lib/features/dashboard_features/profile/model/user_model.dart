class UserModel {
  final String id;
  final String userName;
  final String email;
  final String? phoneNumber;
  final String? profilePicture;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    this.phoneNumber,
    this.profilePicture,
    this.createdAt,
  });

  static UserModel empty() {
    return UserModel(
      id: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
      createdAt: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'name': userName,
      'email': email,
      'phone_no': phoneNumber,
      'profile_picture': profilePicture,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'] ?? '',
      userName: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_no'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  UserModel copyWith({
    String? userName,
    String? email,
    String? phoneNumber,
    String? profilePicture,
  }) {
    return UserModel(
      id: id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt,
    );
  }
}
