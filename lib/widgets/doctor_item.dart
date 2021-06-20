import 'package:articleaapp/screens/edit_doctor.dart';
import 'package:articleaapp/screens/view_article.dart';
import 'package:flutter/material.dart';

class DoctorItem extends StatelessWidget {
  final String drName;
  final String drEmail;
  final String drNumber;
  final String number;
  final int index;
  final bool isSearch;

  const DoctorItem(
      {Key key,
        this.drName,
        this.drEmail,
        this.drNumber,
        this.number,
        this.index,
        this.isSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(number),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Text(
                        drName,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        drEmail,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          child:
                          Text(drNumber, style: TextStyle(fontSize: 15))),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.52,
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(ViewArticle.routeName);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).accentColor,
                                ),
                                child: Text("Assign Article")),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    EditDoctorScreen.routeName,
                                    arguments: DoctorItem(isSearch: isSearch, index: index,));
                              },
                              child: Text("Edit"),
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
