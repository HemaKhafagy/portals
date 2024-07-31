import 'package:Portals/models/document_info.dart';

class ScoresModel
{
  DocumentInfo ? documentInfo;
  String ?  userId;
  double ?  score;
  String ?  gameTitle;

  ScoresModel({required this.userId,required this.score,required this.gameTitle});

  ScoresModel.fromJson(Map<String,dynamic> json)
  {
    userId = json["userId"];
    score = json["score"];
    gameTitle = json["gameTitle"];
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "userId": userId,
    "score": score,
    "gameTitle": gameTitle,
  };

}