import 'dart:ui';

import 'package:Portals/screens/store/cuibt/cubit.dart';
import 'package:Portals/screens/store/cuibt/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IsError extends StatelessWidget {
  const IsError({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit, StoreCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        StoreCubit storeCubitAccess = StoreCubit.get(context);
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.0,
            sigmaY: 3.0,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(16, 12, 19, 0.5)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(242, 73, 152, 1)),
                    child: const Center(
                      child: Icon(
                        FontAwesomeIcons.x,
                        size: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Error! Not Enough Star Dusts",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
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
