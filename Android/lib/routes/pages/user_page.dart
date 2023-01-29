import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:ium_project/controller/home_controller.dart';
import 'package:ium_project/routes/pages/login_page.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:get/get.dart';


class UserPage extends StatelessWidget {

  static const kBlue = Color(0xFF122b62);
  static const kWhite = Colors.white;
  static const kTurquoise = Color(0xFFa7d5c5);

HomeController homeController = HomeController();

  UserPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40, left:10, right:10),
        child: Column(
          children: <Widget> [
              const Center(
                child: Icon(
                    Icons.account_circle,
                    size: 60,
                    color: kBlue,
                )
                ),
              Padding(
                padding: const EdgeInsets.only(top:10, bottom:10),
                child: Center(
                  child: Obx(() => Text(HomeController.username.value,
                    style: const TextStyle(
                        color: kBlue,
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),
                  )
                )
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Center(
                  child: Obx(() => Text('${HomeController.name.value} ${HomeController.surname.value}',
                    style: const TextStyle(
                        color: kBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  )
                  )
              ),
            ),
              const Divider(
                height: 10,
                thickness: 1,
                indent: 40,
                endIndent: 40,
                color: kBlue,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top:20, left:20),
                  child: SettingsList(
                      lightTheme: const SettingsThemeData(
                        settingsListBackground: kWhite
                      ),
                      sections: [
                        SettingsSection(
                            tiles: <SettingsTile>[
                              SettingsTile(
                                  leading: const Icon(Icons.logout, color: kBlue,),
                                  title: const Text('Logout', style: TextStyle(color: kBlue)),
                                  onPressed: (context) async {
                                    await FlutterSession().set('token', '');
                                    Get.to(const LoginPage());
                                  }
                              )
                            ]
                        )
                      ]
                  ),
                ),
              )
          ],
        ),
      )
    );
  }
}