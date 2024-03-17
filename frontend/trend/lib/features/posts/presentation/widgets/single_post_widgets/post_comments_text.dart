import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/config/locale/app_localizations.dart';

class PostCommentsText extends StatefulWidget {
  const PostCommentsText({
    Key? key,
  }) : super(key: key);

  @override
  State<PostCommentsText> createState() => _PostCommentsTextState();
}

class _PostCommentsTextState extends State<PostCommentsText> {
  final List post = [];
  @override
  Widget build(BuildContext context) {
    return post.isEmpty
        ? Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 12.sp),
            child: Text(
              "No comments yet.".hardcoded,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall!.color!,
                fontSize: 12.sp,
              ),
            ),
          )
        : GestureDetector(
            onTap: () async {},
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 12.sp),
              child: Text(
                'View all ${post.length} comment'.hardcoded,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall!.color!,
                  fontSize: 12.sp,
                ),
              ),
            ),
          );
  }
}
