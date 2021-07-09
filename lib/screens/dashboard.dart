import 'dart:io';

import 'package:articleaapp/Database/database_helper.dart';
import 'package:articleaapp/models/assign_article.dart';
import 'package:articleaapp/models/doctor.dart';
import 'package:articleaapp/provider/articles_provider.dart';
import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/provider/dashboard_provider.dart';
import 'package:articleaapp/provider/doctor_provider.dart';
import 'package:articleaapp/screens/add_doctor.dart';
import 'package:articleaapp/screens/view_doctor.dart';
import 'package:articleaapp/styling.dart';
import 'package:articleaapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/Dashboard';


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DatabaseHelper dbHelper = DatabaseHelper();
  bool isInitialize = true;
  bool isFirst = true;
  String doctorsEnrolled;
  String articlesEnrolled;
  String tmName = "";
  String employeeCode = "";
  String tmId = "";
  int doctorsNo = 0;
  int articlesNo = 0;
  bool isCon = true;

  @override
  void didChangeDependencies() {
    if (isInitialize) {

        getUserData();
        getDashData();

      isInitialize = false;
    }
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    if(isFirst){
      List<Doctor> doctors = [];
      List<AssignArticle> articlesToAssign = [];
      isFirst = false;
    isConnected().then((value) {
        isCon = value;
      if(value) {
        // add offline doctors
        dbHelper.getDoctorsOfflineList().then((value) {
          doctors = value;
          doctors.map((e) {
            print("doctor sql list ${value.length} and doc name ${e.docName}");
            Provider.of<DoctorProvider>(context, listen: false).addDoctor(docName: e.docName,
                docCity: e.docCity,
                docMobile: e.docMobile,
                docEmail: e.docEmail,
                tmId: tmId, cleanData: true);
          }).toList();
        });

        // assign offline articles to doctors
        dbHelper.getArticlesOfflineList().then((value) {
          articlesToAssign = value;
          articlesToAssign.map((e) {
            print("object ${e.toString()}, ${e.articlesIds}");

            print("article sql list ${value.length} and doc id ${e.docId} and articles are ${e.articlesIds}");
            Provider.of<ArticleProvider>(context, listen: false).assignArticle(docId: e.docId, articleId: e.articlesIds ,cleanData: true);
          }).toList();
        });
      }
    });
    }


    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawers(),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.sync_sharp,
                size: 30.0,
              ),
              onPressed: () {
                setState(() {
                  isConnected();
                });
              },
            ),
          ],
          centerTitle: true,
          title: Text("Article Alert System",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        //   appBar: AppBar(  backgroundColor: Colors.white,),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: HexColor("#2296F3"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: Text(
                    tmId != "" ? "Welcome $tmName - $employeeCode"
                        : "No User data",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Center(
                child: Image.asset("assets/images/logo.png",
                    width: MediaQuery.of(context).size.width * 0.6),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Image.asset(
                        "assets/images/bran1.png",
                        width: MediaQuery.of(context).size.width * 0.40,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Image.asset("assets/images/bran2.png",
                          width: MediaQuery.of(context).size.width * 0.40),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  color: HexColor("#3DBCC2"),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Doctors Enrolled This Month",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            isCon ? Text(doctorsEnrolled == null? "0" : doctorsEnrolled,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                            : Text(doctorsNo == 0 ? "0" : doctorsNo.toString(), style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          color: Colors.white,
                          width: 1,
                          height: 50,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Articles Assigned This Month",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            isCon ? Text(articlesEnrolled == null ? "0" : articlesEnrolled,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                            : Text(articlesNo == 0 ? "0" : articlesNo.toString(), style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                    child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AddDoctorScreen.routeName);
                        },
                        child: card("Add Doctor",
                            "assets/images/add_doctor.png", context, false)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(ViewDoctor.routeName);
                      },
                      child: card("Manage Doctors",
                          "assets/svg/list_of_doctor.svg", context),
                    ),
                  ],
                )),
              ),
            ],
          )),
        ));
  }

  Widget card(String title, String img, BuildContext context,
      [bool isSvg = true]) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: 100.0,
      child: Card(
        color: HexColor("#B22382"),
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              isSvg
                  ? SvgPicture.asset(
                      img,
                      color: Colors.white,
                      width: 55,
                      height: 55,
                    )
                  : Image.asset(
                      img,
                      color: Colors.white,
                    ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
              SizedBox(
                width: 30,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
        )),
      ),
    );
  }

  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;

      }
      return false;
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tmName = prefs.getString(AuthProvider.tmNameKEY);
      employeeCode = prefs.getString(AuthProvider.tmEmployeeKey);
      tmId = prefs.getString(AuthProvider.tmIdKey);


    });

    var dashProvider = Provider.of<DashboardPorivder>(context, listen: false);

    dashProvider.getArticlesNo(tmId).then((value) {
      setState(() {
        articlesEnrolled = dashProvider.articlesNo.toString();
      });

    });
    dashProvider.getDoctorsNo(tmId).then((value) {
      setState(() {
      doctorsEnrolled = dashProvider.doctorsNo.toString();
      });
    });


    print("user data : $tmName, $employeeCode, $tmId");
  }

  void getDashData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      doctorsNo = prefs.getInt(DashboardPorivder.doctorsNoKey);
      articlesNo = prefs.getInt(DashboardPorivder.articlesNoKey);
    });


    print("dash data : $doctorsNo, $articlesNo");
  }


}


