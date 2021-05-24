import 'package:flutter/material.dart';

class ArticleCheckBoxItem extends StatelessWidget {
  final String number;
  final String title;

  const ArticleCheckBoxItem({Key key, this.number, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(number),
        title: Text(title),
        trailing: Checkbox(
          onChanged: (bool value) {},
          value: null,
        ));
  }
}
