import 'dart:async';
import 'dart:io';


import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/models/star_dust_model.dart';
import 'package:Portals/models/stickers&gifts_model.dart';
import 'package:Portals/screens/store/cuibt/states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class StoreCubit extends Cubit<StoreCubitStates>
{
  int userCurrentStarDusts;
  HomeTapsCubit homeTapsCubitAccess;
  StoreCubit({required this.userCurrentStarDusts,required this.homeTapsCubitAccess}) : super(StoreCubitInitialState());

  static StoreCubit get(context) => BlocProvider.of(context);

  bool exchangeIsOpened = false;
  bool isExchanged = false;
  bool isDone = false;
  StarDustModel ? selectedStarDust;


  // List<StarDustModel> stardustList = [
  //   StarDustModel(imageUrl: "assets/image/moon.png", amount: 100, price: 0.99),
  //   StarDustModel(imageUrl: "assets/image/moon.png", amount: 550, price: 4.99),
  //   StarDustModel(imageUrl: "assets/image/moon.png", amount: 1200, price: 9.99),
  // ];

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

  void changeExchangeIsOpenedStatus(StarDustModel ? sStarDust)
  {
    selectedStarDust = sStarDust;
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

  List<StarDustModel> starDusts = [];

  Future getStarDustDataFromDB() async {
    await FirebaseFirestore.instance.collection('Stardust').get().then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      starDusts = [];
      querySnapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> doc) {
        starDusts.add(StarDustModel.fromJson(doc.data()!));
      });
    }).catchError((error){
      print("STAR DUSTS ERROR .......................");
      print(error);
    });
  }

  var productDetails;
  bool pageIsLoading = false;

  void changePageIsLoadingStatus()
  {
    pageIsLoading = !pageIsLoading;
    emit(ChangePageIsLoadingState());
  }

  Future getStarDustData() async {
    // Get shop items data from db
    // We get items from db to get their IAP shop id,
    // then get the item data from the shop by Id
    changePageIsLoadingStatus();
    await getStarDustDataFromDB();
    for (var starDust in starDusts) {
      try {
        final response = await InAppPurchase.instance.queryProductDetails({starDust.id!});
        final ProductDetails productData = response.productDetails.first;
        productDetails.addAll({starDust.id: productData});
        // productDetails.add({starDust.id!: productData});
        var finalPrice = productData.rawPrice;
        var currencySymbol = productData.currencySymbol;
        // Show this data in the UI
      } catch (e, stackTrace) {
        // log error
      }
    }
    changePageIsLoadingStatus();
  }

  bool buyInProgress = false;

  Future<void> buyRequest(BuildContext context,String SelectedId,[bool closeLoading = true]) async {
    // check if there is no buy operation in progress first
    if (!buyInProgress) {
      // set buy operation in progress to true
      buyInProgress = true;
      // show a loading dialog

      try {
        final purchaseParams = PurchaseParam(
          productDetails: productDetails[SelectedId]!,
        );
        if (productDetails.length == 0) {
          await getStarDustData();
        }
        await InAppPurchase.instance.buyConsumable(
          purchaseParam: purchaseParams,
        );
        buyInProgress = false;
      } catch (e, stackTrace) {
        // This was happening every now and then while developing
        buyInProgress = false;
        if (e is PlatformException){
          if (e.code == 'storekit_duplicate_product_object' && Platform.isIOS) {
            try {
              var transactions = await SKPaymentQueueWrapper().transactions();
              for (var transaction in transactions) {
                await SKPaymentQueueWrapper().finishTransaction(transaction);
              }
              print("recursion starts");
              buyRequest(context,SelectedId,false);
            } on Exception catch (ee) {
              print('Error trying to finish transactions: $ee');
              // S.logError('Error trying to finish transactions $ee, Product: ${selectedPotionPack!.id}', stackTrace: stackTrace);
            }
          } else {
            print('buyConsumable error: $e');
            // S.logError('Apple Store Buy Consumable failed $e, Product: ${selectedPotionPack!.id}', stackTrace: stackTrace);
          }
        } else {
          print('buyConsumable error: $e');
          // S.logError('Apple Store Buy Consumable failed $e, Product: ${selectedPotionPack!.id}', stackTrace: stackTrace);
        }

        // dialogs.closeLoading();
        // Navigator.of(context).pop();
      }
    }
  }

  _cancelPurchase(PurchaseDetails purchaseDetails) async {
    await InAppPurchase.instance.completePurchase(purchaseDetails);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchases) {
    purchases.forEach((purchaseDetails) async {
      if (purchaseDetails.pendingCompletePurchase &&
          purchaseDetails.status != PurchaseStatus.error &&
          purchaseDetails.purchaseID != null) {
        try {
          if (purchaseDetails.productID.contains('Stardust') ||
              purchaseDetails.productID.contains('Stardust')) {
            await InAppPurchase.instance.completePurchase(purchaseDetails);
          }
          incrementUserStarDusts(extractDustNumbers(purchaseDetails.productID));
          // _returnHome();
        } catch (e) {
          _cancelPurchase(purchaseDetails);

          print('errorBuy: $e');
          // S.logError('Complete Purchase instance error $e, Purchase Id : ${purchaseDetails.purchaseID}');
        }
      } else if (purchaseDetails.status == PurchaseStatus.error ||
          purchaseDetails.status == PurchaseStatus.canceled) {
        _cancelPurchase(purchaseDetails);
      }
    });
  }

  Future<void> incrementUserStarDusts(int value) async
  {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('Users').doc(user!.uid).update({
      "stardust": FieldValue.increment(value)
    }).then((resValue) async{
      print("User Amount Updated Successfully.......................");
      userCurrentStarDusts = userCurrentStarDusts+value;
      homeTapsCubitAccess.incrementStarDustValue(value);
    }).catchError((error){
      print("User Amount Update GOT ERROR.......................");
      print(error);
    });
    emit(IncrementUserStarDusts());
  }

  int extractDustNumbers(String input) {
    // Remove all non-digit characters using regular expression
    String numbersOnly = input.replaceAll(RegExp(r'\D'), '');
    return int.parse(numbersOnly);
  }

  late StreamSubscription<List<PurchaseDetails>> _subscription;
  init() {
    getStarDustData();
    final Stream<List<PurchaseDetails>> purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        },
        onDone: () {
          _subscription.cancel();
        }, onError: (error) {
          // handle error here.
        });
  }


  @override
  Future<void> close() async {
    await _subscription.cancel();

    return super.close();
  }
}