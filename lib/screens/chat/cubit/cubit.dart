import 'package:Portals/screens/chat/cubit/states.dart';
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
    channel = createChannel(clint);
    ListenToChannel(channel);
    changeChatIsLoadingState();
  }

  changeChatIsLoadingState() {
    chatIsLoading = !chatIsLoading;
    emit(ChangeChatIsLoadingState());
  }

  Future<void> getUserChatToken(String id) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('userChatToken');
    final resp = await callable.call(<String, dynamic>{
      'id': id,
    }).catchError((error){
      // handel your error
      print("Error.........................");
      print(error);
    });
    print("result: ${resp.data}");
  }

  Future connectToUserFunction(StreamChatClient clint) async{
    final currentUser = FA.FirebaseAuth.instance.currentUser;
    print("ddddddddddddd................");
    print(clint.devToken(currentUser!.uid).rawValue);
    getUserChatToken(currentUser.uid);
    await clint.connectUser(
        User(id: currentUser.uid),
        // create function to auto generate tokens
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiRmJ2cGFvVTl6M2JqUWFNZmtlVWs3MVlmc2toMiJ9.XFHD_K2wTbBClDeeBmvF19C_3JpNd0XZBd2QIBye0X8"
    );
  }

  Channel createChannel(StreamChatClient clint) {
    //id is optional
    return clint.channel("messaging", id: 'FbvpaoU9z3bjQaMfkeUk71Yfskh2');
  }

  ListenToChannel(Channel channel) {
    channel.watch();
  }


}