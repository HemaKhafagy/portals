import 'package:Portals/models/document_info.dart';

class UserLevelsModel
{

  DocumentInfo ? documentInfo;
  String ? levelRef;
  String ? title;
  double ? order;

  UserLevelsModel({this.documentInfo,required this.levelRef,required this.title,required this.order});

  UserLevelsModel.fromJson(Map<String,dynamic> json)
  {
    levelRef = json["levelRef"];
    title = json["title"];
    order = json["order"];
  }

  Map<String,dynamic> toJson() => {
    if(documentInfo != null)
    "documentInfo": documentInfo!.toJson(),
    if(levelRef != null)
    "levelRef": levelRef,
    if(title != null)
    "title": title,
    if(order != null)
    "order": order,
  };
}