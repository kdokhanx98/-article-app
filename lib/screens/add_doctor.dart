import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final tmData = <String>[
    'TM1',
    'TM2',
    'TM3',
    'TM4',
    'TM5',
    'TM6',
  ];
  String tm = null;

  final stringData = <String>[
    'Bengaluru',
    'Delhi',
    'Hyderabad',
    'Mumbai',
    'Pune',
    'Thane',
  ];
  String city = null;
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
                        //   GestureDetector(
                        //     onTap: () {},
                        //     child: GestureDetector(
                        //       onTap: () {},
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //           border: Border.all(color: Colors.grey),
                        //           borderRadius: BorderRadius.circular(5),
                        //         ),
                        //         child: Padding(
                        //           padding: EdgeInsets.symmetric(
                        //               horizontal: 20, vertical: 0),
                        //           child: DropdownButtonHideUnderline(
                        //             child: DropdownButton<String>(
                        //               value: tm,
                        //               //elevation: 5,
                        //               icon: Icon(
                        //                 Icons.arrow_drop_down,
                        //                 color: Colors.grey,
                        //               ),
                        //               style: TextStyle(
                        //                   color: Colors.black, fontSize: 17),
                        //               isExpanded: true,
                        //               items: <String>[
                        //                 'TM1',
                        //                 'TM2',
                        //                 'TM3',
                        //                 'TM4',
                        //                 'TM5',
                        //                 'TM6',
                        //               ].map<DropdownMenuItem<String>>(
                        //                   (String value) {
                        //                 return DropdownMenuItem<String>(
                        //                   value: value,
                        //                   child: Text(value),
                        //                 );
                        //               }).toList(),
                        //               hint: Text(
                        //                 "TM -  No Selected",
                        //                 style: TextStyle(
                        //                   fontSize: 18,
                        //                   color: Colors.grey,
                        //                 ),
                        //               ),
                        //               onChanged: (String value) {
                        //                 setState(() {
                        //                   tm = value;
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
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
                                if (value.isEmpty || value.length < 5) {
                                  return 'الرجاء إدخال اسم صحيح';
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
                                if (value.isEmpty || value.length < 5) {
                                  return 'الرجاء إدخال اسم صحيح';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
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
                                    items: <String>[
                                      'Bengaluru',
                                      'Delhi',
                                      'Hyderabad',
                                      'Mumbai',
                                      'Pune',
                                      'Thane',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "City -  No Selected",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        city = value;
                                      });
                                    },
                                  ),
                                ),
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
                                if (value.isEmpty || value.length < 5) {
                                  return 'الرجاء إدخال اسم صحيح';
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
                      Navigator.of(context).pushNamed(Dashboard.routeName);
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
}
