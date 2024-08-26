import 'dart:async';

import 'package:Portals/models/friends.dart';
import 'package:Portals/models/portal_guests.dart';
import 'package:Portals/models/portals.dart';
import 'package:Portals/screens/chat/cubit/states.dart';
import 'package:Portals/shared/cach_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FA;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:cloud_functions/cloud_functions.dart';

class ChatCubit extends Cubit<ChatCubitStates>
{

  ChatCubit() : super(ChatCubitInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  late Portals selectedPortal;
  late StreamChatClient clint;
  late Channel channel;
  bool chatIsLoading = false;


  Future createChatChannel(String chatId,String ownerId,List members) async{
    // clint = StreamChatClient("58cauyvcrbmf", logLevel: Level.INFO);
    // channel = createChannel(clint,chatId);
    try{
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('createChatChannel');
      final resp = await callable.call(<String, dynamic>{
        'id': chatId,
        'ownerId': ownerId,
        'members': members
      });
    }catch(error){
      return null;
    }
  }


  Future chatInit(String chatId,Portals portal) async{
    changeChatIsLoadingState();
    selectedPortal = portal;
     clint = StreamChatClient(
      "58cauyvcrbmf",
      logLevel: Level.INFO
    );
    await connectToUserFunction(clint);
    // channel = createChannel(clint,chatId);
    channel = clint.channel("messaging", id: chatId);
    ListenToChannel(channel);
    changeChatIsLoadingState();
  }

  Future<bool> addUserToChannel({required chatId,required memberId}) async {
    bool state = false;
    // StreamChatClient(
    //     "58cauyvcrbmf",
    //     logLevel: Level.INFO
    // ).channel("messaging", id: chatID).addMembers(memberID).then((value) {
    //   state = true;
    // }).catchError((error){
    //   state = false;
    // });
    // return state;
    try{
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('addUserToChatChannel');
      final resp = await callable.call(<String, dynamic>{
        'chatId': chatId,
        'memberId': memberId,
      });
      state = true;
    }catch(error){
      state = false;
    }
    return state;
  }

  changeChatIsLoadingState() {
    chatIsLoading = !chatIsLoading;
    emit(ChangeChatIsLoadingState());
  }


  Future connectToUserFunction(StreamChatClient clint) async{
    final currentUser = FA.FirebaseAuth.instance.currentUser;
    final token = await CashHelper.getDataFromSharedPref(key: "getStreamToken");
    if(token != null){
      await clint.connectUser(
          User(id: currentUser!.uid),
          token
      );
    }else{
      // handel your error
    }
  }

  Channel createChannel(StreamChatClient clint,String chatID) {
    //id is optional
    return clint.channel("messaging", id: chatID);
  }

  String errorMessage = "Something Went Wrong !!";
  ListenToChannel(Channel channel) {
    channel.watch().then((value) => null).catchError((error){
      if(error.statusCode == 403 && error.code == 17){
        errorMessage = "You Are Not A Member Of This Channel";
      }
    });
  }

  String switchButtonSelectedValue = "No";
  // this method to change switch button selected value.....
  void changeSBSValue(String newValue)
  {
    switchButtonSelectedValue = newValue;
    emit(ChangeChatSBSValueState());
  }

// this method to change change add new portal range value.....
  List<SubAgeRange> ageSelectedValues = [];
  void changeANPASdRange({required SubAgeRange value})
  {
    ageSelectedValues.any((element) => element.min == value.min) ? ageSelectedValues.removeWhere((element) => element.min == value.min) : ageSelectedValues.add(value);
    emit(ChangeChatANPASdRangeState());
  }

  List<Friends> friendsList = [];
  bool getFriendsList = false;

  changeGetFriendsListStatus() {
    getFriendsList = !getFriendsList;
    emit(ChangeGetFriendsListStatus());
  }

  Future<void> getFriendsForInvite() async {
    changeGetFriendsListStatus();
    final user = FA.FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection("Users").doc(user!.uid).collection("Friends").get().then((docs){
      friendsList = [];
      docs.docs.forEach((elements){
        if(!selectedPortal.guestIds!.contains(elements.id) && !selectedPortal.invitedGuestsIds!.contains(elements.id)){
          friendsList.add(Friends.fromJson(elements.data()));
        }
      });
    }).catchError((error){
      print(error);
    });
    changeGetFriendsListStatus();
  }

  List<Friends> selectedFriendsForInvitesList = [];
  List<String> selectedFriendsForInvitesListIds = [];

  selectFriendsForInvites(Friends friend) {
    selectedFriendsForInvitesList.contains(friend) ? selectedFriendsForInvitesList.remove(friend) :
    selectedFriendsForInvitesList.add(friend);
    selectedFriendsForInvitesListIds.add(friend.friend!.id!);
    emit(SelectFriendsForInvites());
  }

  bool sendFriendsInvitesIsLoading = false;

  changeSendFriendsInvitesIsLoadingStatus()
  {
    sendFriendsInvitesIsLoading = !sendFriendsInvitesIsLoading;
    emit(ChangeSendFriendsInvitesIsLoadingStatus());
  }

  sendFriendsInvites() async {
    changeSendFriendsInvitesIsLoadingStatus();
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('friendsInvite');
    await callable.call(<dynamic, dynamic>{
      'friendsIds': selectedFriendsForInvitesListIds,
      'invitedIds': selectedPortal.invitedGuestsIds,
      // 'portalData': selectedPortal.toJson(),
      'portalData': {
        "documentInfo":{
          "documentId": selectedPortal.documentInfo!.documentId
        },
        "title": selectedPortal.title,
        "imageUrl": selectedPortal.imageUrl,
      },
    }).then((value){
      selectedFriendsForInvitesList = [];
      selectedFriendsForInvitesListIds = [];
      getFriendsForInvite();
    }).catchError((error){
      print(error);
    });
    changeSendFriendsInvitesIsLoadingStatus();
  }

  void searchForFriends(String text) {
    if (text.isEmpty || text == "Tap") {
      // portalsList = portalsListRealData;
    } else {
      // portalsList = portalsListRealData
      //     .where((element) =>
      // element.topic!.contains(text) ||
      //     element.topic!.toLowerCase().contains(text))
      //     .toList();
    }
    emit(SearchForFriendsState());
  }

  bool getPortalGuestsIsLoading = false;

  changeGetPortalGuestsIsLoadingStatus()
  {
    getPortalGuestsIsLoading = !getPortalGuestsIsLoading;
    emit(ChangeGetPortalGuestsIsLoadingStatus());
  }

  Future<void> getPortalGuests() async
  {
    changeGetPortalGuestsIsLoadingStatus();
    await FirebaseFirestore.instance.collection("Portals").doc(selectedPortal.documentInfo!.documentId).collection("Guests").get().then((value){
      selectedPortal.guestsList = [];
      selectedBanUsers = [];
      value.docs.forEach((elements){
        selectedPortal.guestsList.add(PortalGuests.fromJson(elements.data()));
      });
    }).catchError((error){

    });
    changeGetPortalGuestsIsLoadingStatus();
  }

  List<String> selectedBanUsers = [];

  mapBanUserList(String userID)
  {
    selectedBanUsers.contains(userID) ? selectedBanUsers.remove(userID) :
    selectedBanUsers.add(userID);
    selectedBanUsers.add(userID);
    emit(MapBanUserList());
  }

  Future banSelectedUsersList() async
  {
    changeGetPortalGuestsIsLoadingStatus();
    selectedBanUsers.forEach((String element) async{
      final batch = FirebaseFirestore.instance.batch();
      var f1 = FirebaseFirestore.instance.collection("Portals").doc(selectedPortal.documentInfo!.documentId).collection("Guests").doc(element);
      batch.delete(f1);
      var f2 = FirebaseFirestore.instance.collection("Portals").doc(selectedPortal.documentInfo!.documentId);
      batch.update(f2,{
        "guestIds": FieldValue.arrayRemove([element]),
        "invitedGuestsIds": FieldValue.arrayRemove([element]),
      });
      await batch.commit().then((value) async{
        HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('removeUserfromChatChannel');
        await callable.call(<dynamic, dynamic>{
          'chatId': selectedPortal.documentInfo!.documentId,
          'memberId': element,
        }).then((value){

        }).catchError((error){

        });
        selectedBanUsers.remove(element);
      }).catchError((error){

      });
    });
    changeGetPortalGuestsIsLoadingStatus();
  }

  int chatWidgetsIndex = 0;

  changeChatWidgetsIndex(int index){
    chatWidgetsIndex = index;
    emit(ChangeChatWidgetsIndex());
  }


  @override
  Future<void> close() {
    clint.dispose();
    // clint.stopChannelWatching(channel.id!, "messaging");
    return super.close();
  }
}