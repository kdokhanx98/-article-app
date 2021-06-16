import 'dart:convert';
import 'package:articleaapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {

  User user;

  Future<User> login(String username, String password) async {
    final url = Uri.parse("https://humgicwale.com/articlealert/API_TM/tmlogin");
    Map<String, String> loginDetail = {
      "username": username,
      "password": password,
    };
    try{
      final response = await http.post(url, body: loginDetail);
      final responseData = json.decode(response.body);

      String userId = responseData["TMid"];
      if(userId != null && userId.length > 0){
         user = new User(responseData["TMid"], responseData["TMname"],
            responseData["TMemployeecode"], responseData["TMpwd"],
            responseData["TMmobile"], responseData["TMemail"]);
        return user;
      }
      else{
        return null;
      }

    }catch(e){
      print(e);
    }
  }


}