import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:Portals/models/portals.dart';
import 'package:Portals/screens/chat/chat_screen.dart';
import 'package:Portals/screens/chat/cubit/cubit.dart';
import 'package:Portals/screens/notification_screen.dart';
import 'package:Portals/screens/store/store_screen.dart';
import 'package:Portals/shared/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PortalsHomeScreen extends StatelessWidget {
  const PortalsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeTapsCubit,HomeTapsCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        HomeTapsCubit homeTapsCubitAccess = HomeTapsCubit.get(context);
        return  Container(
          decoration: sharedContainerDecoration,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 80,left: 10,right: 10,bottom: 10),
                child: Column(
                  children: [
                    buildTopNav(context,homeTapsCubitAccess.userData!.stardust!,homeTapsCubitAccess),
                    const SizedBox(height: 20,),
                    buildPortal(homeTapsCubitAccess),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(5),
                        children: [
                          buildListViewButton("Tap",0,homeTapsCubitAccess),
                          buildListViewButton("Latest",1,homeTapsCubitAccess),
                          buildListViewButton("Music",2,homeTapsCubitAccess),
                          buildListViewButton("Movies",3,homeTapsCubitAccess),
                          buildListViewButton("Sports",4,homeTapsCubitAccess),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xff2d1859),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                    ),
                    child: homeTapsCubitAccess.portalsList.isEmpty ? const Center(child: CircularProgressIndicator()) :
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(homeTapsCubitAccess.ownedPortals.isNotEmpty)
                            const Text("My Portals",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),),
                            if(homeTapsCubitAccess.ownedPortals.isNotEmpty)
                            const SizedBox(height: 10,),
                            if(homeTapsCubitAccess.ownedPortals.isNotEmpty)
                            Column(
                              children: homeTapsCubitAccess.ownedPortals.map((e) {
                                return Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          navigateTo(context: context,widget: ChatScreen(
                                            chatId: e.documentInfo!.documentId!,
                                            title: e.title!,
                                            guests: e.guests!,
                                            selectedPortal: e,
                                          ));
                                        },
                                        child: buildCardItem(context,e)
                                    ),
                                    const Divider(color: Color.fromRGBO(255, 255, 255, 0.1),)
                                  ],
                                );
                              }).toList(),
                            ),
                            if(homeTapsCubitAccess.explorePortals.isNotEmpty)
                            const Text("Explore Portals",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),),
                            if(homeTapsCubitAccess.explorePortals.isNotEmpty)
                            const SizedBox(height: 10,),
                            if(homeTapsCubitAccess.explorePortals.isNotEmpty)
                            Column(
                              children: homeTapsCubitAccess.explorePortals.map((e) {
                                return Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          showRequestDialog(context, e, homeTapsCubitAccess,screenHeight);
                                        },
                                        child: buildCardItem(context,e)
                                    ),
                                    const Divider(color: Color.fromRGBO(255, 255, 255, 0.1),)
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget buildListViewButton(String text,int index,HomeTapsCubit homeTapsCubitAccess)=> InkWell(
    onTap: () {
      homeTapsCubitAccess.changePortalCatSelectedButton(index);
      homeTapsCubitAccess.searchForPortals(text);
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 1),
          decoration: BoxDecoration(
              gradient: index == homeTapsCubitAccess.portalCatSelectedButton ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.9, 1),
                colors: <Color>[
                  Color(0xfff24998),
                  Color(0xfff2845c)
                ],
              ) : const LinearGradient(
                colors: <Color>[
                  Color(0xff1f1632),
                  Color(0xff1f1632),
                ],
              ) ,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color.fromRGBO(94, 76, 131, 1),width: 0.5)
          ),
        child: Center(
          child: Text(text,style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
        ),
        ),
    ),
  );

  buildStatusContainer(Portals portal) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
    width: 98,
    height: 16,
    decoration: BoxDecoration(
      color: portal.userCurrentPortalStatus! == "Hosted" ? Color.fromRGBO(228, 156, 48, 1) :
      portal.userCurrentPortalStatus! == "Pending Request" ? Color.fromRGBO(242, 73, 152, 1) :
      portal.userCurrentPortalStatus! == "Invited" ? Color.fromRGBO(29, 182, 109, 1) :
      portal.userCurrentPortalStatus! == "Guested" ? Color.fromRGBO(228, 156, 48, 1) :
      portal.guests!.guestCount! == portal.guests!.limit! ? Color.fromRGBO(242, 73, 73, 1) : Color.fromRGBO(100, 82, 217, 1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Text(
        portal.userCurrentPortalStatus != "none" ? portal.userCurrentPortalStatus! :
        portal.guests!.guestCount! == portal.guests!.limit! ? "Portal Full" :
        "Waiting For Guests",
        style: const TextStyle(color: Colors.white,fontSize: 8),
      ),
    ),
  );

  buildLimitShape(Portals portal) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.supervised_user_circle_outlined,size: 17,color: Colors.white,),
        const SizedBox(width: 4,),
        Text("${portal.guests!.guestCount!}""/${portal.guests!.limit!}",style: const TextStyle(color: Colors.white,fontSize: 10),)
      ],
    ),
  );

  Widget buildCardItem(BuildContext context,Portals portal) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 29,
            backgroundColor: const Color(0xfff2845c),
            child: SizedBox(
              width: 55,
              height: 55,
              child: ClipOval(
                child:  buildSharedImageFromNetwork(portal.imageUrl!),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.37,
                child: Text(portal.title!,style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800),maxLines: 1,overflow: TextOverflow.ellipsis,),
              ),
              Text(portal.topic!,style: const TextStyle(color: Colors.white,fontSize: 12)),
            ],
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildStatusContainer(portal),
          buildLimitShape(portal),
        ],
      )
    ],
  );

  Widget buildTopNav(BuildContext context,int stardust,HomeTapsCubit homeTapsCubitAccess) =>  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () => navigateTo(context: context,widget: StoreScreen(userStarDust: stardust,homeTapsCubitAccess: homeTapsCubitAccess,)),
        child: buildPointsComponents(stardust),
      ),
      InkWell(
        onTap: () => navigateTo(context: context,widget: const NotificationScreen()),
        child: buildNotificationComponent(0),
      ),
    ],
  );

  Widget buildPortal(HomeTapsCubit homeTapsCubitAccess) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text("PORTALS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,fontFamily: appUsedFont),),
      const SizedBox(width: 30,),
      Expanded(
        child: SizedBox(
          height: 35,
          child: TextField(
            decoration: sharedTextFiledDecoration(hint: "Find a portal"),
            onChanged: (text) => homeTapsCubitAccess.searchForPortals(text),
          ),
        ),
      ),
    ],
  );

  Future<void> showRequestDialog(BuildContext context,Portals portal,HomeTapsCubit homeTapsCubitAccess,double screenHeight) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(10),
          content: Container(
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
              padding: const EdgeInsets.all(15),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){Navigator.of(context).pop();},
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Text("Request permission to enter portal?",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                  const SizedBox(height: 10,),
                  CircleAvatar(
                    radius: 102,
                    backgroundColor: const Color(0xfff2845c),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: ClipOval(
                        child:  buildSharedImageFromNetwork(portal.imageUrl!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(portal.title!,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                  Text(portal.topic!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  const SizedBox(height: 5,),
                  buildLimitShape(portal),
                  const SizedBox(height: 5,),
                  buildStatusContainer(portal),
                  const SizedBox(height: 30,),
                  buildSharedButton(buttonName: "Request to join", isEnabled: true, action: (){}),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
