import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final String number;
  final String title;

  const ArticleItem({Key key, this.number, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(number),
      title: Text(title),
      trailing: Container(
        width: 80,
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(5)),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 30,
              height: 30,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(5)),
            )
          ],
        ),
      ),
    );
  }
}
