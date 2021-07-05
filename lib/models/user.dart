class User {
   String tmId, tmName, tmEmployeeCode, tmPw, tmMobile, tmEmail;

  User(this.tmId, this.tmName, this.tmEmployeeCode, this.tmPw, this.tmMobile, this.tmEmail);


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['tmId'] = tmId;
    map['tmName'] = tmName;
    map['tmEmployeeCode'] = tmEmployeeCode;
    map['tmPw'] = tmPw;
    map['tmMobile'] = tmMobile;
    map['tmEmail'] = tmEmail;

    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this.tmId = map['tmId'];
    this.tmName = map['tmName'];
    this.tmEmployeeCode = map['tmEmployeeCode'];
    this.tmPw = map['tmPw'];
    this.tmMobile = map['tmMobile'];
    this.tmEmail = map['tmEmail'];
  }
}