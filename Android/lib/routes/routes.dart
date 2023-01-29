import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:get/get.dart';
import 'package:ium_project/routes/pages/book_lesson.dart';
import 'package:ium_project/routes/pages/book_lesson_page.dart';
import 'package:ium_project/routes/pages/my_bookings_page.dart';
import 'package:ium_project/routes/pages/explore_page.dart';
import 'package:ium_project/routes/pages/home_page.dart';
import 'package:ium_project/routes/pages/login_page.dart';
import 'package:ium_project/routes/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


appRoutes() => [
  GetPage(
    name: '/splash',
    page: () => const Splash(),
    transition: Transition.zoom,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
      name: '/home',
      page: () => HomePage(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/login',
    page: () => const Login(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/explore',
    page: () => ExplorePage(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/mybookings',
    page: () => MyBookings(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/booklesson',
    page: () => BookLesson(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}