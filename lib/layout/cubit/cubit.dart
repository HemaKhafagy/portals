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

class HomeTapsCubit extends Cubit<HomeTapsCubitStates> {
  HomeTapsCubit() : super(HomeTapsCubitInitialState());

  static HomeTapsCubit get(context) => BlocProvider.of(context);

//****************************************************************************
// SPLASH SCREEN VARIABLES AMD STATES
//****************************************************************************
  bool splashIsLoading = false;

  void changeSplashIsLoadingStatus() {
    splashIsLoading = !splashIsLoading;
    emit(ChangeSplashIsLoadingState());
  }

  Future<void> checkUserExistence(BuildContext context) async {
    changeSplashIsLoadingStatus();
    await NotificationHandler.handelNotification();
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      await getUserData();
      portalsHomeInitFunction();
      navigateAndFinish(context: context, widget: const HomeTabsScreen());
    } else {
      changeSplashIsLoadingStatus();
    }
  }
//****************************************************************************
//****************************************************************************

  UserModel? userData;
  Future<void> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) async {
      userData = UserModel.fromJson(value.data()!);
      // var ref = FirebaseStorage.instance.ref().child("${user.uid}/data/profile");
      // await ref.getDownloadURL().;
      // userData!.imageURL = (await ref.getDownloadURL()).toString();
      await getUserImage(user.uid);
    }).catchError((error) {
      // handel your error
      print("ERROR FROM GET USER DATA METHOD");
      print(error);
    });
  }

  Future getUserImage(String id) async {
    var ref = FirebaseStorage.instance.ref().child("$id/data/profile");
    await ref.getDownloadURL().then((value) async {
      if (value.isEmpty) {
        var ref1 = FirebaseStorage.instance.ref().child("$id/data/avatar");
        await ref.getDownloadURL().then((value1) {
          if (value1.isEmpty) {
            userData!.imageURL = "";
          } else {
            userData!.imageURL = value1;
          }
        });
      } else {
        userData!.imageURL = value;
      }
    });
  }

  void incrementStarDustValue(int value) {
    print("incrementStarDustValue ........................................");
    print(userData);
    userData!.stardust = userData!.stardust! + value;
    emit(IncrementStarDustValue());
  }

//****************************************************************************
// HOME TAPS SCREEN VARIABLES AMD STATES
//****************************************************************************

  List<Widget> screens = [
    const PortalsHomeScreen(),
    const FriendsScreen(),
    const ExploreScreen(),
    const LeaderBoardsScreen(),
    const ProfileScreen(),
  ];

  int previousHomeScreenIndex = 0;
  int currentHomeScreenIndex = 0;

  void changeCurrentHomeIndexValue(int value) {
    previousHomeScreenIndex = currentHomeScreenIndex;
    currentHomeScreenIndex = value;
    if (value == 0) portalsHomeInitFunction();
    if (previousHomeScreenIndex == 0) portalsHomeDisposeFunction();
    if (value == 1) friendsHomeInitFunction();
    if (previousHomeScreenIndex == 1) friendsHomeDisposeFunction();
    if (value == 2) exploreHomeInitFunction();
    if (previousHomeScreenIndex == 2) exploreHomeDisposeFunction();
    if (value == 3) leaderboardsHomeInitFunction();
    if (previousHomeScreenIndex == 3) leaderboardsHomeDisposeFunction();
    if (value == 4) profileHomeInitFunction();
    if (previousHomeScreenIndex == 4) profileHomeDisposeFunction();
    emit(ChangeCurrentHomeIndexState());
  }

