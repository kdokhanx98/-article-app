import 'package:articleaapp/models/articles.dart';
import 'package:articleaapp/provider/articles_provider.dart';
import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/screens/dashboard.dart';
import 'package:articleaapp/screens/view_doctor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewArticle extends StatefulWidget {
  static const routeName = '/ViewArticle';

  @override
  _ViewArticleState createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  int counter = 0;
  bool isInitialized = true;
  List<Article> articles = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {

    if(isInitialized){
      isInitialized = false;
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      var articleProvider = Provider.of<ArticleProvider>(context, listen: false);
      var username = authProvider.username;
      var password = authProvider.password;
      articleProvider.getArticles(username, password);
      articles = articleProvider.getArticlesList;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Assign Articles"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Articles",
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
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
            /*            getMyArticls[index].isChecked =
                            !getMyArticls[index].isChecked;
                        if (myArticls[index].isChecked) {
                          counter += 1;
                        } else {
                          if (counter == 0) {
                            counter = 0;
                          } else {
                            counter -= 1;
                          }
                        }*/
                      });
                    },
                    child: ListTile(
                        leading: Text((index + 1).toString()),
                        title: Text(articles[index].articleTitle),
                        trailing: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.pink,
                          onChanged: (bool value) {
                            setState(() {
                              articles[index].isChecked = value;
                              if (articles[index].isChecked) {
                                counter += 1;
                              } else {
                                if (counter == 0) {
                                  counter = 0;
                                } else {
                                  counter -= 1;
                                }
                              }
                            });
                          },
                          value: articles[index].isChecked,
                        )),
                  ),
                  itemCount: articles.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
        },
        label: Row(
          children: [
            Text(
              'Assign Article  ',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            Text(
              '$counter',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        backgroundColor: Colors.pink,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
