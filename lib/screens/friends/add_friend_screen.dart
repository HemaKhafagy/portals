import 'package:Portals/screens/friends/cubit/cubit.dart';
import 'package:Portals/screens/friends/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';


class AddFriendScreen extends StatelessWidget {
  const AddFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => FriendsCubit(),
      child: BlocConsumer<FriendsCubit,FriendsCubitStates>(
        listener: (context,state){},
        builder: (context,state){
          FriendsCubit friendsCubitAccessInstance = FriendsCubit.get(context);
          return Scaffold(
            body: Container(
              decoration: sharedContainerDecoration,
              width: screenWidth,
              height: screenHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60,horizontal: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 11,
                  child: Container(
                    padding: const EdgeInsets.only(top: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(242, 132, 92, 0.5),
                            Color.fromRGBO(100, 82, 217, 0.5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.topRight
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(39, 20, 55, 1),
                            Color.fromRGBO(45, 24, 89, 1),
                          ],
                          begin: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){},
                                child: const Row(
                                  children: [
                                    Icon(Icons.arrow_back_ios_new),
                                    SizedBox(width: 10,),
                                    Text("Back",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),)
                                  ],
                                ),
                              ),
                              const Text("Add Friends",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                              InkWell(
                                onTap: (){},
                                child: const Icon(Icons.close),
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              decoration: sharedTextFiledDecoration(hint: "Find Portal Users"),
                              onChanged: (text) => friendsCubitAccessInstance.searchForPortalUsers(text),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          friendsCubitAccessInstance.newFriendsListIsOpened == false ?
                          Expanded(
                            child: SingleChildScrollView(
                              child: SizedBox(
                                height: screenHeight*0.63,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Column(
                                      children: [
                                        Text("Explore Portals With Friends",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                                        SizedBox(height: 20,),
                                        Text("You may send other users a Friend Request so they can become your friends. They need to approve your request in order to be friends with you.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                                      ],
                                    ),
                                    const Divider(color: Color.fromRGBO(255, 255, 255, 0.1),),
                                    Column(
                                      children: [
                                        const Text("Connect",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                                        const SizedBox(height: 7,),
                                        const Text("Invite your friends to join Portals and earn 100 Stardust for every friend who joins the platform",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,),textAlign: TextAlign.center,),
                                        const SizedBox(height: 30,),
                                        buildSharedButton(buttonName: "Invite New Friends", isEnabled: true, action: (){Share.share('https://google.com');})
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ) :
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.all(1),
                              itemCount: friendsCubitAccessInstance.listOfNewFriendsCard.length,
                              separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.grey,),
                              itemBuilder: (BuildContext context, int index) {
                                return buildCardItem(context,index,friendsCubitAccessInstance);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCardItem(BuildContext context,int index,FriendsCubit friendsCubitAccessInstance) => Row(
    children: [
      CircleAvatar(
        radius: 29,
        backgroundColor:const Color.fromRGBO(228, 156, 48, 1),
        child: SizedBox(
          width: 55,
          height: 55,
          child: ClipOval(
            child:  buildSharedImageFromNetwork(friendsCubitAccessInstance.listOfNewFriendsCard[index].friendImageUrl!),
          ),
        ),
      ),
      const SizedBox(width: 10,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(friendsCubitAccessInstance.listOfNewFriendsCard[index].name!,style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800))),
                buildSharedButton(buttonName: "Add Friend", isEnabled: true, width: 100,height: 30,textSize: 14,action: (){})
              ],
            ),
          Text(friendsCubitAccessInstance.listOfNewFriendsCard[index].gender!,style: const TextStyle(color: Colors.white,fontSize: 12),overflow: TextOverflow.ellipsis,maxLines: 2,)
          ],
        ),
      ),
    ],
  );
}
