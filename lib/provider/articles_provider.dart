import 'dart:convert';

import 'package:articleaapp/models/articles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticleProvider with ChangeNotifier{

  List<Article> _articles = [];

  List<Article> get getArticlesList {
    return [..._articles];
  }


  Future<void> getArticles(String username, String password) async {

    final articlesUrl = Uri.parse("https://fdcarticlealert.com/API_Article");

    Map<String, String> articlesBody = {
      "username": username,
      "password": password,
    };

    try {
      final response = await http.post(articlesUrl, body: articlesBody);
      final responseData = json.decode(response.body);
      final listData = responseData as List<dynamic>;
      _articles.clear();
      listData.map((e) => _articles.add(new Article(articleId: e["artiid"], articleFileUrl: e["Articlefile"], articleTitle: e["Arttitle"], articleType: e["Articletype"],
          journalTitle: e["journaltitle"], creationDate: e["createdDate"], modifiedDate: e["modifiedDate"]))).toList();
      notifyListeners();
      print("articles length : ${_articles.length}");
    } catch (e) {
      print(e);
    }

  }

  Future<void> assignArticle (String docId, String articleId) async {
    final assignArticleUrl = Uri.parse("https://fdcarticlealert.com/API_Article/assignarticletodoctor");

    Map<String, String> articlesBody = {
      "doc_id": docId,
      "article": articleId,
    };

    try {
      final response = await http.post(assignArticleUrl, body: articlesBody);
      final responseData = json.decode(response.body);

      print("assign response : $responseData");
    } catch (e) {
      print(e);
    }

  }

}