//****************************************************************************
// PORTALS HOME SCREEN VARIABLES AMD STATES
//****************************************************************************
  int portalCatSelectedButton = 0;

  StreamSubscription<QuerySnapshot>? portalsListSubStream;
  List<Portals> portalsListRealData = [];
  List<Portals> portalsList = [];

  void portalsHomeInitFunction() {
    getPortalsList();
  }

  void portalsHomeDisposeFunction() {
    print("close portalsHome streams successfully");
    if (portalsListSubStream != null) {
      portalsListSubStream!.cancel();
    }
  }

  void changePortalCatSelectedButton(int index) {
    portalCatSelectedButton = index;
    emit(ChangePortalCatSelectedButtonState());
  }

  Future<void> getPortalsList() async {
    portalsListSubStream = FirebaseFirestore.instance
        .collection('Portals')
        .snapshots()
        .listen((event) {
      portalsList = [];
      portalsListRealData = [];
      event.docs.forEach((element) {
        addToPortalsListState(element.data());
      });
    });
  }

  addToPortalsListState(var data) {
    portalsList.add(Portals.fromJson(data));
    portalsListRealData.add(Portals.fromJson(data));
    emit(AddToPortalsListState());
  }

  void searchForPortals(String text) {
    if (text.isEmpty || text == "Tap") {
      portalsList = portalsListRealData;
    } else {
      portalsList = portalsListRealData
          .where((element) =>
              element.topic!.contains(text) ||
              element.topic!.toLowerCase().contains(text))
          .toList();
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
        friendImageUrl:
            "https://images.pexels.com/photos/1379636/pexels-photo-1379636.jpeg"),
    FriendsCardModel(
        name: "Luci Green",
        status: "Online",
        lastMessage: "I’ve been meaning to send you a message, how are you?",
        friendImageUrl:
            "https://images.pexels.com/photos/7241443/pexels-photo-7241443.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    FriendsCardModel(
        name: "Sarah Thomas",
        status: "Online",
        lastMessage: "6:00 PM my place?",
        friendImageUrl:
            "https://s3-alpha-sig.figma.com/img/9509/72bd/8a6979aab2060de04a3bb73b350750eb?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NpNMg3RBaa8N7mmH5jRXNzEA-Y040rCty4z7xIjeI78-~FLhI8UYD6twrjw77uxUzhWv~5cNKur7MppMQakcHhYMuwzt~qUkD5Jze3FgiSR8QQW70A99mGYln~a29KUosoGVVvkeZboWHx20ayPKcliFLeGWqIcSuwi8oGARctql9LnEtRG2hp3Ao5FuEHMKNCV8gvLFy1UheMfAnM7X8bX~oqsUbbwomKilbZGxAWjvVnmRuYQwC7nSK0KXiZSjoNDuUVq7J8KttcugGeJzR4WRVN~1QNFHKwknnkLHj5l-Oq1XhLbCerk3xR1Za~mXMXZ6Jf7JQTbZeGKGroVpLg__"),
    FriendsCardModel(
        name: 'Luci Green',
        status: 'Away',
        lastMessage: 'Aren’t you a little too young?',
        friendImageUrl:
            'https://images.pexels.com/photos/7776200/pexels-photo-7776200.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Away',
        lastMessage: 'You’ll never beat me bro',
        friendImageUrl:
            'https://s3-alpha-sig.figma.com/img/b917/4350/6c833d6707548ef00b50ff174cb3f47e?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qRmqagQMupwKhi5X5tLg-RUiqQu0oeznuAebnqK6h7f-6BRUB5iAGh7Zfv29Y4jPzKUunA5A7~RfCW--vFeV-Z2xCjDJTy-amo1bjwEdQ8kHjfLkW1naPVCvf4VsvZKILrcKp-Cllf~H4nG-09qV0qqX0sTqW-CJxrLL1gqucNt-BaDplVRmVY0T9yN0iLsQQBjwy9cIr7uLmpJ3WrdDwu3uvYri-tjpN7jhyUMOJbox8nQxuOP-K0NV6JLiwpfic0eEnRvvhs4GyZmJF3T2ZsMBhYnwsR1NO2AUOeD7XhPRrb-GgOfDIDkchBv5BTlbTLGdj~zdrSUn~n~-uFBpOw__'),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Offline',
        lastMessage: 'Just looking for friendship atm',
        friendImageUrl:
            'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Offline',
        lastMessage: 'Just looking for friendship atm',
        friendImageUrl:
            'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'),
  ];
  List<FriendsCardModel> listViewFriendsCard = [
    FriendsCardModel(
        name: "Sarah Thomas",
        status: "Online",
        lastMessage: "Did you let me win? LOL",
        friendImageUrl:
            "https://images.pexels.com/photos/1379636/pexels-photo-1379636.jpeg"),
    FriendsCardModel(
        name: "Luci Green",
        status: "Online",
        lastMessage: "I’ve been meaning to send you a message, how are you?",
        friendImageUrl:
            "https://images.pexels.com/photos/7241443/pexels-photo-7241443.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    FriendsCardModel(
        name: "Sarah Thomas",
        status: "Online",
        lastMessage: "6:00 PM my place?",
        friendImageUrl:
            "https://s3-alpha-sig.figma.com/img/9509/72bd/8a6979aab2060de04a3bb73b350750eb?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NpNMg3RBaa8N7mmH5jRXNzEA-Y040rCty4z7xIjeI78-~FLhI8UYD6twrjw77uxUzhWv~5cNKur7MppMQakcHhYMuwzt~qUkD5Jze3FgiSR8QQW70A99mGYln~a29KUosoGVVvkeZboWHx20ayPKcliFLeGWqIcSuwi8oGARctql9LnEtRG2hp3Ao5FuEHMKNCV8gvLFy1UheMfAnM7X8bX~oqsUbbwomKilbZGxAWjvVnmRuYQwC7nSK0KXiZSjoNDuUVq7J8KttcugGeJzR4WRVN~1QNFHKwknnkLHj5l-Oq1XhLbCerk3xR1Za~mXMXZ6Jf7JQTbZeGKGroVpLg__"),
    FriendsCardModel(
        name: 'Luci Green',
        status: 'Away',
        lastMessage: 'Aren’t you a little too young?',
        friendImageUrl:
            'https://images.pexels.com/photos/7776200/pexels-photo-7776200.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Away',
        lastMessage: 'You’ll never beat me bro',
        friendImageUrl:
            'https://s3-alpha-sig.figma.com/img/b917/4350/6c833d6707548ef00b50ff174cb3f47e?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qRmqagQMupwKhi5X5tLg-RUiqQu0oeznuAebnqK6h7f-6BRUB5iAGh7Zfv29Y4jPzKUunA5A7~RfCW--vFeV-Z2xCjDJTy-amo1bjwEdQ8kHjfLkW1naPVCvf4VsvZKILrcKp-Cllf~H4nG-09qV0qqX0sTqW-CJxrLL1gqucNt-BaDplVRmVY0T9yN0iLsQQBjwy9cIr7uLmpJ3WrdDwu3uvYri-tjpN7jhyUMOJbox8nQxuOP-K0NV6JLiwpfic0eEnRvvhs4GyZmJF3T2ZsMBhYnwsR1NO2AUOeD7XhPRrb-GgOfDIDkchBv5BTlbTLGdj~zdrSUn~n~-uFBpOw__'),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Offline',
        lastMessage: 'Just looking for friendship atm',
        friendImageUrl:
            'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'),
    FriendsCardModel(
        name: 'Sarah Thomas',
        status: 'Offline',
        lastMessage: 'Just looking for friendship atm',
        friendImageUrl:
            'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'),
  ];

  bool myOnlineStatus = true;
  String friendsListSortBy = "status";

  void friendsHomeInitFunction() {}
  void friendsHomeDisposeFunction() {}

  void searchForFriends(String text) {
    if (text.isEmpty) {
      listViewFriendsCard = listViewFriendsCardSourceData;
    } else {
      listViewFriendsCard = listViewFriendsCardSourceData
          .where((element) =>
              element.name!.contains(text) ||
              element.name!.toLowerCase().contains(text))
          .toList();
    }
    emit(SearchForFriendsState());
  }

  void changeMyOnlineStatus() {
    myOnlineStatus = !myOnlineStatus;
    emit(ChangeMyOnlineStatusState());
  }

  void changeFriendsListSortBy() {
    friendsListSortBy = friendsListSortBy == "status" ? "name" : "status";
    friendsListSortBy == "status"
        ? listViewFriendsCard
            .sort((a, b) => a.toString().compareTo(b.toString()))
        : listViewFriendsCard;
    emit(ChangeFriendsListSortByState());
  }

