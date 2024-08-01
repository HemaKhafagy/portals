import 'dart:async';
import 'package:Portals/layout/cubit/states.dart';
import 'package:Portals/layout/home_taps_screen.dart';
import 'package:Portals/models/friends_card_model.dart';
import 'package:Portals/models/leader_boards_model.dart';
import 'package:Portals/models/portals.dart';
import 'package:Portals/models/user_model.dart';
import 'package:Portals/screens/friends/friends_screen.dart';
import 'package:Portals/screens/leader_boards/leader_boards_screen.dart';
import 'package:Portals/screens/portals_config/protals_home.dart';
import 'package:Portals/screens/profile/profile_screen.dart';
import 'package:Portals/screens/videos/explore_screen.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/notification_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeTapsCubit extends Cubit<HomeTapsCubitStates>
{

  HomeTapsCubit() : super(HomeTapsCubitInitialState());

  static HomeTapsCubit get(context) => BlocProvider.of(context);

//****************************************************************************
// SPLASH SCREEN VARIABLES AMD STATES
//****************************************************************************
  bool splashIsLoading = false;

  void changeSplashIsLoadingStatus()
  {
    splashIsLoading = !splashIsLoading;
    emit(ChangeSplashIsLoadingState());
  }
  Future<void> checkUserExistence(BuildContext context) async
  {
    changeSplashIsLoadingStatus();
    await NotificationHandler.handelNotification();
    final user = await FirebaseAuth.instance.currentUser;
    if(user != null)
      {
        await getUserData();
        portalsHomeInitFunction();
        navigateAndFinish(context: context, widget: const HomeTabsScreen());
      }else{
      changeSplashIsLoadingStatus();
    }
  }
//****************************************************************************
//****************************************************************************

  UserModel ? userData;
  Future<void> getUserData() async
  {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get().then((value) async{
      userData = UserModel.fromJson(value.data()!);
      print(userData);
      var ref = FirebaseStorage.instance.ref().child("${user.uid}/data/portalProfile");
      print(ref);
      userData!.imageURL = (await ref.getDownloadURL()).toString();
    }).catchError((error){
      // handel your error
      print("ERROR FROM GET USER DATA METHOD");
      print(error);
    });
  }

  void incrementStarDustValue(int value)
  {
    print("incrementStarDustValue ........................................");
    print(userData);
    userData!.stardust = userData!.stardust! + value;
    emit(IncrementStarDustValue());
  }


//****************************************************************************
// HOME TAPS SCREEN VARIABLES AMD STATES
//****************************************************************************

  List<Widget> screens =[
    const PortalsHomeScreen(),
    const FriendsScreen(),
    const ExploreScreen(),
    const LeaderBoardsScreen(),
    const ProfileScreen(),
  ];

  int previousHomeScreenIndex = 0;
  int currentHomeScreenIndex = 0;

  void changeCurrentHomeIndexValue(int value)
  {
    previousHomeScreenIndex = currentHomeScreenIndex;
    currentHomeScreenIndex = value;
    if(value == 0) portalsHomeInitFunction();
    if(previousHomeScreenIndex == 0) portalsHomeDisposeFunction();
    if(value == 1) friendsHomeInitFunction();
    if(previousHomeScreenIndex == 1) friendsHomeDisposeFunction();
    if(value == 2) exploreHomeInitFunction();
    if(previousHomeScreenIndex == 2) exploreHomeDisposeFunction();
    if(value == 3) leaderboardsHomeInitFunction();
    if(previousHomeScreenIndex == 3) leaderboardsHomeDisposeFunction();
    if(value == 4) profileHomeInitFunction();
    if(previousHomeScreenIndex == 4) profileHomeDisposeFunction();
    emit(ChangeCurrentHomeIndexState());
  }


//****************************************************************************
// PORTALS HOME SCREEN VARIABLES AMD STATES
//****************************************************************************
  int portalCatSelectedButton = 0;

  StreamSubscription<QuerySnapshot> ? portalsListSubStream;
  List<Portals> portalsListRealData = [];
  List<Portals> portalsList = [];


  void portalsHomeInitFunction()
  {
    getPortalsList();
  }

  void portalsHomeDisposeFunction()
  {
    print("close portalsHome streams successfully");
    if(portalsListSubStream != null){
      portalsListSubStream!.cancel();
    }
  }

  void changePortalCatSelectedButton(int index)
  {
    portalCatSelectedButton = index;
    emit(ChangePortalCatSelectedButtonState());
  }

  Future<void> getPortalsList() async
  {
    portalsListSubStream = FirebaseFirestore.instance.collection('Portals').snapshots().listen((event) {
      portalsList = [];
      portalsListRealData = [];
      event.docs.forEach((element) {
        addToPortalsListState(element.data());
      });
    });
  }

  addToPortalsListState(var data)
  {
    portalsList.add(Portals.fromJson(data));
    portalsListRealData.add(Portals.fromJson(data));
    emit(AddToPortalsListState());
  }

  void searchForPortals(String text)
  {
    if(text.isEmpty || text == "Tap"){
      portalsList = portalsListRealData;
    }else{
      portalsList = portalsListRealData.where((element) => element.topic!.contains(text) || element.topic!.toLowerCase().contains(text)).toList();
    }
    emit(SearchForPortalsState());
  }

//****************************************************************************
//****************************************************************************

//****************************************************************************
// FRIENDS HOME SCREEN VARIABLES AMD STATES
//****************************************************************************
  List<FriendsCardModel> listViewFriendsCardSourceData = [
    FriendsCardModel(
        name: "Sarah Thomas",
        status: "Online",
        lastMessage: "Did you let me win? LOL",
        friendImageUrl: "https://images.pexels.com/photos/1379636/pexels-photo-1379636.jpeg"
    ),
    FriendsCardModel(
        name: "Luci Green",
        status: "Online",
        lastMessage: "I’ve been meaning to send you a message, how are you?",
        friendImageUrl: "https://images.pexels.com/photos/7241443/pexels-photo-7241443.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    ),
    FriendsCardModel(
        name: "Sarah Thomas",
        status: "Online",
        lastMessage: "6:00 PM my place?",
        friendImageUrl: "https://s3-alpha-sig.figma.com/img/9509/72bd/8a6979aab2060de04a3bb73b350750eb?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NpNMg3RBaa8N7mmH5jRXNzEA-Y040rCty4z7xIjeI78-~FLhI8UYD6twrjw77uxUzhWv~5cNKur7MppMQakcHhYMuwzt~qUkD5Jze3FgiSR8QQW70A99mGYln~a29KUosoGVVvkeZboWHx20ayPKcliFLeGWqIcSuwi8oGARctql9LnEtRG2hp3Ao5FuEHMKNCV8gvLFy1UheMfAnM7X8bX~oqsUbbwomKilbZGxAWjvVnmRuYQwC7nSK0KXiZSjoNDuUVq7J8KttcugGeJzR4WRVN~1QNFHKwknnkLHj5l-Oq1XhLbCerk3xR1Za~mXMXZ6Jf7JQTbZeGKGroVpLg__"
    ),
    FriendsCardModel(
        name: 'Luci Green',
        status: 'Away',
        lastMessage: 'Aren’t you a little too young?',
        friendImageUrl: 'https://images.pexels.com/photos/7776200/pexels-photo-7776200.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
    ),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Away',
        lastMessage: 'You’ll never beat me bro',
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/b917/4350/6c833d6707548ef00b50ff174cb3f47e?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qRmqagQMupwKhi5X5tLg-RUiqQu0oeznuAebnqK6h7f-6BRUB5iAGh7Zfv29Y4jPzKUunA5A7~RfCW--vFeV-Z2xCjDJTy-amo1bjwEdQ8kHjfLkW1naPVCvf4VsvZKILrcKp-Cllf~H4nG-09qV0qqX0sTqW-CJxrLL1gqucNt-BaDplVRmVY0T9yN0iLsQQBjwy9cIr7uLmpJ3WrdDwu3uvYri-tjpN7jhyUMOJbox8nQxuOP-K0NV6JLiwpfic0eEnRvvhs4GyZmJF3T2ZsMBhYnwsR1NO2AUOeD7XhPRrb-GgOfDIDkchBv5BTlbTLGdj~zdrSUn~n~-uFBpOw__'
    ),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Offline',
        lastMessage: 'Just looking for friendship atm',
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'
    ),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Offline',
        lastMessage: 'Just looking for friendship atm',
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'
    ),
  ];
  List<FriendsCardModel> listViewFriendsCard = [
    FriendsCardModel(
        name: "Sarah Thomas",
        status: "Online",
        lastMessage: "Did you let me win? LOL",
        friendImageUrl: "https://images.pexels.com/photos/1379636/pexels-photo-1379636.jpeg"
    ),
    FriendsCardModel(
        name: "Luci Green",
        status: "Online",
        lastMessage: "I’ve been meaning to send you a message, how are you?",
        friendImageUrl: "https://images.pexels.com/photos/7241443/pexels-photo-7241443.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    ),
    FriendsCardModel(
        name: "Sarah Thomas",
        status: "Online",
        lastMessage: "6:00 PM my place?",
        friendImageUrl: "https://s3-alpha-sig.figma.com/img/9509/72bd/8a6979aab2060de04a3bb73b350750eb?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NpNMg3RBaa8N7mmH5jRXNzEA-Y040rCty4z7xIjeI78-~FLhI8UYD6twrjw77uxUzhWv~5cNKur7MppMQakcHhYMuwzt~qUkD5Jze3FgiSR8QQW70A99mGYln~a29KUosoGVVvkeZboWHx20ayPKcliFLeGWqIcSuwi8oGARctql9LnEtRG2hp3Ao5FuEHMKNCV8gvLFy1UheMfAnM7X8bX~oqsUbbwomKilbZGxAWjvVnmRuYQwC7nSK0KXiZSjoNDuUVq7J8KttcugGeJzR4WRVN~1QNFHKwknnkLHj5l-Oq1XhLbCerk3xR1Za~mXMXZ6Jf7JQTbZeGKGroVpLg__"
    ),
    FriendsCardModel(
        name: 'Luci Green',
        status: 'Away',
        lastMessage: 'Aren’t you a little too young?',
        friendImageUrl: 'https://images.pexels.com/photos/7776200/pexels-photo-7776200.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
    ),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Away',
        lastMessage: 'You’ll never beat me bro',
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/b917/4350/6c833d6707548ef00b50ff174cb3f47e?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qRmqagQMupwKhi5X5tLg-RUiqQu0oeznuAebnqK6h7f-6BRUB5iAGh7Zfv29Y4jPzKUunA5A7~RfCW--vFeV-Z2xCjDJTy-amo1bjwEdQ8kHjfLkW1naPVCvf4VsvZKILrcKp-Cllf~H4nG-09qV0qqX0sTqW-CJxrLL1gqucNt-BaDplVRmVY0T9yN0iLsQQBjwy9cIr7uLmpJ3WrdDwu3uvYri-tjpN7jhyUMOJbox8nQxuOP-K0NV6JLiwpfic0eEnRvvhs4GyZmJF3T2ZsMBhYnwsR1NO2AUOeD7XhPRrb-GgOfDIDkchBv5BTlbTLGdj~zdrSUn~n~-uFBpOw__'
    ),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Offline',
        lastMessage: 'Just looking for friendship atm',
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'
    ),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Offline',
        lastMessage: 'Just looking for friendship atm',
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'
    ),
  ];

  bool myOnlineStatus = true;
  String friendsListSortBy = "status";

  void friendsHomeInitFunction()
  {

  }
  void friendsHomeDisposeFunction()
  {

  }

  void searchForFriends(String text)
  {
    if(text.isEmpty){
      listViewFriendsCard = listViewFriendsCardSourceData;
    }else{
      listViewFriendsCard = listViewFriendsCardSourceData.where((element) => element.name!.contains(text) || element.name!.toLowerCase().contains(text)).toList();
    }
    emit(SearchForFriendsState());
  }

  void changeMyOnlineStatus()
  {
    myOnlineStatus = !myOnlineStatus;
    emit(ChangeMyOnlineStatusState());
  }

  void changeFriendsListSortBy()
  {
    friendsListSortBy = friendsListSortBy == "status" ? "name" : "status";
    friendsListSortBy == "status" ? listViewFriendsCard.sort((a, b) => a.toString().compareTo(b.toString())) : listViewFriendsCard;
    emit(ChangeFriendsListSortByState());
  }

