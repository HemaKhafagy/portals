import 'package:Portals/models/add_friend_model.dart';
import 'package:Portals/models/friends_card_model.dart';
import 'package:Portals/screens/friends/cubit/states.dart';
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
  List<AddFriedModel> listOfNewFriendsSourceData = [
    AddFriedModel(
        name: "Scarlet Johansson",
        gender: "Female",
        friendImageUrl: "https://images.pexels.com/photos/1379636/pexels-photo-1379636.jpeg"
    ),
    AddFriedModel(
        name: "Luci Green",
        gender: "Female",
        friendImageUrl: "https://images.pexels.com/photos/7241443/pexels-photo-7241443.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    ),
    AddFriedModel(
        name: "Sarah Thomas",
        gender: "Female",
        friendImageUrl: "https://s3-alpha-sig.figma.com/img/9509/72bd/8a6979aab2060de04a3bb73b350750eb?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NpNMg3RBaa8N7mmH5jRXNzEA-Y040rCty4z7xIjeI78-~FLhI8UYD6twrjw77uxUzhWv~5cNKur7MppMQakcHhYMuwzt~qUkD5Jze3FgiSR8QQW70A99mGYln~a29KUosoGVVvkeZboWHx20ayPKcliFLeGWqIcSuwi8oGARctql9LnEtRG2hp3Ao5FuEHMKNCV8gvLFy1UheMfAnM7X8bX~oqsUbbwomKilbZGxAWjvVnmRuYQwC7nSK0KXiZSjoNDuUVq7J8KttcugGeJzR4WRVN~1QNFHKwknnkLHj5l-Oq1XhLbCerk3xR1Za~mXMXZ6Jf7JQTbZeGKGroVpLg__"
    ),
    AddFriedModel(
        name: 'Luci Green',
        gender: "Female",
        friendImageUrl: 'https://images.pexels.com/photos/7776200/pexels-photo-7776200.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
    ),
    AddFriedModel(
        name: 'Sarah Thomas',
        gender: "Female",
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/b917/4350/6c833d6707548ef00b50ff174cb3f47e?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qRmqagQMupwKhi5X5tLg-RUiqQu0oeznuAebnqK6h7f-6BRUB5iAGh7Zfv29Y4jPzKUunA5A7~RfCW--vFeV-Z2xCjDJTy-amo1bjwEdQ8kHjfLkW1naPVCvf4VsvZKILrcKp-Cllf~H4nG-09qV0qqX0sTqW-CJxrLL1gqucNt-BaDplVRmVY0T9yN0iLsQQBjwy9cIr7uLmpJ3WrdDwu3uvYri-tjpN7jhyUMOJbox8nQxuOP-K0NV6JLiwpfic0eEnRvvhs4GyZmJF3T2ZsMBhYnwsR1NO2AUOeD7XhPRrb-GgOfDIDkchBv5BTlbTLGdj~zdrSUn~n~-uFBpOw__'
    ),
    AddFriedModel(
        name: 'Sarah Thomas',
        gender: "Female",
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'
    ),
    AddFriedModel(
        name: 'Sarah Thomas',
        gender: "Female",
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'
    ),
  ];
  List<AddFriedModel> listOfNewFriendsCard = [
    AddFriedModel(
        name: "Scarlet Johansson",
        gender: "Female",
        friendImageUrl: "https://images.pexels.com/photos/1379636/pexels-photo-1379636.jpeg"
    ),
    AddFriedModel(
        name: "Luci Green",
        gender: "Female",
        friendImageUrl: "https://images.pexels.com/photos/7241443/pexels-photo-7241443.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    ),
    AddFriedModel(
        name: "Sarah Thomas",
        gender: "Female",
        friendImageUrl: "https://s3-alpha-sig.figma.com/img/9509/72bd/8a6979aab2060de04a3bb73b350750eb?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NpNMg3RBaa8N7mmH5jRXNzEA-Y040rCty4z7xIjeI78-~FLhI8UYD6twrjw77uxUzhWv~5cNKur7MppMQakcHhYMuwzt~qUkD5Jze3FgiSR8QQW70A99mGYln~a29KUosoGVVvkeZboWHx20ayPKcliFLeGWqIcSuwi8oGARctql9LnEtRG2hp3Ao5FuEHMKNCV8gvLFy1UheMfAnM7X8bX~oqsUbbwomKilbZGxAWjvVnmRuYQwC7nSK0KXiZSjoNDuUVq7J8KttcugGeJzR4WRVN~1QNFHKwknnkLHj5l-Oq1XhLbCerk3xR1Za~mXMXZ6Jf7JQTbZeGKGroVpLg__"
    ),
    AddFriedModel(
        name: 'Luci Green',
        gender: "Female",
        friendImageUrl: 'https://images.pexels.com/photos/7776200/pexels-photo-7776200.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
    ),
    AddFriedModel(
        name: 'Sarah Thomas',
        gender: "Female",
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/b917/4350/6c833d6707548ef00b50ff174cb3f47e?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qRmqagQMupwKhi5X5tLg-RUiqQu0oeznuAebnqK6h7f-6BRUB5iAGh7Zfv29Y4jPzKUunA5A7~RfCW--vFeV-Z2xCjDJTy-amo1bjwEdQ8kHjfLkW1naPVCvf4VsvZKILrcKp-Cllf~H4nG-09qV0qqX0sTqW-CJxrLL1gqucNt-BaDplVRmVY0T9yN0iLsQQBjwy9cIr7uLmpJ3WrdDwu3uvYri-tjpN7jhyUMOJbox8nQxuOP-K0NV6JLiwpfic0eEnRvvhs4GyZmJF3T2ZsMBhYnwsR1NO2AUOeD7XhPRrb-GgOfDIDkchBv5BTlbTLGdj~zdrSUn~n~-uFBpOw__'
    ),
    AddFriedModel(
        name: 'Sarah Thomas',
        gender: "Female",
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'
    ),
    AddFriedModel(
        name: 'Sarah Thomas',
        gender: "Female",
        friendImageUrl: 'https://s3-alpha-sig.figma.com/img/2fff/3618/341596633c53bf6e0543f476e88248dd?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mADLQk2Z8J3Klmljkl1xraLN20TKyaFtZnmid8LTwZdZrC6o8qDpWc65AFgMDzZ3cVise4unOp9zSNcG0ucKuYPE6p~ykmP1u-uQ3A8-n9SfubIlZkZPFp4NbIh7kfGMowcvKuC~TPT2dvfAnbkn4gaYXZH2nb~3WUl97n2bjjVQVROSDWLJtbpKRX-nU4JGJNeguumMZMnJnkBo8nl0uUDw1pLbl7kLDB02WLzkk4jHGujGMHoIpX--njIBxUApOT7pLJLqiikmPcJGHau7gy~ldnwiz4DeeF6-qhW7nMUzNpuVGsJ5aZH643MkG57EhtCidqRSImfXP26PzpFT0w__'
    ),
  ];
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

//******************************************************************************
//******************************************************************************
}