class Doctor {

   String docName;
   String docEmail;
   String docMobile;
   String tmId;
   String docCity;
   String docId;
   int isDone;

  Doctor(this.docName, this.docEmail, this.docMobile, this.tmId, this.docCity, [this.isDone = 0, this.docId]);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['docId'] = docId;
    map['docName'] = docName;
    map['docEmail'] = docEmail;
    map['docMobile'] = docMobile;
    map['tmId'] = tmId;
    map['docCity'] = docCity;
    map['isDone'] = 0;

    return map;
  }

  Doctor.fromMapObject(Map<String, dynamic> map) {
    this.docId = map['docId'];
    this.docName = map['docName'];
    this.docEmail = map['docEmail'];
    this.docMobile = map['docMobile'];
    this.tmId = map['tmId'];
    this.docCity = map['docCity'];
    this.isDone = map['isDone'];

  }



}


