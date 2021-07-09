import 'package:articleaapp/models/user.dart';
import 'package:articleaapp/provider/auth_provider.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import '../custom_route.dart';
import '../users.dart';
import 'dashboard.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';


  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if(data == null){
        return 'wrong credentials';
      }
      if (!mockUsers.containsKey(data.name)) {
        return 'User not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/login_bg.jpg'), fit: BoxFit.fill,),

        ),
        child: SizedBox(
          child: FlutterLogin(

            emailValidator: (value)  {
              if(value.isEmpty){
                return 'Employee Code is empty';
              }
              return null;
            },

            messages: LoginMessages(
              usernameHint: "Employee Code"
            ),
            theme: LoginTheme(
              buttonTheme: LoginButtonTheme(backgroundColor: Colors.pink),
              primaryColor: Colors.pink,
                pageColorLight: Colors.transparent,
                pageColorDark: Colors.transparent,

             //   textFieldStyle: TextStyle(color: Colors.pink, backgroundColor: Colors.pink)
            ),
            //   title: Constants.appName,
            logo: "assets/images/logo.png",

            // userValidator: (value) {
            //   if (!value.contains('@') || !value.endsWith('.com')) {
            //     return "Email must contain '@' and end with '.com'";
            //   }
            //   return null;
            // },
            passwordValidator: (value) {
              if (value.isEmpty) {
                return 'Password is empty';
              }
              return null;
            },
            hideSignUpButton: true,
            hideForgotPasswordButton: true,

            onLogin: (loginData) async {

              User user = await Provider.of<AuthProvider>(context, listen: false).login(loginData.name, loginData.password);

              if(user != null && user.tmId.length > 0){
                Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
                return _loginUser(loginData);
              }else{
                return _loginUser(null);
              }

            },
            // onSignup: (loginData) {
            //   print('Signup info');
            //   print('Name: ${loginData.name}');
            //   print('Password: ${loginData.password}');
            //   return _loginUser(loginData);
            // },
            onSignup: (_) => Future(null),

            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(FadePageRoute(
                builder: (context) => Dashboard(),
              ));
            },
            onRecoverPassword: (name) {
              print('Recover password info');
              print('Name: $name');
              return _recoverPassword(name);
              // Show new password dialog
            },
            // showDebugButtons: true,
          ),
        ),
      ),
    );

  }

}