//****************************************************************************
//****************************************************************************

//****************************************************************************
// EXPLORE HOME SCREEN VARIABLES AMD STATES
//****************************************************************************
  late VideoPlayerController videController;
  ChewieController ? chewieController;
  bool liked = false;
  bool videoIsLoading = false;


  final List<String> videosURL = [
    "https://media.istockphoto.com/id/1334298602/video/gameplay-of-a-racing-simulator-video-game-with-interface-computer-generated-3d-car-driving.mp4?s=mp4-640x640-is&k=20&c=BK0DKkECYXW-KbJw0s7I95qhNzJo_LxftYw8B56XN9E=",
    "https://media.istockphoto.com/id/1393553089/video/successful-gamer-winning-in-online-video-game-on-computer-close-up-portrait-of-young-black.mp4?s=mp4-640x640-is&k=20&c=vTNAz00iOGtTvmbZTZayjUIKrfxF3YI1t8Tq-c_f5JI=",
    'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
  ];


  void exploreHomeInitFunction()
  {

  }
  void exploreHomeDisposeFunction()
  {
    videController.pause();
    videController.dispose();
    chewieController!.pause();
    chewieController!.dispose();
  }


  Future pickVideo() async
  {
    final ImagePicker picker = ImagePicker();
    await picker.pickVideo(source: ImageSource.gallery).then((value) async{
      videosURL.add(value!.path);
    }).catchError((error){

    });
  }


  Future initializeVideoPlayer(String src) async
  {
    videoIsLoading = true;
    videController = VideoPlayerController.networkUrl(Uri.parse(src));
    await Future.wait([videController.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videController,
      autoPlay: true,
      showControls: false,
      looping: true,
      // fullScreenByDefault: true
    );
    videoIsLoading = false;
    emit(InitializeVideoPlayerState());
  }

  void changeLikeButtonState()
  {
    liked = !liked;
    emit(ChangeLikeButtonState());
  }

  void changePlayAndPauseVideo()
  {
    videController.value.isPlaying
        ? videController.pause()
        : videController.play();
    emit(ChangePlayAndPauseVideoState());
  }


//****************************************************************************
//****************************************************************************

//****************************************************************************
// LEADERBOARDS HOME SCREEN VARIABLES AMD STATES
//****************************************************************************
  List<String> gamesNameList = [
    "Quantum Solstice",
    "Color Picker",
    "Flappy Bird",
    "Hang Man",
    "2 Truths 1 Lie",
  ];
  List<LeaderBoardsModel> leadersListItems = [
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl: "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"
    ),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl: "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"
    ),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl: "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"
    ),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl: "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"
    ),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl: "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"
    ),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl: "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"
    ),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl: "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"
    ),
  ];
  int selectedGameIndex = 0;

  void leaderboardsHomeInitFunction()
  {

  }
  void leaderboardsHomeDisposeFunction()
  {

  }

