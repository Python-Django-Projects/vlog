import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trend/posts/data/models.dart';

Future<List<PostModel>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/post/list/'));
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    List<PostModel> posts = [];
    for (var post in jsonDecode(response.body)) {
      posts.add(PostModel.fromJson(post));
    }
    return posts;
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load posts');
  }
}
