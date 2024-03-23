// ignore_for_file: deprecated_member_use, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/resources/assets_manager.dart';
import 'package:trend/core/resources/color_manager.dart';
import 'package:trend/core/widgets/custom_cached_image.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/shared_pref.dart';
import '../../../../injection_container.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final isVlog = location.contains("vlog");

    final sharedPref = sl<SharedPref>();
    return WillPopScope(
      onWillPop: () async {
        if (location.startsWith(Routes.posts)) return true;

        context.go(Routes.posts);
        return false;
      },
      child: Scaffold(
        extendBody: false,
        bottomNavigationBar: location == Routes.camera
            ? const SizedBox()
            : Container(
                decoration: BoxDecoration(
                  color: isVlog ? Colors.black : Colors.transparent,
                  // border: Border(
                  //     top: BorderSide(
                  //         color: Theme.of(context).highlightColor, width: .5.sp)),
                ),
                child: Card(
                  color: isVlog ? Colors.black : Colors.transparent,
                  elevation: 0.sp,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 14.sp),
                    child: GNav(
                      backgroundColor:
                          isVlog ? Colors.black : Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 8.sp),
                      tabBorderRadius: 20.sp,
                      activeColor:
                          Theme.of(context).textTheme.displayLarge?.color,
                      color: Theme.of(context).hintColor,
                      selectedIndex: _mapLocationToIndex(location),
                      onTabChange: _onTabChanged,
                      iconSize: 30.sp,
                      tabs: [
                        _buildTab(
                            context: context,
                            title: "Home".hardcoded,
                            assetUrl: ImgAssets.homeIconSVG,
                            route: Routes.posts),
                        _buildTab(
                            context: context,
                            title: "Search".hardcoded,
                            assetUrl: ImgAssets.searchIconSVG,
                            route: Routes.explore),
                        _buildTab(
                            context: context,
                            title: "Camera".hardcoded,
                            assetUrl: ImgAssets.addIconSVG,
                            route: Routes.camera),
                        _buildTab(
                            context: context,
                            height: 25.sp,
                            title: "Vlog".hardcoded,
                            assetUrl: ImgAssets.videoIconSVG,
                            route: Routes.vlog),
                        _profileTab(context, location),
                      ],
                    ),
                  ),
                ),
              ),
        body: widget.child,
      ),
    );
  }

  GButton _profileTab(BuildContext context, String location) {
    return _buildTab(
        context: context,
        title: "",
        assetUrl: "",
        child: Column(
          children: [
            SizedBox(height: 3.sp),
            CustomCachedImageWidget(
                size: 23.sp,
                imageUrl:
                    "https://www.thefashionisto.com/wp-content/uploads/2021/03/Attractive-Man-Selfie-Sunglasses-Smiling.jpg"),
            SizedBox(height: 5.sp),
            Text(
              "Profile".hardcoded,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: _getTabColor(Routes.profile),
              ),
            )
          ],
        ),
        route: Routes.profile);
  }

  GButton _buildTab(
      {required BuildContext context,
      required String title,
      required String assetUrl,
      required String route,
      Widget? child,
      double? height,
      double? width}) {
    return GButton(
      icon: Icons.home_outlined,
      gap: 10.sp,
      leading: IconTheme(
          data: IconThemeData(
            color: _getTabColor(route),
          ),
          child: child ??
              Column(
                children: [
                  SizedBox(
                    height: height ?? 25.sp,
                    child: SvgPicture.asset(
                      assetUrl,
                      color: _getTabColor(route),
                      height: height ?? 25.sp,
                      width: width,
                    ),
                  ),
                  SizedBox(
                      height: height != null ? height - 25.sp + 4.sp : 4.sp),
                  Text(
                    title.hardcoded,
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: _getTabColor(route)),
                  )
                ],
              )),
    );
  }

  Color _getTabColor(String route) {
    final location = GoRouterState.of(context).uri.toString();
    final isVlog = location.startsWith("/vlog");
    if (isVlog) {
      return route.startsWith("/vlog") ? Colors.white : kGreyColor;
    }
    return location.startsWith(route)
        ? Theme.of(context).textTheme.displayLarge!.color!
        : Theme.of(context).textTheme.headlineMedium!.color!;
  }

  int _mapLocationToIndex(String location) {
    if (location.startsWith(Routes.posts)) {
      return 0;
    }
    if (location.startsWith(Routes.explore)) {
      return 1;
    }

    if (location.startsWith(Routes.camera)) {
      return 2;
    }

    if (location.startsWith(Routes.vlog)) {
      return 3;
    }

    if (location.startsWith(Routes.profile)) {
      return 4;
    }

    return 0;
  }

  void _onTabChanged(int value) {
    switch (value) {
      case 0:
        GoRouter.of(context).go(Routes.posts);
      case 1:
        GoRouter.of(context).go(Routes.explore);
      case 2:
        GoRouter.of(context).go(Routes.camera);
      case 3:
        GoRouter.of(context).go(Routes.vlog);
      case 4:
        GoRouter.of(context).go(Routes.profile);
    }
  }
}