//****************************************************************************
//****************************************************************************

//****************************************************************************
// PROFILE HOME SCREEN VARIABLES AMD STATES
//****************************************************************************
  List listOfUserFeathers = [
    "Outgoing",
    "Fashion",
    "Fitness",
    "Talkative",
    "Socialite",
  ];

  List listOfUserBadges = [
    "https://s3-alpha-sig.figma.com/img/2f3f/1616/be87001c31eed4bebde22105113862f7?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=e3ynPS86ieP3plJR1aIAL~vKmK3ny~ewcK-g3zJAcSoluk0lr6IMKFuEGKxUDrfIhrmu8-zX7VJt8bP922gsjShnXYkIqdF-CAMFlwTVFg845EJeUXt-3WoEpFDSDtAdj3LDGtcOt9qsVpuU1mR7DBZm5nH3o2Kpw-CXuzLBZJ-sLI8qesHKzqZNoUVHgbrkZ0SDq~QYMePa~iHQcPvEZcQTfduTegI5w~To~SUuHSKQqTjgc4g8yQRP-HClPVnXOsl8ZGfDU~cdCzAISMlwK2O0kbJQoGnNE6HzIi9BihDEGjhOZQkqJDd7RlvPo2l-iYLULjqhk7GZnBqhb0FiOg__",
    "https://s3-alpha-sig.figma.com/img/d182/ed81/59824cb2b08a7656ebfeb5497a179dbd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=G7rd2-eal2Jy8GYb1tNHwCuECVk3OpxmOouomZRd7x1vvxBCiNPBRul8oCdyreKmqzIBDs8JFWzArxfvKbgkzisV4Dle4F0h1BTuIjWsRbDQzHCpVRazkUQ1t3RY4zHB-mJ5QhizkuzftufRzpIM-vqwlmagAM~LtJALsiBaBsVQND55E-q27cOkBlEie4WG06U~nPNVi-oHg6j0zJ1tj0DxaCnUGnHlmfq0mnNr2Y3vhsrwKjOzFi~8udqDl28eaHZ2t-6CIZ~2QpcWorWE8~2ifkWL-fSSYGsY1-pPFS9tW7sXJI8VV9j6yic2crEkVzm-WFhdSTg8JsegxaUG-A__",
    "https://s3-alpha-sig.figma.com/img/c40f/707e/032395e70b962da58c0e7bfc3e0b680d?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=b8li7Ff4PaGQoSaXZE9HKuYukp3S2~bTk4zMlA-BDYrSzjPq28~R6DBwW-Cr7dkNfpCGSEU3JtGlWxYFFs-ryyNGj2Tad6h8Jpfg8CBOmTLZd7r3JzCsn7trsZ-xOQWUxRykBxOrkXnC1TKhFoZ1HBOzl8AthQI3uTPSbenaT-DuTYNjcuP0gmUS1SKJzMpXpIWFz4GOTTv8HiiJ7UJ4rBeGIDrIznkKO1USI1WkJOd59Yy8YrAqY9jGxyx1yi6EGR~cF6vSGvpV784ogu0W3dPK2xTUJSaqdPk4-18b9ecJCmKtihKBQwy0UKCCTJxytAhMgIxYfzsb6GVyL9bSBg__",
    "https://s3-alpha-sig.figma.com/img/22e6/8d84/3ad30e437d7a18d3e3fb57f8dbcbd043?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Rwpcuqwzn0sGAF9wAWj61Uo4IdJhlmeTeqQqvsYPgH1F0ETD1Hvw01x5QLLyUD61ki8eFv~6AGZ1m2I785Bwc14eUd-OHuwTf1uzuxnKQ~ls3W9UbhI-35wd4nUcbsFQxcipZS9roH5Or7QDLACaVzkhmhnYgyer6cIlCzzD6kZQHwRqQUdjMZv8CLcHnwRLa4yCkInUoF4eR-UCijNI7oIM1Ce1wKiR2hem3g9VW4PclcLsS4gitiMcLiNEIUHSgFYz1Oi~TPOBcs5sf2ALpFSJRw8zM7z9DqnERF7nrhnmpo8vwYLn12bCvpc--ck0cDrmKyjP79isY~jqu~I0aA__",
    "https://s3-alpha-sig.figma.com/img/9e3f/f4f6/e876b0b4b2ee09e657a8c1dad0f88e96?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=az3N6SQrwFQ9okJbsjC-pqCbgELa8A4EMxv4ZH0iTjV6cZ75YngWNa0FSy0Wh9nNYVpZ3dLPFFNJLEXcVaL-ovTg-UAXU46tEIK5ECACq71Yt5B7BQt8qmRCpOXwGz3sY6-J5PhvxtTvr5FGO5lwaEyd8gCLE565YIi0RrtvO5yA9h4Eqm85GHBX1PVRZ92yxtNYssCEXkUW3miTco97GO9apn5w8rwg-aPLZyPRlZr~aIgirLM15OYTq9VFAMPmGHYci1e3MDb6EghfXfuy5ZsQY6WzRvFA4ntfKR1wQ7vvB8t8M3DAvv2yisaaJvnFipXOa99Vv-HxC38TW9Canw__",
  ];

  List listOfUserGifts = [
    "https://s3-alpha-sig.figma.com/img/dbbc/a4d1/808c899537a9d42edc2faa6b820944e9?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=AGq-cLoBvOk7WfJf7kIKNA-ySqqIz4ZLBEzjTF6AmSHi-4Ung5FeA9XSXA9ix5IkwKHiImRgaok5F-YtWyv29LyCEboKvffPUZH1bamlMvCJugEsM7qoVhzCe1CDSm23UvqFuTPmGiyvkMR3x9RujGd26-qYxNz~XMiO6-TooBW92GZiRL~p5PZT06Mdw4T18NEdqK4LTtkHda89U9pU3p~GK2JWgu-FAvcCqW3lD1s1oAtZ3pGDGVOm06ALCXXOD0hb1Osiumy57TIHYN0DOH9EeC7IVYLGG0pyZNPm0vlxjz~0AO6Mxa965iWZEbulJYEvoeCGPnEHS-JjuHJEGA__",
    "https://s3-alpha-sig.figma.com/img/9d92/01e3/56ea53e0782b16ed3c9041d07d8e4486?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Z3FA4chGhQ1PB5zXtYEcsnBRneJqvE3~Sq4jJ2V42j5~uvwTfc3HDcDNaJr1kLe3joYyiMGrF8jrNIfziiyZOpn3gFbah-Xz2uLXRZlHvj-PHfnKEkW3DL~doA~IbNhwxJvAs54PzryxTcrZN3c7rzL3oQwzu2P8uZR9BDC9azJC4x236SSdiYHTzs-tYBl7ZEzicGpm1iQppanMnU70j2T02RUAtpWTSTtWgsaZ0~ANmE-EH3a9Obe59xBYb6bCgUb6HFgRGddtYkgrh-kTrXv3bAcrzMunUBhPSz-eX~H~xxToRWHJiAjlDKnEDEJYHK4sz7dvjKsBev8hGXSBQQ__",
    "https://s3-alpha-sig.figma.com/img/cacf/294e/316366a2ceaeadce35fd66e7477cea1f?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=iRy~0X4Y7y6-0d3v8I8hpgjduiIj87jZbj5xgLiJMtz1e9rgyNxfUBMSwCggJOnAYI5jB5Ac0p~fhC6~9VQPsMoaO9cn6cshtGivsduGvy5Yzv5sqz1g-934UgbwSmphUmnHgp9pmwYZMRMBE5-MoYKjOHagFh14YGRBbIT8wDLmkanDDCTT5pD654AnA5YMhGYB1D8ExtoZebfeDcQ4w1ITDKZfsHvuB8g5X3dnrWIVavHQdoIJ9wciRDO2v74fDXMzhQczHoBsGKIWePnsBoBzjmL70U5aXDO~zRQjh4IlKIYXmcYvXLmAtS0BRjeiK92GkOGuaDiT6Uo51A92Sg__",
    "https://s3-alpha-sig.figma.com/img/4696/828e/566b58dd93382144bd30a20272c8659f?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=PK46qkfHHTtZLIPlyUWlaxGPFZx69RKGlCoZqGH2GIzYRmxbx5bl-qV7RyBoKGmT0pSyV5dxPIfUTyY52lCZL~r2FKXRXaE52eRQ0tRVbDIRzc~9nnbfeaoLXz2vga~K3U7F0JCiwairoF9x~IbllCUPwSSeUoDATqdJG-vheFT1QuY5GJsiFQVxSlEoyFqokNnScRynC1Vp8K4ZxhGlbcC6K3zR920gDAWO4B32-2lBcg5bhFBT6lus40hv~0StoPgHzsABMStHcyxvkgj9iqkbtsDw6lkLppXl6caq8rcqWgzU9vH2DnkUK5G2UeAKRf7IjDDFDaEGZmyzhA4WkQ__",
    "https://s3-alpha-sig.figma.com/img/62dd/029a/fe69ba9a287fd9f99319989189897531?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=piaD6QExsnUaJ51V6cTLpa8AJ4cawtyMJtlttMs9NQxYHFd13VRggdrTsyrB3tIQQRbv96oa5S1uez3jMocMWYiPrP308XdqQjLKRAN~sPUYw9RaGSrr37upHlnuMI7ixmbNtxBowCR0sY25F5HS1PD6ASqLSKY-Mi965IdPujBENskV3GSO-c8KBXjTKf4bYv~j~SDMGXQM9x-4eRRGHNL1c8DDAg1w2ZcQmz0UgoXhU65fNr2vaUbiGgFaEhWw3W~hZ-Tfg~wJ-FWacQAcIhDz9f3~GXsVckQbNiawIkMFalwvZFb1k~xe5FXJRCp3c56u60bK3Du40T2IbD~rmQ__",
  ];

  bool profileDetailsIsOpened = true;

  void changeProfileDetailsIsOpenedStatus()
  {
    profileDetailsIsOpened = !profileDetailsIsOpened;
    emit(ChangeProfileDetailsIsOpenedState());
  }

  void profileHomeInitFunction()
  {

  }
  void profileHomeDisposeFunction()
  {

  }


  TextEditingController editProfileFirstNameController = TextEditingController();
  TextEditingController editProfileLastNameController = TextEditingController();
  TextEditingController editProfileEmailController = TextEditingController();
  TextEditingController editAboutYouController = TextEditingController();
  TextEditingController editCountryController = TextEditingController();
  TextEditingController editCityController = TextEditingController();
  bool updateUserDataIsLoading = false;
  void changeUpdateUserDataIsLoadingState()
  {
    updateUserDataIsLoading = !updateUserDataIsLoading;
    emit(ChangeUpdateUserDataIsLoadingState());
  }
  Future updateUserData(BuildContext context) async
  {
    changeUpdateUserDataIsLoadingState();
    if(
    editProfileFirstNameController.text.isEmpty &&
    editProfileLastNameController.text.isEmpty &&
    editProfileEmailController.text.isEmpty &&
    editAboutYouController.text.isEmpty &&
    editCountryController.text.isEmpty &&
    editCityController.text.isEmpty
    ){
      showSharedAlertDialog(
          title: "",
          content: "Please enter data do you need to edit it",
          context: context,
          actions: [
            buildSharedButton(buttonName: "Close", isEnabled: true, action: (){Navigator.of(context).pop();}),
          ]
      );
    }else {
      final user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('Users').doc(user!.uid).update({
        if(editProfileFirstNameController.text.isNotEmpty) "firstName": editProfileFirstNameController.text,
        if(editProfileLastNameController.text.isNotEmpty) "lastName": editProfileLastNameController.text,
        if(editProfileEmailController.text.isNotEmpty) "email": editProfileEmailController.text,
        if(editAboutYouController.text.isNotEmpty) "about": editAboutYouController.text,
        if(editCountryController.text.isNotEmpty) "country": editCountryController.text,
        if(editCityController.text.isNotEmpty) "city": editCityController.text,
      }).then((value) async{
        await getUserData();
        print("UPDATE USER DATA Successfully.......................");
        editProfileFirstNameController.clear();
        editProfileLastNameController.clear();
        editProfileEmailController.clear();
        editAboutYouController.clear();
        editCountryController.clear();
        editCityController.clear();
        Navigator.of(context).pop();
        sharedToast(text: "Your Data Updated Successfully");
        // showSharedAlertDialog(
        //     title: "Congrats!",
        //     content: "Your Data Updated Successfully",
        //     context: context,
        //     actions: [
        //       buildSharedButton(buttonName: "Close", isEnabled: true, action: (){Navigator.of(context).pop();}),
        //     ]
        // );
      }).catchError((error){
        print("UPDATE USER DATA GOT ERROR.......................");
      });
    }
    changeUpdateUserDataIsLoadingState();
  }
//****************************************************************************
//****************************************************************************

}