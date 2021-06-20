class Article {
  final String articleId;
  final String articleType;
  final String articleTitle;
  final String journalTitle;
  final String articleFileUrl;
  final String creationDate;
  final String modifiedDate;
  bool isChecked = false;

  Article(
      {this.articleId,
      this.articleType,
      this.articleTitle,
      this.journalTitle,
      this.articleFileUrl,
      this.creationDate,
      this.modifiedDate});
}
