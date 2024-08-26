import 'package:Portals/models/document_info.dart';
import 'package:Portals/models/user_address_model.dart';
import 'package:Portals/models/user_badges.dart';
import 'package:Portals/models/user_levels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel
{

  DocumentInfo ? documentInfo;
  String ? imageUrl;
  String ? firstName;
  String ? lastName;
  String ? email;
  DateTime ? dateOfBirth;
  String ? gender;
  List<dynamic> ? interestedIn;
  List<InterestedInAgeModel> ? interestedInAge;
  String ? about;
  UserAddressModel ? userAddress;
  List<UserBadgesModel> ? badges;
  UserLevelsModel ? currentLevel;
  int ? numFriends;
  int ? victories;
  int ? stardust;
  String ? country;
  String ? city;

  UserModel({
    this.documentInfo,
    this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.interestedIn,
    required this.interestedInAge,
    required this.about,
    this.userAddress,
    this.badges,
    this.currentLevel,
    this.numFriends,
    this.victories,
  });

  UserModel.fromJson(Map<String,dynamic> json)
  {
    documentInfo = DocumentInfo.fromJson(json["documentInfo"]);
    imageUrl = json["imageUrl"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    dateOfBirth = json["dateOfBirth"].toDate();
    gender = json["gender"];
    interestedIn = json["interestedIn"];
    interestedInAge = json["interestedInAge"].map<InterestedInAgeModel>((value)=> InterestedInAgeModel.fromJson(value)).toList();
    about = json["about"];
    userAddress = json["userAddress"];
    badges = json["badges"] != null ? json["badges"].map<UserBadgesModel>((value)=> UserBadgesModel.fromJson(value)).toList() : json["badges"];
    currentLevel = json["currentLevel"];
    numFriends = json["numFriends"];
    victories = json["victories"];
    stardust = json["stardust"]??0;
    country = json["country"]??"";
    city = json["city"]??"";
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "firstName":firstName,
    "lastName":lastName,
    "email":email,
    "dateOfBirth":dateOfBirth,
    "gender":gender,
    "interestedIn": FieldValue.arrayUnion(interestedIn!),
    "interestedInAge": FieldValue.arrayUnion(interestedInAge!.map((e) => e.toJson()).toList()),
    "about":about,
    if(userAddress != null)
    "userAddress":userAddress!.toJson(),
    if(badges != null)
    "badges":badges!.map((e) => e.toJson()),
    if(currentLevel != null)
    "currentLevel":currentLevel!.toJson(),
    "numFriends":numFriends,
    "victories":victories,
  };
}

class InterestedInAgeModel
{
  int ? minAge;
  int ? maxAge;

  InterestedInAgeModel({required this.minAge,required this.maxAge});

  InterestedInAgeModel.fromJson(Map<String,dynamic> json)
  {
    minAge = json["minAge"];
    maxAge = json["maxAge"];
  }

  Map<String,dynamic> toJson() => {
    "minAge": minAge,
    "maxAge": maxAge,
  };
}
