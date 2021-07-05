import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:articleaapp/Database/database_helper.dart';
import 'package:articleaapp/models/city.dart';
import 'package:articleaapp/models/doctor.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorProvider with ChangeNotifier {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Doctor> _doctorsList = [];
  List<Doctor> _searchedList = [];
  List<City> _citiesList = [];

  List<Doctor> get getDoctorList {
    return [..._doctorsList];
  }
  List<Doctor> get getSearchedDoctorList {
    return [..._searchedList];
  }
  List<City> get getCitiesList {
    return [..._citiesList];
  }

  Uri addDoctorUrl =
      Uri.parse("https://fdcarticlealert.com/API_Doctor/insert");
  
  Uri getDoctorsUrl = Uri.parse("https://fdcarticlealert.com/API_Doctor/fetch_all");
  
  Uri editDoctorUrl = Uri.parse("https://fdcarticlealert.com/API_Doctor/update");
  
  Uri searchDoctorUrl = Uri.parse("https://fdcarticlealert.com/API_Doctor/search");

  Uri citiesUri = Uri.parse("https://fdcarticlealert.com/API_City");


  Future<void> addDoctor(
      {@required String docName,
      @required String docCity,
      @required String docMobile,
      @required String docEmail,
      @required String tmId}) async {

    var isConnectedVar = false;
    isConnected().then((value) => isConnectedVar = value);

    if(isConnectedVar) {
      Map<String, String> addDoctorBodyMap = {
        "Docname": docName,
        "Doccity": docCity,
        "Docmobile": docMobile,
        "Docemail": docEmail,
        "tmid": tmId,
      };
      try {
        await http.post(addDoctorUrl, body: addDoctorBodyMap);
      } catch (e) {
        print(e);
      }
    }else{
      Doctor doctor = Doctor(docName, docEmail, docMobile, tmId, docCity, 0);
      dbHelper.insertDoctor(doctor);
    }
  }
  
  
  Future<void> getDoctors(String tmId)  async {

    isConnected().then((value) async {
      if(value == true){
          print("inside if");
          Map<String, String> getDoctorsBody = {
            "tmid": tmId,
          };

          try {
            final response = await http.post(getDoctorsUrl, body: getDoctorsBody);
            final responseData = json.decode(response.body);
            final listData = responseData as List<dynamic>;
            dbHelper.deleteTable("doctorTable");
            _doctorsList.clear();
            listData.map((e) {
              print("inside loop");
              final doctor = Doctor(
                  e['Docname'], e['Docemail'], e['Docmobile'], e['TMid'],
                  e['Doccity'], 0 , e['Docid']);

              _doctorsList.add(doctor);
              dbHelper.insertDoctor(doctor);
            }
            ).toList();
            notifyListeners();
            print("length : ${_doctorsList.length}");
          } catch (e) {
            print(e);
          }
        } else{
          _doctorsList.clear();
          dbHelper.getDoctorsList().then((value) => _doctorsList.addAll(value));
          notifyListeners();
        }

    });


  }

  Future<void> getSearchList(String word, String tmid) async {
    var isConnectedVar = false;
    isConnected().then((value) => isConnectedVar = value);
    if(isConnectedVar) {
      Map<String, String> searchBody = {
        "doctor_detail": word,
        "tmid": tmid,
      };

      try {
        final response = await http.post(searchDoctorUrl, body: searchBody);
        final responseData = json.decode(response.body);
        final listData = responseData as List<dynamic>;

        _searchedList.clear();
        listData.map((e) =>
            _searchedList.add(new Doctor(
                e['Docname'], e['Docemail'], e['Docmobile'], e['TMid'],
                e['Doccity'], e['Docid']))).toList();
        notifyListeners();
        print("search length : ${_searchedList.length}");
        print(_searchedList);
      } catch (e) {
        print(e);
      }
    }else{
      _searchedList.clear();
      dbHelper.getDoctorsSearchedList(word).then((value) => _searchedList.addAll(value));
      notifyListeners();
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
      await http.post(editDoctorUrl, body: editDoctorBody);

      notifyListeners();

    } catch (e) {
      print(e);
    }

  }

  Future<void> getCities() async {
    try {
      final response = await http.get(citiesUri);
      final responseData = json.decode(response.body);
      final listData = responseData as List<dynamic>;
      _citiesList.clear();
      listData.map((e) => _citiesList.add(new City(cityId: e["Cityid"], cityName: e["Cityname"]))).toList();
      notifyListeners();
      print("city length : ${_citiesList.length}");
      print(_citiesList);
    } catch (e) {
      print(e);
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> isConnected() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
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
