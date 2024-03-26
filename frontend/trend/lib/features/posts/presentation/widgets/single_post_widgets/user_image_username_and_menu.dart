import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trend/config/routes/app_routes.dart';
import 'package:trend/core/resources/assets_manager.dart';

import '../../../../../core/widgets/custom_cached_image.dart';

class UserImageAndUsernameAndMenu extends StatefulWidget {
  const UserImageAndUsernameAndMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<UserImageAndUsernameAndMenu> createState() =>
      _UserImageAndUsernameAndMenuState();
}

class _UserImageAndUsernameAndMenuState
    extends State<UserImageAndUsernameAndMenu> {
  _showPostMenuModal(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 12.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              context.go(Routes.userProfile);
            },
            child: Row(
              children: [
                CustomCachedImageWidget(
                  addBorder: true,
                  size: 38.sp,
                  imageUrl:
                      "https://www.thefashionisto.com/wp-content/uploads/2021/03/Attractive-Man-Selfie-Sunglasses-Smiling.jpg",
                ),
                SizedBox(width: 10.sp),
                Text(
                  "rabeeomran",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Theme.of(context).textTheme.displayLarge!.color!),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: () => _showPostMenuModal(context),
              child: SvgPicture.asset(
                ImgAssets.threeDotsIconSVG,
                width: 4.sp,
                height: 4.sp,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).textTheme.displayLarge!.color!,
                    BlendMode.srcIn),
              ))
        ],
      ),
    );
  }
}
