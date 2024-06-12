import 'package:Portals/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Portals/screens/signup/cubit/cubit.dart';
import 'package:Portals/screens/signup/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';

class PreferenceScreen extends StatelessWidget {
  const PreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUPCubit,SignUpCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        SignUPCubit signUPCubitAccessInstance = SignUPCubit.get(context);
        return Scaffold(
          body: Container(
            decoration: sharedContainerDecoration,
            padding: signUPCubitAccessInstance.submittingIsLoading ? null : const EdgeInsets.all(15),
            child: signUPCubitAccessInstance.submittingIsLoading ? buildSharedShimmer() :
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("What’s your birth preference?",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("I am a...",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 43,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          buildGenderBox(label: "Guy", parameterVal: signUPCubitAccessInstance.genderPara, index: 1,access: signUPCubitAccessInstance),
                          buildGenderBox(label: "Girl", parameterVal: signUPCubitAccessInstance.genderPara, index: 2,access: signUPCubitAccessInstance),
                          buildGenderBox(label: "Non-Binary", parameterVal: signUPCubitAccessInstance.genderPara, index: 3,access: signUPCubitAccessInstance),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text("Aged",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 43,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          buildUserAgeBox(min: 13,max: 17, parameterVal: signUPCubitAccessInstance.agePara, index: 1,access: signUPCubitAccessInstance),
                          buildUserAgeBox(min: 18,max: 24, parameterVal: signUPCubitAccessInstance.agePara, index: 2,access: signUPCubitAccessInstance),
                          buildUserAgeBox(min: 25,max: 34, parameterVal: signUPCubitAccessInstance.agePara, index: 3,access: signUPCubitAccessInstance),
                          buildUserAgeBox(min: 35,max: 44, parameterVal: signUPCubitAccessInstance.agePara, index: 4,access: signUPCubitAccessInstance),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text("And I want to meet...",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                    const Text("(Select all that apply)",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color.fromARGB(173, 158, 193, 1)),),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 100,
                      child: GridView.count(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        crossAxisCount: 2,
                        childAspectRatio: (1 / .27),
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        children: <Widget>[
                          buildWantMeetBox(label: "Male Friends", index: 1,access: signUPCubitAccessInstance),
                          buildWantMeetBox(label: "Female Friends", index: 2,access: signUPCubitAccessInstance),
                          buildWantMeetBox(label: "Non-Binary Friends", index: 3,access: signUPCubitAccessInstance),
                          buildWantMeetBox(label: "All Kinds of Friends", index: 4,access: signUPCubitAccessInstance),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Text("Aged",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 43,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          buildWantAgeBox(min: 13,max: 17,access: signUPCubitAccessInstance),
                          buildWantAgeBox(min: 18,max: 24,access: signUPCubitAccessInstance),
                          buildWantAgeBox(min: 25,max: 34,access: signUPCubitAccessInstance),
                          buildWantAgeBox(min: 35,max: 44,access: signUPCubitAccessInstance),
                        ],
                      ),
                    ),
                  ],
                ),
                buildSharedButton(
                    buttonName: "Continue",
                    isEnabled: (signUPCubitAccessInstance.genderPara != 0 && signUPCubitAccessInstance.agePara != 0 && signUPCubitAccessInstance.wantMeet.isNotEmpty && signUPCubitAccessInstance.interestedAge.isNotEmpty) ? true : false,
                    action: (){signUPCubitAccessInstance.submitSignUp(context);}
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget buildGenderBox({required String label,required int parameterVal,required int index,required SignUPCubit access}) => GestureDetector(
    onTap: () => access.changeGenderValue(value: label,index: index),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 103,
        decoration: BoxDecoration(
            gradient: index == parameterVal && parameterVal != 0 ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.9, 1),
              colors: <Color>[
                Color(0xfff24998),
                Color(0xfff2845c)
              ],) : const LinearGradient(
              colors: <Color>[
                Color.fromRGBO(255, 255, 255, 0.25),
                Color.fromRGBO(255, 255, 255, 0.25),
              ],
            ) ,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey,width: 0.5)
        ),
        child: Center(
          child: Text(label,style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
        ),
      ),
    ),
  );

  Widget buildUserAgeBox({required int min,required int max,required int parameterVal,required int index,required SignUPCubit access}) => GestureDetector(
    onTap: () => access.changeUserAgeValue(min: min,max: max,index: index),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 77,
        decoration: BoxDecoration(
            gradient: index == parameterVal && parameterVal != 0 ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.9, 1),
              colors: <Color>[
                Color(0xfff24998),
                Color(0xfff2845c)
              ],) : const LinearGradient(
              colors: <Color>[
                Color.fromRGBO(255, 255, 255, 0.25),
                Color.fromRGBO(255, 255, 255, 0.25),
              ],
            ) ,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey,width: 0.5)
        ),
        child: Center(
          child: Text("$min-$max",style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
        ),
      ),
    ),
  );

  Widget buildWantMeetBox({required String label,required int index,required SignUPCubit access}) => GestureDetector(
    onTap: () => access.changeWantMeetValue(value: label),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 127,
        decoration: BoxDecoration(
            gradient: access.wantMeet.contains(label) ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.9, 1),
              colors: <Color>[
                Color(0xfff24998),
                Color(0xfff2845c)
              ],) : const LinearGradient(
              colors: <Color>[
                Color.fromRGBO(255, 255, 255, 0.25),
                Color.fromRGBO(255, 255, 255, 0.25),
              ],
            ) ,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey,width: 0.5)
        ),
        child: Center(
          child: Text(label,style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
        ),
      ),
    ),
  );

  Widget buildWantAgeBox({required int min,required int max,required SignUPCubit access}) => GestureDetector(
    onTap: () => access.changeWantAgeValue(value:  InterestedInAgeModel(minAge: min, maxAge: max)),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 77,
        decoration: BoxDecoration(
            gradient: access.interestedAge.any((element) => element.minAge == min) ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.9, 1),
              colors: <Color>[
                Color(0xfff24998),
                Color(0xfff2845c)
              ],) : const LinearGradient(
              colors: <Color>[
                Color.fromRGBO(255, 255, 255, 0.25),
                Color.fromRGBO(255, 255, 255, 0.25),
              ],
            ) ,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey,width: 0.5)
        ),
        child: Center(
          child: Text("$min-$max",style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
        ),
      ),
    ),
  );


}
