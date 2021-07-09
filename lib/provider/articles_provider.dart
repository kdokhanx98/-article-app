import 'dart:convert';
import 'dart:io';

import 'package:articleaapp/Database/database_helper.dart';
import 'package:articleaapp/models/articles.dart';
import 'package:articleaapp/models/assign_article.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticleProvider with ChangeNotifier{
  DatabaseHelper dbHelper = DatabaseHelper();

  List<Article> _articles = [];

  List<Article> get getArticlesList {
    return [..._articles];
  }


  Future<void> getArticles(String username, String password) async {
    var isConnectedVar = false;
    await isConnected().then((value) => isConnectedVar = value);

    if(isConnectedVar) {
      final articlesUrl = Uri.parse("https://fdcarticlealert.com/API_Article");
      dbHelper.deleteTable("articleTable");
      Map<String, String> articlesBody = {
        "username": username,
        "password": password,
      };

      try {
        final response = await http.post(articlesUrl, body: articlesBody);
        final responseData = json.decode(response.body);
        print("res: $responseData");
        final listData = responseData as List<dynamic>;
        _articles.clear();
        listData.map((e) {
          _articles.add(new Article(articleId: e["artiid"],
              articleFileUrl: e["Articlefile"],
              articleTitle: e["Arttitle"],
              articleType: e["Articletype"],
              journalTitle: e["journaltitle"],
              creationDate: e["createdDate"],
              modifiedDate: e["modifiedDate"]));

          dbHelper.addArticle(Article(articleId: e["artiid"],
              articleFileUrl: e["Articlefile"],
              articleTitle: e["Arttitle"],
              articleType: e["Articletype"],
              journalTitle: e["journaltitle"],
              creationDate: e["createdDate"],
              modifiedDate: e["modifiedDate"]));

        }).toList();

        notifyListeners();
        print("articles length : ${_articles.length}");
      } catch (e) {
        print(e);
      }
    }else{
      _articles.clear();
      await dbHelper.getArticlesList().then((value) => _articles.addAll(value));
      if(_articles.length > 0){
        notifyListeners();
      }

    }

  }

  Future<void> assignArticle ({String docId, String articleId, bool cleanData = false}) async {
    var isConnectedVar = false;
    await isConnected().then((value) => isConnectedVar = value);

    if(isConnectedVar) {
      final assignArticleUrl = Uri.parse(
          "https://fdcarticlealert.com/API_Article/assignarticletodoctor");

      Map<String, String> articlesBody = {
        "doc_id": docId,
        "article": articleId,
      };

      try {
       await http.post(assignArticleUrl, body: articlesBody);
        print("assigned article online");
        if(cleanData){
          print("data cleaned");
          dbHelper.deleteTable("articleOfflineTable");
        }

      } catch (e) {
        print(e);
      }
    }else{
      print("added article offline");
      AssignArticle article = AssignArticle(docId: docId, articlesIds: articleId);
      dbHelper.insertArticle(article);
    }

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
      return false;
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }

  }

}