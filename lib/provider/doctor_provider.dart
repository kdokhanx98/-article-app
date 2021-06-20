import 'dart:convert';

import 'package:articleaapp/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorProvider with ChangeNotifier {
  List<Doctor> _doctorsList = [];
  List<Doctor> _searchedList = [];

  List<Doctor> get getDoctorList {
    return [..._doctorsList];
  }
  List<Doctor> get getSearchedDoctorList {
    return [..._searchedList];
  }

  Uri addDoctorUrl =
      Uri.parse("https://fdcarticlealert.com/API_Doctor/insert");
  
  Uri getDoctorsUrl = Uri.parse("https://fdcarticlealert.com/API_Doctor/fetch_all");
  
  Uri editDoctorUrl = Uri.parse("https://fdcarticlealert.com/API_Doctor/update");
  
  Uri searchDoctorUrl = Uri.parse("https://fdcarticlealert.com/API_Doctor/search");


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

    } catch (e) {
      print(e);
    }
  }
  
  
  Future<void> getDoctors(String tmId) async {
    Map<String, String> getDoctorsBody = {
      "tmid": tmId,
    };

    try {
      final response = await http.post(getDoctorsUrl, body: getDoctorsBody);
      final responseData = json.decode(response.body);
      final listData = responseData as List<dynamic>;
      _doctorsList.clear();
      listData.map((e) => _doctorsList.add(new Doctor(e['Docname'], e['Docemail'], e['Docmobile'],e['TMid'],e['Doccity'], e['Docid']))).toList();
      notifyListeners();
      print("length : ${_doctorsList.length}");
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSearchList(String word, String tmid) async {
    Map<String, String> searchBody = {
      "doctor_detail": word,
      "tmid": tmid,
    };

    try {
      final response = await http.post(searchDoctorUrl, body: searchBody);
      final responseData = json.decode(response.body);
      final listData = responseData as List<dynamic>;
      _searchedList.clear();
      listData.map((e) => _searchedList.add(new Doctor(e['Docname'], e['Docemail'], e['Docmobile'],e['TMid'],e['Doccity'], e['Docid']))).toList();
      notifyListeners();
      print("search length : ${_searchedList.length}");
      print(_searchedList);
    } catch (e) {
      print(e);
    }
    
  }

  Future<void> updateDoctor({@required String tmId ,@required String docId, @required String docName, @required String docEmail, @required String docCity, @required String docMobile}) async {

    Map<String, String> editDoctorBody = {
      "tmid": tmId  ,
      "Docid": docId  ,
      "Docemail": docEmail  ,
      "Docmobile": docMobile  ,
      "Docname": docName  ,
      "Doccity": docCity  ,

    };

    try {
      final response = await http.post(editDoctorUrl, body: editDoctorBody);
      final responseData = json.decode(response.body);

      notifyListeners();

    } catch (e) {
      print(e);
    }

  }
}
