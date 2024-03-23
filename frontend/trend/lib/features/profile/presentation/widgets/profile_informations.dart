import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/resources/color_manager.dart';

class ProfileInformationsWidget extends StatelessWidget {
  const ProfileInformationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "rabeeomran",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Theme.of(context).textTheme.displayLarge?.color),
          ),
        ),
        Gap(8.sp),
        SizedBox(
          width: 303.sp,
          child: Center(
            child: Text(
              "I’d rather regret the things I’ve done than regret the things I haven’t done",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: kGreyColor2,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Gap(12.sp),
        SizedBox(
          width: 320.sp,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildStatis(context, "Posts".hardcoded, "125", () {}),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 25.sp),
                child:
                    _buildStatis(context, "Followers".hardcoded, "290", () {}),
              ),
              _buildStatis(context, "Following".hardcoded, "2500", () {}),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector _buildStatis(
      BuildContext context, String title, String count, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.displayLarge?.color),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: kGreyColor2,
            ),
          ),
        ],
      ),
    );
  }
}
