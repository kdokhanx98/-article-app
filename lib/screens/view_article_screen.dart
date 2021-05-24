import 'package:articleaapp/models/articles.dart';
import 'package:articleaapp/widgets/articlee_item.dart';
import 'package:flutter/material.dart';

class ViewArticleScreen extends StatelessWidget {
  static const routeName = '/ViewArticleScreen';

  @override
  Widget build(BuildContext context) {
    print(myArticls.length);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "View Article",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ArticleItem(
                    number: (index + 1).toString(),
                    title: myArticls[index].title,
                  ),
                  itemCount: myArticls.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text(
          'Assign Article',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.thumb_up,
          color: Colors.white,
        ),
        backgroundColor: Colors.pink,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
