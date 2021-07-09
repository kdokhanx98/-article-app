
import 'package:articleaapp/Database/database_helper.dart';
import 'package:articleaapp/models/city.dart';
import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/provider/dashboard_provider.dart';
import 'package:articleaapp/provider/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AddDoctorScreen extends StatefulWidget {

  static const routeName = '/AddDoctorScreen';



  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<City> searchCities = [];
  List<String> cities = [];
  GlobalKey<FormState> formKey = GlobalKey();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  bool isInitialized = true;
  bool isDone = false;
  String city;
  String cityId;
  var userId;


  @override
  void didChangeDependencies() {
    var authProvider = Provider.of<AuthProvider>(context);
    final docProvider = Provider.of<DoctorProvider>(context);
    if (isInitialized) {
      isInitialized = false;

      if(docProvider.getCitiesList.length > 0){
        searchCities = docProvider.getCitiesList;
        if(cities.length == 0) {
          searchCities.map((e) {
            cities.add(e.cityName);
          }).toList();
        }
        return;
      }

      authProvider.isConnected().then((value) {
        if(value){
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


    }

    super.didChangeDependencies();
  }




  saveForm(BuildContext context){
    final isValid = formKey.currentState.validate();

    if(!isValid || city == null || city.isEmpty){
      Fluttertoast.showToast(msg: "Please choose a city");
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

      getUserId().then((value)  {
          formKey.currentState.save();
      Provider.of<DoctorProvider>(context, listen: false).addDoctor(docName: nameController.text, docCity: cityId,
          docMobile: mobileController.text, docEmail: emailController.text, tmId: userId).then((value)  {

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
          dashProvider.getDoctorsNo(userId).whenComplete(() => Navigator.of(context).pop());

        });

      });
      });


    }
  }

  @override
  Widget build(BuildContext context) {
    print(cities.length);
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
                              "City -  No Selected",
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50.0,
                  child: isDone == false ? RaisedButton(
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
                  ) : Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),),
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
