import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/core/widgets/custom_cached_image.dart';

class ProfileImageAndCoverWidget extends StatelessWidget {
  const ProfileImageAndCoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: double.infinity,
          height: 300.sp,
        ),
        CustomCachedImageWidget(
            size: double.infinity,
            height: 240.sp,
            radius: 0,
            imageUrl:
                "https://images.unsplash.com/photo-1710336723033-bfae8216b139?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyM3x8fGVufDB8fHx8fA%3D%3D"),
        Positioned(
            top: 160.sp,
            child: CustomCachedImageWidget(
                addBorder: true,
                size: 140.sp,
                radius: 100.sp,
                imageUrl:
                    "https://www.thefashionisto.com/wp-content/uploads/2021/03/Attractive-Man-Selfie-Sunglasses-Smiling.jpg")),
      ],
    );
  }
}
