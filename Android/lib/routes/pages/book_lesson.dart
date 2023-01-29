import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ium_project/controller/home_controller.dart';
import 'package:http/http.dart' as http;


const kBlue = Color(0xFF122b62);
const kWhite = Color(0xFFF6F6F6);
const kTurquoise = Color(0xFFa7d5c5);

class BookLesson extends StatefulWidget {
  const BookLesson({super.key});



  @override
  State<StatefulWidget> createState() => _BookLessonState();
}

class _BookLessonState extends State<BookLesson> {
  @override
  void initState() {
    _getCoursesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Prenota una lezione',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: kBlue
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top:20, bottom: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              height: 40, width: 40, decoration: const BoxDecoration(color: kWhite),
                                child: const Padding(
                                    padding: EdgeInsets.only(top: 20, left: 10, bottom: 10, right: 10),
                                    child: Icon(Icons.book, color: kBlue, size: 40,))
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    value: selectedCourse,
                                    icon: const Icon(Icons.arrow_drop_down, color:kBlue),
                                    style: const TextStyle(
                                      color: kBlue,
                                    ),
                                    elevation: 16,
                                    underline: Container(
                                      height: 2,
                                      color: kTurquoise
                                    ),
                                    hint: const Text("Seleziona il corso", style: TextStyle(fontStyle: FontStyle.italic, color: kTurquoise),),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCourse = newValue;
                                        _getTeachersList();
                                      });
                                    },
                                    items: coursesList.map((item) {
                                      return DropdownMenuItem(
                                        value: item['Title'].toString(),
                                        child: Text(item['Title'], style: const TextStyle(fontSize: 22, color: kBlue, fontWeight: FontWeight.bold)),
                                      );
                                    }).toList() ??
                                        [],
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 15, bottom: 5),
                                child: Text('Corso', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400)),
                              ),
                              const Divider(color: kTurquoise, thickness: 1, indent: 10, endIndent: 50),
                            ],
                            ),
                          )
                        ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 40, width: 40, decoration: const BoxDecoration(color: kWhite),
                              child: const Padding(padding: EdgeInsets.only(top: 20, left: 10, bottom: 10, right: 10),
                              child: Icon(Icons.person, color: kBlue, size: 40,))),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    value: selectedTeacher,
                                    icon: const Icon(Icons.arrow_drop_down, color:kBlue),
                                    style: const TextStyle(
                                      color: kBlue,
                                    ),
                                    elevation: 16,
                                    underline: Container(
                                        height: 2,
                                        color: kTurquoise
                                    ),
                                    hint: const Text('Seleziona il docente', style: TextStyle(color: kTurquoise, fontStyle: FontStyle.italic),),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedTeacher = newValue;
                                        _getDaysList();
                                      });
                                    },
                                    items: teachersList.map((item) {
                                      return DropdownMenuItem(
                                        value: '${item['Surname']}, ${item['Name']}',
                                        child: Text('${item['Surname']}, ${item['Name']}', style: const TextStyle(fontSize: 22, color: kBlue, fontWeight: FontWeight.bold)),
                                      );
                                    }).toList() ??
                                        [],
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 15, bottom: 5),
                                child: Text('Docente', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400)),
                              ),
                              const Divider(color: kTurquoise, thickness: 1, indent: 10, endIndent: 50),
                            ],
                            ),
                          )
                        ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 40, width: 40, decoration: const BoxDecoration(color: kWhite),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 20, left: 10, bottom: 10, right: 10),
                              child: Icon(Icons.calendar_month, color: kBlue, size: 40)
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      value: selectedDay,
                                      icon: const Icon(Icons.arrow_drop_down, color:kBlue),
                                      style: const TextStyle(
                                        color: kBlue,
                                      ),
                                      elevation: 16,
                                      underline: Container(
                                        height: 2,
                                        color: kTurquoise
                                    ),
                                      hint: const Text('Seleziona il giorno', style: TextStyle(color: kTurquoise, fontStyle: FontStyle.italic),),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedDay = newValue;
                                        selectedDayText = newValue!.toUpperCase();
                                        _getHoursList();
                                      });
                                    },
                                    items: daysList.map((item) {
                                      return DropdownMenuItem(
                                        value: item.toString(),
                                        child: Text(item, style: const TextStyle(fontSize: 22, color: kBlue, fontWeight: FontWeight.bold)),
                                      );
                                    }).toList() ??
                                        [],
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 15, bottom: 5),
                                child: Text('Giorno', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400)),
                              ),
                              const Divider(color: kTurquoise, thickness: 0.5, indent: 10, endIndent: 50),
                              ]
                            ),
                          )
                        ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 40, width: 40, decoration: const BoxDecoration(color: kWhite),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 20, left: 10, bottom: 10, right: 10),
                            child: Icon(Icons.lock_clock, color: kBlue, size: 40),
                        ),
                    ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Row(
                            children: [
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    value: selectedTime,
                                    icon: const Icon(Icons.arrow_drop_down, color: kBlue),
                                    style: const TextStyle(
                                      color: kBlue,
                                    ),
                                    elevation: 16,
                                    underline: Container(
                                      height: 2,
                                      color: kTurquoise,
                                    ),
                                    hint: const Text('Seleziona l\'Ora', style: TextStyle(color: kTurquoise, fontStyle: FontStyle.italic)),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedTime = newValue;
                                      });
                                    },
                                    items: hoursList.map((item) {
                                      return DropdownMenuItem(
                                        value: item['time'].toString(),
                                        child: Text(item['time'], style: const TextStyle(fontSize: 22, color: kBlue, fontWeight: FontWeight.bold)),
                                      );
                                    }).toList() ??[],
                                  ),
                                ),
                              ),
                                const Padding(padding: EdgeInsets.only(left: 15, bottom: 5),
                                child: Text('Ora', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),)
                                ),
                                const Divider(color: kTurquoise, thickness: 0.5, indent: 10, endIndent: 50),
                            ]
                            ),
                              SizedBox(width: 50),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: (result == true) ? Icon(Icons.done, color: Colors.green, size: 60) : (result == false) ? Icon(Icons.close, color: Colors.red, size: 60) : SizedBox(height: 0),
                              )
                            ]
                          ),
                        ),
                      ]
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                              color: kBlue, borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            onPressed: () {
                              print(selectedCourse!);
                              print(selectedTeacher!);
                              print(selectedDay!);
                              print(selectedTime!);
                              bookLesson();
                            },
                            child: const Text(
                              'Prenota',
                              style: TextStyle(color: kWhite, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]
        )
    );
  }

  List coursesList = [];
  List teachersList = [];
  List daysList = ['Lunedi', 'Martedi', 'Mercoledi', 'Giovedi', 'Venerdi'];
  List hoursList = [];
  String? selectedCourse;
  String? selectedTeacher;
  String? selectedDay;
  String? selectedTime;
  bool? result;

  String selectedDayText = '';
  String selectedTeacherText = '';
  String selectedCourseText = '';
  String selectedTimeText = '';

  Future<String> _getCoursesList() async {
    coursesList = [];
    teachersList = [];
    hoursList = [];
    selectedTeacher = null;
    selectedDay = null;
    selectedTime = null;
      var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletCorsi';
      await http.get(Uri.parse(url)).then((response) {
        var data = json.decode(response.body);
        setState(() {
          coursesList = data;
        });
      });
      return "";
    }

  Future<String> _getTeachersList() async {
    teachersList = [];
    hoursList = [];
    selectedTeacher = null;
    selectedDay = null;
    selectedTime = null;
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletBookLessonApp';
    await http.post(Uri.parse(url), body: {"Action": "AvailableTeachers", "Course": selectedCourse}
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        teachersList = data;
      });
    });
    return "";
  }

  void _getDaysList() {
    selectedDay = null;
    selectedTime = null;
    hoursList = [];
  }

  Future<String> _getHoursList() async {
    hoursList = [];
    selectedTime = null;
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletBookLessonApp';
    await http.post(Uri.parse(url), body: {"Action": "AvailableHours", "Course": selectedCourse, "Teacher": selectedTeacher, "Day": selectedDay}
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        hoursList = data;
      });
    });
    return "";
  }

  void bookLesson() async {
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletBookLessonApp';
    await http.post(Uri.parse(url), body: {"Action": "BookLesson", "Username": HomeController.username.value,"Course": selectedCourse, "Teacher": selectedTeacher, "Day": selectedDay, "Hour": selectedTime}
    ).then((response) {
      var data = json.decode(response.body);
      setState(() {
        result = data;
        print(result);
      });
    });
  }

}

