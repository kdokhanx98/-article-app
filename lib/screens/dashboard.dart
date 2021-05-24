import 'package:articleaapp/screens/add_article.dart';
import 'package:articleaapp/screens/add_doctor.dart';
import 'package:articleaapp/screens/view_article.dart';
import 'package:articleaapp/screens/view_article_screen.dart';
import 'package:articleaapp/screens/view_doctor.dart';
import 'package:articleaapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/Dashboard';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawers(),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 30.0,
                      ),
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Image.asset(
                        "assets/images/bran1.png",
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset("assets/images/bran2.png",
                        width: MediaQuery.of(context).size.width * 0.4)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  color: Colors.redAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Doctor's Enrolled This Month",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("0",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          color: Colors.black87,
                          width: 1,
                          height: 50,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Article Assigned This Month",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text("0",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
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
                        child: card(
                            "Add Doctor", "assets/svg/doctor.svg", context)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(ViewDoctor.routeName);
                      },
                      child: card("View Doctor",
                          "assets/svg/list_of_doctor.svg", context),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).pushNamed(ViewArticle.routeName);
                    //   },
                    //   child: card("View Article",
                    //       "assets/svg/content_writing.svg", context),
                    // ),
                  ],
                )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Image.asset(
                        "assets/images/bran1.png",
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset("assets/images/bran2.png",
                        width: MediaQuery.of(context).size.width * 0.4)
                  ],
                ),
              ),
            ],
          )),
        ));
  }

  Widget card(String title, String img, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: 100.0,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SvgPicture.asset(
                img,
                width: 55,
                height: 55,
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                width: 30,
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        )),
      ),
    );
  }
}
