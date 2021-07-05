class Article {
   String articleId;
   String articleType;
   String articleTitle;
   String journalTitle;
   String articleFileUrl;
   String creationDate;
   String modifiedDate;
  bool isChecked = false;

  Article(
      {this.articleId,
      this.articleType,
      this.articleTitle,
      this.journalTitle,
      this.articleFileUrl,
      this.creationDate,
      this.modifiedDate});


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['articleId'] = articleId;
    map['articleType'] = articleType;
    map['articleTitle'] = articleTitle;
    map['journalTitle'] = journalTitle;
    map['articleFileUrl'] = articleFileUrl;
    map['creationDate'] = creationDate;
    map['modifiedDate'] = modifiedDate;

    return map;
  }

   Article.fromMapObject(Map<String, dynamic> map) {
    this.articleId = map['articleId'];
    this.articleType = map['articleType'];
    this.articleTitle = map['articleTitle'];
    this.journalTitle = map['journalTitle'];
    this.articleFileUrl = map['articleFileUrl'];
    this.creationDate = map['creationDate'];
    this.modifiedDate = map['modifiedDate'];
  }


}
