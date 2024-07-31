import 'dart:ui';

import 'package:Portals/screens/signup/cubit/cubit.dart';
import 'package:Portals/screens/signup/cubit/states.dart';
import 'package:Portals/screens/signup/otp_screen.dart';
import 'package:Portals/screens/signup/preference_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Portals/shared/constants.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components.dart';

class AssignDateOfBirth extends StatelessWidget {
  const AssignDateOfBirth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUPCubit,SignUpCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        SignUPCubit signUPCubitAccess = SignUPCubit.get(context);
        return Scaffold(
          body: Container(
            decoration: sharedContainerDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("What’s your birth date?",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                SizedBox(
                  height: 250,
                  child: ScrollDateTimePicker(
                    itemExtent: 54,
                    infiniteScroll: true,
                    dateOption: DateTimePickerOption(
                      dateFormat: intl.DateFormat('ddMMMMy'),
                      minDate: DateTime(1800, 6),
                      maxDate: DateTime(2050, 6),
                      // initialDate: time,
                    ),
                    centerWidget: DateTimePickerCenterWidget(
                      builder: (context, constraints, child) => const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color.fromRGBO(242, 73, 152, 0),
                              Color.fromRGBO(242, 132, 92, 0.35),
                              Color.fromRGBO(242, 73, 152, 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    style: DateTimePickerStyle(
                      activeStyle: const TextStyle(
                          fontSize: 24,
                          letterSpacing: -0.2,
                          fontWeight: FontWeight.w700
                      ),
                      inactiveStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700
                      ),
                      disabledStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    onChange: (datetime) {signUPCubitAccess.setUserBirthDate(datetime);},
                  ),
                ),
                Column(
                  children: [
                    buildSharedButton(buttonName: "Continue", isEnabled: true, action: (){navigateToAndCloseCurrent(context: context, widget: const PreferenceScreen());}),
                    const SizedBox(height: 15,),
                    const Text("Only your first name is public",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
