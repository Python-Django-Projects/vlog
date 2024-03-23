import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/extenstions/media_query_values.dart';
import '../../../../../core/utils/timeago_utils.dart';
import '../../../../../core/widgets/custom_cached_image.dart';

class PostLikes extends StatefulWidget {
  const PostLikes({
    Key? key,
  }) : super(key: key);

  @override
  State<PostLikes> createState() => _PostLikesState();
}

class _PostLikesState extends State<PostLikes> {
  final List post = [];

  Widget _buildLikesPersonAvtars() {
    if (post.isEmpty) {
      return const SizedBox();
    } else if (post.length == 1) {
      return Padding(
        padding: EdgeInsetsDirectional.only(end: 5.sp),
        child: CustomCachedImageWidget(
            size: 18.sp, radius: 50.sp, imageUrl: post.first.userImageUrl),
      );
    } else {
      return Padding(
        padding: EdgeInsetsDirectional.only(end: 2.5.sp),
        child: Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            SizedBox(width: 35.sp),
            CustomCachedImageWidget(
                size: 18.sp, radius: 50.sp, imageUrl: post.first.userImageUrl),
            PositionedDirectional(
              start: 10.sp,
              bottom: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.sp),
                    border: Border.all(
                      width: 2.sp,
                    )),
                child: SizedBox(
                  height: 50.sp,
                  width: 50.sp,
                ),
              ),
            ),
            PositionedDirectional(
              start: 12.sp,
              child: CustomCachedImageWidget(
                  size: 18.sp,
                  radius: 50.sp,
                  imageUrl: post.toList()[1].userImageUrl),
            ),
          ],
        ),
      );
    }
  }

  SizedBox _buildLikes() {
    return SizedBox(
      height: 21.sp,
      child: Row(
        children: [
          _buildLikesPersonAvtars(),
          Text(
            _buildLikeText(),
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  String _buildLikeText() {
    if (post.isEmpty) {
      return '${post.length.toString()} likes'.hardcoded;
    }
    if (post.length == 1) {
      return '${post.length.toString()} like'.hardcoded;
    } else {
      return '${post.length.toString()} likes'.hardcoded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              if (post.isNotEmpty) {}
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.sp),
              child: _buildLikes(),
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(end: 12.sp),
            child: Text(
              TimeAgo.format(DateTime.now().subtract(const Duration(days: 2))),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall!.color!,
                  fontSize: 12.sp,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
