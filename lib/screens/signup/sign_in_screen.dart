import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Portals/screens/signup/cubit/cubit.dart';
import 'package:Portals/screens/signup/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:Portals/shared/constants.dart';



class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    return BlocConsumer<SignUPCubit,SignUpCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        SignUPCubit signUPCubitAccess = SignUPCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: signUPCubitAccess.formKey,
              child: Container(
                width: double.infinity,
                height: screenHeight,
                decoration: sharedContainerDecoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Hello There!",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700),),
                        SizedBox(height: 15,),
                        Text(
                          "please enter our number to login",
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                            child: IntlPhoneField(
                              controller: signUPCubitAccess.phoneNumberController,
                              decoration: const InputDecoration(
                                  hintText: '123 456 7890',
                                  hintStyle: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w200),
                                  counterText: ""
                              ),
                              initialCountryCode: 'US',
                              showDropdownIcon: false,
                              validator: (value){
                                // print(value!.number);
                                if (value!.number.isEmpty || !value.isValidNumber()) {
                                  return 'Invalid number!';
                                }
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.disabled,
                              onChanged: (phone) {
                                signUPCubitAccess.signUpPhoneNumber = phone.completeNumber.trim();
                              },
                              onSubmitted: (value){

                              },
                            ),
                          ),
                          const SizedBox(height: 3,),
                          const Text("Phone Number",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        buildSharedButton(buttonName: "Continue", isEnabled: true, action: (){signUPCubitAccess.personalInfoSubmit(context,true);}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
