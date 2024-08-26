class DocumentInfo
{
  String ? documentId;
  String ? createdBy;
  DateTime ? createdOn;

  DocumentInfo({required this.createdBy,required this.createdOn,this.documentId});

  DocumentInfo.fromJson(Map<String,dynamic> json)
  {
    createdBy = json["createdBy"];
    createdOn = json["createdOn"].toDate();
    if(json["documentId"] != null)  documentId = json["documentId"];
  }

  Map<String,dynamic> toJson() => {
    "createdBy": createdBy,
    "createdOn": createdOn,
    if(documentId != null) "documentId": documentId
  };
}