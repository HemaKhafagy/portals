import 'package:Portals/screens/signup/avatar_prepareing_screen.dart';
import 'package:Portals/screens/signup/cubit/cubit.dart';
import 'package:Portals/screens/signup/cubit/states.dart';
import 'package:Portals/screens/signup/profile_picture_screen.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAvatarScreen extends StatelessWidget {
  const CreateAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUPCubit,SignUpCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        SignUPCubit signUPCubitAccessInstance = SignUPCubit.get(context);
        return Scaffold(
          body: Container(
            decoration: sharedContainerDecoration,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Create your Avatar",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                SizedBox(
                  height: 340,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Image.asset("assets/image/avatar-1.png",width: 183,height: 232,),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Image.asset("assets/image/avatar-3.png",width: 208,height: 262,),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 1,
                        right: 1,
                        child: Image.asset("assets/image/avatar-2.png",width: 140,height: 183,),
                      ),
                    ],
                  ),
                ),
                const Text("Interact anonymously and confidently until\nyou’re ready to show your face to the\nworld!",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                buildSharedButton(buttonName: "Create", isEnabled: true, action: (){navigateTo(context: context, widget: const AvatarPreparingScreen());}),
                InkWell(
                  onTap: () => navigateTo(context: context, widget: const ProfilePictureScreen()),
                  child: const Text("Skip For Now",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
