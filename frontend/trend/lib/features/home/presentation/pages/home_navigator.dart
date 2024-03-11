// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
    final sharedPref = sl<SharedPref>();
    return WillPopScope(
      onWillPop: () async {
        if (location.startsWith(Routes.posts)) return true;

        context.go(Routes.posts);
        return false;
      },
      child: Scaffold(
        extendBody: false,
        bottomNavigationBar: Card(
          elevation: 8,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              tabBorderRadius: 20,
              activeColor: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).hintColor,
              selectedIndex: _mapLocationToIndex(location),
              onTabChange: _onTabChanged,
              iconSize: 30,
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  gap: 10,
                  leading: IconTheme(
                      data: IconThemeData(
                        size: 32,
                        color: location.startsWith(Routes.posts)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).hintColor,
                      ),
                      child: const Icon(
                        Icons.home_outlined,
                      )),
                ),
                GButton(
                  icon: Icons.search,
                  gap: 10,
                  leading: IconTheme(
                      data: IconThemeData(
                        size: 32,
                        color: location.startsWith(Routes.explore)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).hintColor,
                      ),
                      child: const Icon(
                        Icons.search,
                      )),
                ),
                GButton(
                  icon: MdiIcons.plus,
                  gap: 10,
                  leading: IconTheme(
                      data: IconThemeData(
                        size: 32,
                        color: location.startsWith(Routes.camera)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).hintColor,
                      ),
                      child: Icon(
                        MdiIcons.plus,
                      )),
                ),
                GButton(
                  icon: MdiIcons.videoOutline,
                  gap: 10,
                  leading: IconTheme(
                      data: IconThemeData(
                        size: 32,
                        color: location.startsWith(Routes.vlog)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).hintColor,
                      ),
                      child: Icon(
                        MdiIcons.videoOutline,
                      )),
                ),
                GButton(
                  icon: MdiIcons.accountOutline,
                  gap: 10,
                  leading: IconTheme(
                      data: IconThemeData(
                        size: 32,
                        color: location.startsWith(Routes.profile)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).hintColor,
                      ),
                      child: Icon(MdiIcons.accountOutline)),
                ),
              ],
            ),
          ),
        ),
        body: widget.child,
      ),
    );
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
