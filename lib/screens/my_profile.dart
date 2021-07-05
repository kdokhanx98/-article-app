import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/styling.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatelessWidget {
  static const routeName = '/prof';

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
                    Text(Provider.of<AuthProvider>(context).employeeName, style: TextStyle(fontSize: 20, color: Colors.black),),

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
                    Text(Provider.of<AuthProvider>(context).employeeEmail, style: TextStyle(fontSize: 20, color: Colors.black),),

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
                      Text(Provider.of<AuthProvider>(context).employeeMobile, style: TextStyle(fontSize: 20, color: Colors.black),),

                    ],),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
