import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


List<String> teachersList = <String>[''];
List<String> daysList = <String>['', 'Lunedi', 'Martedi', 'Mercoledi', 'Giovedi', 'Venerdi'];
List<String> hoursList = <String>['', '14-15', '15-16', '16-17', '17-18'];
List<String>? booking;
String? selectedCourse;
String? selectedTeacher;
String? selectedDay;
String? selectedHour;


const kBlue = Color(0xFF122b62);
const kWhite = Colors.white;
const kTurquoise = Color(0xFFa7d5c5);


class BookLessonPage extends StatelessWidget {

  BookLessonPage ({Key? key}) : super(key:key);

  String courseValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Prenota una lezione',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: kBlue
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                  Text('Corso:', style: TextStyle(color: kBlue, fontSize: 24)),
                  SizedBox(width: 30),
                  DropdownButtonCourse()
                  ]
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: kTurquoise, borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                         onPressed: () {
                           print('$selectedCourse $selectedTeacher $selectedDay $selectedHour');

                         },
                        child: const Text(
                          'Prenota',
                          style: TextStyle(color: kWhite, fontSize: 25),
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
}




class DropdownButtonCourse extends StatefulWidget {

  const DropdownButtonCourse({super.key});

  @override
  State<StatefulWidget> createState() => _DropDownButtonCourseState();

}

class _DropDownButtonCourseState extends State<DropdownButtonCourse>{

  List coursesList = [];
  String? dropdownValue;

  @override
  void initState() {
    _getCoursesList();
    super.initState();
  }

  Future<String> _getCoursesList() async {
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletCorsi';
    await http.get(Uri.parse(url)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        coursesList = data;
      });
    });
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text('Seleziona il corso'),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down, color: kTurquoise),
      elevation: 16,
      style: const TextStyle(color: kBlue),
      underline: Container(
        height: 2,
        color: kTurquoise,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          selectedCourse = value;
        });
      },

      items: coursesList.map((item) {
        return DropdownMenuItem(
          value:item['Text'].toString(),
          child: Text(item['Text'], style: const TextStyle(fontSize: 18)),
        );
      })?.toList() ??[],
    );
  }
}

class DropdownButtonTeacher extends StatefulWidget {

  const DropdownButtonTeacher({super.key});

  @override
  State<StatefulWidget> createState() => _DropDownButtonTeacherState();

}

class _DropDownButtonTeacherState extends State<DropdownButtonTeacher>{

  String dropdownValue = "Seleziona un docente";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down, color: kTurquoise),
      elevation: 16,
      style: const TextStyle(color: kBlue),
      underline: Container(
        height: 2,
        color: kTurquoise,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          selectedTeacher = value;
        });
      },
      items: teachersList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 18)),
        );
      }).toList(),
    );
  }
}

class DropdownButtonDay extends StatefulWidget {

  const DropdownButtonDay({super.key});

  @override
  State<StatefulWidget> createState() => _DropDownButtonDayState();

}

class _DropDownButtonDayState extends State<DropdownButtonDay>{

  String dropdownValue = "Seleziona un giorno";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down, color: kTurquoise),
      elevation: 16,
      style: const TextStyle(color: kBlue),
      underline: Container(
        height: 2,
        color: kTurquoise,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          selectedDay = value;
        });
      },
      items: daysList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 18)),
        );
      }).toList(),
    );
  }
}

class DropdownButtonHour extends StatefulWidget {

  const DropdownButtonHour({super.key});

  @override
  State<StatefulWidget> createState() => _DropDownButtonHourState();

}

class _DropDownButtonHourState extends State<DropdownButtonHour>{

  String dropdownValue = "Seleziona un'ora";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down, color: kTurquoise),
      elevation: 16,
      style: const TextStyle(color: kBlue),
      underline: Container(
        height: 2,
        color: kTurquoise,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          selectedHour = value;
        });
      },
      items: hoursList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 18)),
        );
      }).toList(),
    );
  }
}

