import 'dart:ui';

import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:Portals/screens/friends/add_friend_screen.dart';
import 'package:Portals/screens/friends/cubit/cubit.dart';
import 'package:Portals/screens/friends/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTapsCubit,HomeTapsCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        HomeTapsCubit homeTapsCubitAccess = HomeTapsCubit.get(context);
        return Scaffold(
          body: Container(
            decoration: sharedContainerDecoration,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 80,left: 10,right: 10,bottom: 10),
                  child: Column(
                    children: [
                      buildTopNav(context),
                      const SizedBox(height: 20,),
                      buildPortal(homeTapsCubitAccess),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 37,
                        child: buildStatus(homeTapsCubitAccess),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xff2d1859),
                          gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.center,
                              colors: [
                                Color.fromRGBO(105, 65, 171, 1),
                                Color.fromRGBO(67, 30, 91, 1),
                                Color.fromRGBO(44, 24, 83, 1),
                              ]
                          ),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(15),
                        itemCount: homeTapsCubitAccess.listViewFriendsCard.length,
                        separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.grey,),
                        itemBuilder: (BuildContext context, int index) {
                          return buildCardItem(context,index,homeTapsCubitAccess);
                        },
                      )
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



Widget buildCardItem(BuildContext context,int index,HomeTapsCubit homeTapsCubitAccess) => Row(
    children: [
      CircleAvatar(
        radius: 29,
        backgroundColor: homeTapsCubitAccess.listViewFriendsCard[index].status! == "Online" ? const Color.fromRGBO(29, 182, 109, 1) : homeTapsCubitAccess.listViewFriendsCard[index].status! == "Away" ? const Color.fromRGBO(228, 156, 48, 1) :  const Color.fromRGBO(136, 132, 145, 1),
        child: SizedBox(
          width: 55,
          height: 55,
          child: ClipOval(
            child:  buildSharedImageFromNetwork(homeTapsCubitAccess.listViewFriendsCard[index].friendImageUrl!),
          ),
        ),
      ),
      const SizedBox(width: 10,),
      Expanded(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(homeTapsCubitAccess.listViewFriendsCard[index].name!,style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                  width: 64,
                  height: 18,
                  decoration: BoxDecoration(
                    color: homeTapsCubitAccess.listViewFriendsCard[index].status! == "Online" ? const Color.fromRGBO(29, 182, 109, 1) : homeTapsCubitAccess.listViewFriendsCard[index].status! == "Away" ? const Color.fromRGBO(228, 156, 48, 1) :  const Color.fromRGBO(136, 132, 145, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(homeTapsCubitAccess.listViewFriendsCard[index].status!,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 10),),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(FontAwesomeIcons.solidMessage,size: 20,),
                const SizedBox(width: 3,),
                Flexible(child: Text(homeTapsCubitAccess.listViewFriendsCard[index].lastMessage!,style: const TextStyle(color: Colors.white,fontSize: 12),overflow: TextOverflow.ellipsis,maxLines: 2,))
              ],
            )
          ],
        ),
      ),
    ],
  );

  Widget buildTopNav(BuildContext context) =>  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 93,
        height: 35,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(31, 22, 50, 1),
            borderRadius: BorderRadius.circular(50)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: ClipOval(
                child:  Image.asset("assets/image/moon.png"),
              ),
            ),
            const SizedBox(width: 10,),
            const Text("5000",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      Row(
        children: [
          GestureDetector(
            onTap: (){
              navigateTo(context: context, widget: const AddFriendScreen());
            },
            child: Container(
              width: 130,
              height: 35,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(242, 73, 152, 1),
                      Color.fromRGBO(242, 132, 92, 1),
                    ]
                  ),
                  borderRadius: BorderRadius.circular(50),
                border: Border.all(color: const Color.fromRGBO(100, 82, 217, 1))
              ),
              child: const Center(child: Text("+  Add Friends",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900),)),
            ),
          ),
          const SizedBox(width: 10,),
          Container(
            width: 63,
            height: 35,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(31, 22, 50, 1),
                borderRadius: BorderRadius.circular(50)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("3",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                const SizedBox(width: 10,),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset("assets/image/bell.png"),
                ),
              ],
            ),
          ),
        ],
      )
    ],
  );

  Widget buildPortal(HomeTapsCubit homeTapsCubitAccess) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text("FRIENDS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
      const SizedBox(width: 30,),
      Expanded(
        child: SizedBox(
          height: 35,
          child: TextField(
            decoration: sharedTextFiledDecoration(hint: "Find Friends"),
            onChanged: (text) => homeTapsCubitAccess.searchForFriends(text),
          ),
        ),
      ),
    ],
  );

  Widget buildStatus(HomeTapsCubit homeTapsCubitAccess) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          SizedBox(
            width: 34.13,
            height: 36,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: homeTapsCubitAccess.myOnlineStatus ? const Color.fromRGBO(29, 182, 109, 1) : const Color.fromRGBO(136, 132, 145, 1),width: 3),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: const SizedBox(),
                ),
                Positioned(
                  top: 0,
                  right: 1,
                  left: 1,
                  child: Image.asset("assets/image/profile.png",width: 20.63,height: 30,),
                )
              ],
            ),
          ),
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Online",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13),),
              GestureDetector(
                onTap: () => homeTapsCubitAccess.changeMyOnlineStatus(),
                child: SizedBox(
                  width: 34,
                  height: 15,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 34,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(3),// border color
                          ),
                        ),
                      ),
                      Positioned(
                        right: homeTapsCubitAccess.myOnlineStatus == true ? 0 : null,
                        left: homeTapsCubitAccess.myOnlineStatus == false ? 0 : null,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: homeTapsCubitAccess.myOnlineStatus == true ? const Color.fromRGBO(32, 183, 111, 1) : const Color.fromRGBO(136, 132, 145, 1), // border color
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
      const SizedBox(width: 30,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("By Status",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
          const SizedBox(width: 5,),
          IconButton(onPressed: (){}, icon: const Icon(FontAwesomeIcons.arrowDownWideShort,size: 25,),
          ),
        ],
      ),
    ],
  );

}
