import 'package:Portals/layout/home_taps_screen.dart';
import 'package:Portals/models/portals.dart';
import 'package:Portals/screens/portals_config/cubit/cubit.dart';
import 'package:Portals/screens/portals_config/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AddNewPortalFirst extends StatelessWidget {
  const AddNewPortalFirst({super.key});

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
                    onTap: (){navigateAndFinish(context: context, widget: const HomeTabsScreen());},
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
              const Text("NEW PORTAL",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
              const SizedBox(height: 5,),
              const Text("Give your portal a name, choose a topic and set an age range for your Portal guests",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
              const SizedBox(height: 15,),
              TextFormField(
                controller: portalsCCAInstance.portalNameController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Colors.white
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: portalsCCAInstance.portalNameController.text.isEmpty ? Colors.white : Color.fromRGBO(242, 132, 92, 1)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(242, 132, 92, 1)),
                  ),
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      color: Colors.white
                  ),
                  hintText: 'Friends & Fun',
                ),
              ),
              const SizedBox(height: 7,),
              const Text("Give your Portal a name",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,),),
              const SizedBox(height: 30,),
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(16, 12, 19, 1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: portalsCCAInstance.topicSelectedValue != "" ? const Color.fromRGBO(242, 132, 92, 1) :
                        const Color.fromRGBO(100, 82, 217, 1)
                    )
                ),
                child: InkWell(
                  onTap: () => portalsCCAInstance.changeDropDMIO(!portalsCCAInstance.dropDownMenuIsOpened),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(portalsCCAInstance.topicSelectedValue == "" ? "Select a Topic " : portalsCCAInstance.topicSelectedValue,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                      Icon(portalsCCAInstance.dropDownMenuIsOpened ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_outlined)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              if(portalsCCAInstance.dropDownMenuIsOpened)
                Container(
                  height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(16, 12, 19, 1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color.fromRGBO(100, 82, 217, 1))
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: portalsCCAInstance.topics.map((e) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 12),
                                child: GestureDetector(
                                  onTap: () => portalsCCAInstance.changeTopicSelectedValue(e),
                                  child: Text(e,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                                ),
                              )
                          ).toList()
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 35,),
              const Text("Age Range",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14,),),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildListViewButton(min: 18,max: 24,access: portalsCCAInstance),
                  buildListViewButton(min: 25,max: 34,access: portalsCCAInstance),
                  buildListViewButton(min: 35,max: 44,access: portalsCCAInstance),
                ],
              ),
              const SizedBox(height: 35,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Private Portal",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,),),
                  buildSwitchButton(portalsCCAInstance),
                ],
              ),
              const SizedBox(height: 35,),
              (portalsCCAInstance.portalNameController.text.isNotEmpty && portalsCCAInstance.topicSelectedValue.isNotEmpty && portalsCCAInstance.ageSelectedValues.isNotEmpty) ?
              buildSharedButton(buttonName: "Continue", isEnabled: true, action: (){portalsCCAInstance.increaseAddingScreenIndex();}) :
              buildSharedButton(buttonName: "Continue", isEnabled: false, action: (){})
              // const Spacer(),
            ],
          ),
        );
      },
    );
  }

  Widget buildListViewButton({required int min, required int max, required PortalsConfigCubit access})=> InkWell(
    onTap: () => access.changeANPASdRange(value: SubAgeRange(min: min,max: max)),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
            gradient: access.ageSelectedValues.any((element) => element.min == min) ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.9, 1),
              colors: <Color>[
                Color(0xfff24998),
                Color(0xfff2845c)
              ],
            ) : const LinearGradient(
              colors: <Color>[
                Color(0xff1f1632),
                Color(0xff1f1632),
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

  Widget buildSwitchButton(PortalsConfigCubit access) => GestureDetector(
    onTap: () {
      access.changeSBSValue(access.switchButtonSelectedValue == "No" ? "Yes" : "No");
    },
    child: Container(
      width: 85,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(31, 22, 50, 1)
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: access.switchButtonSelectedValue == "No" ? const Color.fromRGBO(136, 132, 145, 1) : null
              ),
              child: const Center(child: Text("No",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,))),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: access.switchButtonSelectedValue == "Yes" ? Colors.green : null
              ),
              child: const Center(child: Text("Yes",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,))),
            ),
          ),
        ],
      ),
    ),
  );

}
