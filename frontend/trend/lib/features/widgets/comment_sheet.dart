import 'package:flutter/material.dart';
import 'package:trend/features/posts/data/models.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet(
      {super.key,
      required this.post,
      required this.description,
      required this.image});
  final PostModel post;
  final String description;
  final String image;

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Comment',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
          ),
          const Divider(
            thickness: 0.3,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.post.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.post.description),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.post.image),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(widget.post.description),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
