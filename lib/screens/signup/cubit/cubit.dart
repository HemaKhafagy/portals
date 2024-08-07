import 'dart:io';
import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/home_taps_screen.dart';
import 'package:Portals/screens/signup/create_avatar_screen.dart';
import 'package:Portals/shared/cach_helper.dart';
import 'package:Portals/shared/notification_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Portals/models/document_info.dart';
import 'package:Portals/models/user_model.dart';
import 'package:Portals/screens/signup/assign_date_of_birth.dart';
import 'package:Portals/screens/signup/otp_screen.dart';
import 'package:Portals/shared/components.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Portals/screens/signup/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUPCubit extends Cubit<SignUpCubitStates> {
  SignUPCubit() : super(SignUpInitialState());

  static SignUPCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> OTPFormKey = GlobalKey<FormState>();

//******************************************************************************
// Personal Info Screen Variables
//******************************************************************************
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  void personalInfoSubmit(BuildContext context, bool isSignIn) {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      navigateToAndCloseCurrent(
          context: context, widget: OTPScreen(isSignIn: isSignIn));
      verifyPhoneNumber(context);
    }
    emit(PersonalInfoSubmitState());
  }
//******************************************************************************
//******************************************************************************

//******************************************************************************
// User Birth Date Screen Variables
//******************************************************************************
  DateTime? userBirthDate;

  void setUserBirthDate(DateTime date) {
    userBirthDate = date;
    emit(SetUerBirthDateState());
  }
//******************************************************************************
//******************************************************************************

//******************************************************************************
// Preference Screen Variables
//******************************************************************************

  int genderPara = 0;
  String genderValue = "";
  InterestedInAgeModel? userAge;
  List<InterestedInAgeModel> interestedAge = [];
  int agePara = 0;
  List<String> wantMeet = [];

  void changeGenderValue({required String value, required int index}) {
    genderValue = value;
    genderPara = index;
    emit(ChangeGenderValueState());
  }

  void changeUserAgeValue(
      {required int min, required int max, required int index}) {
    userAge = InterestedInAgeModel(minAge: min, maxAge: max);
    agePara = index;
    emit(ChangeUserAgeValueState());
  }

  void changeWantMeetValue({required String value}) {
    wantMeet.contains(value) ? wantMeet.remove(value) : wantMeet.add(value);
    emit(ChangeWantMeetState());
  }

  void changeWantAgeValue({required InterestedInAgeModel value}) {
    interestedAge.any((element) => element.minAge == value.minAge)
        ? interestedAge.removeWhere((element) => element.minAge == value.minAge)
        : interestedAge.add(value);
    emit(ChangeWantAgeValueState());
  }

  File? selectedProfilePic;
// Pick an image.
  Future getProfilePic() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      selectedProfilePic = File(value!.path);
    }).catchError((error) {});
    emit(GetProfilePicState());
  }

//******************************************************************************
//******************************************************************************

//******************************************************************************
// Preference Screen Variables
//******************************************************************************

  String avatarSVGStringValue = "";

  void changeAvatarSVGStringValue(String value) {
    avatarSVGStringValue = value;
    print(value);
    emit(ChangeAvatarSVGStringValue());
  }

//******************************************************************************
//******************************************************************************

//******************************************************************************
// OTP screen
//******************************************************************************
  String? signUpPhoneNumber;
  String? signUpPhoneNumberSMSCode;
  // we make change here from String ? to var
  var signUpPhoneNumberVerificationId;
  bool verifyPhoneNumberIsLoading = false;

  void changeVerifyPhoneNumberIsLoadingStatus() {
    verifyPhoneNumberIsLoading = !verifyPhoneNumberIsLoading;
    emit(ChangeVerifyPhoneNumberIsLoadingState());
  }

  Future verifyPhoneNumber(BuildContext context) async {
    changeVerifyPhoneNumberIsLoadingStatus();
    await FirebaseAuth.instance
        .verifyPhoneNumber(
      phoneNumber: signUpPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print(
            "PHONE AUTHENTICATION VERIFICATION COMPLETED ${credential.smsCode}");
        print(
            "PHONE AUTHENTICATION VERIFICATION COMPLETED ${credential.verificationId}");
        print(
            "PHONE AUTHENTICATION VERIFICATION COMPLETED ${credential.accessToken}");
        print(
            "PHONE AUTHENTICATION VERIFICATION COMPLETED ${credential.providerId}");
        print(
            "PHONE AUTHENTICATION VERIFICATION COMPLETED ${credential.signInMethod}");
        print(
            "PHONE AUTHENTICATION VERIFICATION COMPLETED ${credential.token}");
        signUpPhoneNumberSMSCode = credential.smsCode;
        signUpPhoneNumberVerificationId = credential.verificationId;
      },
      codeSent: (String verificationId, int? resendToken) async {
        print("PHONE AUTHENTICATION codeSent $verificationId");
        signUpPhoneNumberVerificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("PHONE AUTHENTICATION codeAutoRetrievalTimeout $verificationId");
        signUpPhoneNumberVerificationId = verificationId;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        // Handle other errors
      },
      // timeout: const Duration(seconds: 60),
    )
        .catchError((error) {
      showSharedAlertDialog(
          title: "Something wrong ...",
          content: "Please rejoin portals app",
          context: context,
          actions: [
            buildSharedButton(
                buttonName: "Close",
                isEnabled: true,
                action: () {
                  Navigator.of(context).pop();
                }),
          ]);
    });
    changeVerifyPhoneNumberIsLoadingStatus();
  }

  TextEditingController OTPController = TextEditingController();
  Future signUpWithPhoneNumber(BuildContext context, String pin, bool isSignIn) async {
    changeVerifyPhoneNumberIsLoadingStatus();
    if (signUpPhoneNumberVerificationId == null) {
      OTPController.clear();
      showSharedAlertDialog(
          title: "warning!!!",
          content: "Please add code again",
          context: context,
          actions: [
            buildSharedButton(
                buttonName: "Close",
                isEnabled: true,
                action: () {
                  Navigator.of(context).pop();
                }),
          ]);
    } else {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: signUpPhoneNumberVerificationId, smsCode: pin);
        await FirebaseAuth.instance.signInWithCredential(credential).then((UserCredential value) async {
          // NotificationHandler.saveTokenToDatabase();
          if (isSignIn) {
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(value.user!.uid)
                .get()
                .then((value) async {
              if (value.exists) {
                // SAVE DEVICE TOKENS AND GET STREAM USER TOKEN
                saveTokens();
                // navigateToAndCloseCurrent(context: context, widget: const HomeTabsScreen());
                await HomeTapsCubit.get(context).checkUserExistence(context);
              } else {
                showSharedAlertDialog(
                    title: "You are not a member of portals app",
                    content: "Please join portals app",
                    context: context,
                    actions: [
                      buildSharedButton(
                          buttonName: "Close",
                          isEnabled: true,
                          action: () {
                            Navigator.of(context).pop();
                          }),
                    ]);
              }
            });
          } else {
            navigateToAndCloseCurrent(context: context, widget: const AssignDateOfBirth());
          }
        });
      } on FirebaseAuthException catch (error) {
        showSharedAlertDialog(
            title: "Sorry!!!",
            content: error.message.toString(),
            context: context,
            actions: [
              buildSharedButton(
                  buttonName: "Close",
                  isEnabled: true,
                  action: () {
                    Navigator.of(context).pop();
                  }),
            ]);
      }
    }
    changeVerifyPhoneNumberIsLoadingStatus();
  }

