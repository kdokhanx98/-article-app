import 'package:articleaapp/models/articles.dart';
import 'package:articleaapp/models/doctor.dart';
import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/provider/doctor_provider.dart';
import 'package:articleaapp/widgets/doctor_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewDoctor extends StatefulWidget {
  static const routeName = '/ViewDoctor';
  @override
  _ViewDoctorState createState() => _ViewDoctorState();
}

class _ViewDoctorState extends State<ViewDoctor> {
  bool isSearchClicked = false;
  bool isInitialize = true;
  List<Doctor> doctorsList = [];

  @override
  void didChangeDependencies() {
    var provider = Provider.of<DoctorProvider>(context);
    if(isInitialize) {
      final userId = Provider.of<AuthProvider>(context).userId;
      Provider.of<DoctorProvider>(context, listen: false).getDoctors(userId).then((value) => doctorsList = provider.getDoctorList);
        isInitialize = false;
    }
    super.didChangeDependencies();
    }

  @override
  Widget build(BuildContext context) {

    print(myArticls.length);

    return Scaffold(
      appBar: AppBar(
        title: isSearchClicked == false
            ? Text("Doctors List")
            : Container(
                decoration: BoxDecoration(
                  color: Colors.black38.withAlpha(10),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20.0),
                          hintText: "Search ..",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (String keyword) {},
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 30.0,
                        ),
                        onPressed: () {
                          setState(() {
                            isSearchClicked = !isSearchClicked;
                          });
                        })
                  ],
                ),
              ),
        centerTitle: true,
        actions: [
          isSearchClicked == false
              ? Padding(
                  padding: const EdgeInsets.only(right: 15.5),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                    onPressed: () {
                      setState(() {
                        isSearchClicked = !isSearchClicked;
                      });
                    },
                  ),
                )
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
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
              doctorsList.length > 0 ? Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => DoctorItem(
                    number: (index + 1).toString(),
                    drName: doctorsList[index].docName,
                    drEmail: doctorsList[index].docEmail,
                    drNumber: doctorsList[index].docMobile,
                    indxe: index,
                  ),
                  itemCount: doctorsList.length,
                ),
              ) : Center(child: CircularProgressIndicator()) ,
            ],
          ),
        ),
      ),
    );
  }
}
