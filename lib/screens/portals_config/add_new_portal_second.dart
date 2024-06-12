import 'package:Portals/layout/home_taps_screen.dart';
import 'package:Portals/screens/portals_config/cubit/cubit.dart';
import 'package:Portals/screens/portals_config/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddNewPortalSecond extends StatelessWidget {
  const AddNewPortalSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortalsConfigCubit,PortalsConfigStates>(
      listener: (context,state){},
      builder: (context,state){
        PortalsConfigCubit portalsCCAInstance = PortalsConfigCubit.get(context);
        return SingleChildScrollView(
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
              Text("Girl Power".toUpperCase(),style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
              const SizedBox(height: 5,),
              const Text("Fitness",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
              const SizedBox(height: 15,),
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(16, 12, 19, 1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: portalsCCAInstance.selectedThemeValues.isNotEmpty ? const Color.fromRGBO(242, 132, 92, 1) :
                        const Color.fromRGBO(100, 82, 217, 1)
                    ),
                  image: portalsCCAInstance.selectedThemeValues.isNotEmpty ? DecorationImage(
                    image: AssetImage(portalsCCAInstance.selectedThemeValues["image"]!),
                    fit: BoxFit.cover,
                  ) : null,
                ),
                child: InkWell(
                  onTap: () => portalsCCAInstance.changeThemeMenuIsOpenedStatus(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(portalsCCAInstance.selectedThemeValues.isNotEmpty ? portalsCCAInstance.selectedThemeValues["name"]! : "Select a Theme ",style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                      const Icon(Icons.keyboard_arrow_down_outlined)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              if(portalsCCAInstance.themeMenuIsOpened)
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color.fromRGBO(100, 82, 217, 1),width: 2)
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                            children: portalsCCAInstance.themes.keys.map((e) =>
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () => portalsCCAInstance.changeSelectedThemeValue({"name": portalsCCAInstance.themes[e]!["name"]!,"image":portalsCCAInstance.themes[e]!["image"]!}),
                                      child: Image.asset(portalsCCAInstance.themes[e]!["image"]!,height: 80,fit: BoxFit.cover,opacity: const AlwaysStoppedAnimation(.7),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: SizedBox(
                                        height: 80,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(portalsCCAInstance.themes[e]!["name"]!,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ).toList()
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 30,),
              buildUploadPhotoTemp("portal",portalsCCAInstance.selectedPortalPic, (){portalsCCAInstance.getPortalPic();}),
              const SizedBox(height: 20,),
              Text(portalsCCAInstance.selectedPortalPic != null ? "That’s a Cool Image!" : "Add a cool image",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
              const SizedBox(height: 30,),
              portalsCCAInstance.selectedThemeValues.isNotEmpty && portalsCCAInstance.selectedPortalPic != null ?
                buildSharedButton(buttonName: "Open Portal", isEnabled: true, action: (){portalsCCAInstance.increaseAddingScreenIndex();}) :
                buildSharedButton(buttonName: "Open Portal", isEnabled: false, action: (){}),
              const SizedBox(height: 30,),
            ],
          ),
        );
      },
    );
  }
}
