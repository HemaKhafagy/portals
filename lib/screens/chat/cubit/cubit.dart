import 'package:Portals/screens/chat/cubit/states.dart';
import 'package:Portals/shared/cach_helper.dart';
import 'package:firebase_auth/firebase_auth.dart' as FA;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:cloud_functions/cloud_functions.dart';

class ChatCubit extends Cubit<ChatCubitStates>
{

  ChatCubit() : super(ChatCubitInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  late StreamChatClient clint;
  late Channel channel;
  bool chatIsLoading = false;


  Future chatInit() async{



    changeChatIsLoadingState();
     clint = StreamChatClient(
      "58cauyvcrbmf",
      logLevel: Level.INFO
    );

    await connectToUserFunction(clint);
    channel = createChannel(clint,'FbvpaoU9z3bjQaMfkeUk71Yfskh2');
    ListenToChannel(channel);
    changeChatIsLoadingState();
  }

  changeChatIsLoadingState() {
    chatIsLoading = !chatIsLoading;
    emit(ChangeChatIsLoadingState());
  }

  // Future getUserChatToken(String id) async {
  //   try{
  //     HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('userChatToken');
  //     final resp = await callable.call(<String, dynamic>{
  //       'id': id,
  //     });
  //     print("result: ${resp.data}");
  //     return resp.data;
  //   }catch(error){
  //     print("Error...........................");
  //     // print(error.toString());
  //     return null;
  //   }
  // }

  Future connectToUserFunction(StreamChatClient clint) async{
    final currentUser = FA.FirebaseAuth.instance.currentUser;
    final token = await CashHelper.getDataFromSharedPref(key: "getStreamToken");
    if(token != null){
      await clint.connectUser(
          User(id: currentUser!.uid),
          // create function to auto generate tokens
          token
      );
    }else{
      // handel your error
    }
  }

  Channel createChannel(StreamChatClient clint,String chatID) {
    //id is optional
    return clint.channel("messaging", id: chatID);
  }

  ListenToChannel(Channel channel) {
    channel.watch();
  }


}