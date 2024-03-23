import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:trend/core/utils/app_divider.dart';

class ModalSheetUtils {
  final BuildContext context;

  ModalSheetUtils(this.context);

  void showCustomModalSheet({
    required Widget child,
    double? height,
    required String title,
    required String? assetImageUrl,
  }) {
    showModalBottomSheet(
      enableDrag: true,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return _CustomModalSheet(
          title: title,
          assetImageUrl: assetImageUrl,
          height: height,
          child: child,
        );
      },
    );
  }
}

class _CustomModalSheet extends StatefulWidget {
  final String title;
  final String? assetImageUrl;
  final Widget child;
  final double? height;

  const _CustomModalSheet({
    Key? key,
    required this.title,
    required this.child,
    required this.height,
    this.assetImageUrl,
  }) : super(key: key);

  @override
  __CustomModalSheetState createState() => __CustomModalSheetState();
}

class __CustomModalSheetState extends State<_CustomModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.sp),
        child: SizedBox(
          height: widget.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.sp),
              Container(
                height: 6.sp,
                width: 55.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200.sp),
                  color: Theme.of(context).textTheme.headlineSmall?.color,
                ),
              ),
              Gap(20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.assetImageUrl != null)
                    SvgPicture.asset(
                      widget.assetImageUrl!,
                      height: 25.sp,
                      width: 25.sp,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).textTheme.displayLarge!.color!,
                          BlendMode.srcIn),
                    ),
                  if (widget.assetImageUrl != null) SizedBox(width: 4.sp),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.displayLarge!.color!,
                    ),
                  ),
                ],
              ),
              Gap(4.sp),
              const AppDivider(),
              Expanded(
                child: SingleChildScrollView(child: widget.child),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
