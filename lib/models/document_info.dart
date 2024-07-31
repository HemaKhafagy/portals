class DocumentInfo
{
  String ? createdBy;
  DateTime ? createdOn;

  DocumentInfo({required this.createdBy,required this.createdOn});

  DocumentInfo.fromJson(Map<String,dynamic> json)
  {
    createdBy = json["createdBy"];
    createdOn = json["createdOn"];
  }

  Map<String,dynamic> toJson() => {
    "createdBy": createdBy,
    "createdOn": createdOn,
  };
}