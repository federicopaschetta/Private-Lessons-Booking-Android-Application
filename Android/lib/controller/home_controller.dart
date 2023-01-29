import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var tabIndex = 1.obs;

  static var username = ''.obs;
  static var name = ''.obs;
  static var surname = ''.obs;
  static var role = ''.obs;


  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void getUserInfo() async {
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletUserInfo';
    var response = await http.post(Uri.parse(url), body: {"Username": username.value});
    role.value = jsonDecode(response.body)['Role'];
    name.value = jsonDecode(response.body)['Name'];
    surname.value = jsonDecode(response.body)['Surname'];
  }

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

}