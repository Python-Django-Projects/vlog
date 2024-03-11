import 'package:http/http.dart' as http;

void createAccount(String email, username, password, password2) async {
  final response = await http.post(
    Uri.parse("http://127.0.0.1:8000/register/"),
    body: {
      "email": email,
      "username": username,
      "password": password,
      "password2": password2,
    },
  );
  if (response.statusCode == 201) {
    print("Created account");
  } else {
    print("Login failed");
  }
}

void loginUser(String email, password) async {
  final response = await http.post(
    Uri.parse("http://127.0.0.1:8000/api/token/"),
    body: {
      "email": email,
      "password": password,
    },
  );

  if (response.statusCode == 200) {
    print("Logged in");
  } else {
    print("Login failed");
    print('Response body: ${response.body}');
    print('Response body: ${response.statusCode}');
  }
}

void resetPassword(String email) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/reset_password/'),
    body: {'email': email},
  );

  if (response.statusCode == 200) {
    // Password reset successful, handle the response accordingly
    print('Password reset successful');
  } else {
    // Password reset failed, handle the error
    print('Password reset failed. Status code: ${response.statusCode}');
  }
}
