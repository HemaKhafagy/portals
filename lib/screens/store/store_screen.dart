import 'package:Portals/screens/store/cuibt/cubit.dart';
import 'package:Portals/screens/store/cuibt/states.dart';
import 'package:Portals/screens/store/exchange.dart';
import 'package:Portals/screens/store/is_done.dart';
import 'package:Portals/screens/store/store_content.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StoreCubit()..init(),
      child: BlocConsumer<StoreCubit,StoreCubitStates>(
        listener: (context,state){},
        builder: (context,state){
          StoreCubit storeCubitAccess = StoreCubit.get(context);
          return Scaffold(
            body: Container(
              decoration: sharedContainerDecoration,
              child: SafeArea(
                child: storeCubitAccess.pageIsLoading ? Center(child: CircularProgressIndicator(),) :
                Stack(
                  children: [
                    const StoreContent(),
                    if(storeCubitAccess.exchangeIsOpened)
                       Exchange(
                        selectedAvatarURL: storeCubitAccess.selectedStarDust!.imageUrl!,
                        selectedAvatarName: storeCubitAccess.selectedStarDust!.name!,
                          amount: storeCubitAccess.selectedStarDust!.amount!,
                      ),
                    if(storeCubitAccess.isDone)
                      const IsDone()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }



}
