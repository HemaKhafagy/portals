class CardModel
{

  String ? imageUrls;
  String ? title;
  String  ? description;
  String  ? state;
  int ? score;

  CardModel({
    required this.imageUrls,
    required this.title,
    required this.description,
    required this.state,
    required this.score,
  });

  CardModel.fromJson(Map<String,dynamic> json)
  {
    imageUrls = json["imageUrls"];
    title = json["title"];
    description = json["description"];
    state = json["state"];
    score = json["score"];
  }

}