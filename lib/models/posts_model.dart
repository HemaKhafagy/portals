import 'package:Portals/models/document_info.dart';

class PostsModel
{

  DocumentInfo ? documentInfo;
  InUser ? user;
  String ? description;
  InVideo ? video;
  InAnalytics ? analytics;

  PostsModel({
    required this.user,
    required this.description,
    required this.video,
    required this.analytics,
  });

  PostsModel.fromJson(Map<String,dynamic> json)
  {
    user = InUser.fromJson(json["user"]);
    description = json["description"];
    video = InVideo.fromJson(json["video"]);
    analytics = InAnalytics.fromJson(json["analytics"]);
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "user": user!.toJson(),
    "description": description,
    "video": video!.toJson(),
    "analytics": analytics!.toJson(),
  };

}

class InUser
{
  String ? ref;
  String ? name;
  String ? imageUrl;

  InUser({required this.ref,required this.name,required this.imageUrl});

  InUser.fromJson(Map<String,dynamic> json)
  {
    ref = json["ref"];
    name = json["name"];
    imageUrl = json["imageUrl"];
  }

  Map<String,dynamic> toJson() => {
    "ref": ref,
    "name": name,
    "imageUrl": imageUrl,
  };

}

class InVideo
{
  String ? url;
  String ? status;
  String ? relatedGame;

  InVideo({required this.url,required this.status,required this.relatedGame});

  InVideo.fromJson(Map<String,dynamic> json)
  {
    url = json["url"];
    status = json["status"];
    relatedGame = json["relatedGame"];
  }

  Map<String,dynamic> toJson() => {
    "url": url,
    "status": status,
    "relatedGame": relatedGame,
  };
}

class InAnalytics
{
  int ? numComments;
  int ? numLikes;


  InAnalytics({required this.numComments,required this.numLikes,});

  InAnalytics.fromJson(Map<String,dynamic> json)
  {
    numComments = json["numComments"];
    numLikes = json["numLikes"];
  }

  Map<String,dynamic> toJson() => {
    "numComments": numComments,
    "numLikes": numLikes,
  };
}