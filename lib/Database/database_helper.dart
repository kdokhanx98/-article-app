import 'dart:io';

import 'package:articleaapp/models/articles.dart';
import 'package:articleaapp/models/assign_article.dart';
import 'package:articleaapp/models/city.dart';
import 'package:articleaapp/models/dashboard.dart';
import 'package:articleaapp/models/doctor.dart';
import 'package:articleaapp/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper helperData;
  static Database db;
  String docTableName = "doctorTable";
  String articleTableName = "articleTable";
  String cityTableName = "cityTable";
  String userTableName = "userTable";
  String dashboardTableName = "dashTable";
  String docOfflineTableName = "docOfflineTable";
  String articleOfflineTableName = "articleOfflineTable";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (helperData == null) {
      helperData = DatabaseHelper._createInstance();
    }
    return helperData;
  }

  Future<Database> get database async {
    if (db == null) {
      db = await initialDatabase();
    }
    return db;
  }

  Future<Database> initialDatabase() async {
    Directory dic = await getApplicationDocumentsDirectory();
    String path = dic.path + "doc.db";

    var taskDB = await openDatabase(path, version: 1, onCreate: createDatabase);
    return taskDB;
  }

  void createDatabase(Database dbCreate, int versionCreate) async {
    await dbCreate.execute(
        "CREATE TABLE $docTableName(docId TEXT, docName TEXT, docMobile TEXT, tmId TEXT, docCity TEXT, docEmail TEXT, isDone INTEGER)");

    await dbCreate.execute(
        "CREATE TABLE $articleTableName(articleId TEXT, articleType TEXT, articleTitle TEXT, journalTitle TEXT, articleFileUrl TEXT, creationDate TEXT, modifiedDate TEXT, isDone INTEGER)");

    await dbCreate.execute(
        "CREATE TABLE $articleOfflineTableName(docId TEXT, articlesIds TEXT)");

    await dbCreate.execute(
        "CREATE TABLE $cityTableName(cityName TEXT, cityId TEXT)");

    await dbCreate.execute(
        "CREATE TABLE $userTableName(tmId TEXT, tmName TEXT, tmEmployeeCode TEXT, tmPw TEXT, tmMobile TEXT, tmEmail TEXT)");

    await dbCreate.execute(
        "CREATE TABLE $dashboardTableName(doctorsNo INTEGER, articlesNo INTEGER)");

    await dbCreate.execute(
        "CREATE TABLE $docOfflineTableName(docId TEXT, docName TEXT, docMobile TEXT, tmId TEXT, docCity TEXT, docEmail TEXT, isDone INTEGER)");

  }

  Future<void> deleteTable(String tableName) async {
    await db.execute(
      "DELETE FROM $tableName"
    );
  }

  Future<List<Map<String, dynamic>>> getTable(String tableName) async {
    Database dbMap = await this.database;

    var result = await dbMap.query(tableName);
    return result;
  }

  Future<int> insertDoctor(Doctor doctor) async {
    Database dbInsert = await this.database;
    var result = await dbInsert.insert(docOfflineTableName, doctor.toMap());
    return result;
  }

  Future<int> addDoctor(Doctor doctor) async {
    Database dbInsert = await this.database;
    var result = await dbInsert.insert(docTableName, doctor.toMap());
    return result;
  }

  Future<int> insertUser(User user) async {
    Database dbInsert = await this.database;
    var result = await dbInsert.insert(userTableName, user.toMap());
    print("result is : $result");
    return result;
  }

  Future<int> insertArticle(AssignArticle article) async {
    Database dbInsert = await this.database;
    var result = await dbInsert.insert(articleOfflineTableName, article.toMap());
    return result;
  }

  Future<int> addArticle(Article article) async {
    Database dbInsert = await this.database;
    var result = await dbInsert.insert(articleTableName, article.toMap());
    return result;
  }

  Future<int> insertCity(City city) async {
    Database dbInsert = await this.database;
    var result = await dbInsert.insert(cityTableName, city.toMap());
    return result;
  }

  Future<int> insertDashData(DashboardData dashboardData) async {
    Database dbInsert = await this.database;
    var result = await dbInsert.insert(dashboardTableName, dashboardData.toMap());
    return result;
  }

  Future<List<DashboardData>> getDashDataList() async {
    var mapListData = await getTable(dashboardTableName);
    int count = mapListData.length;

    List<DashboardData> docGets = [];

    for (int i = 0; i <= count - 1; i++) {
      docGets.add(DashboardData.fromMapObject(mapListData[i]));
    }
    print('data size : ${docGets.length}');
    return docGets;
  }

  Future<List<Doctor>> getDoctorsList() async {
    var mapListData = await getTable(docTableName);
    int count = mapListData.length;

    List<Doctor> docGets = [];

    for (int i = 0; i <= count - 1; i++) {
      docGets.add(Doctor.fromMapObject(mapListData[i]));
    }
    print('data size : ${docGets.length}');
    return docGets;
  }

  Future<List<Doctor>> getDoctorsOfflineList() async {
    var mapListData = await getTable(docOfflineTableName);
    int count = mapListData.length;

    List<Doctor> docGets = [];

    for (int i = 0; i <= count - 1; i++) {
      docGets.add(Doctor.fromMapObject(mapListData[i]));
    }
    print('data size : ${docGets.length}');
    return docGets;
  }


  Future<List<Article>> getArticlesList() async {
    var mapListData = await getTable(articleTableName);
    int count = mapListData.length;

    List<Article> articleGets = [];

    for (int i = 0; i <= count - 1; i++) {
      articleGets.add(Article.fromMapObject(mapListData[i]));
    }
    print('data size : ${articleGets.length}');
    return articleGets;
  }

  Future<List<AssignArticle>> getArticlesOfflineList() async {
    var mapListData = await getTable(articleOfflineTableName);
    int count = mapListData.length;

    List<AssignArticle> articleGets = [];

    for (int i = 0; i <= count - 1; i++) {
      articleGets.add(AssignArticle.fromMapObject(mapListData[i]));
    }
    print('data size : ${articleGets.length}');
    return articleGets;
  }

  Future<List<City>> getCitiesList() async {
    var mapListData = await getTable(cityTableName);
    int count = mapListData.length;

    List<City> cityGets = [];

    for (int i = 0; i <= count - 1; i++) {
      cityGets.add(City.fromMapObject(mapListData[i]));
    }
    print('data size : ${cityGets.length}');
    return cityGets;
  }

  Future<List<User>> getUsersList() async {
    var mapListData = await getTable(userTableName);
    int count = mapListData.length;

    List<User> userGets = [];

    for (int i = 0; i <= count - 1; i++) {
      userGets.add(User.fromMapObject(mapListData[i]));
    }
    print('data size : ${userGets.length}');
    return userGets;
  }


  Future<List<Doctor>> getDoctorsSearchedList(String keyWord) async {
  var data;

    await getDoctorsList().then((value) {
      data = value.where((element) {
        print("element: ${element.docName}");
        if(element.docName.contains(keyWord) || element.docEmail.contains(keyWord)) {
          print("element contained: ${element.docName}");
          return true;
        }
        return false;
      }).toList();
    });
    return data;

  }


}
