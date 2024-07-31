class FriendsCardModel
{

  String ? name;
  String ? status;
  String ? lastMessage;
  String ? friendImageUrl;

  FriendsCardModel({
    required this.name,
    required this.status,
    required this.lastMessage,
    required this.friendImageUrl,
  });

  FriendsCardModel.fromJson(Map<String,dynamic> json)
  {
    name = json["name"];
    status = json["status"];
    lastMessage = json["lastMessage"];
    friendImageUrl = json["friendImageUrl"];
  }
}