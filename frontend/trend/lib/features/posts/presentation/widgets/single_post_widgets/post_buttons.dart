import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/resources/assets_manager.dart';

class PostButtons extends StatefulWidget {
  const PostButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<PostButtons> createState() => _PostButtonsState();
}

class _PostButtonsState extends State<PostButtons> {
  @override
  Widget build(BuildContext context) {
    final postBtnsStyle = TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: Theme.of(context).textTheme.bodyMedium!.color!);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImgAssets.heartIconSVG,
                  width: 20.7.sp,
                  height: 20.7.sp,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyMedium!.color!,
                      BlendMode.srcIn),
                ),
                SizedBox(width: 5.sp),
                Text(
                  "Like".hardcoded,
                  style: postBtnsStyle,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImgAssets.commentsIconSVG,
                  width: 17.7.sp,
                  height: 17.7.sp,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyMedium!.color!,
                      BlendMode.srcIn),
                ),
                SizedBox(width: 5.sp),
                Text(
                  "Comments".hardcoded,
                  style: postBtnsStyle,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImgAssets.shareIconSVG,
                  width: 17.7.sp,
                  height: 17.7.sp,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyMedium!.color!,
                      BlendMode.srcIn),
                ),
                SizedBox(width: 5.sp),
                Text(
                  "Share".hardcoded,
                  style: postBtnsStyle,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
