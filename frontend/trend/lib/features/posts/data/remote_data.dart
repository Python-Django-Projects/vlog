// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:trend/features/posts/data/models.dart';
import 'package:trend/main.dart';

Future<List<PostModel>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/post/list/'));
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

Future<void> addPost(
    File imageFile, String description, BuildContext context) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://127.0.0.1:8000/post/list/'));
  request.fields.addAll({
    'author': '1',
    'description': description,
    'comment': '',
  });
  request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: "Post added successfully");
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => BottomNavBar()), (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: "Unable to add post, please try again later.");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Unable to add post, please try again later.");
  }
}
