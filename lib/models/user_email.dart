import 'package:Portals/models/document_info.dart';

class UserEmailModel
{
  DocumentInfo ? documentInfo;
  String ? email;
  DateTime ? verifiedOn;

  UserEmailModel.fromJson(Map<String,dynamic> json)
  {
    email = json["email"];
    verifiedOn = json["verifiedOn"];
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "email": email,
    "verifiedOn": verifiedOn,
  };

}