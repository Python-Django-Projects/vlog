import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () async {},
                    child: CustomCachedImageWidget(
                      addBorder: true,
                      size: 38.sp,
                      imageUrl:
                          "https://www.thefashionisto.com/wp-content/uploads/2021/03/Attractive-Man-Selfie-Sunglasses-Smiling.jpg",
                    ),
                  )),
              SizedBox(width: 10.sp),
              GestureDetector(
                onTap: () async {},
                child: Text(
                  "rabeeomran",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  padding: EdgeInsets.all(8.sp),
                  onPressed: () => _showPostMenuModal(context),
                  icon: SvgPicture.asset(
                    ImgAssets.threeDotsIconSVG,
                    width: 4.sp,
                    height: 4.sp,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.displayLarge!.color!,
                        BlendMode.srcIn),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
