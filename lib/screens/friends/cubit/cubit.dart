import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/models/add_friend_model.dart';
import 'package:Portals/models/friends_card_model.dart';
import 'package:Portals/models/user_model.dart';
import 'package:Portals/screens/friends/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';


class FriendsCubit extends Cubit<FriendsCubitStates>
{

  FriendsCubit() : super(FriendsCubitInitialState());

  static FriendsCubit get(context) => BlocProvider.of(context);

  //******************************************************************************
  // Friends Screen Variables
  //******************************************************************************
  // TextEditingController searchForFriendsController = TextEditingController();


//******************************************************************************
//******************************************************************************


//******************************************************************************
// Add Friends Screen Variables
//******************************************************************************

  bool getUsersIsLoading = false;

  void changeGetUsersIsLoadingStatus() {
    getUsersIsLoading = !getUsersIsLoading;
    emit(ChangeGetUsersIsLoadingState());
  }

  Future<void> getUsers() async{
    changeGetUsersIsLoadingStatus();
    await getOwnFriends().then((List own) async{
      await FirebaseFirestore.instance.collection("Users").get().then((value){
        listOfNewFriendsSourceData = [];
        listOfNewFriendsCard = [];
        value.docs.forEach((doc){
          if(!own.contains(doc.id)){
            listOfNewFriendsSourceData.add(AddFriedModel(
              name: doc["firstName"]+" "+doc["lastName"],
              gender: doc["gender"],
              friendImageUrl: doc["imageUrl"],
              friendId: doc.id,
            ));
          }
        });
      }).catchError((error){

      });
    }).catchError((error){});
    changeGetUsersIsLoadingStatus();
  }

  List<AddFriedModel> listOfNewFriendsSourceData = [];
  List<AddFriedModel> listOfNewFriendsCard = [];
  bool newFriendsListIsOpened = false;

  void searchForPortalUsers(String text)
  {
    if(text.isEmpty){
      listOfNewFriendsCard = listOfNewFriendsSourceData;
      newFriendsListIsOpened = false;
    }else{
      listOfNewFriendsCard = listOfNewFriendsSourceData.where((element) => element.name!.contains(text) || element.name!.toLowerCase().contains(text)).toList();
      newFriendsListIsOpened = true;
    }
    emit(SearchForPortalUsersState());
  }

  Future<List> getOwnFriends() async{
    final user = FirebaseAuth.instance.currentUser;
    List friends = [];
    await FirebaseFirestore.instance.collection("Users").doc(user!.uid).collection("Friends").get().then((value){
      value.docs.forEach((doc){
        friends.add(doc.id);
      });
    }).catchError((error){

    });
    return friends;
  }

  bool addFriendsIsLoading = false;
  int currentLoadingIndex = 0;

  void changeAddFriendsIsLoadingStatus() {
    addFriendsIsLoading = !addFriendsIsLoading;
    emit(ChangeAddFriendsIsLoadingState());
  }

  Future<void> addUser(AddFriedModel friend,int index,UserModel userData) async {
    final batch = FirebaseFirestore.instance.batch();
    currentLoadingIndex = index;
    changeAddFriendsIsLoadingStatus();
    var f1 = FirebaseFirestore.instance.collection("Users").doc(userData.documentInfo!.createdBy).collection("Friends").doc(friend.friendId);
    batch.set(f1,{
      "documentInfo": {
        "createdBy": f1.id,
        "createdOn": DateTime.now(),
      },
      "friend": {
        "id": friend.friendId,
        "name": friend.name,
        "imageUrl": friend.friendImageUrl,
        "gender": friend.gender,
      },
      "statusMap": {
        "status": "none",
      }
    });

    var f2 = FirebaseFirestore.instance.collection("Users").doc(friend.friendId).collection("Friends").doc(userData.documentInfo!.createdBy);
    batch.set(f2,{
      "documentInfo": {
        "createdBy": f2.id,
        "createdOn": DateTime.now(),
      },
      "friend": {
        "id": userData.documentInfo!.createdBy,
        "name": userData.firstName!+" "+userData.lastName!,
        "imageUrl": userData.imageUrl,
        "gender": userData.gender,
      },
      "statusMap": {
        "status": "none",
      }
    });

    var f3 = FirebaseFirestore.instance.collection("Users").doc(friend.friendId).collection("Notifications").doc();
    batch.set(f3,{
      "documentInfo": {
        "createdBy": f3.id,
        "createdOn": DateTime.now(),
      },
      "type": "friend_request",
      "sender": {
        "id": userData.documentInfo!.createdBy,
        "name": userData.firstName!+" "+userData.lastName!,
        "imageUrl": userData.imageUrl,
      },
      "statusMap": {
        "status": "none",
      }
    });

    await batch.commit().then((value){
      listOfNewFriendsSourceData.remove(friend);
      listOfNewFriendsCard.remove(friend);
    }).catchError((error){

    });
    changeAddFriendsIsLoadingStatus();
  }
//******************************************************************************
//******************************************************************************
}