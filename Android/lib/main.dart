import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:ium_project/controller/home_controller.dart';
import 'package:ium_project/routes/routes.dart';

dynamic token;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  token = await FlutterSession().get('token');
  if(token != null && token.toString().length>2) {
    HomeController.username.value = token as String;
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Route Managment',
      initialRoute: '/splash',
      getPages: appRoutes(),
    );
  }
}