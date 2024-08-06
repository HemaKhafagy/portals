class StarDustModel {
  int? amount;
  String? id;
  String? imageUrl;
  String? name; // should be type
  double? price;
  String? title;
  String? description;

  StarDustModel({
    required this.amount,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.title,
    this.description,
  });

  StarDustModel.fromJson(Map<String, dynamic> json) {
    amount = json["amount"];
    id = json["id"];
    imageUrl = json["imageUrl"];
    name = json["name"];
    price = json["price"];
    title = json["title"];
    description = json["description"];
  }
}
