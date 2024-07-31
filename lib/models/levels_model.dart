import 'package:Portals/models/document_info.dart';

class LevelModel
{

  DocumentInfo ? documentInfo;
  int ? index;
  double ? points;
  String ? title;
  String ? imageUrl;
  String ? perks;

  LevelModel({required this.index,required this.points,required this.title,required this.imageUrl,required this.perks});

  LevelModel.fromJson(Map<String,dynamic> json){
    index = json["index"];
    points = json["points"];
    title = json["title"];
    imageUrl = json["imageUrl"];
    perks = json["perks"];
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "index": index,
    "points": points,
    "title": title,
    "imageUrl": imageUrl,
    "perks": perks,
  };

}