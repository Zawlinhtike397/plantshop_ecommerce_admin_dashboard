class AddressModel {
  final String? id;
  final String userId;
  final String contactName;
  final String phone;
  final String homeNo;
  final String street;
  final String city;
  final bool isDefault;

  AddressModel({
    this.id,
    required this.userId,
    required this.contactName,
    required this.phone,
    required this.homeNo,
    required this.street,
    required this.city,
    this.isDefault = false,
  });

  static AddressModel empty() {
    return AddressModel(
      userId: '',
      contactName: '',
      phone: '',
      homeNo: '',
      street: '',
      city: '',
    );
  }

  AddressModel copyWith({
    String? id,
    String? userId,
    String? contactName,
    String? phone,
    String? homeNo,
    String? street,
    String? city,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
      homeNo: homeNo ?? this.homeNo,
      street: street ?? this.street,
      city: city ?? this.city,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'],
      userId: map['user_id'],
      contactName: map['contact_name'],
      phone: map['phone'],
      homeNo: map['home_no'],
      street: map['street'],
      city: map['city'],
      isDefault: map['is_default'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'contact_name': contactName,
      'phone': phone,
      'home_no': homeNo,
      'street': street,
      'city': city,
      'is_default': isDefault,
    };
  }
}
