import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:get/get.dart';


class Booking extends StatelessWidget {
  const Booking ({Key? key, required this.course, required this.teacher, required this.day, required this.time, required this.state}) : super(key:key);

  static const kBlue = Color(0xFF122b62);
  static const kWhite = Colors.white;
  static const kTurquoise = Color(0xFFa7d5c5);


  final String course;
  final String teacher;
  final String day;
  final String time;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          color: const Color(0xfffbffff),
          elevation: 5,
          shadowColor: kTurquoise,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right:  5, top: 15, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Icon(Icons.book, color: kBlue),
                        Text(course, style: const TextStyle(
                            color: kBlue,
                            fontSize: 16)
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.person, color: kBlue),
                        Text(teacher, style: const TextStyle(color: kBlue, fontSize: 16)
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Icon(Icons.calendar_month, color: kBlue),
                        Text(day, style: const TextStyle(color: kBlue, fontSize: 16)
                        )
                      ],
                    ),
                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Icon(Icons.lock_clock, color: kBlue),
                        Text(time, style: const TextStyle(color: kBlue, fontSize: 16)
                        )
                      ],
                    ),
                    Row(
                      children: [
                        if(state == 'effettuata') const Icon(Icons.circle, color: Colors.green)
                        else if(state == 'attiva') const Icon(Icons.circle, color: Colors.yellow)
                        else const Icon(Icons.circle, color: Colors.red)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}