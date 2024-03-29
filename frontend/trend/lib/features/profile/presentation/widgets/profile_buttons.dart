import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:trend/core/resources/color_manager.dart';
import 'package:trend/features/profile/presentation/widgets/single_profile_button.dart';

class ProfileButtonsWidget extends StatelessWidget {
  const ProfileButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: SingleProfileButtonWidget(
            title: "Follow",
            onPressed: () {},
            backgroundColor: Theme.of(context).primaryColor,
            titleColor: kWhiteColor,
          )),
          Gap(20.sp),
          Expanded(
              child: SingleProfileButtonWidget(
                  title: "Share profile", onPressed: () {})),
        ],
      ),
    );
  }
}
