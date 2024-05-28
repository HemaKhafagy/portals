class StardustModel
{
  String ? imageUrl;
  int ? amount;
  double ? price;

  StardustModel({required this.imageUrl,required this.amount,required this.price});

  StardustModel.fromJson(Map<String,dynamic> json)
  {
    imageUrl = json["imageUrl"];
    amount = json["amount"];
    price = json["price"];
  }

}