import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPorivder with ChangeNotifier {
  Uri doctorsThisMonthUri = Uri.parse("https://fdcarticlealert.com/API_Dashboard/doctorsaddedpermonth");
  Uri articlesEnrolledUri = Uri.parse("https://fdcarticlealert.com/API_Dashboard/articleassignedpermonth");

  int doctorsNo;
  int articlesNo;

  static const doctorsNoKey = "doctors_no";
  static const articlesNoKey = "articles_no";


Future<void> getArticlesNo(String tmId) async {

  Map<String, String> articlesBody = {
    "tmid": tmId,
  };
  try {
    final response = await http.post(articlesEnrolledUri, body: articlesBody);
    articlesNo = json.decode(response.body) as int;
    setInt(articlesNoKey, articlesNo);
    notifyListeners();
  } catch (e) {
    print(e);
  }
}

Future<void> getDoctorsNo(String tmId) async {

  Map<String, String> doctorsBody = {
    "tmid": tmId,
  };

  try {
    final response = await http.post(doctorsThisMonthUri, body: doctorsBody);
    doctorsNo = json.decode(response.body) as int;
    setInt(doctorsNoKey, doctorsNo);
    notifyListeners();
  } catch (e) {
    print(e);
  }
}


void setInt(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);

  print("inserted $key, value $value");
}


}