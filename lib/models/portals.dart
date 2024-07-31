import 'package:Portals/models/document_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Portals
{
  DocumentInfo ? documentInfo;
  String ? title;
  String ? topic;
  SubGuests ? guests;
  List<SubAgeRange> ? ageRange;
  bool ? isPrivate;
  String ? themeRef;
  String ? imageUrl;
  DateTime ? endTime;

  Portals({
    required this.documentInfo,
    required this.title,
    required this.topic,
    required this.guests,
    required this.ageRange,
    required this.isPrivate,
    required this.themeRef,
    required this.imageUrl,
    required this.endTime,
  });

  Portals.fromJson(Map<String,dynamic> json) {
    title = json["title"];
    topic = json["topic"];
    guests = SubGuests.fromJson(json["guests"]);
    ageRange = json["ageRange"].forEach((e) => SubAgeRange.fromJson(e));
    isPrivate = json["isPrivate"];
    themeRef = json["themeRef"];
    imageUrl = json["imageUrl"];
    endTime = json["endTime"].toDate();
  }

  Map<String,dynamic> toJson ()=> {
    "documentInfo": documentInfo!.toJson(),
    "title": title,
    "topic": topic,
    "guests": guests!.toJson(),
    "ageRange": FieldValue.arrayUnion(ageRange!.map((e) => e.toJson()).toList()),
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