//****************************************************************************
//****************************************************************************

//****************************************************************************
// EXPLORE HOME SCREEN VARIABLES AMD STATES
//****************************************************************************
  late VideoPlayerController videController;
  ChewieController? chewieController;
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

  void exploreHomeInitFunction() {}
  void exploreHomeDisposeFunction() {
    videController.pause();
    videController.dispose();
    chewieController!.pause();
    chewieController!.dispose();
  }

  Future pickVideo() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickVideo(source: ImageSource.gallery).then((value) async {
      videosURL.add(value!.path);
    }).catchError((error) {});
  }

  Future initializeVideoPlayer(String src) async {
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

  void changeLikeButtonState() {
    liked = !liked;
    emit(ChangeLikeButtonState());
  }

  void changePlayAndPauseVideo() {
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
        playerImageUrl:
            "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl:
            "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl:
            "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl:
            "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl:
            "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl:
            "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"),
    LeaderBoardsModel(
        gameName: "Quantum Solstice",
        playerName: "Gigachad",
        playerImageUrl:
            "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__",
        playerRank: "9.999.999"),
  ];
  int selectedGameIndex = 0;

  void leaderboardsHomeInitFunction() {}
  void leaderboardsHomeDisposeFunction() {}

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

  List listOfUserBadges = [];

  List listOfUserGifts = [];

  bool profileDetailsIsOpened = true;

  void changeProfileDetailsIsOpenedStatus() {
    profileDetailsIsOpened = !profileDetailsIsOpened;
    emit(ChangeProfileDetailsIsOpenedState());
  }

  void profileHomeInitFunction() {}
  void profileHomeDisposeFunction() {}

  TextEditingController editProfileFirstNameController =
      TextEditingController();
  TextEditingController editProfileLastNameController = TextEditingController();
  TextEditingController editProfileEmailController = TextEditingController();
  TextEditingController editAboutYouController = TextEditingController();
  TextEditingController editCountryController = TextEditingController();
  TextEditingController editCityController = TextEditingController();
  bool updateUserDataIsLoading = false;
  void changeUpdateUserDataIsLoadingState() {
    updateUserDataIsLoading = !updateUserDataIsLoading;
    emit(ChangeUpdateUserDataIsLoadingState());
  }

  Future updateUserData(BuildContext context) async {
    changeUpdateUserDataIsLoadingState();
    if (editProfileFirstNameController.text.isEmpty &&
        editProfileLastNameController.text.isEmpty &&
        editProfileEmailController.text.isEmpty &&
        editAboutYouController.text.isEmpty &&
        editCountryController.text.isEmpty &&
        editCityController.text.isEmpty) {
      showSharedAlertDialog(
          title: "",
          content: "Please enter data do you need to edit it",
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
      final user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .update({
        if (editProfileFirstNameController.text.isNotEmpty)
          "firstName": editProfileFirstNameController.text,
        if (editProfileLastNameController.text.isNotEmpty)
          "lastName": editProfileLastNameController.text,
        if (editProfileEmailController.text.isNotEmpty)
          "email": editProfileEmailController.text,
        if (editAboutYouController.text.isNotEmpty)
          "about": editAboutYouController.text,
        if (editCountryController.text.isNotEmpty)
          "country": editCountryController.text,
        if (editCityController.text.isNotEmpty) "city": editCityController.text,
      }).then((value) async {
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
      }).catchError((error) {
        print("UPDATE USER DATA GOT ERROR.......................");
      });
    }
    changeUpdateUserDataIsLoadingState();
  }
//****************************************************************************
//****************************************************************************
}
