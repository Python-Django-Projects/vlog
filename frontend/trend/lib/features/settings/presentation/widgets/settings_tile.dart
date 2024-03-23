import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsTileWidget extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final Color? titleColor;
  final bool showTrailing;
  final String? iconIAssetUrl;
  const SettingsTileWidget({
    Key? key,
    this.onTap,
    required this.title,
    this.titleColor,
    this.showTrailing = true,
    this.iconIAssetUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      dense: true,
      horizontalTitleGap: 12.sp,
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 14.sp, color: titleColor, fontWeight: FontWeight.w500),
      ),
      leading: iconIAssetUrl != null
          ? SvgPicture.asset(
              iconIAssetUrl!,
              height: 25.sp,
              width: 25.sp,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.displayLarge!.color!,
                  BlendMode.srcIn),
            )
          : null,
      trailing: showTrailing
          ? Icon(
              Icons.arrow_forward_ios,
              size: 18.sp,
            )
          : null,
    );
  }
}
