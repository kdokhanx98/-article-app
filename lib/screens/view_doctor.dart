import 'dart:io';

import 'package:articleaapp/models/doctor.dart';
import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/provider/doctor_provider.dart';
import 'package:articleaapp/widgets/doctor_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewDoctor extends StatefulWidget {
  static const routeName = '/ViewDoctor';

  @override
  _ViewDoctorState createState() => _ViewDoctorState();
}

class _ViewDoctorState extends State<ViewDoctor> {
  bool isSearchClicked = false;
  bool isInitialize = true;
  bool showProgressDialog = true;
  List<Doctor> doctorsList = [];
  List<Doctor> searchedList = [];
  var provider;
  var userId;
  var isCon = false;

  @override
  void didChangeDependencies() {
    provider = Provider.of<DoctorProvider>(context);
    if (isInitialize) {
      isInitialize = false;

      setState(() {
        isConnected();
        getUserId();
      });


    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: isSearchClicked == false
            ? Text("Doctors List")
            : Container(
          decoration: BoxDecoration(
            color: Colors.black38.withAlpha(10),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    hintText: "Search ..",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (String keyword) {
                    Provider.of<DoctorProvider>(context, listen: false)
                        .getSearchList(keyword, userId)
                        .whenComplete(() {
                      searchedList = Provider
                          .of<DoctorProvider>(context, listen: false)
                          .getSearchedDoctorList;

                    });

                  },
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                  onPressed: () {
                    setState(() {
                      isSearchClicked = !isSearchClicked;
                    });
                  })
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          isSearchClicked == false
              ? Padding(
            padding: const EdgeInsets.only(right: 15.5),
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 30.0,
              ),
              onPressed: () {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                });
              },
            ),
          )
              : Container(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Image.asset(
                    "assets/images/bran1.png",
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.24,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Image.asset("assets/images/logo.png",
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Image.asset("assets/images/bran2.png",
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.24),
                )
              ],
            ),
          ), //logos
    Expanded(
    child: ListView(
    children: [
          !isSearchClicked ? !showProgressDialog ? Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    DoctorItem(
                      number: (index + 1).toString(),
                      drName: doctorsList[index].docName,
                      drEmail: doctorsList[index].docEmail,
                      drNumber: doctorsList[index].docMobile,
                      docId: doctorsList[index].docId,
                      docCity: doctorsList[index].docCity,
                      isSearch: false,
                      index: index,
                    ),
                itemCount: doctorsList.length,
              ),
            ),
          ) : Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.7,
              child: Center(child: CircularProgressIndicator(),)) :
          searchedList.length > 0 ? Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  DoctorItem(
                    number: (index + 1).toString(),
                    drName: searchedList[index].docName,
                    drEmail: searchedList[index].docEmail,
                    drNumber: searchedList[index].docMobile,
                    docId: searchedList[index].docId,
                    docCity: searchedList[index].docCity,
                    isSearch: true,
                    index: index,
                  ),
              itemCount: searchedList.length,
            ),
          ) : Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.2,
              child: Center(child: CircularProgressIndicator(),)),
          ],
          ),
          ),
        ],
      ),
    );
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

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      doctorsList.clear();
      userId = prefs.getString(AuthProvider.tmIdKey);
      print("userid: $userId");
      Provider.of<DoctorProvider>(context, listen: false)
          .getDoctors(userId)
          .whenComplete(() {
        doctorsList = provider.getDoctorList;
        showProgressDialog = false;
      });
    });
  }
}
