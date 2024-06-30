import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Portals/screens/signup/cubit/cubit.dart';
import 'package:Portals/screens/signup/cubit/states.dart';
import 'package:pinput/pinput.dart';
import 'package:Portals/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPScreen extends StatelessWidget {
  final bool isSignIn;
  const OTPScreen({required this.isSignIn,super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUPCubit,SignUpCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        SignUPCubit signUPCubitAccessInstance = SignUPCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: sharedContainerDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Welcome Robert, join the party!",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                  Column(
                    children: [
                      signUPCubitAccessInstance.verifyPhoneNumberIsLoading ? const CircularProgressIndicator() :
                      Form(
                        key: signUPCubitAccessInstance.OTPFormKey,
                        child: Pinput(
                          // Without Validator
                          // If true error state will be applied no matter what validator returns
                          // forceErrorState: true,
                          // Text will be displayed under the Pinput
                          // errorText: 'Error',
                          /// ------------
                          /// With Validator
                          /// Auto validate after user tap on keyboard done button, or completes Pinput
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                          validator: (pin) {
                            if (pin!.length == 6) {
                              signUPCubitAccessInstance.signUpWithPhoneNumber(context,pin,isSignIn);
                            }
                            /// Text will be displayed under the Pinput
                            // return 'Pin is incorrect';
                            return null;
                          },
                          length: 6,
                          defaultPinTheme: const PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                            decoration: BoxDecoration(
                              border:  Border(
                                  bottom: BorderSide(
                                      color: Color.fromRGBO(234, 239, 243, 1),
                                      width: 3
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Text("Enter 6 digit code",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn’t get a code? ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color.fromARGB(242, 178, 121, 1)),),
                      InkWell(
                        onTap: (){

                        },
                        child: const Text("Resend",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color.fromARGB(242, 178, 121, 1),
                          decoration:  TextDecoration.underline,decorationColor: Color.fromARGB(242, 178, 121, 1),)
                          ,),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
