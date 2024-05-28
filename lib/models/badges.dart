import 'package:Portals/models/document_info.dart';

class BadgesModel
{

  DocumentInfo ? documentInfo;
  int ? index;
  String ? title;
  String ? imageUrl;
  String ? description;

  BadgesModel({
    required this.index,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  BadgesModel.fromJsom(Map<String,dynamic> json){
    index = json["index"];
    title = json["title"];
    imageUrl = json["imageUrl"];
    description = json["description"];
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "index": index,
    "title": title,
    "imageUrl": imageUrl,
    "description": description,
  };


}