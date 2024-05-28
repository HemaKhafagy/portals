import 'dart:io';

import 'package:Portals/screens/portals_config/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

class PortalsConfigCubit extends Cubit<PortalsConfigStates>
{

  PortalsConfigCubit() : super(PortalsConfigInitialState());

  static PortalsConfigCubit get(BuildContext context) => BlocProvider.of(context);


//**********************************************************************************
// New Portal Attributes
//**********************************************************************************
  TextEditingController portalNameController = TextEditingController();
  TextEditingController portalCodeController = TextEditingController();
  bool dropDownMenuIsOpened = false;
  String topicSelectedValue = "";
  int newPortalAgeSelectedIndex = 0;
  String newPortalAgeSelectedValue = "";
  String switchButtonSelectedValue = "No";


List<String> topics = [
  "Gaming",
  "Sports",
  "Dating",
  "Fashion & Aesthetics",
  "Movies",
  "Music & Media",
  "Entertainment",
  "Technology",
  "Jobs",
  "Gaming",
  "Sports",
  "Dating",
  "Fashion & Aesthetics",
  "Movies",
  "Music & Media",
  "Entertainment",
  "Technology",
  "Jobs",
];

// this method to change dropdown menu open and close value.....
void changeDropDMIO(bool newValue)
{
  dropDownMenuIsOpened = newValue;
  emit(ChangeDropDMIOState());
}

// this method to change change topic selected value state.....
void changeTopicSelectedValue(String newValue)
{
  topicSelectedValue = newValue;
  dropDownMenuIsOpened = false;
  emit(ChangeTopicSelectedValueState());
}

// this method to change change add new portal range value.....
void changeANPASdRange(int newValue,String newAge)
{
  newPortalAgeSelectedIndex = newValue;
  newPortalAgeSelectedValue = newAge;
  emit(ChangeANPASdRangeState());
}

// this method to change switch button selected value.....
  void changeSBSValue(String newValue)
  {
    switchButtonSelectedValue = newValue;
    emit(ChangeSBSValueState());
  }

//**********************************************************************************
//**********************************************************************************

//******************************************************************************
// Add Portal Second Screen Variables
//******************************************************************************
//   final ImagePicker selectedProfilePic = ImagePicker();
  File ? selectedPortalPic;
// Pick an image.
  Future<void> getPortalPic() async{
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      selectedPortalPic = File(value!.path );
    }).catchError((error){

    });
    emit(GetPortalPicState());
  }

  Map<String,String> selectedThemeValues = {};
  bool themeMenuIsOpened = false;

  Map<int,Map<String,String>> themes = {
    1:{
      "name":"Groovy",
      "image":"assets/theme/theme1.png",
    },
    2:{
      "name":"Fairy Tale",
      "image":"assets/theme/theme2.png",
    },
    3:{
      "name":"Black & White",
      "image":"assets/theme/theme3.png",
    },
    4:{
      "name":"Hex",
      "image":"assets/theme/theme4.png",
    },
    5:{
      "name":"Nightclub",
      "image":"assets/theme/theme5.png",
    },
    6:{
      "name":"Shapes & colors",
      "image":"assets/theme/theme6.png",
    },
  };

  void changeSelectedThemeValue(Map<String,String> newValue)
  {
    selectedThemeValues = newValue;
    themeMenuIsOpened = false;
    emit(ChangeSelectedThemeState());
  }

  void changeThemeMenuIsOpenedStatus()
  {
    themeMenuIsOpened = !themeMenuIsOpened;
    emit(ChangeThemeMenuIsOpenedState());
  }

//******************************************************************************
//******************************************************************************

//******************************************************************************
// Add Portal Second Screen Variables
//******************************************************************************
 List portalCodeNames = [
   "@Pineapple",
   "@Banana",
   "@Manzana",
   "@Kangaroo",
   "@Gipsy",
   "@Eggplant",
 ];
//******************************************************************************
//******************************************************************************
}