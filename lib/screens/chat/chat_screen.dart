import 'package:Portals/models/portals.dart';
import 'package:Portals/screens/chat/cubit/cubit.dart';
import 'package:Portals/screens/chat/cubit/states.dart';
import 'package:Portals/screens/chat/widgets.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  final String title;
  final SubGuests guests;
  final Portals selectedPortal;
  ChatScreen({super.key,required this.chatId, required this.title,required this.guests,required this.selectedPortal});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ChatCubit()..chatInit(chatId,selectedPortal),
      child: BlocConsumer<ChatCubit,ChatCubitStates>(
        listener: (context,state){},
        builder: (context,state){
          ChatCubit chatCubitAccess = ChatCubit.get(context);
          return chatCubitAccess.chatIsLoading ? Scaffold(
            backgroundColor: Color.fromRGBO(6, 0, 32, 1),
            body: Center(child: buildIOSLoader()),
          ) :
           StreamChat(
               client: chatCubitAccess.clint,
               child: StreamChatTheme(
                   data: StreamChatThemeData(
                     // messageInputTheme: StreamMessageInputThemeData(
                     //   inputBackgroundColor: Color.fromRGBO(29, 8, 126, 1),
                     //   borderRadius: BorderRadius.circular(100),
                     //   inputDecoration: InputDecoration(
                     //     filled: true,
                     //     // fillColor: Colors.white,
                     //     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),),
                     //     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),),
                     //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                     //     hintText: "Message",
                     //     // prefixIcon: Icon(FontAwesomeIcons.gift,)
                     //   )
                     //   // actionButtonColor: Colors.deepOrange,
                     //   // actionButtonIdleColor: Colors.deepOrange,
                     //   // sendButtonColor: Colors.red
                     // ),
                     messageListViewTheme: StreamMessageListViewThemeData(
                       backgroundImage: DecorationImage(
                         image: NetworkImage(
                           "https://s3-alpha-sig.figma.com/img/52a9/32e6/a6ded888ee15f381c4e9121a21a2f5ad?Expires=1723420800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=EPlYB22NU7POKHvb0qWTKUwYH~38X4ilIw-79wvft8Hua13gkvnlY8Ir34LOpMEqi2M86Fb1tgdQwU5-ggLN8IvYIgnYoWo6b8764P5IsVhLwl-fDmuUE9IUE5fzZ4DSjdnl5-YlT9Pim9uxeMOlqG6ITEHq5NHsPnQQ~5Vj35nZkNMetF7ZpWjU48YwmfM~NmVcCplE65er8aiMxpb52o-SiVs12hyz6aVP7cQK3Fwlo2dz2zq1VVBVJCRI0mhCFKAuodzVpJGaFEecVhD0MTH4~JX85hFBGcmyyDJn6wg-Ubg7Pl3zgXB2mrHEpGGNU2U6eQfL-cgC1VOD2EV~9w__",
                         ),
                         // **************************************
                         // don't forget on error
                         fit: BoxFit.cover,
                         opacity: 0.5,
                         onError:  (context, t,) => const SizedBox(),
                       )
                     ),
                     colorTheme: StreamColorTheme.dark(),
                     ownMessageTheme: StreamMessageThemeData(
                       messageBackgroundColor: Color.fromRGBO(78, 48, 219, 1),
                       messageTextStyle: TextStyle(
                         color: Colors.white,
                       ),
                       avatarTheme: StreamAvatarThemeData(
                         borderRadius: BorderRadius.circular(8),
                       ),
                     ),
                     otherMessageTheme: StreamMessageThemeData(
                       messageBackgroundColor: Color.fromRGBO(6, 0, 32, 1),
                       messageTextStyle: TextStyle(
                         color: Colors.white,
                       ),
                       avatarTheme: StreamAvatarThemeData(
                         borderRadius: BorderRadius.circular(8),
                       ),
                     ),
                   ),
                   child: StreamChannel(
                     channel: chatCubitAccess.channel,
                     errorBuilder: (context,error,stackTrace) => errorBuilder(context,chatCubitAccess.errorMessage),
                     loadingBuilder: (context) => buildIOSLoader(),
                     child: Scaffold(
                       // appBar: const StreamChannelHeader(),
                       body: Column(
                         children: [
                           Expanded(
                             child: Stack(
                               children: [
                                 StreamMessageListView(
                                   emptyBuilder: (context) => emptyBuilder(context),
                                   messageBuilder: (context, details, messageList, defaultMessageWidget) {
                                     return defaultMessageWidget.copyWith(
                                       showUsername: false,
                                       showTimestamp: false
                                     );
                                   },
                                 ),
                                 Container(
                                   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                   height: 120,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           InkWell(
                                             onTap: () => Navigator.of(context).pop(),
                                             child: Icon(Icons.arrow_back_ios)
                                           ),
                                           Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                                               const SizedBox(width: 10,),
                                               Row(
                                                 children: [
                                                   const Icon(FontAwesomeIcons.user,size: 15,color: Colors.white,),
                                                   const SizedBox(width: 4,),
                                                   Text("${guests.guestCount}""/${guests.limit!}",style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),)
                                                 ],
                                               ),
                                             ],
                                           )
                                         ],
                                       ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           InkWell(
                                             onTap: (){},
                                             child: Icon(LineIcons.phone,size: 30,color: Colors.white,),
                                           ),
                                           const SizedBox(width: 10,),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [
                                               const Icon(Icons.alarm,size: 15,color: Colors.white,),
                                               const SizedBox(width: 5,),
                                               Text("${3}:""${26}",style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
                                             ],
                                           ),
                                           const SizedBox(width: 10,),
                                           InkWell(
                                             onTap: (){
                                               chatCubitAccess.changeChatWidgetsIndex(0);
                                               ChatAdminWidgets.showCustomDialog(context: context,chatCubitAccess: chatCubitAccess);
                                             },
                                             child: Icon(LineIcons.bars,size: 30,color: Colors.white,),
                                           ),
                                         ],
                                       )
                                     ],
                                   ),
                                 )
                               ],
                             ),
                           ),
                           StreamMessageInput(
                             spaceBetweenActions: 1,
                             enableSafeArea: false,
                             showCommandsButton: false,
                             sendButtonLocation: SendButtonLocation.inside,
                           ),
                         ],
                       ),
                     ),
                   )
               )
           );
        },
      ),
    );
  }

  Widget emptyBuilder(BuildContext context) => Container(
    color: Color.fromRGBO(6, 0, 32, 1),
    child: Center(
      child: Text("Write Your First Message ....."),
    ),
  );

  Widget errorBuilder(BuildContext context,String error) => Scaffold(
    backgroundColor: Color.fromRGBO(6, 0, 32, 1),
    body: Container(
      color: Color.fromRGBO(6, 0, 32, 1),
      child: Center(
        child: Text(error),
      ),
    ),
  );


}


