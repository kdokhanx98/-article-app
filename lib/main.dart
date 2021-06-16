import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/provider/doctor_provider.dart';
import 'package:articleaapp/styling.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/add_article.dart';
import 'screens/add_doctor.dart';
import 'screens/dashboard.dart';
import 'screens/edit_doctor.dart';
import 'screens/login_screen.dart';
import 'screens/view_article.dart';
import 'screens/view_article_screen.dart';
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

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [ListenableProvider<AuthProvider>(create: (_) => AuthProvider()), ListenableProvider<DoctorProvider>(create: (_) => DoctorProvider()), ],
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
      home: LoginScreen(),
      // navigatorObservers: [TransitionRouteObserver()],
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        Dashboard.routeName: (context) => Dashboard(),
        AddDoctorScreen.routeName: (context) => AddDoctorScreen(),
        AddAticleScreen.routeName: (context) => AddAticleScreen(),
        ViewArticleScreen.routeName: (context) => ViewArticleScreen(),
        ViewArticle.routeName: (context) => ViewArticle(),
        ViewDoctor.routeName: (context) => ViewDoctor(),
        EditDoctorScreen.routeName: (context) => EditDoctorScreen(),
      },
    )
    );
  }
}
