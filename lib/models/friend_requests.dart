import 'package:Portals/models/document_info.dart';

class FriendRequests
{
  DocumentInfo ? documentInfo;
  String ? sentTo;
  String ? status;

  FriendRequests({required this.sentTo,required this.status});

  FriendRequests.fromJson(Map<String,dynamic> json){
    sentTo = json["sentTo"];
    status = json["status"];
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "sentTo": sentTo,
    "status": status,
  };
}