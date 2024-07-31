import 'package:get/get.dart';
import 'package:Portals/screens/signup/cubit/cubit.dart';
import 'package:Portals/screens/signup/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoji/fluttermoji.dart';


class AvatarPreparingScreen extends StatelessWidget {
  const AvatarPreparingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return BlocConsumer<SignUPCubit,SignUpCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        SignUPCubit signUPCubitAccessInstance = SignUPCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: sharedContainerDecoration,
              height: screenHeight,
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40,),
                        InkWell(
                          onTap: () async{
                            // signUPCubitAccessInstance.changeAvatarSVGStringValue("");
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:  Text("Go Back",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                          ),
                        ),
                        // (signUPCubitAccessInstance.avatarSVGStringValue != "") ?
                        // Expanded(child: SvgPicture.string(FluttermojiFunctions().decodeFluttermojifromString(signUPCubitAccessInstance.avatarSVGStringValue))) :
                        Center(
                          child: FluttermojiCircleAvatar(
                            radius: 120,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // if((signUPCubitAccessInstance.avatarSVGStringValue == ""))
                  Expanded(
                    flex: 4,
                    child: signUPCubitAccessInstance.submittingIsLoading ? buildSharedShimmer() : Container(
                      decoration: const BoxDecoration(
                        color:  Color.fromRGBO(45, 24, 89, 1),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          buildMOJiAvatar(),
                          const SizedBox(height: 30,),
                          buildSharedButton(
                              buttonName: "Save & Continue",
                              isEnabled: true,
                              action: () async{
                                final fluttermojiController = Get.find<FluttermojiController>();
                                await fluttermojiController.setFluttermoji();
                                await FluttermojiFunctions().encodeMySVGtoString().then((value) {
                                  signUPCubitAccessInstance.changeAvatarSVGStringValue(value);
                                  signUPCubitAccessInstance.addImageToFirebaseStorage(key: "avatar",context: context,avatar: value);
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget buildMOJiAvatar() => FluttermojiCustomizer(
    scaffoldWidth: double.infinity,
    autosave: false,
    theme: FluttermojiThemeData(
        scrollPhysics: const AlwaysScrollableScrollPhysics(),
        primaryBgColor: const Color.fromRGBO(45, 24, 89, 1),
        secondaryBgColor: const Color.fromRGBO(45, 24, 89, 1),
        labelTextStyle: const TextStyle(color: Colors.white),
        selectedIconColor: const Color.fromRGBO(242, 122, 130, 1),
        selectedTileDecoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.9, 1),
              colors: <Color>[
                Color(0xfff24998),
                Color(0xfff2845c)
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey,width: 0.5)
        ),
        unselectedIconColor: Colors.white,
        boxDecoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
        )
    ),
  );

}
