import 'package:Portals/models/document_info.dart';

class Friends
{
  DocumentInfo ? documentInfo;
  FriendData ? friend;
  FriendStatus ? status;

  Friends({this.documentInfo ,this.friend});

  Friends.fromJson(Map<String,dynamic> json){
    documentInfo = DocumentInfo.fromJson(json["documentInfo"]);
    friend = FriendData.fromJson(json["friend"]);
    status = FriendStatus.fromJson(json["statusMap"]);
  }

}

class FriendData
{
  String ? id;
  String ? gender;
  String ? imageUrl;
  String ? name;

  FriendData(this.id,this.gender,this.imageUrl,this.name);


  FriendData.fromJson(Map<String,dynamic> json){
    id = json["id"];
    gender = json["gender"];
    imageUrl = json["imageUrl"];
    name = json["name"];
  }

}

class FriendStatus
{
  String ? status;
  DateTime ? acceptedOn;
  DateTime ? rejectedOn;

  FriendStatus(this.status,this.acceptedOn,this.rejectedOn);


  FriendStatus.fromJson(Map<String,dynamic> json){
    status = json["status"];
    if(json["acceptedOn"] != null) acceptedOn = json["acceptedOn"].toDate();
    if(json["rejectedOn"] != null) rejectedOn = json["rejectedOn"].toDate();
  }

}