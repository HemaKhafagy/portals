import 'package:Portals/screens/portals_config/cubit/cubit.dart';
import 'package:Portals/screens/portals_config/cubit/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JoinPortalScreen extends StatelessWidget {
  const JoinPortalScreen({super.key});

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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){},
                                  child: const Icon(Icons.close),
                                )
                              ],
                            ),
                            const Text("Request permission to enter portal?",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),textAlign: TextAlign.center),
                            const SizedBox(height: 10,),
                            CircleAvatar(
                              radius: 105,
                              backgroundColor: const Color.fromRGBO(255, 255, 255, 0.65),
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: ClipOval(
                                  child:  Image.network("https://s3-alpha-sig.figma.com/img/a0f6/ee13/685c9575db087c68c4c4029ab2978ec1?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=SKkbmBKDZ5NctEYUn2aU2mstoX~ZRZmqpCGY4ntF~y5QvX8QC2kq2KNZ2w48qIZ9N38BZa3rSX0Qw8Mest62-XcvaGWNoFuu~AK6deWV2Q3OwjlUwZV4igBPQxmkvAy7xREMGSU2Z7D1LUD5D7RICWLX6hyWTwYSzvgtnatdn50W4CFkeGcj1U3EO01Fg5c1VrrmVqvPjddhgKY~vNvOFvElsmnn0tcX8tmCgaqSIG8miK~jA2l9549PC-iGkj0RvL2YxpD7y5zyEke2uz5XuKd~UeBN12EFV6Xj7O6p3Bj~6mn1tUNOrggjMS6DZwronkYtbdTn1Jw3431ouzmsMQ__",fit: BoxFit.cover,),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 20,),
                                const Text("Gains & Fitness",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),textAlign: TextAlign.center),
                                const SizedBox(height: 10,),
                                const Text("Aesthetics",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),textAlign: TextAlign.center),
                                const SizedBox(height: 10,),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.user,size: 17,color: Colors.white,),
                                    SizedBox(width: 4,),
                                    Text("15/20",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12),)
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                  width: 98,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    // color: listViewCards[index].score! == 20 ? Colors.deepOrange.shade400 : Colors.deepPurple,
                                    color: const Color.fromRGBO(100, 82, 217, 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text("Waiting For Guests",style: TextStyle(color: Colors.white,fontSize: 8),),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30,),
                            buildSharedButton(buttonName: "Request to join", isEnabled: true, action: (){}),
                            const SizedBox(height: 30,),
                            const Text("I changed my mind",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),textAlign: TextAlign.center),

                          ],
                        ),
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
