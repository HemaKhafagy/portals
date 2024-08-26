import 'package:Portals/models/portals.dart';
import 'package:Portals/screens/chat/cubit/cubit.dart';
import 'package:Portals/screens/chat/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

class ChatAdminWidgets {

  static double screenWidth (context) => MediaQuery.of(context).size.width;
  static double screenHeight (context) => MediaQuery.of(context).size.height;

  static Widget dialogLeading(icon,double size) =>  Icon(icon,size: size,color: Colors.white,);
  static Widget dialogTitle(text,double size) =>  Text(text,style: TextStyle(fontSize: size,fontWeight:FontWeight.w600 ,color: Colors.white,fontFamily: appUsedFont),);

  static showCustomDialog({
    required BuildContext context,
    required ChatCubit chatCubitAccess,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) => BlocProvider<ChatCubit>.value(
        value: context.read<ChatCubit>(),
        child:  BlocConsumer<ChatCubit,ChatCubitStates>(
          listener: (context,state) {},
          builder: (context,state) => Dialog(
            insetPadding: EdgeInsets.all(0),
            child: Container(
              width: screenWidth(context)*0.94,
              constraints: BoxConstraints(
                  maxHeight: screenHeight(context)*0.9
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: RadialGradient(
                  center: Alignment(0, 0),
                  radius: 1.8,
                  colors: <Color>[
                    Color.fromRGBO(13, 0, 70, 1),
                    Color.fromRGBO(29, 8, 126, 1),
                  ],
                ),
              ), // Height of your drawable
              child: chatCubitAccess.chatWidgetsIndex == 0 ? adminMenu(context: context,chatCubitAccess: chatCubitAccess) :
              chatCubitAccess.chatWidgetsIndex == 1 ? portalsSettings(context: context,chatCubitAccess: chatCubitAccess) :
              chatCubitAccess.chatWidgetsIndex == 2 ? portalsInviteFriends(context: context,chatCubitAccess: chatCubitAccess) :
              chatCubitAccess.chatWidgetsIndex == 5 ? portalBan(context: context,chatCubitAccess: chatCubitAccess) :
              SizedBox(),
            ),
          ),
        ),
      ),
    );
  }

  static Widget adminMenu({
    required BuildContext context,
    required ChatCubit chatCubitAccess,
  }) {
    final double iconSize = screenHeight(context)*0.038;
    final double titleSize = screenHeight(context)*0.022;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Portal Menu",style: TextStyle(fontSize: screenHeight(context)*0.035,fontWeight: FontWeight.w700),),
            IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.close,size: screenHeight(context)*0.038))
          ],
        ),
        const SizedBox(height: 20,),
        Flexible(
          fit: FlexFit.loose,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  onTap: () => chatCubitAccess.changeChatWidgetsIndex(1),
                  leading: dialogLeading(LineIcons.assistiveListeningSystems,iconSize),
                  title: dialogTitle("Portal Settings", titleSize),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: () {
                    chatCubitAccess.changeChatWidgetsIndex(2);
                    chatCubitAccess.getFriendsForInvite();
                  },
                  leading: dialogLeading(LineIcons.userPlus,iconSize),
                  title: dialogTitle("Invite Friends", titleSize),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: () => chatCubitAccess.changeChatWidgetsIndex(3),
                  leading: dialogLeading(LineIcons.gamepad,iconSize),
                  title: dialogTitle("Start Game Session", titleSize),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: () {
                    chatCubitAccess.changeChatWidgetsIndex(4);
                  },
                  leading: dialogLeading(LineIcons.users,iconSize),
                  title: dialogTitle("List of Guests", titleSize),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: () {
                    chatCubitAccess.getPortalGuests();
                    chatCubitAccess.changeChatWidgetsIndex(5);
                  },
                  leading: dialogLeading(LineIcons.removeUser,iconSize),
                  title: dialogTitle("Ban Users", titleSize),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: () => chatCubitAccess.changeChatWidgetsIndex(6),
                  leading: dialogLeading(LineIcons.question,iconSize),
                  title: dialogTitle("F.A.Q", titleSize),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: () => chatCubitAccess.changeChatWidgetsIndex(6),
                  leading: dialogLeading(LineIcons.fileContract,iconSize),
                  title: dialogTitle("Privacy Policy & Settings", titleSize),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        )
      ],
    );
  }

  static Widget portalsSettings({required BuildContext context,required ChatCubit chatCubitAccess}) => Container(
    child: Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Portal Menu",style: TextStyle(fontSize: screenHeight(context)*0.035,fontWeight: FontWeight.w700),),
            IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.close,size: screenHeight(context)*0.038))
          ],
        ),
        const SizedBox(height: 20,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Private Portal",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,),),
                    GestureDetector(
                      onTap: () {
                        chatCubitAccess.changeSBSValue(chatCubitAccess.switchButtonSelectedValue == "No" ? "Yes" : "No");
                      },
                      child: Container(
                        width: 85,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color.fromRGBO(31, 22, 50, 1)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: chatCubitAccess.switchButtonSelectedValue == "No" ? const Color.fromRGBO(136, 132, 145, 1) : null
                                ),
                                child: const Center(child: Text("No",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,))),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: chatCubitAccess.switchButtonSelectedValue == "Yes" ? Colors.green : null
                                ),
                                child: const Center(child: Text("Yes",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                const Divider(color: Color.fromRGBO(255, 255, 255, 0.1),),
                const SizedBox(height: 10,),
                const Text("Private Limits",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Users",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 4,),
                        Row(
                          children: [
                            const Icon(FontAwesomeIcons.user,size: 14,color: Colors.white,),
                            const SizedBox(width: 4,),
                            Text("${chatCubitAccess.selectedPortal.guests!.guestCount}""/${chatCubitAccess.selectedPortal.guests!.limit!}",style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),)
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                      // width: 93,
                      // height: 35,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(31, 22, 50, 1),
                          border: Border.all(color: Color.fromRGBO(100, 82, 217, 1)),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/image/moon.png",
                            width: 31,
                            height: 28,
                          ),
                          const SizedBox(width: 6,),
                          Text(
                            "Increase Limit",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Time Left",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.alarm,size: 15,color: Colors.white,),
                            const SizedBox(width: 5,),
                            Text("${3}:""${26}",style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                      // width: 93,
                      // height: 35,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(31, 22, 50, 1),
                          border: Border.all(color: Color.fromRGBO(100, 82, 217, 1)),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/image/moon.png",
                            width: 31,
                            height: 28,
                          ),
                          const SizedBox(width: 6,),
                          Text(
                            "Increase Limit",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30,),
                Center(child: const Text("Age Range",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14,),)),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildListViewButton(min: 18,max: 24,access: chatCubitAccess),
                    buildListViewButton(min: 25,max: 34,access: chatCubitAccess),
                    buildListViewButton(min: 35,max: 44,access: chatCubitAccess),
                  ],
                ),
                const SizedBox(height: 20,),
                const Divider(color: Color.fromRGBO(255, 255, 255, 0.1),),
                const SizedBox(height: 20,),
                const Spacer(),
                Center(child: buildSharedButton(buttonName: "Save Changes", isEnabled: true, action: (){})),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        )
      ],
    ),
  );


  static Widget buildListViewButton({required int min, required int max, required ChatCubit access})=> InkWell(
    onTap: () => access.changeANPASdRange(value: SubAgeRange(min: min,max: max)),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
            gradient: access.ageSelectedValues.any((element) => element.min == min) ? const LinearGradient(
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
            border: Border.all(color: Colors.grey,width: 0.5)
        ),
        child: Center(
          child: Text("$min-$max",style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
        ),
      ),
    ),
  );


  static Widget portalsInviteFriends({required BuildContext context,required ChatCubit chatCubitAccess}) => Container(
    child: chatCubitAccess.getFriendsList || chatCubitAccess.sendFriendsInvitesIsLoading ? Center(child: buildIOSLoader(),) :
    Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Portal Menu",style: TextStyle(fontSize: screenHeight(context)*0.035,fontWeight: FontWeight.w700),),
            IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.close,size: screenHeight(context)*0.038))
          ],
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 35,
          child: TextField(
            decoration: sharedTextFiledDecoration(hint: "Find Portal Users"),
            onChanged: (text) => chatCubitAccess.searchForFriends(text),
          ),
        ),
        const SizedBox(height: 20,),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context,index) => Divider(),
              itemCount: chatCubitAccess.friendsList.length,
              itemBuilder: (context,index){
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 29,
                      backgroundColor:const Color.fromRGBO(228, 156, 48, 1),
                      child: SizedBox(
                        width: 55,
                        height: 55,
                        child: ClipOval(
                          child:  buildSharedImageFromNetwork(chatCubitAccess.friendsList[index].friend!.imageUrl!),
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
                              Flexible(child: Text(chatCubitAccess.friendsList[index].friend!.name!,style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800))),
                              Checkbox(
                                  value: chatCubitAccess.selectedFriendsForInvitesList.contains(chatCubitAccess.friendsList[index]) ? true : false,
                                  activeColor: Colors.green,
                                  onChanged:(bool ? value){
                                    chatCubitAccess.selectFriendsForInvites(chatCubitAccess.friendsList[index]);
                                  }),
                            ],
                          ),
                          Text(chatCubitAccess.friendsList[index].friend!.gender!,style: const TextStyle(color: Colors.white,fontSize: 12),overflow: TextOverflow.ellipsis,maxLines: 2,)
                        ],
                      ),
                    ),
                  ],
                );
              },
          ),
        ),
        const SizedBox(width: 15,),
        buildSharedButton(buttonName: "Send Invitations", isEnabled: chatCubitAccess.friendsList.isNotEmpty ? true : false, action: (){
          if(chatCubitAccess.friendsList.isNotEmpty){
            chatCubitAccess.sendFriendsInvites();
          }
        }),
        const SizedBox(width: 15,),
      ],
    ),
  );


  static Widget portalBan({required BuildContext context,required ChatCubit chatCubitAccess}) => Container(
    child: chatCubitAccess.getPortalGuestsIsLoading ? Center(child: buildIOSLoader(),) :
    Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Ban Users",style: TextStyle(fontSize: screenHeight(context)*0.035,fontWeight: FontWeight.w700),),
            IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.close,size: screenHeight(context)*0.038))
          ],
        ),
        const SizedBox(height: 20,),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context,index) => Divider(),
            itemCount: chatCubitAccess.selectedPortal.guestsList.length,
            itemBuilder: (context,index){
              return Row(
                children: [
                  CircleAvatar(
                    radius: 29,
                    backgroundColor:const Color.fromRGBO(228, 156, 48, 1),
                    child: SizedBox(
                      width: 55,
                      height: 55,
                      child: ClipOval(
                        child:  buildSharedImageFromNetwork(chatCubitAccess.selectedPortal.guestsList[index].userInfo!.imageUrl!),
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
                            Flexible(child: Text(chatCubitAccess.selectedPortal.guestsList[index].userInfo!.name!,style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800))),
                            chatCubitAccess.selectedPortal.documentInfo!.createdBy == chatCubitAccess.selectedPortal.guestsList[index].documentInfo!.createdBy ? const SizedBox() :
                            Checkbox(
                                value: chatCubitAccess.selectedBanUsers.contains(chatCubitAccess.selectedPortal.guestsList[index].documentInfo!.createdBy) ? true : false,
                                activeColor: Colors.green,
                                onChanged:(bool ? value){
                                  chatCubitAccess.mapBanUserList(chatCubitAccess.selectedPortal.guestsList[index].documentInfo!.createdBy!);
                                }),
                          ],
                        ),
                        Text(chatCubitAccess.selectedPortal.guestsList[index].userInfo!.gender!,style: const TextStyle(color: Colors.white,fontSize: 12),overflow: TextOverflow.ellipsis,maxLines: 2,)
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(width: 15,),
        buildSharedButton(buttonName: "Ban Selected Users", isEnabled: chatCubitAccess.selectedBanUsers.isNotEmpty ? true : false, action: (){
          if(chatCubitAccess.selectedBanUsers.isNotEmpty){
            chatCubitAccess.banSelectedUsersList();
          }
        }),
        const SizedBox(width: 15,),
      ],
    ),
  );


}