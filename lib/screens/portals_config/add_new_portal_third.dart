import 'package:Portals/layout/home_taps_screen.dart';
import 'package:Portals/screens/portals_config/cubit/cubit.dart';
import 'package:Portals/screens/portals_config/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AddNewPortalThird extends StatelessWidget {
  const AddNewPortalThird({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortalsConfigCubit,PortalsConfigStates>(
      listener: (context,state){},
      builder: (context,state){
        PortalsConfigCubit portalsCCAInstance = PortalsConfigCubit.get(context);
        return portalsCCAInstance.submitIsLoading ? buildSharedShimmer() :
          Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){portalsCCAInstance.decreaseAddingScreenIndex();},
                          child: const Row(
                            children: [
                              Icon(Icons.arrow_back_ios_new),
                              SizedBox(width: 10,),
                              Text("Back",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (){navigateAndFinish(context: context, widget: const HomeTabsScreen());},
                          child: const Icon(Icons.close),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Text("Set a codename to interact with other users",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w700),textAlign: TextAlign.center),
                    const SizedBox(height: 5,),
                    const Text("Your codename will keep your identity hidden until it’s time to reveal who you are!",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: portalsCCAInstance.portalCodeController,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.white
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: portalsCCAInstance.portalCodeController.text.isEmpty ? Colors.white : const Color.fromRGBO(242, 132, 92, 1)),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(242, 132, 92, 1)),
                        ),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white
                        ),
                        hintText: '@  Codename',
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: (3.5 / 1 ),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        children: portalsCCAInstance.portalCodeNames.map((e) {
                          return InkWell(
                            onTap: (){
                              portalsCCAInstance.changeCodeNameValue(e);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 1),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(31, 22, 50, 1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color.fromRGBO(94, 76, 131, 1)),
                              ),
                              child: Center(child: Text("$e",style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w700),)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(31, 22, 50, 1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color.fromRGBO(94, 76, 131, 1)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(FontAwesomeIcons.arrowsRotate),
                                SizedBox(width: 5,),
                                Text("Refresh",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
            buildSharedButton(buttonName: "Set Codename", isEnabled: true, action: (){portalsCCAInstance.submitNewPortalAdding(context: context);}),
            const SizedBox(height: 20,),
          ],
        );
      },
    );
  }
}
