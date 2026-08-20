class User {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final String? status;
  final String? phoneNumber;
  final String? biography;
  final String? profilePicture;
  final String? instrument;
  final int? yearExperience;
  final String? addressId;
  final bool isVerified;
  final String? certificate;
  final String? cv;
  final String? portfolio;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.status,
    this.phoneNumber,
    this.biography,
    this.profilePicture,
    this.instrument,
    this.yearExperience,
    this.addressId,
    this.isVerified = false,
    this.certificate,
    this.cv,
    this.portfolio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
      role: json['role'] ?? '',
      status: json['status'],
      phoneNumber: json['phone_number'],
      biography: json['biography'],
      profilePicture: json['profile_picture'],
      instrument: json['instrument'],
      yearExperience: json['year_experience'],
      addressId: json['address_id'],
      isVerified: json['is_verified'] == true || json['is_verified'] == '1',
      certificate: json['certificate'],
      cv: json['cv'],
      portfolio: json['portfolio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role,
      'status': status,
      'phone_number': phoneNumber,
      'biography': biography,
      'profile_picture': profilePicture,
      'instrument': instrument,
      'year_experience': yearExperience,
      'address_id': addressId,
      'is_verified': isVerified,
      'certificate': certificate,
      'cv': cv,
      'portfolio': portfolio,
    };
  }

  bool get isTeacher => role == 'teacher';
  bool get isStudent => role == 'student';

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? role,
    String? status,
    String? phoneNumber,
    String? biography,
    String? profilePicture,
    String? instrument,
    int? yearExperience,
    String? addressId,
    bool? isVerified,
    String? certificate,
    String? cv,
    String? portfolio,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      biography: biography ?? this.biography,
      profilePicture: profilePicture ?? this.profilePicture,
      instrument: instrument ?? this.instrument,
      yearExperience: yearExperience ?? this.yearExperience,
      addressId: addressId ?? this.addressId,
      isVerified: isVerified ?? this.isVerified,
      certificate: certificate ?? this.certificate,
      cv: cv ?? this.cv,
      portfolio: portfolio ?? this.portfolio,
    );
  }
}

class LoginResponse {
  final String accessToken;
  final String? refreshToken;
  final User? user;

  LoginResponse({
    required this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    User? user;
    if (json['data'] != null) {
      user = User.fromJson(json['data']);
    }

    String? accessToken;
    if (json['access_token'] != null) {
      accessToken = json['access_token'];
    } else if (json['token'] != null) {
      accessToken = json['token'];
    }

    String? refreshToken;
    if (json['refresh_token'] != null) {
      refreshToken = json['refresh_token'];
    }

    return LoginResponse(
      accessToken: accessToken ?? '',
      refreshToken: refreshToken,
      user: user,
    );
  }
}

class Instrument {
  final String id;
  final String name;

  Instrument({
    required this.id,
    required this.name,
  });

  factory Instrument.fromJson(Map<String, dynamic> json) {
    return Instrument(
      id: json['id']?.toString() ?? json['name'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
