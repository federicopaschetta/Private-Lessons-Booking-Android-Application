import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ium_project/components/booking.dart';
import 'package:ium_project/controller/home_controller.dart';
import 'package:http/http.dart' as http;


List<dynamic> pendingBookingsList = [];
List<dynamic> finishedBookingsList = [];


class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
   return const MyBookingsPage();
  }
}

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<StatefulWidget> createState() => MyBookingsPageState();
}


class MyBookingsPageState extends State<MyBookingsPage> {

  @override
  void initState() {
    super.initState();
    if(HomeController.role.value == 'admin') {
      getBookings();
    } else {
      getMyBookings();
    }
  }

  void getMyBookings() async {
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletViewBookingsApp';
    var response = await http.post(Uri.parse(url), body: {"Username": HomeController.username.value, "Action": "Pending"});
    pendingBookingsList = jsonDecode(response.body);
    response = await http.post(Uri.parse(url), body: {"Username": HomeController.username.value, "Action": "Finished"});
    finishedBookingsList = jsonDecode(response.body);
    setState(() {
    });
  }

  void getBookings() async {
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletViewBookingsApp';
    var response = await http.post(Uri.parse(url), body: {"Action": "AdminPending"});
    pendingBookingsList = jsonDecode(response.body);
    response = await http.post(Uri.parse(url), body: {"Action": "AdminFinished"});
    finishedBookingsList = jsonDecode(response.body);
    setState(() {
    });
  }

  void markAs(id, state) async {
    var url = 'http://10.0.2.2:8080/ServletTest_war_exploded/ServletMarkBookingsApp';
    var response = await http.post(Uri.parse(url), body: {"Booking": id, "Action": state});
    var result = jsonDecode(response.body);
  }

  Future<void> _pullRefresh() async {
    if(HomeController.role.value == 'admin') {
      getBookings();
    } else {
      getMyBookings();
    }
  }

  static const kBlue = Color(0xFF122b62);
  static const kWhite = Colors.white;
  static const kTurquoise = Color(0xFFa7d5c5);

  Widget getListView() {
    if(pendingBookingsList.isNotEmpty || finishedBookingsList.isNotEmpty) {
      return SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pendingBookingsList.length,
          itemBuilder: (context, index) {
            final booking = pendingBookingsList[index];
            return Dismissible(
              key: Key(booking['ID'].toString()),
              onDismissed: (DismissDirection direction) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$booking dismissed')));
                if(direction == DismissDirection.endToStart) {
                  markAs(booking['ID'].toString(), 'Canceled');
                } else {
                  markAs(booking['ID'].toString(), 'Done');
                }
                pendingBookingsList.removeAt(index);
                setState(() {
                  if(HomeController.role.value == 'admin') {
                    getBookings();
                  } else {
                    getBookings();
                  }
                });
              },
              background: Container(color: Colors.green),
              secondaryBackground: Container(color: Colors.red),

              child: Booking(
                course: booking['course'], teacher: booking['teacherName']+' '+booking['teacherSurname'], day: booking['day'], time: booking['time'], state: booking['state'],
              ),
            );
          },
        ),
      );
    } else {
      return const Center(child: Text("Non hai ancora prenotato lezioni!"));
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 40, left:10, right:10),
            child: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: Column(
                children: <Widget> [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                         'Le mie lezioni',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: kBlue
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SizedBox(
                      child: ListView(
                        children: <Widget>[
                          getListView(),
                          for(var booking in finishedBookingsList)
                            Booking(course: booking['course'], teacher: booking['teacherName']+' '+booking['teacherSurname'], day:booking['day'], time: booking['time'], state: booking['state'])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        )
    );
  }
}