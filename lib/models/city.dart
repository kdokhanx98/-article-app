
class City {
   String cityName;
   String cityId;

  City({this.cityName, this.cityId});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['cityName'] = cityName;
    map['cityId'] = cityId;


    return map;
  }

  City.fromMapObject(Map<String, dynamic> map) {
    this.cityName = map['cityName'];
    this.cityId = map['cityId'];

  }

}