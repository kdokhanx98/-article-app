import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../constants.dart';
import '../custom_route.dart';
import '../styling.dart';
import '../users.dart';
import 'dashboard.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
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
    return FlutterLogin(
      //   title: Constants.appName,
      logo: "assets/images/logo.jpg",
      theme: LoginTheme(
        primaryColor: HexColor("#fe0063"),
      ),
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

      onLogin: (loginData) {
        Navigator.of(context).pushNamed(Dashboard.routeName);

        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
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
    );
  }
}
