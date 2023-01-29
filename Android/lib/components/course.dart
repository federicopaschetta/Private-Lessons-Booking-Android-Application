import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:get/get.dart';


class Course extends StatelessWidget {
  const Course ({Key? key, required this.title}) : super(key:key);

  static const kBlue = Color(0xFF122b62);
  static const kWhite = Colors.white;
  static const kTurquoise = Color(0xFFa7d5c5);


  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          color: const Color(0xfffbffff),
          elevation: 5,
          shadowColor: kTurquoise,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right:  5, top: 20, bottom: 20),
            child: Column(

              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.book, color: kBlue),
                    Text(title, style: const TextStyle(
                        color: kBlue,
                        fontSize: 16)
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