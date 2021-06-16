import 'package:articleaapp/models/user.dart';
import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/screens/add_article.dart';
import 'package:articleaapp/screens/add_doctor.dart';
import 'package:articleaapp/screens/view_article.dart';
import 'package:articleaapp/screens/view_article_screen.dart';
import 'package:articleaapp/screens/view_doctor.dart';
import 'package:articleaapp/styling.dart';
import 'package:articleaapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/Dashboard';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final  userData = Provider.of<AuthProvider>(context).user;
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
              onPressed: () {},
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
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     IconButton(
                //       icon: Icon(
                //         Icons.menu,
                //         size: 30.0,
                //       ),
                //       onPressed: () => _scaffoldKey.currentState.openDrawer(),
                //     ),
                //     Text("Article Alert System",
                //         style: TextStyle(fontSize: 20, color: Colors.black , fontWeight: )),
                //     IconButton(
                //       icon: Icon(
                //         Icons.sync_sharp,
                //         size: 30.0,
                //       ),
                //       onPressed: () {},
                //     ),
                //   ],
                // ),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: HexColor("#2296F3"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: Text(
                     userData != null ?
                    "Welcome, ${userData.tmEmail} - ${userData.tmEmployeeCode}": "No User data",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
                    SizedBox(width: 15,),
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
                            "Add Doctor", "assets/images/add_doctor.png", context, false)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(ViewDoctor.routeName);
                      },
                      child: card("Manage Doctor",
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
            ],
          )),
        ));
  }

  Widget card(String title, String img, BuildContext context, [bool isSvg = true]) {
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
              isSvg?
              SvgPicture.asset(
                img,
                color: Colors.white,
                width: 55,
                height: 55,
              ) : Image.asset(img, color: Colors.white,),
              SizedBox(
                width: 20.0,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
              ),
              SizedBox(
                width: 30,
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white,)
            ],
          ),
        )),
      ),
    );
  }
}
