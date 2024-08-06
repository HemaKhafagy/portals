class StickersAndGiftsModel {
  String? title;
  String? description;
  String? imageUrl;
  String? id;
  int? amount;

  StickersAndGiftsModel({required this.imageUrl, required this.amount});

  StickersAndGiftsModel.fromJson(Map<String, dynamic> json, String id) {
    imageUrl = json["imageUrl"];
    amount = json["stardustValue"];
    title = json["title"];
    description = json["description"];
    this.id = id;
  }
}
