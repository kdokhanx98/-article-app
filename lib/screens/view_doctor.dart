import 'package:articleaapp/models/articles.dart';
import 'package:articleaapp/models/doctor.dart';
import 'package:articleaapp/widgets/doctor_item.dart';
import 'package:flutter/material.dart';

class ViewDoctor extends StatefulWidget {
  static const routeName = '/ViewDoctor';

  @override
  _ViewDoctorState createState() => _ViewDoctorState();
}

class _ViewDoctorState extends State<ViewDoctor> {
  @override
  Widget build(BuildContext context) {
    print(myArticls.length);

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctors List"),
        centerTitle: true,
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
                      padding: const EdgeInsets.only(top: 5),
                      child: Image.asset(
                        "assets/images/bran1.png",
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset("assets/images/bran2.png",
                        width: MediaQuery.of(context).size.width * 0.4)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => DoctorItem(
                    number: (index + 1).toString(),
                    drName: doctors[index].drName,
                    drEmail: doctors[index].drEmail,
                    drNumber: doctors[index].drNumber,
                    indxe: index,
                  ),
                  itemCount: doctors.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
