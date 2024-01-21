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
  print(response.statusCode);
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
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    print("Logged in");
  } else {
    print("Login failed");
    print('Response body: ${response.body}');
    print('Response body: ${response.statusCode}');
  }
}
