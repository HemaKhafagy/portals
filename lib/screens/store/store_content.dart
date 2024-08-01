import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/screens/store/cuibt/cubit.dart';
import 'package:Portals/screens/store/cuibt/states.dart';
import 'package:Portals/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';

class StoreContent extends StatelessWidget {
  const StoreContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit,StoreCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        StoreCubit storeCubitAccess = StoreCubit.get(context);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromRGBO(242, 132, 92, 1),width: 2),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: buildPointsComponents(storeCubitAccess.userCurrentStarDusts),
                  ),
                  buildNotificationComponent(3)
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("STORE",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),)
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromRGBO(16, 12, 19, 0.5)
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    const Text("Stardust",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                    storeCubitAccess.starDusts.isEmpty ? SizedBox() :
                    SizedBox(
                      height: 170,
                      child: ListView.separated(
                        itemCount: storeCubitAccess.starDusts.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(10),
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 10);
                        },
                        itemBuilder: (context,index){
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: const GradientBoxBorder(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromRGBO(100, 82, 217, 1),
                                      Color.fromRGBO(242, 73, 152, 1),
                                    ]
                                ),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: buildSharedImageFromNetwork(storeCubitAccess.starDusts[index].imageUrl!),
                                  ),
                                ),
                                Text("${storeCubitAccess.starDusts[index].amount} Stardust",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                                InkWell(
                                  onTap: (){
                                    storeCubitAccess.changeExchangeIsOpenedStatus(storeCubitAccess.starDusts[index]);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(31, 22, 50, 1),
                                        border: Border.all(color: const Color.fromRGBO(94, 76, 131, 1)),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("\$ ${storeCubitAccess.starDusts[index].price}",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text("Stickers & Gifts",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        itemCount: storeCubitAccess.sgList.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(10),
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 10);
                        },
                        itemBuilder: (context,index){
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(31, 22, 50, 1),
                                border: Border.all(color: const Color.fromRGBO(94, 76, 131, 1)),
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Center(
                              child: Text(storeCubitAccess.sgList[index],style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        padding: const EdgeInsets.all(10),
                        crossAxisCount: 2,
                        childAspectRatio: (1 / 1 ),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: storeCubitAccess.sgCardList.map((e) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: const GradientBoxBorder(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromRGBO(100, 82, 217, 1),
                                      Color.fromRGBO(242, 73, 152, 1),
                                    ]
                                ),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(e.imageUrl!,width: 80,height: 80,),
                                const SizedBox(height: 10,),
                                InkWell(
                                  onTap: () => storeCubitAccess.changeIsDoneStatus(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(31, 22, 50, 1),
                                        border: Border.all(color: const Color.fromRGBO(94, 76, 131, 1)),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/image/moon.png",width: 22,height: 20,),
                                        const SizedBox(width: 5,),
                                        Text("${e.amount}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
