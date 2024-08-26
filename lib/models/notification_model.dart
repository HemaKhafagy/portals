import 'package:Portals/models/document_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class NotificationModel
{
  DocumentInfo ? documentInfo;
  String ? type;
  NotificationSender ? notificationSender;
  GameInvite ? gameInvite;
  PortalInvite ? portalInvite;
  PortalAccessRequest ? portalAccessRequest;
  StatusMap ? statusMap;

  NotificationModel.fromJson(Map<String,dynamic> json)
  {
    documentInfo = DocumentInfo.fromJson(json["documentInfo"]);
    type = json["type"];
    if(json["sender"] != null) notificationSender = NotificationSender.fromJson(json["sender"]);
    if(json["gameInvite"] != null) gameInvite = GameInvite.fromJson(json["gameInvite"]);
    if(json["portalInvite"] != null) portalInvite = PortalInvite.fromJson(json["portalInvite"]);
    if(json["portalAccessRequest"] != null) portalAccessRequest = PortalAccessRequest.fromJson(json["portalAccessRequest"]);
    statusMap = StatusMap.fromJson(json["statusMap"]);
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "type": type,
    // "notificationSender": notificationSender!.toJson(),
    "gameInvite": gameInvite!.toJson(),
    "portalInvite": portalInvite!.toJson(),
    "portalAccessRequest": portalAccessRequest!.toJson(),
    "statusMap": statusMap!.toJson(),
  };

}

class NotificationSender
{
  String ? verifiedOn;
  String ? name;
  String ? imageUrl;
  String ? id;
  int ? age;

  NotificationSender({required this.verifiedOn,required this.name,required this.imageUrl,required this.age});

  NotificationSender.fromJson(Map<String,dynamic> json){
    verifiedOn = json["verifiedOn"];
    name = json["name"];
    imageUrl = json["imageUrl"];
    id = json["id"];
    age = json["age"];
  }

  Map<String,dynamic> toJson() => {
    "verifiedOn": verifiedOn,
    "name": name,
    "imageUrl": imageUrl,
    "id": id,
    "age": age,
  };
}

class GameInvite
{
  String ? gameRef;
  String ? gameTitle;

  GameInvite({required this.gameRef,required this.gameTitle});

  GameInvite.fromJson(Map<String,dynamic> json){
    gameRef = json['gameRef'];
    gameTitle = json['gameTitle'];
  }

  Map<String,dynamic> toJson() => {
    "gameRef": gameRef,
    "gameTitle": gameTitle,
  };
}

class PortalInvite
{
  String ? portalRef;
  String ? portalTitle;
  String ? imageUrl;

  PortalInvite({required this.portalRef,required this.portalTitle,required this.imageUrl});

  PortalInvite.fromJson(Map<String,dynamic> json){
    portalRef = json['portalRef'];
    portalTitle = json['portalTitle'];
    imageUrl = json['imageUrl'];
  }

  Map<String,dynamic> toJson() => {
    "portalRef": portalRef,
    "portalTitle": portalTitle,
    "imageUrl": imageUrl,
  };
}

class PortalAccessRequest
{
  String ? portalRef;
  String ? portalTitle;

  PortalAccessRequest({required this.portalRef,required this.portalTitle});

  PortalAccessRequest.fromJson(Map<String,dynamic> json){
    portalRef = json['portalRef'];
    portalTitle = json['portalTitle'];
  }

  Map<String,dynamic> toJson() => {
    "portalRef": portalRef,
    "portalTitle": portalTitle,
  };
}

class StatusMap
{
  String ? status;
  DateTime ? acceptedOn;
  DateTime ? rejectedOn;

  StatusMap({required this.status,required this.acceptedOn,required this.rejectedOn});

  StatusMap.fromJson(Map<String,dynamic> json){
    status = json['status'];
    acceptedOn = json['acceptedOn'];
    rejectedOn = json['rejectedOn'];
  }

  Map<String,dynamic> toJson() => {
    "status": status,
    "acceptedOn": acceptedOn,
    "rejectedOn": rejectedOn,
  };

}

enum NotificationType {
  game_invite("game_invite",FontAwesomeIcons.gamepad),
  friend_request("friend_request",FontAwesomeIcons.user),
  portal_invite("portal_invite",FontAwesomeIcons.robot),
  portal_access_request("portal_access_request",FontAwesomeIcons.robot);


  const NotificationType(this.type,this.icon);
  final String type;
  final IconData icon;
}

enum StatusMapState {
  // (default to none)
  none("none"),
  accepted("accepted"),
  rejected("rejected");



  const StatusMapState(this.state);
  final String state;
}
