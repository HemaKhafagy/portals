import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  void initState() {
    super.initState();
    HomeTapsCubit.get(context).getUserNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeTapsCubit, HomeTapsCubitStates>(
        listener: (context,state){},
        builder: (context,state){
          HomeTapsCubit homeTapsCubitAccess = HomeTapsCubit.get(context);
          return Container(
            decoration: sharedContainerDecoration,
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("NOTIFICATIONS",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color.fromRGBO(242, 132, 92, 1),width: 2),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: buildNotificationComponent(3),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Latest",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
                          SizedBox(width: 10,),
                          Icon(FontAwesomeIcons.arrowUpWideShort)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(16, 12, 19, 0.5),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                      ),
                      child: homeTapsCubitAccess.getNotificationIsLoading ? Center(child: CircularProgressIndicator(),) :
                      homeTapsCubitAccess.notifications.length == 0 ? Center(child: Text(""),) :
                      ListView.separated(
                        itemCount: homeTapsCubitAccess.notifications.length,
                        separatorBuilder: (BuildContext context, int index) => const Divider(color: Color.fromRGBO(255, 255, 255, 0.1),),
                        itemBuilder: (context,index){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 31,
                                backgroundColor: const Color.fromRGBO(242, 132, 92, 1),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: ClipOval(
                                    child:  buildSharedImageFromNetwork(
                                        homeTapsCubitAccess.notifications[index].type == "portal_invite" ? homeTapsCubitAccess.notifications[index].portalInvite!.imageUrl! :
                                        homeTapsCubitAccess.notifications[index].notificationSender!.imageUrl!
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  children: [
                                     Row(
                                      children: [
                                        Icon(homeTapsCubitAccess.notifications[index].type == "portal_invite" ? LineIcons.gamepad : LineIcons.userFriends),
                                        SizedBox(width: 15,),
                                        Text("${homeTapsCubitAccess.notifications[index].type}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${
                                                  homeTapsCubitAccess.notifications[index].type == "portal_invite" ? homeTapsCubitAccess.notifications[index].portalInvite!.portalTitle! :
                                                  homeTapsCubitAccess.notifications[index].notificationSender!.name!}",
                                                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                                              Text("Just Now",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                                            ],
                                          ),
                                        ),
                                        if(
                                        homeTapsCubitAccess.notifications[index].type == "game_invite" || homeTapsCubitAccess.notifications[index].type == "friend_request" ||
                                        homeTapsCubitAccess.notifications[index].type == "portal_invite" || homeTapsCubitAccess.notifications[index].type == "portal_access_request"
                                        )
                                        (homeTapsCubitAccess.notificationActionIsLoading && (homeTapsCubitAccess.loadingIndex == index)) ? buildIOSLoader() :
                                        homeTapsCubitAccess.notifications[index].statusMap!.status != "none" ?Text("${homeTapsCubitAccess.notifications[index].statusMap!.status}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),) :
                                        Row(
                                          children: [
                                            buildSharedButton(buttonName: "Accept", isEnabled: true, width: 70,height: 25,textSize: 12,action: (){
                                              if(homeTapsCubitAccess.notifications[index].type == "portal_invite"){
                                                homeTapsCubitAccess.acceptNotification(
                                                    index:  index,
                                                    notificationId: homeTapsCubitAccess.notifications[index].documentInfo!.documentId!,
                                                    portalId:  homeTapsCubitAccess.notifications[index].portalInvite!.portalRef!,
                                                    status: "accepted"
                                                );
                                              }else if(homeTapsCubitAccess.notifications[index].type == "friend_request"){
                                                homeTapsCubitAccess.friendRequestNotificationAction(index: index,senderId: homeTapsCubitAccess.notifications[index].notificationSender!.id!, notificationId: homeTapsCubitAccess.notifications[index].documentInfo!.createdBy!, status: "accepted");
                                              }

                                            }),
                                            const SizedBox(width: 5,),
                                            buildSharedButton(buttonName: "Deny", isEnabled: false, width: 70,height: 25,textSize: 12,action: (){
                                              if(homeTapsCubitAccess.notifications[index].type == "portal_invite"){
                                                homeTapsCubitAccess.changeNotificationStatus(
                                                    index: index,
                                                    notificationId: homeTapsCubitAccess.notifications[index].documentInfo!.documentId!,
                                                    status: "rejected"
                                                );
                                              }else if(homeTapsCubitAccess.notifications[index].type == "friend_request"){
                                                homeTapsCubitAccess.friendRequestNotificationAction(index: index, senderId: homeTapsCubitAccess.notifications[index].notificationSender!.id!, notificationId: homeTapsCubitAccess.notifications[index].documentInfo!.createdBy!, status: "rejected");
                                              }
                                            })
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
