import 'package:async_and_await/controller/root_page.dart';
import 'package:async_and_await/view/pages/sign_in_page.dart';
import 'package:async_and_await/view/pages/sign_up_page.dart';
import 'package:async_and_await/view/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter routes = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      }),
  GoRoute(
      path: '/root',
      builder: (context, state) {
        return const RootPage();
      }),
  // GoRoute(
  //     path: '/sign_in',
  //     builder: (context, state) {
  //       return const SignInPage();
  //     }),
  // GoRoute(
  //     path: '/sign_up',
  //     builder: (context, state) {
  //       return const SignUpPage();
  //     }),
]);
