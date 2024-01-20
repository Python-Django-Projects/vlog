class UserCreate {
  final String email;
  final String username;
  final String password;
  final String password2;

  UserCreate(this.email, this.password2,
      {required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'password2': password2,
    };
  }
}

// class UserLogin {
//   final String username;
//   final String password;

//   UserLogin({required this.username, required this.password});

//   Map<String, dynamic> toJson() {
//     return {
//       'username': username,
//       'password': password,
//     };
//   }
// }
