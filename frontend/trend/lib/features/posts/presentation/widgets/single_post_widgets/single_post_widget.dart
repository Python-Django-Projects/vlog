import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'post_comments_text.dart';
import 'post_media_widget.dart';
import 'post_username_and_description.dart';
import 'user_image_username_and_menu.dart';
import 'post_buttons.dart';
import 'post_likes.dart';

class SinglePostWidget extends StatefulWidget {
  const SinglePostWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SinglePostWidget> createState() => _SinglePostWidgetState();
}

class _SinglePostWidgetState extends State<SinglePostWidget>
    with SingleTickerProviderStateMixin {
  int currentImageIndex = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserImageAndUsernameAndMenu(),
        SizedBox(height: 3.sp),
        const PostMediaWidget(),
        SizedBox(height: 10.sp),
        const PostButtons(),
        SizedBox(height: 10.sp),
        Divider(
          thickness: 0.1.sp,
          height: 0.1.sp,
        ),
        SizedBox(height: 10.sp),
        const PostLikes(),
        SizedBox(height: 2.sp),
        const PostUsernameAndDescription(),
        const PostCommentsText(),
        SizedBox(height: 8.sp)
      ],
    );
  }
}
