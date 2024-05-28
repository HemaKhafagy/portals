class StickersAndGiftsModel
{

  String ? imageUrl;
  int ? amount;

  StickersAndGiftsModel({required this.imageUrl,required this.amount});

  StickersAndGiftsModel.fromJson(Map<String,dynamic> json)
  {
    imageUrl = json["imageUrl"];
    amount = json["amount"];
  }
}