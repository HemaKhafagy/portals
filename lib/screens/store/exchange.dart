import 'dart:ui';

import 'package:Portals/screens/store/cuibt/cubit.dart';
import 'package:Portals/screens/store/cuibt/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class Exchange extends StatelessWidget {
  final String selectedAvatarURL;
  final String selectedAvatarName;
  final int amount;

  const Exchange({super.key,required this.selectedAvatarURL,required this.selectedAvatarName,required this.amount});

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    return BlocConsumer<StoreCubit,StoreCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        StoreCubit storeCubitAccess = StoreCubit.get(context);
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.0,
            sigmaY: 3.0,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color:  Color.fromRGBO(16, 12, 19, 0.5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromRGBO(242, 132, 92, 1),width: 2),
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: buildPointsComponents(5000),
                      ),
                      InkWell(
                        onTap: () => storeCubitAccess.changeExchangeIsOpenedStatus(null),
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(FontAwesomeIcons.xmark,size: 30,),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 210,
                          height: 210,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.15),
                            border: Border.all(color: const Color.fromRGBO(242, 73, 152, 1)),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 188,
                              height: 188,
                              child: ClipOval(
                                child:  buildSharedImageFromNetwork(selectedAvatarURL),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(45, 24, 89, 1),
                              borderRadius: BorderRadius.circular(10),
                              border: const Border(top: BorderSide(color: Color.fromRGBO(242, 132, 92, 0.5),))
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 30,),
                              Text(selectedAvatarName,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
                              const SizedBox(height: 5,),
                              const Text("Avatar",style:  TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Color.fromRGBO(242, 132, 92, 1)),),
                              const SizedBox(height: 10,),
                              const Text("Premium Avatar, to show the dance floor who’s the APEX predator",style:  TextStyle(fontSize: 14,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                              const SizedBox(height: 30,),
                              Container(
                                width: screenWidth*0.8,
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(31, 22, 50, 1),
                                    border: Border.all(color: const Color.fromRGBO(94, 76, 131, 1)),
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Row(
                                  mainAxisAlignment: storeCubitAccess.isExchanged ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildSharedButton(buttonName: "EXCHANGE", isEnabled: true, width: screenWidth*0.4,height: 40,action: () async{
                                      storeCubitAccess.changeIsExchangedStatus();
                                      await Future.delayed(Duration(seconds: 1));
                                      storeCubitAccess.changeExchangeIsOpenedStatus(storeCubitAccess.selectedStarDust);
                                      storeCubitAccess.buyRequest(context, storeCubitAccess.selectedStarDust!.id!);
                                      storeCubitAccess.changeIsExchangedStatus();
                                    }),
                                    if(!storeCubitAccess.isExchanged)
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/image/moon.png",width: 40,height: 36,),
                                          const SizedBox(width: 5,),
                                          Text("$amount",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
