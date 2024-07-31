import 'package:Portals/models/document_info.dart';

class UserBadgesModel
{
  DocumentInfo ? documentInfo;
  String ? badgeRef;
  String ? title;

  UserBadgesModel({this.documentInfo,required this.badgeRef,required this.title});

  UserBadgesModel.fromJson(Map<String,dynamic> json)
  {
    badgeRef = json["badgeRef"];
    title = json["title"];
  }

  Map<String,dynamic> toJson() => {
    if(documentInfo !=null)
    "documentInfo": documentInfo!.toJson(),
    if(badgeRef !=null)
    "badgeRef": badgeRef,
    if(title !=null)
    "title": title,
  };

}