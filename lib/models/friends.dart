import 'package:Portals/models/document_info.dart';

class Friends
{

  DocumentInfo ? documentInfo;
  //members contains friends userId
  List<String> ? members;
  String ? status;

  Friends({required this.members,required this.status});

  Friends.fromJson(Map<String,dynamic> json){
    members = json["members"];
    status = json["status"];
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "item": members,
    "status": status,
  };
}