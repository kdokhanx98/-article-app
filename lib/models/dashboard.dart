class DashboardData {
  int doctorsNo, articlesNo;
  DashboardData(this.doctorsNo, this.articlesNo);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['doctorsNo'] = doctorsNo;
    map['articlesNo'] = articlesNo;
    return map;
  }

  DashboardData.fromMapObject(Map<String, dynamic> map) {
    this.doctorsNo = map['doctorsNo'];
    this.articlesNo = map['articlesNo'];
  }
}