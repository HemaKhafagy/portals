class DocumentInfo
{
  String ? createdBy;
  String ? portalID;
  DateTime ? createdOn;

  DocumentInfo({required this.createdBy,required this.createdOn,this.portalID});

  DocumentInfo.fromJson(Map<String,dynamic> json)
  {
    createdBy = json["createdBy"];
    createdOn = json["createdOn"];
    if(json["portalID"] != null)  portalID = json["portalID"];
  }

  Map<String,dynamic> toJson() => {
    "createdBy": createdBy,
    "createdOn": createdOn,
    if(portalID != null) "portalID": portalID
  };
}