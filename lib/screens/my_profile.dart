import 'dart:io';

import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  static const routeName = '/prof';

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isCon = false;
  bool isInitialize = true;

  String employeeName = "";
  String employeeEmail = "";
  String employeeMobile = "";

  String empName = "";
  String empEmail = "";
  String empMobile = "";

  @override
  void didChangeDependencies() {
    if (isInitialize) {
      isInitialize = false;
      setState(() {
        print("inside build set");
        isConnected();
        getProfileData();

        empMobile = Provider.of<AuthProvider>(context).employeeMobile;
        empName = Provider.of<AuthProvider>(context).employeeName;
        empEmail = Provider.of<AuthProvider>(context).employeeEmail;

      });

    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: HexColor("#E2E0E3"),
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, top: 16, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 10,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,

                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                    Text(isCon ? empName : employeeName, style: TextStyle(fontSize: 20, color: Colors.black),),

                  ],),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.white,

                  ),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Email: ", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                      isCon? Text(empEmail, style: TextStyle(fontSize: 20, color: Colors.black),)
                      : Text(employeeEmail , style: TextStyle(fontSize: 20, color: Colors.black),)

                  ],),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 10,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,

                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact: ", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                      Text(isCon ? empMobile : employeeMobile, style: TextStyle(fontSize: 20, color: Colors.black),),

                    ],),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      employeeName = prefs.getString(AuthProvider.tmNameKEY);
      employeeEmail = prefs.getString(AuthProvider.tmEmailKey);
      employeeMobile = prefs.getString(AuthProvider.tmMobileKey);
    });



  }

  void isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          isCon = true;
        });

      }
      setState(() {
        isCon = false;
      });

    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        isCon = false;
      });
    }
  }
}
