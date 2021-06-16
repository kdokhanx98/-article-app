import 'dart:convert';

import 'package:articleaapp/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorProvider with ChangeNotifier {
  List<Doctor> _doctorsList = [];

  List<Doctor> get getDoctorList {
    return [..._doctorsList];
  }

  Uri addDoctorUrl =
      Uri.parse("https://humgicwale.com/articlealert/API_Doctor/insert");
  
  Uri getDoctorsUrl = Uri.parse("https://humgicwale.com/articlealert/API_Doctor/fetch_all");


  Future<void> addDoctor(
      {@required String docName,
      @required String docCity,
      @required String docMobile,
      @required String docEmail,
      @required String tmId}) async {
    Map<String, String> addDoctorBodyMap = {
      "Docname": docName,
      "Doccity": docCity,
      "Docmobile": docMobile,
      "Docmobile": docMobile,
      "Docemail": docEmail,
      "tmid": tmId,
    };
    try {
      final response = await http.post(addDoctorUrl, body: addDoctorBodyMap);
      final responseData = json.decode(response.body);

      print("${response.statusCode}");
      print("$responseData");
    } catch (e) {
      print(e);
    }
  }
  
  
  Future<void> getDoctors(String tmId) async {
    print("ID: $tmId");
    Map<String, String> getDoctorsBody = {
      "tmid": tmId,
    };

    try {
      final response = await http.post(getDoctorsUrl, body: getDoctorsBody);
      final responseData = json.decode(response.body);
      final listData = responseData as List<dynamic>;
      _doctorsList.clear();
      listData.map((e) => _doctorsList.add(new Doctor(e['Docname'], e['Docemail'], e['Docmobile'],e['TMid'],e['Doccity']))).toList();
      notifyListeners();
      print("length : ${_doctorsList.length}");
    } catch (e) {
      print(e);
    }
  }
}
