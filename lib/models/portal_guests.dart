import 'package:Portals/models/document_info.dart';

class PortalGuests{
  DocumentInfo ? documentInfo;
  GuestInfo ? guestInfo;
  UserInf ? userInfo;

  PortalGuests({
    this.documentInfo,
    required this.guestInfo,
    required this.userInfo,
  });

  PortalGuests.fromJson(Map<String,dynamic> json)
  {
    if(json["documentInfo"] != null) documentInfo = DocumentInfo.fromJson(json["documentInfo"]);
    if(json["guestInfo"] != null) guestInfo = GuestInfo.fromJson(json["guestInfo"]);
    if(json["userInfo"] != null) userInfo = UserInf.fromJson(json["userInfo"]);
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "guestInfo": guestInfo!.toJson(),
    "userInfo": userInfo!.toJson(),
  };

}

class GuestInfo
{
  String ? codename;
  String ? status;
  DateTime ? mutedOn;

  GuestInfo({
    required this.codename,
    required this.status,
    required this.mutedOn,
  });

  GuestInfo.fromJson(Map<String,dynamic> json)
  {
    codename = json["codename"]??"";
    status = json["status"]??"";
    if(json["mutedOn"] != null) mutedOn = json["mutedOn"].toDate();
  }

  Map<String,dynamic> toJson() => {
    "codename": codename,
    "status": status,
    "mutedOn": mutedOn,
  };

}

class UserInf
{
  String ? name;
  String ? imageUrl;
  String ? gender;
  DateTime ? dateOfBirth;

  UserInf({
    required this.name,
    required this.imageUrl,
    required this.gender,
    required this.dateOfBirth,
  });

  UserInf.fromJson(Map<String,dynamic> json)
  {
    name = json["name"];
    imageUrl = json["imageUrl"];
    gender = json["gender"];
    if(json["dateOfBirth"] != null) dateOfBirth = json["dateOfBirth"].toDate();
  }

  Map<String,dynamic> toJson() => {
    "name": name,
    "imageUrl": imageUrl,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
  };

}