import 'package:Portals/models/document_info.dart';

class UserPhoneNumberModel
{
  DocumentInfo ? documentInfo;
   String ? phoneNumber;

  UserPhoneNumberModel({this.documentInfo,required this.phoneNumber});

  UserPhoneNumberModel.fromJson(Map<String,dynamic> json)
  {
    phoneNumber = json["phoneNumber"];
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "phoneNumber": phoneNumber,
  };

}

