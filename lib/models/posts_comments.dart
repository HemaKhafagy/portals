import 'package:Portals/models/document_info.dart';

class PostsComments
{
  DocumentInfo ? documentInfo;
  InUser ? user;
  String ? comment;

  PostsComments({required this.user,required this.comment});

  PostsComments.fromJson(Map<String,dynamic> json)
  {
    user = InUser.fromJson(json["user"]);
    comment = json["comment"];
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "user": user!.toJson(),
    "comment": comment,
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