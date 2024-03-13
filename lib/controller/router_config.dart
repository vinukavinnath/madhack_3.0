import 'package:async_and_await/controller/root_page.dart';
import 'package:async_and_await/view/pages/account_type.dart';
import 'package:async_and_await/view/pages/forgot_password.dart';
import 'package:async_and_await/view/pages/home_page_applicant.dart';
import 'package:async_and_await/view/pages/home_page_employer.dart';
import 'package:async_and_await/view/pages/sign_in_page.dart';
import 'package:async_and_await/view/pages/sign_up_page.dart';
import 'package:async_and_await/view/pages/splash_screen.dart';
import 'package:async_and_await/view/pages/verify_account.dart';
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
        return const SignInPage();
      }),
  GoRoute(
      path: '/sign_in',
      builder: (context, state) {
        return const SignInPage();
      }),
  GoRoute(
      path: '/sign_up',
      builder: (context, state) {
        return const SignUpPage();
      }),
  GoRoute(
      path: '/forgot_password',
      builder: (context, state) {
        return const ForgotPassword();
      }),
  GoRoute(
      path: '/home_applicant',
      builder: (context, state) {
        return const HomePageApplicant();
      }),
  GoRoute(
      path: '/home_employer',
      builder: (context, state) {
        return const HomePageEmployer();
      }),
  GoRoute(
      path: '/verify_account',
      builder: (context, state) {
        return const VerifyAccount();
      }),
  GoRoute(
      path: '/choose_type',
      builder: (context, state) {
        return const AccountType();
      }),
]);
