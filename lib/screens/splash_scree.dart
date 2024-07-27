import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:Portals/layout/home_taps_screen.dart';
import 'package:Portals/screens/signup/sign_in_screen.dart';
import 'package:Portals/screens/signup/sign_up_personal_info.dart';
import 'package:flutter/material.dart';
import 'package:Portals/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    HomeTapsCubit.get(context).checkUserExistence(context);
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
    return BlocConsumer<HomeTapsCubit,HomeTapsCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        HomeTapsCubit homeTapsCubitAccess = HomeTapsCubit.get(context);
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, 0),
                radius: 1.6,
                colors: <Color>[
                  Color(0xffc76e7b),
                  Color(0xff7846b3),
                  Color(0xff493599),
                  Color(0xff2d1859),
                  Color(0xff261742)
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/image/portal-logo.png",width: 213,height: 191,),
                      const SizedBox(height: 10,),
                      const Text("Cool Slogan Line",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
                Image.asset("assets/image/stars.png"),
                Image.asset("assets/image/vector.png"),
                homeTapsCubitAccess.splashIsLoading ? Container(
                  padding: const EdgeInsets.all(20),
                  width: screenWidth,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width:20,height:20,child: CircularProgressIndicator()),
                    ],
                  ),
                ) :
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: screenWidth,
                    height: screenHeight/3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            navigateTo(context: context, widget: const SignInScreen());
                            },
                          child: const Text("Sign in",style: TextStyle(fontSize: 16,color: Colors.white),),
                        ),
                        Column(
                          children: [
                            buildSharedButton(buttonName: "Join Portals", isEnabled: true, action: (){navigateTo(context: context, widget: const SignUpPersonaInfo());}),
                            const SizedBox(height: 15,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildTermsAndConditionText("By joining Portals you agree to our",false),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (){},
                                      child: buildTermsAndConditionText("Terms & Conditions",true),
                                    ),
                                    buildTermsAndConditionText(" and ",false),
                                    InkWell(
                                      onTap: (){},
                                      child: buildTermsAndConditionText("Privacy Policy",true),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTermsAndConditionText(String text,bool isUnderLine) => Text(
    text,
    style: isUnderLine == true ? const TextStyle(
        fontSize: 14,
        color: Colors.white,
        decoration:  TextDecoration.underline,
        decorationColor: Colors.white,
    ) : const TextStyle(
        fontSize: 14,
        color: Colors.white,
    ),
    textAlign: TextAlign.center,
  );
}
