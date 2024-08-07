import 'dart:io';
import 'package:Portals/layout/home_taps_screen.dart';
import 'package:Portals/models/document_info.dart';
import 'package:Portals/models/portals.dart';
import 'package:Portals/screens/portals_config/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PortalsConfigCubit extends Cubit<PortalsConfigStates>
{

  PortalsConfigCubit() : super(PortalsConfigInitialState());

  static PortalsConfigCubit get(BuildContext context) => BlocProvider.of(context);


//**********************************************************************************
// New Portal Attributes
//**********************************************************************************
  TextEditingController portalNameController = TextEditingController();
  bool dropDownMenuIsOpened = false;
  String topicSelectedValue = "";
  String portalImageUrl = "";
  // int newPortalAgeSelectedIndex = 0;
  // String newPortalAgeSelectedValue = "";
  List<SubAgeRange> ageSelectedValues = [];
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
  FocusManager.instance.primaryFocus?.unfocus();
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
void changeANPASdRange({required SubAgeRange value})
{
  // newPortalAgeSelectedIndex = newValue;
  // newPortalAgeSelectedValue = newAge;
  ageSelectedValues.any((element) => element.min == value.min) ? ageSelectedValues.removeWhere((element) => element.min == value.min) : ageSelectedValues.add(value);
  emit(ChangeANPASdRangeState());
}

// this method to change switch button selected value.....
  void changeSBSValue(String newValue)
  {
    switchButtonSelectedValue = newValue;
    emit(ChangeSBSValueState());
  }

  int addingScreenIndex = 0;

  void increaseAddingScreenIndex()
  {
    addingScreenIndex++;
    emit(IncreaseAddingScreenIndex());
  }

  void decreaseAddingScreenIndex()
  {
    if(addingScreenIndex > 0) addingScreenIndex--;
    emit(DecreaseAddingScreenIndex());
  }


  bool submitIsLoading = false;

  void changeSubmitIsLoadingStatus()
  {
    submitIsLoading = !submitIsLoading;
    emit(ChangeSubmitIsLoadingStatus());
  }
  Future<void> submitNewPortalAdding({required BuildContext context}) async
  {
    changeSubmitIsLoadingStatus();
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference colRef = FirebaseFirestore.instance.collection("Portals");
    DocumentReference docRef = FirebaseFirestore.instance.collection("Portals").doc();
    await uploadPortalImage(portalId: docRef.id,key: "portalProfile", context: context,file: selectedPortalPic!);
    Portals newPortal = Portals(
        documentInfo: DocumentInfo(
            createdBy: user!.uid,
            portalID: docRef.id,
            createdOn: DateTime.now()
        ),
        title: portalNameController.text,
        topic: topicSelectedValue,
        guests: SubGuests(guestCount: 1, limit: 20),
        ageRange: ageSelectedValues,
        isPrivate: switchButtonSelectedValue == "No" ? false : true,
        themeRef: "s",
        imageUrl: portalImageUrl,
        endTime: DateTime.now()
    );
    await colRef.doc(docRef.id).set(newPortal.toJson()).then((value) {
      changeSubmitIsLoadingStatus();
      print("ADDING SUCCESS FROM submitNewPortalAdding FUNCTION CHECK IT ................................");
      navigateAndFinish(context: context, widget: const HomeTabsScreen());
    }).catchError((error){
      print("ERORR FROM submitNewPortalAdding FUNCTION CHECK IT ................................");
      print(error);
    });
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

  Future<void> uploadPortalImage({required String portalId, required String key,required BuildContext context ,required File file}) async
  {
    try
    {
      Uint8List ? bytes = await file.readAsBytes();
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(portalId)
          .child("data")
          .child(key);
       await ref.putData(bytes);
      portalImageUrl = await ref.getDownloadURL();
    }catch(error)
    {
      print("ERORR FROM uploadPortalImage FUNCTION CHECK IT ................................");
      print(error);
    }
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
// Add Portal third Screen Variables
//******************************************************************************
  TextEditingController portalCodeController = TextEditingController();

 List portalCodeNames = [
   "Pineapple",
   "Banana",
   "Manzana",
   "Kangaroo",
   "Gipsy",
   "Eggplant",
 ];

  void changeCodeNameValue(String value)
  {
    portalCodeController.text = value;
    emit(ChangeCodeNameValue());
  }
//******************************************************************************
//******************************************************************************
}