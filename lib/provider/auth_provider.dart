import 'dart:convert';
import 'dart:io';
import 'package:articleaapp/Database/database_helper.dart';
import 'package:articleaapp/models/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {

  User user;
  String userId;
  String employeeCode;
  String employeePass;
  String employeeName;
  String employeeEmail;
  String employeeMobile;

  DatabaseHelper dbHelper = DatabaseHelper();

  final String isLoggedKey = "isLogged";
  static const tmIdKey = "tmId";
  static const tmNameKEY = "tmName";
  static const tmEmployeeKey = "tmEmployeeCode";
  static const tmEmailKey = "tmEmail";
  static const tmMobileKey = "tmMobile";
  static const tmEmployeePass = "empPassword";

  Future<User> login(String username, String password) async {

        final url = Uri.parse("https://fdcarticlealert.com/API_TM/tmlogin");
        Map<String, String> loginDetail = {
          "username": username,
          "password": password,
        };
        try {
          final response = await http.post(url, body: loginDetail);
          final responseData = json.decode(response.body);
          userId = responseData["TMid"];

          if (userId != null && userId.length > 0) {
            employeeCode = responseData["TMemployeecode"];
            employeePass = responseData["TMpwd"];
            employeeName = responseData["TMname"];
            employeeEmail = responseData["TMemail"];
            employeeMobile = responseData["TMmobile"];
            user = new User(responseData["TMid"], responseData["TMname"],
                responseData["TMemployeecode"], responseData["TMpwd"],
                responseData["TMmobile"], responseData["TMemail"]);
            dbHelper.insertUser(user);
            setUserData(userId, employeeName, employeeCode, employeeEmail, employeeMobile, employeePass);
            setLogBool(true);
            return user;
          }
          else {
            setLogBool(false);
            return null;

          }
        } catch (e) {
          print(e);
          setLogBool(false);
        }
        setLogBool(false);
        return null;

  }



  void setUserData(String tmId, String tmName, String tmEmployeeCode, String tmEmail, String tmMobile, String empPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(tmIdKey, tmId);
    prefs.setString(tmNameKEY, tmName);
    prefs.setString(tmEmployeeKey, tmEmployeeCode);
    prefs.setString(tmEmailKey, tmEmail);
    prefs.setString(tmMobileKey, tmMobile);
    prefs.setString(tmEmployeePass, empPassword);
  }

  void setLogBool(bool isLogged) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedKey, isLogged);
    print("inside setLogBool + value is : $isLogged");
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

}