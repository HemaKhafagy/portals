import 'package:Portals/screens/chat/cubit/cubit.dart';
import 'package:Portals/screens/chat/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..chatInit(),
      child: BlocConsumer<ChatCubit,ChatCubitStates>(
        listener: (context,state){},
        builder: (context,state){
          ChatCubit chatCubitAccess = ChatCubit.get(context);
          return chatCubitAccess.chatIsLoading ? CircularProgressIndicator() :
           StreamChat(
               client: chatCubitAccess.clint,
               child: StreamChatTheme(
                   data: StreamChatThemeData(
                     messageInputTheme: StreamMessageInputThemeData(
                       inputBackgroundColor: Color.fromRGBO(29, 8, 126, 1),
                       // actionButtonColor: Colors.deepOrange,
                       // actionButtonIdleColor: Colors.deepOrange,
                       // sendButtonColor: Colors.red
                     ),
                     messageListViewTheme: StreamMessageListViewThemeData(
                       backgroundImage: DecorationImage(
                         image: NetworkImage(
                           "https://s3-alpha-sig.figma.com/img/52a9/32e6/a6ded888ee15f381c4e9121a21a2f5ad?Expires=1723420800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=EPlYB22NU7POKHvb0qWTKUwYH~38X4ilIw-79wvft8Hua13gkvnlY8Ir34LOpMEqi2M86Fb1tgdQwU5-ggLN8IvYIgnYoWo6b8764P5IsVhLwl-fDmuUE9IUE5fzZ4DSjdnl5-YlT9Pim9uxeMOlqG6ITEHq5NHsPnQQ~5Vj35nZkNMetF7ZpWjU48YwmfM~NmVcCplE65er8aiMxpb52o-SiVs12hyz6aVP7cQK3Fwlo2dz2zq1VVBVJCRI0mhCFKAuodzVpJGaFEecVhD0MTH4~JX85hFBGcmyyDJn6wg-Ubg7Pl3zgXB2mrHEpGGNU2U6eQfL-cgC1VOD2EV~9w__",
                         ),
                         fit: BoxFit.cover
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
                     child: Scaffold(
                       // appBar: const StreamChannelHeader(),
                       body: Column(
                         children: [
                           Expanded(child: StreamMessageListView()),
                           StreamMessageInput(
                             spaceBetweenActions: 1,
                             enableSafeArea: false,
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
}
