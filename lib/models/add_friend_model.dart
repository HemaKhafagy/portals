class AddFriedModel
{

  String ? name;
  String ? gender;
  String ? friendImageUrl;
  String ? friendId;
  DateTime ? friendDate;

  AddFriedModel({
    required this.name,
    required this.gender,
    required this.friendImageUrl,
    this.friendId
  });

  AddFriedModel.fromJson(Map<String,dynamic> json)
  {
    name = json["name"];
    gender = json["gender"];
    friendImageUrl = json["friendImageUrl"];
    friendId = json["friendId"];
    friendImageUrl = json["friendDate"];
  }
}