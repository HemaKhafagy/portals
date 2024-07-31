class LeaderBoardsModel
{

  String ? gameName;
  String ? playerName;
  String ? playerImageUrl;
  String ? playerRank;

  LeaderBoardsModel({
    required this.gameName,
    required this.playerName,
    required this.playerImageUrl,
    required this.playerRank,
  });

  LeaderBoardsModel.fromJson(Map<String,dynamic> json)
  {
    gameName = json["gameName"];
    playerName = json["playerName"];
    playerImageUrl = json["playerImageUrl"];
    playerRank = json["playerRank"];
  }
}