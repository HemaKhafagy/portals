class StarDustModel
{
  int ? amount;
  String ? id;
  String ? imageUrl;
  String ? name;
  double ? price;

  StarDustModel({
    required this.amount,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  StarDustModel.fromJson(Map<String,dynamic> json)
  {
    amount = json["amount"];
    id = json["id"];
    imageUrl = json["imageUrl"];
    name = json["name"];
    price = json["price"];
  }

}