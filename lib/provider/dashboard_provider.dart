import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardPorivder with ChangeNotifier {
  Uri doctorsThisMonthUri = Uri.parse("https://fdcarticlealert.com/API_Dashboard/doctorsaddedpermonth");
  Uri articlesEnrolledUri = Uri.parse("https://fdcarticlealert.com/API_Dashboard/articleassignedpermonth");

  int doctorsNo;
  int articlesNo;


Future<void> getArticlesNo(String tmId) async {

  Map<String, String> articlesBody = {
    "tmid": tmId,
  };
  try {
    final response = await http.post(articlesEnrolledUri, body: articlesBody);
    articlesNo = json.decode(response.body) as int;
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
    notifyListeners();
  } catch (e) {
    print(e);
  }
}



}