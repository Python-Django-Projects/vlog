import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class TakenImagePreviewPage extends StatefulWidget {
  final XFile file;
  const TakenImagePreviewPage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<TakenImagePreviewPage> createState() => _TakenImagePreviewPageState();
}

class _TakenImagePreviewPageState extends State<TakenImagePreviewPage> {
  bool _isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  void peformAddPost() async {
    setState(() {
      _isLoading = true;
    });
    // await addPost(
    //     File(widget.file.path),
    //     _descriptionController.text.isEmpty ? "" : _descriptionController.text,
    //     context);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add post",
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: () => peformAddPost(),
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
          )
        ],
      ),
      // POST FORM
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (_isLoading) const LinearProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      File(widget.file.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        hintText: "Write a caption...",
                        border: InputBorder.none),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
