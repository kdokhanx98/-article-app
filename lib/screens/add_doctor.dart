import 'dart:math';

import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/provider/dashboard_provider.dart';
import 'package:articleaapp/provider/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';


class AddDoctorScreen extends StatefulWidget {

  static const routeName = '/AddDoctorScreen';


  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();

  
  saveForm(BuildContext context){
    final isValid = formKey.currentState.validate();

    if(!isValid){
      return;
    }else{
      final userId = Provider.of<AuthProvider>(context, listen: false).userId;
      formKey.currentState.save();
      Provider.of<DoctorProvider>(context, listen: false).addDoctor(docName: nameController.text, docCity: cityController.text, docMobile: mobileController.text, docEmail: emailController.text, tmId: userId).then((value)  {
      Fluttertoast.showToast(
      msg: "Added Successfully",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
      ).whenComplete(() {
        var dashProvider = Provider.of<DashboardPorivder>(context, listen: false);
        dashProvider.getArticlesNo(userId);
        dashProvider.getDoctorsNo(userId).then((value) => Navigator.of(context).pop());

      });

      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New Doctor"),
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
                      width: 10,
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
                                }else if(!isValidEmail(value)){
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
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: cityController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "City",
                                labelStyle: TextStyle(fontSize: 18),
                                hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                              style: TextStyle(fontSize: 15),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter doctor\'s city';
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
                                  return 'Enter Doctor\'s mobile';
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                     saveForm(context);
                    
                    },
                    textColor: Colors.white,
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 23.0,
                        fontFamily: "Schyler",
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
