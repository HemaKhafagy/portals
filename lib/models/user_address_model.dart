import 'package:Portals/models/document_info.dart';

class UserAddressModel
{

  DocumentInfo ? documentInfo;
  GeoPoint ? geopoint;
  String ? city;
  String ? country;
  bool ? isMain;

  UserAddressModel({
    this.documentInfo,
    required this.geopoint,
    required this.city,
    required this.country,
    required this.isMain,
  });

  UserAddressModel.fromJson(Map<String,dynamic> json)
  {
    geopoint = GeoPoint.fromJson(json["geopoint"]);
    city = json["city"];
    country = json["country"];
    isMain = json["isMain"];
  }

  Map<String,dynamic> toJson() => {
    if(documentInfo != null)
    "documentInfo": documentInfo!.toJson(),
    if(geopoint != null)
    "geopoint": geopoint!.toJson(),
    if(city != null)
    "city": city,
    if(country != null)
    "country": country,
    if(isMain != null)
    "isMain": isMain,
  };

}

class GeoPoint
{
  dynamic lat;
  dynamic lng;

  GeoPoint({required lat,required lng});

  GeoPoint.fromJson(Map<String,dynamic> json){
    lat = json["lat"];
    lng = json["lng"];
  }

  Map<String,dynamic> toJson() => {
    "geopoint": {
      "lat": lat,
      "lng": lng,
    }
  };
}