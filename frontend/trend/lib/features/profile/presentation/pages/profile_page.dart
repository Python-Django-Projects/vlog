import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:trend/config/routes/app_routes.dart';
import 'package:trend/core/resources/assets_manager.dart';
import 'package:trend/features/profile/presentation/widgets/profile_buttons.dart';
import 'package:trend/features/profile/presentation/widgets/profile_posts.dart';
import '../widgets/profile_image_and_cover.dart';
import '../widgets/profile_informations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                    actions: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.sp),
                        child: IconButton(
                            onPressed: () {
                              context.go(Routes.settings);
                            },
                            icon: SvgPicture.asset(
                              ImgAssets.settingsIconSVG,
                              colorFilter: const ColorFilter.mode(
                                  Colors.black, BlendMode.srcIn),
                            )),
                      )
                    ],
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
