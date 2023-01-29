import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ium_project/components/course.dart';
import 'package:ium_project/components/lesson.dart';
import 'package:ium_project/components/teachers.dart';
import 'package:http/http.dart' as http;

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExplorePage();
  }
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<StatefulWidget> createState() => ExplorePageState();

}

class ExplorePageState extends State<ExplorePage> {

  static List<String> coursesTitleList = [];
  static List<String> teachersList = [];
  static List<dynamic> lessonsList = [];


  static const kBlue = Color(0xFF122b62);
  static const kWhite = Colors.white;
  static const kTurquoise = Color(0xFFa7d5c5);


  @override
  void initState() {
    super.initState();
    populateCourses();
    populateTeachers();
    populateAvailableLessons();
  }
  void populateCourses() async {
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletCorsi';
    var response = await http.get(Uri.parse(url));
    List<dynamic> coursesList = jsonDecode(response.body);
    coursesTitleList = [];
    for(var course in coursesList) {
      coursesTitleList.add(course['Title']);
    }
    setState(() {});
  }

  void populateTeachers() async {
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletDocenti';
    var response = await http.get(Uri.parse(url));
    List<dynamic> responseList = jsonDecode(response.body);
    teachersList = [];
    for(var teacher in responseList) {
      teachersList.add(teacher['Surname']+', '+teacher['Name']);
    }
    setState(() {});
  }
  void populateAvailableLessons() async {
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletLezioni';
    var response = await http.get(Uri.parse(url));
    lessonsList = jsonDecode(response.body);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget> [
                const Padding(
                  padding: EdgeInsets.only(top:25, left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Esplora',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: kBlue
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'I nostri corsi',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kBlue
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: <Widget> [
                    for (var course in coursesTitleList)
                      Course(title: course)
                  ],
                ),
                const SizedBox(height: 100),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'I nostri docenti',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kBlue
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: <Widget> [
                    for (var teacher in teachersList)
                      Teacher(teacher: teacher)
                  ],
                ),

                const SizedBox(height: 100),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Le lezioni disponibili',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kBlue
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Column(
                  children: <Widget> [
                    for (var lesson in lessonsList)
                      Lesson(course: lesson['course'], teacher: lesson['teacherName']+' '+lesson['teacherSurname'], day: lesson['day'], time: lesson['time'], state: -1)
                  ],
                )
              ],
            ),
          ),
      //  )
    );
  }
}