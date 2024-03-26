import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleProfileButtonWidget extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final Function()? onPressed;

  const SingleProfileButtonWidget({
    Key? key,
    required this.title,
    required this.onPressed,
    this.titleColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(1.sp, 25.sp),
            elevation: 0,
            backgroundColor: backgroundColor ??
                Theme.of(context).textTheme.bodyLarge?.color),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 0.sp),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: titleColor ??
                    Theme.of(context).textTheme.displayLarge?.color),
          ),
        ));
  }
}
