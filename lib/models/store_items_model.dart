import 'package:Portals/models/document_info.dart';

class StoreItemsModel
{
  DocumentInfo ? documentInfo;
  String ? collection;
  String ? filter;
  double ? price;
  String ? currency;
  double ? stardustValue;
  String ? title;
  String ? description;
  String ? imageUrl;
  String ? type;

  StoreItemsModel({
    required this.collection,
    required this.filter,
    required this.price,
    required this.currency,
    required this.stardustValue,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
  });

  StoreItemsModel.fromJsom(Map<String,dynamic> json)
  {
    collection = json["collection"];
    filter = json["collection"];
    price = json["collection"];
    currency = json["collection"];
    stardustValue = json["collection"];
    title = json["collection"];
    description = json["collection"];
    imageUrl = json["collection"];
    type = json["collection"];
  }

  Map<String,dynamic> toJson() => {
    "documentInfo": documentInfo!.toJson(),
    "collection": collection,
    "filter": filter,
    "price": price,
    "currency": currency,
    "stardustValue": stardustValue,
    "title": title,
    "description": description,
    "imageUrl": imageUrl,
    "type": type,
  };

}