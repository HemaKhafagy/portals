import 'package:Portals/models/document_info.dart';

class TransactionModel
{
  DocumentInfo ? documentInfo;
  String ? storeItemRef;
  String ? status;


  TransactionModel({this.storeItemRef,this.status});

  TransactionModel.fromJson(Map<String,dynamic> json)
  {
    storeItemRef = json["storeItemRef"];
    status = json["status"];
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "storeItemRef": storeItemRef,
    "status": status,
  };

}