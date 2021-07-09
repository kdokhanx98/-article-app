class AssignArticle {
  String docId, articlesIds;
  AssignArticle({this.docId, this.articlesIds});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['docId'] = docId;
    map['articlesIds'] = articlesIds;


    return map;
  }

  AssignArticle.fromMapObject(Map<String, dynamic> map) {
    this.docId = map['docId'];
    this.articlesIds = map['articlesIds'];
  }
}