//******************************************************************************
//******************************************************************************
  bool submittingIsLoading = false;

  void changeSubmittingIsLoadingStatus() {
    submittingIsLoading = !submittingIsLoading;
    emit(ChangeSubmittingIsLoadingState());
  }

  Future<void> submitSignUp(BuildContext context) async {
    changeSubmittingIsLoadingStatus();
    CollectionReference colRef = FirebaseFirestore.instance.collection("Users");
    // DocumentReference docRef = FirebaseFirestore.instance.collection("Users").doc();
    FirebaseAuth auth = FirebaseAuth.instance;
    UserModel userData = UserModel(
        documentInfo: DocumentInfo(
            createdBy: auth.currentUser!.uid, createdOn: DateTime.now()),
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        dateOfBirth: userBirthDate,
        gender: genderValue,
        interestedIn: wantMeet,
        interestedInAge: interestedAge,
        about: "",
        numFriends: 0,
        victories: 0);
    await colRef.doc(auth.currentUser!.uid).set(userData.toJson()).then((value) {
      changeSubmittingIsLoadingStatus();
      navigateToAndCloseCurrent(context: context, widget: const CreateAvatarScreen());
    }).catchError((error) {
      print("ERORR FROM submitSignUp FUNCTION CHECK IT ................................");
      print(error);
    });
  }

  Future<void> addImageToFirebaseStorage(
      {required String key,
      required BuildContext context,
      String? avatar,
      File? file}) async {
    changeSubmittingIsLoadingStatus();
    final user = FirebaseAuth.instance.currentUser;
    try {
      Uint8List? bytes = file != null ? await file.readAsBytes() : null;
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(user!.uid)
          .child("data")
          .child(key);
      key == "avatar"
          ? await ref.putString(avatar!)
          : await ref.putData(bytes!);
      // SAVE DEVICE TOKENS AND GET STREAM USER TOKEN
      saveTokens();
      await HomeTapsCubit.get(context).checkUserExistence(context);
    } catch (error) {
      showSharedAlertDialog(
          title: "photo can't uploaded",
          content: "Please try again",
          context: context,
          actions: [
            buildSharedButton(
                buttonName: "Close",
                isEnabled: true,
                action: () {
                  Navigator.of(context).pop();
                }),
          ]);
      changeSubmittingIsLoadingStatus();
      // navigateAndFinish(context: context, widget: const HomeTabsScreen());
    }
  }

//****************************************************************************
// Tokens
//****************************************************************************
  saveTokens() async{
    final user = FirebaseAuth.instance.currentUser;
    FirebaseMessaging.instance.getToken().then((value) {
      if(value != null){
        CashHelper.saveDataFromSharedPref(key: "deviceToken", value: value);
        FirebaseFirestore.instance.collection('Users').doc(user!.uid).update({
          "deviceToken": value
        }).then((resValue) async {

        }).catchError((error) {

        });
      }
    }).catchError((error){

    });
    try{
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('userChatToken');
      final resp = await callable.call(<String, dynamic>{
        'id': user!.uid,
      });
      CashHelper.saveDataFromSharedPref(key: "getStreamToken", value: resp.data);
    }catch(error){
      // print("Error...........................");
      // print(error.toString());
    }
  }

  clearTokens() {

  }
//****************************************************************************

}
