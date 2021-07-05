import 'dart:convert';
import 'dart:io';
import 'package:articleaapp/models/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {

  User user;
  String userId;
  String employeeCode;
  String employeePass;
  String employeeName;
  String employeeEmail;
  String employeeMobile;

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
          return user;
        }
        else {
          return null;
        }
      } catch (e) {
        print(e);
      }
      return null;

  }

}