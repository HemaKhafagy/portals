class AddFriedModel
{

  String ? name;
  String ? gender;
  String ? friendImageUrl;

  AddFriedModel({
    required this.name,
    required this.gender,
    required this.friendImageUrl,
  });

  AddFriedModel.fromJson(Map<String,dynamic> json)
  {
    name = json["name"];
    gender = json["gender"];
    friendImageUrl = json["friendImageUrl"];
  }
}