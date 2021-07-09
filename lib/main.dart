import 'package:articleaapp/provider/articles_provider.dart';
import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/provider/dashboard_provider.dart';
import 'package:articleaapp/provider/doctor_provider.dart';
import 'package:articleaapp/screens/my_profile.dart';
import 'package:articleaapp/styling.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/add_doctor.dart';
import 'screens/dashboard.dart';
import 'screens/edit_doctor.dart';
import 'screens/login_screen.dart';
import 'screens/view_article.dart';
import 'screens/view_doctor.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var route = "";

  var widget;

  var isInitialized = true;

  @override
  Widget build(BuildContext context) {
    if(isInitialized){
      isInitialized = false;
      getRoute().then((value){
        setState(() {
          route = value;
          print("route : $route");
        });
      });



    }


    return MultiProvider(providers: [ListenableProvider<AuthProvider>(create: (_) => AuthProvider()), ListenableProvider<ArticleProvider>(create: (_) => ArticleProvider()), ListenableProvider<DashboardPorivder>(create: (_) => DashboardPorivder()), ListenableProvider<DoctorProvider>(create: (_) => DoctorProvider()), ],
        child: MaterialApp(
      theme: ThemeData(
        // brightness: Brightness.dark,

        accentColor: HexColor("B22382"),
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.orange),
        // fontFamily: 'SourceSansPro',
        textTheme: TextTheme(
          headline3: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            // fontWeight: FontWeight.w400,
            color: Colors.orange,
          ),
          button: TextStyle(
            // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
            fontFamily: 'OpenSans',
          ),
          caption: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.deepPurple[300],
          ),
          headline1: TextStyle(fontFamily: 'Quicksand'),
          headline2: TextStyle(fontFamily: 'Quicksand'),
          headline4: TextStyle(fontFamily: 'Quicksand'),
          headline5: TextStyle(fontFamily: 'NotoSans'),
          headline6: TextStyle(fontFamily: 'NotoSans'),
          subtitle1: TextStyle(fontFamily: 'NotoSans'),
          bodyText1: TextStyle(fontFamily: 'NotoSans'),
          bodyText2: TextStyle(fontFamily: 'NotoSans'),
          subtitle2: TextStyle(fontFamily: 'NotoSans'),
          overline: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      home: route == "/Dashboard" ? Dashboard() : LoginScreen(),
        initialRoute: route,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        Dashboard.routeName: (context) => Dashboard(),
        AddDoctorScreen.routeName: (context) => AddDoctorScreen(),
        MyProfile.routeName: (context) => MyProfile(),
       // ViewArticleScreen.routeName: (context) => ViewArticleScreen(),
        ViewArticle.routeName: (context) => ViewArticle(),
        ViewDoctor.routeName: (context) => ViewDoctor(),
        EditDoctorScreen.routeName: (context) => EditDoctorScreen(),
      },
    )
    );
  }

  Future<String> getRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogged = prefs.getBool("isLogged");
    if(isLogged == null){
      isLogged = false;
    }
    print("inside route + value is : $isLogged");
    route = isLogged ? Dashboard.routeName : LoginScreen.routeName;
    return route;
  }
}




