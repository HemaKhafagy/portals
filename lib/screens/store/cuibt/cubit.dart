import 'package:Portals/models/stardust_model.dart';
import 'package:Portals/models/stickers&gifts_model.dart';
import 'package:Portals/screens/store/cuibt/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreCubit extends Cubit<StoreCubitStates>
{

  StoreCubit() : super(StoreCubitInitialState());

  static StoreCubit get(context) => BlocProvider.of(context);

  bool exchangeIsOpened = false;
  bool isExchanged = false;
  bool isDone = false;

  List<StardustModel> stardustList = [
    StardustModel(imageUrl: "assets/image/moon.png", amount: 100, price: 0.99),
    StardustModel(imageUrl: "assets/image/moon.png", amount: 550, price: 4.99),
    StardustModel(imageUrl: "assets/image/moon.png", amount: 1200, price: 9.99),
  ];

  List<String> sgList = [
    "Stickers",
    "Gifts",
    "Handcuffs",
    "Chocolate",
  ];

  List<StickersAndGiftsModel> sgCardList = [
    StickersAndGiftsModel(imageUrl: "assets/image/smile.png",amount: 5),
    StickersAndGiftsModel(imageUrl: "assets/image/smile.png",amount: 6),
    StickersAndGiftsModel(imageUrl: "assets/image/smile.png",amount: 7),
    StickersAndGiftsModel(imageUrl: "assets/image/smile.png",amount: 8),
  ];

  void changeIsExchangedStatus()
  {
    isExchanged = !isExchanged;
    emit(ChangeIsExchangedState());
  }

  void changeExchangeIsOpenedStatus()
  {
    exchangeIsOpened = !exchangeIsOpened;
    emit(ChangeExchangeIsOpenedState());
  }

  Future<void> changeIsDoneStatus() async
  {
    isDone = !isDone;
    emit(ChangeIsDoneState());
    await Future.delayed(const Duration(seconds: 2));
    isDone = !isDone;
    emit(ChangeIsDoneState());
  }

}