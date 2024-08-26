import 'package:Portals/models/document_info.dart';
import 'package:Portals/models/portal_guests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Portals
{
  DocumentInfo ? documentInfo;
  String ? title;
  String ? topic;
  SubGuests ? guests;
  List<SubAgeRange> ? ageRange;
  List ? guestIds;
  List ? invitedGuestsIds;
  List ? requestedGuestsIds;
  bool ? isPrivate;
  String ? themeRef;
  String ? imageUrl;
  DateTime ? endTime;
  String ? userCurrentPortalStatus;
  List<PortalGuests> guestsList = [];

  Portals({
    required this.documentInfo,
    required this.title,
    required this.topic,
    required this.guests,
    required this.ageRange,
    required this.guestIds,
    required this.isPrivate,
    required this.themeRef,
    required this.imageUrl,
    required this.endTime,
  });

  Portals.fromJson(Map<String,dynamic> json) {
    documentInfo = DocumentInfo.fromJson(json["documentInfo"]);
    title = json["title"];
    topic = json["topic"];
    guests = SubGuests.fromJson(json["guests"]);
    ageRange = json["ageRange"].forEach((e) => SubAgeRange.fromJson(e));
    guestIds = json["guestIds"];
    invitedGuestsIds = json["invitedGuestsIds"];
    requestedGuestsIds = json["requestedGuestsIds"];
    isPrivate = json["isPrivate"];
    themeRef = json["themeRef"];
    imageUrl = json["imageUrl"];
    endTime = json["endTime"].toDate();
    userCurrentPortalStatus = getUserCurrentPortalStatus();
  }

  String getUserCurrentPortalStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if(guestIds != null && guestIds!.contains(user!.uid)){
      if(documentInfo!.createdBy == user.uid){
        return "Hosted";
      }else{
        return "Guested";
      }
    }else if(invitedGuestsIds != null && invitedGuestsIds!.contains(user!.uid)){
      return "Invited";
    }else if(requestedGuestsIds != null && requestedGuestsIds!.contains(user!.uid)){
      return "Pending Request";
    }else{
      return "none";
    }
  }


  Map<String,dynamic> toJson ()=> {
    "documentInfo": documentInfo!.toJson(),
    "title": title,
    "topic": topic,
    "guests": guests!.toJson(),
    if(ageRange != null) "ageRange": FieldValue.arrayUnion(ageRange!.map((e) => e.toJson()).toList()),
    "guestIds": guestIds,
    "isPrivate": isPrivate,
    "themeRef": themeRef,
    "imageUrl": imageUrl,
    "endTime": endTime,
  };
}

class  SubGuests
{
  int ? guestCount;
  int ? limit;

  SubGuests({required this.guestCount,required this.limit});

  SubGuests.fromJson(Map<String,dynamic> json)
  {
    guestCount = json["guestCount"];
    limit = json["limit"];
  }

  Map<String,dynamic> toJson() => {
    "guestCount": guestCount,
    "limit": limit,
  };

}

class SubAgeRange
{
  int ? min;
  int ? max;

  SubAgeRange({required this.min,required this.max});

  SubAgeRange.fromJson(Map<String,dynamic> json)
  {
    min = json["min"];
    max = json["max"];
  }

  Map<String,dynamic> toJson() => {
    "min": min,
    "max": max,
  };
}
