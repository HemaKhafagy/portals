import 'package:Portals/screens/signup/cubit/cubit.dart';
import 'package:Portals/screens/signup/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePictureScreen extends StatelessWidget {
  const ProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUPCubit,SignUpCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        SignUPCubit signUPCubitAccessInstance = SignUPCubit.get(context);
        print(signUPCubitAccessInstance.submittingIsLoading);
        return Scaffold(
          body: Container(
            decoration: sharedContainerDecoration,
            padding:  signUPCubitAccessInstance.submittingIsLoading ? null : const EdgeInsets.all(15),
            child: signUPCubitAccessInstance.submittingIsLoading ? buildSharedShimmer() :
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Upload your profile picture",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                buildUploadPhotoTemp("profile",signUPCubitAccessInstance.selectedProfilePic, (){signUPCubitAccessInstance.getProfilePic();}),
                buildSharedButton(buttonName: signUPCubitAccessInstance.selectedProfilePic != null ? "Save & Continue" : "Upload Picture", isEnabled: signUPCubitAccessInstance.selectedProfilePic != null ? true : false, action: (){
                  if(signUPCubitAccessInstance.selectedProfilePic != null){
                    signUPCubitAccessInstance.addImageToFirebaseStorage(key: "profile",context: context,file: signUPCubitAccessInstance.selectedProfilePic);
                  }
                }),
                const Text("Skip For Now",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
              ],
            ),
          ),
        );
      },
    );
  }
}
