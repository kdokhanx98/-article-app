import 'package:articleaapp/screens/add_doctor.dart';
import 'package:articleaapp/screens/dashboard.dart';
import 'package:articleaapp/screens/login_screen.dart';
import 'package:articleaapp/screens/view_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Drawers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              // CircleAvatar(
              //   radius: 50.0,
              //   backgroundImage: NetworkImage(
              //     "https://images.unsplash.com/photo-1594616838951-c155f8d978a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
              //   ),
              // ),
              Image.asset(
                "assets/images/logo.png",
                width: 70,
                height: 70,
              ),
              SizedBox(
                height: 50.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text('My Profile'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AddDoctorScreen.routeName);
                },
                child: ListTile(
                  leading: Image.asset("assets/images/add_doctor.png", color: Colors.black, width: 25,),
                  title: Text('Add Doctors'),
                  onTap: () {
                    Navigator.of(context).pushNamed(AddDoctorScreen.routeName);
                  },
                ),
              ),
              Divider(),

              ListTile(
                leading: SvgPicture.asset(
                  "assets/svg/list_of_doctor.svg",
                  width: 25,
                ),
                title: Text('Manage Doctors'),
                onTap: () {
                  Navigator.of(context).pushNamed(ViewDoctor.routeName);
                },
              ),
              // ListTile(
              //   leading: SvgPicture.asset(
              //     "assets/svg/edit.svg",
              //   ),
              //   title: Text('Assign Articies'),
              //   onTap: () {
              //   },
              // ),
              Divider(),

     /*         GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.sync_sharp,
                    color: Colors.black,
                  ),
                  title: Text('Pull Data'),
                  onTap: () {
                    Navigator.of(context)
                      .pop(Dashboard.routeName);
                  },
                ),
              ),
              Divider(),*/
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
