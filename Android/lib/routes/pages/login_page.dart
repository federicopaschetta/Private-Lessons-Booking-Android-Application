import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:ium_project/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  const Login ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  static const kBlue = Color(0xFF122b62);
  static const kWhite = Colors.white;
  static const kTurquoise = Color(0xFFa7d5c5);

  String username = '';
  String password = '';


  void loginFunction() async {
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletAutentica';
    var response = await http.post(
        Uri.parse(url), body: {"loginUsername":username, "loginPassword":password}
    );
    var role = jsonDecode(response.body)['Role'];
    if(role != null) {
      HomeController.username.value = username;
      HomeController.role.value = role;
      HomeController.name.value = jsonDecode(response.body)['Name'];
      HomeController.surname.value = jsonDecode(response.body)['Surname'];
      await FlutterSession().set('token', username);
      Get.toNamed('/home');
    }
  }


  @override
  Widget build (BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlue,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 140.0, horizontal: 15.0),
        child: Expanded(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 0, bottom: 15.0),
                child: Text('Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: TextField(
                  onChanged: (newText) {username = newText;},
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kTurquoise)
                    ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kTurquoise)
                      ),
                    labelText: 'Username',
                      labelStyle: TextStyle(color: kTurquoise)
                  ),
                  style: const TextStyle(
                    color: kTurquoise
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:15.0, right:15.0, top: 15.0, bottom: 0),
                child: TextField(
                  onChanged: (newText) {password = newText;},
                  obscureText: true,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kTurquoise)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kTurquoise)
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: kTurquoise)
                  ),
                  style: const TextStyle(
                    color: kTurquoise
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: kTurquoise, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    loginFunction();
                    },
                  child: const Text(
                    'Accedi',
                    style: TextStyle(color: kWhite, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                width: 125,
                decoration: BoxDecoration(
                    color: kWhite, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    loginFunction();
                    },
                  child: const Text(
                    'Registrati',
                    style: TextStyle(color: kBlue, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
