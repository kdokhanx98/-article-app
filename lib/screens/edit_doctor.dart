import 'package:articleaapp/Database/database_helper.dart';
import 'package:articleaapp/models/city.dart';
import 'package:articleaapp/models/doctor.dart';
import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/provider/doctor_provider.dart';
import 'package:articleaapp/widgets/doctor_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';


class EditDoctorScreen extends StatefulWidget {
  static const routeName = '/EditDoctorScreen';

  @override
  _EditDoctorScreenState createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  GlobalKey<FormState> formKey = GlobalKey();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  bool isInitialize = true;
  bool isDone = false;
  var userId;

  List<City> searchCities = [];
  List<String> cities = [];
  String city;
  String cityId;

  saveForm(BuildContext context){
    final isValid = formKey.currentState.validate();

    if(!isValid){
      return;
    }else{
      searchCities.map((e) {
        if(e.cityName == city){
          cityId = e.cityId;
        }
      }).toList();
      setState(() {
        isDone = !isDone;
      });
      List<Doctor> doctors;
      final args = ModalRoute.of(context).settings.arguments as DoctorItem;
      final index = args.index;
      if(args.isSearch){
        doctors = Provider.of<DoctorProvider>(context, listen: false).getSearchedDoctorList;
      }else{
        doctors = Provider.of<DoctorProvider>(context, listen: false).getDoctorList;
      }
      getUserId().then((value) {
        formKey.currentState.save();
        Provider.of<DoctorProvider>(context, listen: false).updateDoctor(
            docName: nameController.text,
            docCity: cityId,
            docMobile: mobileController.text,
            docEmail: emailController.text,
            tmId: userId,
            docId: doctors[index].docId).then((value) {
          Fluttertoast.showToast(
              msg: "Updated Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          ).whenComplete(() =>
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Dashboard.routeName, (Route<dynamic> route) => false).then((
                  value) => setState(() {})));
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    final authProvider = Provider.of<AuthProvider>(context);

    if (isInitialize) {
      isInitialize = false;
      print("inside if");
      List<Doctor> doctorsList;
      final args = ModalRoute.of(context).settings.arguments as DoctorItem;
      final index = args.index;
      final docCity = args.docCity;
      if(!args.isSearch){
         doctorsList = Provider.of<DoctorProvider>(context).getDoctorList;
      }else{
        doctorsList = Provider.of<DoctorProvider>(context).getSearchedDoctorList;
      }

      authProvider.isConnected().then((value) {
        if(value){
          final docProvider = Provider.of<DoctorProvider>(context);
          docProvider.getCities().then((value) {
            searchCities = docProvider.getCitiesList;
            searchCities.map((e) {
              cities.add(e.cityName);
            }).toList();
          });
        }else{
          cities.clear();
          dbHelper.getCitiesList().then((value) {
            value.map((e) {
              cities.add(e.cityName);
            }).toList();
          });
        }
      });

      setState(() {
        nameController.text = doctorsList[index].docName;
        emailController.text = doctorsList[index].docEmail;
        mobileController.text = doctorsList[index].docMobile;
      });


      final docProvider = Provider.of<DoctorProvider>(context);
      if(docProvider.getCitiesList.length > 0) {
        searchCities = docProvider.getCitiesList;
        searchCities.map((e) {
          if(e.cityId == docCity){
            setState(() {
              city = e.cityName;
            });
          }
          cities.add(e.cityName);
        }).toList();

      }else {
        docProvider.getCities().then((value) {
          searchCities = docProvider.getCitiesList;
          searchCities.map((e) {
            if (e.cityId == docCity) {
              setState(() {
                city = e.cityName;
              });
            }
            cities.add(e.cityName);
          }).toList();
        });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Doctor"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Image.asset(
                        "assets/images/bran1.png",
                        width: MediaQuery.of(context).size.width * 0.24,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset("assets/images/logo.png",
                        width: MediaQuery.of(context).size.width * 0.4),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Image.asset("assets/images/bran2.png",
                          width: MediaQuery.of(context).size.width * 0.24),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Doctor Name",
                                labelStyle: TextStyle(fontSize: 18),
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                              style: TextStyle(fontSize: 15),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter doctor\'s name';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Doctor Email",
                                labelStyle: TextStyle(fontSize: 18),
                                hintStyle: TextStyle(
                                    color: Colors.green, fontSize: 10),
                              ),
                              style: TextStyle(fontSize: 15),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter doctor\'s email';
                                } else if (!isValidEmail(value)) {
                                  return 'Please enter valid email';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: city,
                                //elevation: 5,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                                isExpanded: true,

                                items:  cities.map<DropdownMenuItem<String>> (
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                hint: cities.length > 0 ? Text(
                                  "HQ/City -  No Selected",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ): Text("Loading data.."),
                                onChanged: (String value) {
                                  setState(() {
                                    city = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: mobileController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Mobile",
                                labelStyle: TextStyle(fontSize: 18),
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                              style: TextStyle(fontSize: 15),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter doctor\'s mobile';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50.0,
                  child: isDone == false ? RaisedButton(
                    onPressed: () {

                     saveForm(context);
                    },
                    textColor: Colors.white,
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 23.0,
                        fontFamily: "Schyler",
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ): Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    String email2 = email.trim();
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email2);
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(AuthProvider.tmIdKey);
    return userId;
  }
}
