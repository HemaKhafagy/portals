import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:Portals/models/portals.dart';
import 'package:Portals/screens/notification_screen.dart';
import 'package:Portals/screens/store/store_screen.dart';
import 'package:Portals/shared/components.dart';
import 'package:flutter/material.dart';
import '../../shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PortalsHomeScreen extends StatelessWidget {
  const PortalsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    buildTopNav(context),
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
                    ListView.separated(
                      padding: const EdgeInsets.all(15),
                      itemCount: homeTapsCubitAccess.portalsList.length,
                      separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.grey,),
                      itemBuilder: (BuildContext context, int index) {
                        return buildCardItem(homeTapsCubitAccess.portalsList[index]);
                      },
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

  Widget buildCardItem(Portals portal) => Row(
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
              Text(portal.title!,style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800)),
              Text(portal.topic!,style: const TextStyle(color: Colors.white,fontSize: 12)),
            ],
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
            width: 98,
            height: 16,
            decoration: BoxDecoration(
              color: portal.guests!.guestCount! == portal.guests!.limit! ? Colors.deepOrange.shade400 : Colors.deepPurple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(portal.guests!.guestCount! == portal.guests!.limit! ? "Portal Full" : "Waiting For Guests",style: const TextStyle(color: Colors.white,fontSize: 8),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
            child: Row(
              children: [
                const Icon(Icons.supervised_user_circle_outlined,size: 17,color: Colors.white,),
                const SizedBox(width: 4,),
                Text("${portal.guests!.guestCount!}""/${portal.guests!.limit!}",style: const TextStyle(color: Colors.white,fontSize: 10),)
              ],
            ),
          )
        ],
      )
    ],
  );

  Widget buildTopNav(BuildContext context) =>  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () => navigateTo(context: context,widget: const StoreScreen()),
        child: buildPointsComponents(5000),
      ),
      InkWell(
        onTap: () => navigateTo(context: context,widget: const NotificationScreen()),
        child: buildNotificationComponent(3),
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
}
