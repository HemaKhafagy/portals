import 'package:Portals/screens/portals_config/add_new_portal_first.dart';
import 'package:Portals/screens/portals_config/add_new_portal_second.dart';
import 'package:Portals/screens/portals_config/add_new_portal_third.dart';
import 'package:Portals/screens/portals_config/cubit/cubit.dart';
import 'package:Portals/screens/portals_config/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddingNewPortal extends StatelessWidget {
  const AddingNewPortal({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => PortalsConfigCubit(),
      child: BlocConsumer<PortalsConfigCubit,PortalsConfigStates>(
        listener: (context,state){},
        builder: (context,state){
          PortalsConfigCubit portalsCCAInstance = PortalsConfigCubit.get(context);
          return Scaffold(
            body: Container(
              decoration: sharedContainerDecoration,
              width: screenWidth,
              height: screenHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60,horizontal: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 11,
                  child: Container(
                    padding: const EdgeInsets.only(top: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(242, 132, 92, 0.5),
                            Color.fromRGBO(100, 82, 217, 0.5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.topRight
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(39, 20, 55, 1),
                            Color.fromRGBO(45, 24, 89, 1),
                          ],
                          begin: Alignment.topCenter,
                        ),
                      ),
                      child: portalsCCAInstance.addingScreenIndex == 0 ? const AddNewPortalFirst() : portalsCCAInstance.addingScreenIndex == 1 ? const AddNewPortalSecond() : const AddNewPortalThird(),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
