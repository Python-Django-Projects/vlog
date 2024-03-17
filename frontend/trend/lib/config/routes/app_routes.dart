import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trend/features/home/camera/camera_page.dart';
import 'package:trend/features/posts/presentation/explore_page.dart';
import 'package:trend/features/profile/presentation/profile_page.dart';
import '../../core/utils/shared_pref.dart';
import '../../features/authentication/presentation/bloc/auth_bloc/auth_bloc.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_initial_page.dart';
import '../../features/home/presentation/pages/home_navigator.dart';
import '../../features/posts/presentation/posts_page.dart';
import '../../features/vlogs/presentation/pages/vlogs_page.dart';
import '../../injection_container.dart';
import '../locale/app_localizations.dart';

class Routes {
  static String initialPage = '/';
  static String posts = '/posts';
  static String explore = '/explore';
  static String camera = '/camera';
  static String vlog = '/vlog';
  static String profile = '/profile';
  static String login = '/login';
  static String signUp = '/login/signUp';
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final SharedPref _sharedPref = sl<SharedPref>();

void logout() async {
  try {
    await _sharedPref.clear();
  } catch (e) {
    debugPrint(e.toString());
  }

  router.go(Routes.login);
}

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.initialPage,
  routes: [
    GoRoute(
      path: Routes.initialPage,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeInitialPage()),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => HomeNavigator(
        child: child,
      ),
      routes: [
        GoRoute(
          path: Routes.posts,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PostsPage(),
          ),
          routes: const [],
        ),
        GoRoute(
          path: Routes.vlog,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: VlogsPage(),
          ),
        ),
        GoRoute(
          path: Routes.explore,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ExplorePage(),
          ),
        ),
        GoRoute(
          path: Routes.camera,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: CameraPage(),
          ),
          routes: const [],
        ),
      ],
    ),
    GoRoute(
      path: '/profile',
      name: 'Profile',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => const SlideTransitionPage(
        child: ProfilePage(),
      ),
      routes: const [],
    ),
    GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const LoginPage(),
            ),
        routes: [
          GoRoute(
            path: 'signUp',
            pageBuilder: (context, state) => SlideTransitionPage(
                child: BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const RegisterPage(),
            )),
          ),
        ]),
  ],
  redirect: (context, state) {
    if (!state.uri.toString().startsWith('/login') && !_sharedPref.isLoggedIn) {
      return '/login';
    }

    return null;
  },
  errorPageBuilder: (context, state) =>
      const NoTransitionPage(child: PageNotFound()),
);

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Page Not Found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextButton(
                onPressed: () {
                  if (GoRouter.of(context).canPop()) {
                    Navigator.pop(context);
                  } else {
                    context.go(Routes.posts);
                  }
                },
                child: Text(GoRouter.of(context).canPop()
                    ? 'Back'.hardcoded
                    : 'Home'.hardcoded),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SlideTransitionPage<T> extends CustomTransitionPage<T> {
  const SlideTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(
          transitionsBuilder: _transitionsBuilder,
          transitionDuration: const Duration(milliseconds: 300),
        );

  static Widget _transitionsBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    final begin = AppLocalizations.of(context)!.isRTL
        ? const Offset(-1.0, 0.0)
        : const Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: tween.animate(animation),
      child: child,
    );
  }
}
