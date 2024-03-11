class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String image;
  final String email;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  String get fullName => '$firstName $lastName';

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData.containsKey('id') && jsonData['id'] != null
          ? jsonData['id']
          : 0,
      firstName:
          jsonData.containsKey('firstName') && jsonData['firstName'] != null
              ? jsonData['firstName']
              : '',
      lastName: jsonData.containsKey('lastName') && jsonData['lastName'] != null
          ? jsonData['lastName']
          : '',
      image: jsonData.containsKey('image') && jsonData['image'] != null
          ? jsonData['image']
          : '',
      email: jsonData.containsKey('email') && jsonData['email'] != null
          ? jsonData['email']
          : '',
      refreshToken:
          jsonData.containsKey('refresh') && jsonData['refresh'] != null
              ? jsonData['refresh']
              : '',
      accessToken: jsonData.containsKey('access') && jsonData['access'] != null
          ? jsonData['access']
          : '',
    );
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? image,
    String? email,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      image: image ?? this.image,
      email: email ?? this.email,
      accessToken: email ?? this.email,
      refreshToken: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
      'email': email,
      'access': accessToken,
      'refresh': refreshToken,
    };
  }
}
