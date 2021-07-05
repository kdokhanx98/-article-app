import 'package:articleaapp/models/articles.dart';
import 'package:articleaapp/provider/articles_provider.dart';
import 'package:articleaapp/provider/auth_provider.dart';
import 'package:articleaapp/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  List<String> checkedArticlesIds = [];
  String docId;
  bool isDone = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {

    if (isInitialized) {
      isInitialized = false;
      docId = ModalRoute.of(context).settings.arguments as String;
      var articleProvider = Provider.of<ArticleProvider>(context, listen: true);
      if(articleProvider.getArticlesList.length > 0){
        articles = articleProvider.getArticlesList;
        articles.map((e) {
          if(e.isChecked){
            e.isChecked = false;
          }
        }
        ).toList();
        return;
      }

      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      var username = authProvider.employeeCode;
      var password = authProvider.employeePass;


      articleProvider.getArticles(username, password).then((value) =>  articles = articleProvider.getArticlesList);

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
              articles.length > 0
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              articles[index].isChecked =
                                  !articles[index].isChecked;
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
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                        child: CircularProgressIndicator(),
                      )),
            ],
          ),
        ),
      ),
      floatingActionButton:  counter > 0 ? FloatingActionButton.extended(
        onPressed: !isDone ?  () {
          checkedArticlesIds.clear();
          setState(() {
            isDone = !isDone;
          });
       articles.where((element)  {
            if(element.isChecked){
              checkedArticlesIds.add(element.articleId);
              return true;
            }
            return false;
          }).toList();
          String checkedArticles = checkedArticlesIds.join(',');
          Provider.of<ArticleProvider>(context, listen: false)
              .assignArticle(docId, checkedArticles)
              .then((value) {
            Fluttertoast.showToast(
                    msg: "Assigned Successfully",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0)
                .whenComplete(() {
              Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
            });
          });
        } : null,
        label: Row(
          children: !isDone ? [
            Text(
              'Assign Article  ',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            Text(
              '$counter',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ] : [
            Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white,),
      )],
        ),
        backgroundColor: Colors.pink,
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
