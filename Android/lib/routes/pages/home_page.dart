import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ium_project/controller/home_controller.dart';
import 'package:ium_project/routes/pages/explore_page.dart';

import 'book_lesson.dart';
import 'book_lesson_page.dart';
import 'my_bookings_page.dart';
import 'user_page.dart';

class HomePage extends StatelessWidget {

  static const kBlue = Color(0xFF122b62);
  static const kWhite = Colors.white;
  static const kTurquoise = Color(0xFFa7d5c5);

  final TextStyle selectedLabelStyle = const TextStyle(color: kTurquoise, fontWeight: FontWeight.w500, fontSize: 12);
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);


  HomePage({super.key});

  buildBottomNavigationMenu(context, homeController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: homeController.changeTabIndex,
            currentIndex: homeController.tabIndex.value,
            backgroundColor: kBlue,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: kTurquoise,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(top: 3, bottom: 7),
                    child: const Icon(
                      Icons.calendar_month,
                      size: 22.0
                    ),
                  ),
                  label: 'Prenota',
                  backgroundColor: kBlue
              ),
              BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(top:3, bottom: 7),
                    child: const Icon(
                        Icons.public,
                        size: 22.0
                    ),
                  ),
                  label: 'Esplora',
                  backgroundColor: kBlue
              ),
              BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(top: 3, bottom: 7),
                    child: const Icon(
                        Icons.book,
                        size: 22.0
                    ),
                  ),
                  label: HomeController.role.value == 'cliente' ? 'Le mie lezioni' : 'Tutte le lezioni',
                  backgroundColor: kBlue
              ),
              BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(top: 3, bottom: 7),
                    child: const Icon(
                        Icons.account_circle,
                        size: 22.0
                    ),
                  ),
                  label: 'Account',
                  backgroundColor: kBlue
              )
            ],
          ),
        )
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController(), permanent: false);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Image.asset('assets/images/writing2.png', fit:BoxFit.cover, height: 48)
          ),
          backgroundColor: kBlue,
        ),
        body: SafeArea(
            child: Scaffold(
              bottomNavigationBar: buildBottomNavigationMenu(context, homeController),
              body: Obx(() => IndexedStack(
                index: homeController.tabIndex.value,
                children: [
                  const BookLesson(),
                  const ExplorePage(),
                  const MyBookings(),
                  UserPage()
                ],
              )
              ),
            ),
        ),
      ),
    );
  }

}

