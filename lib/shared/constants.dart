import 'package:Portals/models/friends_card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

const String appUsedFont = "Proxima";

CollectionReference users = FirebaseFirestore.instance.collection('Users');



BoxDecoration sharedContainerDecoration = const BoxDecoration(
  gradient: RadialGradient(
    center: Alignment(0, 0),
    radius: 1.8,
    colors: <Color>[
      Color.fromRGBO(73, 53, 153, 1),
      Color.fromRGBO(45, 24, 89, 1),
      Color.fromRGBO(38, 23, 66, 1),
    ],
  ),
  image: DecorationImage(
    image: AssetImage("assets/image/vector.png"),
    fit: BoxFit.cover,
  ),
);

