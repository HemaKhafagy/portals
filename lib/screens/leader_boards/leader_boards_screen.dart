import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/material.dart';


class LeaderBoardsScreen extends StatelessWidget {
    const LeaderBoardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTapsCubit,HomeTapsCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        HomeTapsCubit homeTapsCubitAccess = HomeTapsCubit.get(context);
        return Container(
          decoration: sharedContainerDecoration,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildPointsComponents(5000),
                          buildNotificationComponent(3),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("LEADERBOARDS",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),)
                        ],
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          itemCount: homeTapsCubitAccess.gamesNameList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return gameNameCardItem(homeTapsCubitAccess.gamesNameList[index],index,homeTapsCubitAccess);
                          },
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 200,
                        child: Stack(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Positioned(bottom: 0,left: 0,child: buildRankedPlayerCard(imageUrl: "https://s3-alpha-sig.figma.com/img/5e0c/d451/f6595a1a72f8f19655b2d0c19e1ce87c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=fRYS8VkCcafBvBFyK~Yp7qDmyQJM34ExXFbGQLp~RaiMg-wP7EvAd-7qy5qBWOirKLZKtaqPwoRYZvUVKTFIu7wk1WnBIB-SznQu779Uy9NtOzXLsu3M8gDFKcdcVL4uOo9gDNb30Y2L8CjJdcjPgga84p~rEi9tmFhHEUEz-F653ruAMDPVo8MsY4Zr1kAMzaPX64akp49U6FM3ngJR5qYI1~A7sSbOz7cfKXwN61HMrQ6njis0FeWKLokiFh-AjpON9TwixFPxbBbxgPXRKIFf1AxJfvig97tQ1LPyro0JEJGf6TZHfC9r7d3eAefDFat1SRD9UqB0-0K9pbrHMg__", name: "Gigachad", rank: 2, points: "8.999.999",radius: 50,width: 80,height: 80)),
                            Positioned(top: 0,left: 1,right: 1,child: buildRankedPlayerCard(imageUrl: "https://s3-alpha-sig.figma.com/img/fa69/e317/1f8e3bbe5dc00d4f1c56c18e54ccb06c?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oiIUarKL2FmuTNMG8aVZy9NzRJMi4Ly8GPF7swAPyh6hiRphFTfJP1-~IycCvOQeV34HYOkQVJchebC2O9OhcxTzGHlJnxRX4TN3WP2jjf3Y-VwcI5W5QnqAjrvciSdtn3MI12wlRv7ppK3beC5MVo8Xo7Jz2fktp18FaMSygT1blOvPvblsPu9--fNofFsXyrPfxuhsnZClwbYISYgLQxdTjKOA~39YFBcrtWa4ow8YmI-5sSYAaHa4dIrXP81sWzg91EGcvxUErFrbgsPNePMWl6xfZ3JwcjR3VtbEIDjfaLzjB8EYPL-lE0Mz6cjQchwHNgov-GE-Z~PBTQ1WAA__", name: "Gigachad", rank: 1, points: "9.999.999",radius: 60,width: 100,height: 100)),
                            Positioned(bottom: 0,right: 0,child: buildRankedPlayerCard(imageUrl: "https://s3-alpha-sig.figma.com/img/9f28/a5e4/c06bd0238ce429dd2cafb03ed7163737?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=iuePwY8pBT0hT1NrctRSBGRL8vR7G5n78JNe6GtLVlQrb6J1Z4kSzD9qgiz7mqv0ytMOkijCzx3tsAF2~5moSvCYxh7rCrbPgDi-x1hbNZo1QBTZMpQM3VxOr0fsiK3wkrWrjzrNKmrJ~u5NKXZbZxsiXwoc0CsWLJ7tpjPB09W~Tmox9llcm3wZ9HX5nR9JYu5gDM0uey00EDl1KO6lJlttKawfLbkbSsqZ13CGFxxMkQEB4POb5TMh0GMWHSSUlZriGejAh5FZV3jQZ-3AVqIxVCQxUsya3oQpb6jNWoEVWqPxWWjqnZA0p5sXrAwNjTiZoLC43A4d1O3sVyb3OQ__", name: "Gigachad", rank: 3, points: "7.999.999",radius: 50,width: 80,height: 80))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(16, 12, 19, 0.5),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                    ),
                    child: ListView.separated(
                      itemCount: homeTapsCubitAccess.leadersListItems.length,
                      separatorBuilder: (BuildContext context, int index) => const Divider(color: Color.fromRGBO(255, 255, 255, 0.1),),
                      itemBuilder: (context,index){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("${index+1}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                const SizedBox(width: 10,),
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: const Color.fromRGBO(242, 132, 92, 1),
                                  child: SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: ClipOval(
                                      child:  buildSharedImageFromNetwork(homeTapsCubitAccess.leadersListItems[index].playerImageUrl!),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text(homeTapsCubitAccess.leadersListItems[index].playerName!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                              ],
                            ),
                            Text(homeTapsCubitAccess.leadersListItems[index].playerRank!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget gameNameCardItem(String text,int index,HomeTapsCubit homeTapsCubitAccess) => GestureDetector(
    onTap: (){},
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 1),
        decoration: BoxDecoration(
            gradient: index == homeTapsCubitAccess.selectedGameIndex ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.9, 1),
              colors: <Color>[
                Color(0xfff24998),
                Color(0xfff2845c)
              ],
            ) :
            const LinearGradient(
              colors: <Color>[
                Color(0xff1f1632),
                Color(0xff1f1632),
              ],
            ) ,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color.fromRGBO(94, 76, 131, 1),width: 0.5)
        ),
        child: Center(
          child: Text(text,style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
        ),
      ),
    ),
  );

  Widget buildRankedPlayerCard({
    required String imageUrl,
    required String name,
    required int rank,
    required String points,
    required double radius,
    required double width,
    required double height,
  }) => SizedBox(
    height: rank == 1 ? 185 : rank == 2 ? 163 : 163,
    child: Column(
      children: [
        SizedBox(
          height: rank == 1 ? 125 : rank == 2 ? 103 : 103,
          width: rank == 1 ? 110 : rank == 2 ? 90 : 90,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 1,
                right: 1,
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor: rank == 1 ? const Color.fromRGBO(228, 156, 48, 1) : rank == 2 ? const Color.fromRGBO(136, 132, 145, 1) : const Color.fromRGBO(195, 99, 63, 1),
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: ClipOval(
                      child:  buildSharedImageFromNetwork(imageUrl),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 1,
                right: 1,
                child: Container(
                  width: rank == 1 ? 32 : 24,
                  height: rank == 1 ? 32 : 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: rank == 1 ? const Color.fromRGBO(228, 156, 48, 1) : rank == 2 ? const Color.fromRGBO(136, 132, 145, 1) : const Color.fromRGBO(195, 99, 63, 1)
                  ),
                  child: Center(child: Text("$rank",style: TextStyle(fontWeight: FontWeight.w700,fontSize: rank == 1 ? 20 : rank == 2 ? 18 : 18),),),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5,),
        Text(name,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
        const SizedBox(height: 5,),
        Container(
          width: 95,
          height: 30,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[
                  Color(0xff1f1632),
                  Color(0xff1f1632),
                ],
              ) ,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color.fromRGBO(94, 76, 131, 1),width: 0.5)
          ),
          child: Center(
            child: Text(points,style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
          ),
        ),
      ],
    ),
  );
}
