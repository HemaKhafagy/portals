import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Portals/screens/signup/cubit/cubit.dart';
import 'package:Portals/screens/signup/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:Portals/shared/constants.dart';



class SignUpPersonaInfo extends StatelessWidget {
  const SignUpPersonaInfo({super.key});

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
                          "Let's get started, first, we are thrilled to get to\nknow you, how about you tell us a little more\nabout yourself?",
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
                          buildPageTextFormFiled(signUPCubitAccess.firstNameController,"John","First Name",(String? value) {
                            if (value!.isEmpty) {
                              return 'Invalid name!';
                            }
                            return null;
                          }),
                          buildPageTextFormFiled(signUPCubitAccess.lastNameController,"Doe","Last Name",(String? value) {
                            if (value!.isEmpty) {
                              return 'Invalid name!';
                            }
                            return null;
                          }),
                          buildPageTextFormFiled(signUPCubitAccess.emailController,"Jdoe@gmail.com","Email",(String? value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Invalid email!';
                            }
                            return null;
                          }),
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
                        buildSharedButton(buttonName: "Continue", isEnabled: true, action: (){signUPCubitAccess.personalInfoSubmit(context,false);}),
                        const SizedBox(height: 15,),
                        const Text("Only your first name is public",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
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


  Widget buildPageTextFormFiled(TextEditingController controller,String hintText,String labelText,var validator) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 30,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              contentPadding: // Text Field height
              const EdgeInsets.symmetric(vertical: 8.0,),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w200)
          ),
          onSaved: (String? value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: validator,
        ),
      ),
      const SizedBox(height: 3,),
      Text(labelText,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
      const SizedBox(height: 20,),
    ],
  );
}
