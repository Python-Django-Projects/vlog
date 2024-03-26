import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:trend/features/profile/presentation/widgets/profile_posts.dart';
import '../widgets/profile_buttons.dart';
import '../widgets/profile_image_and_cover.dart';
import '../widgets/profile_informations.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  const ProfileImageAndCoverWidget(),
                  AppBar(
                    backgroundColor: Colors.transparent,
                    actions: const [],
                  )
                ],
              ),
              Gap(8.sp),
              const ProfileInformationsWidget(),
              Gap(8.sp),
              const ProfileButtonsWidget(),
              Gap(8.sp),
              const ProfilePostsWidget()
            ],
          ),
        ),
      ),
    );
  }
}
