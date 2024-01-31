import 'package:flutter/material.dart';

class _CommentSheet extends StatelessWidget {
  _CommentSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Comment',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
          ),
          Container(
            color: Colors.red,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 21,
                ),
                // Text(widget.post.description),
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
