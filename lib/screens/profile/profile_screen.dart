import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:Portals/screens/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:Portals/shared/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeTapsCubit, HomeTapsCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeTapsCubit homeTapsCubitAccess = HomeTapsCubit.get(context);
        return Scaffold(
          backgroundColor: const Color.fromRGBO(26, 20, 31, 1),
          body: Stack(
            fit: StackFit.expand,
            children: [
              buildSharedImageFromNetwork("https://s3-alpha-sig.figma.com/img/12d4/22f2/e20c1e0ad7f0fb2a477e2a910d924539?Expires=1723420800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=KzSKOcSecBpGna7RJ8jL17UwmL39BlAqsFosQlpkpH4BfhYFOBBX4RSWK0aDwzO0X4cTX4mhjzxZuqiRnmQvJZ0VnFW~unXQ9n4U-HBhC8R~j~VL-o00Dmyv5PEkqaYoxSHd5TTepLiPTfkxJAzuV5Mb0kQyiIlA5-Ahw2ZOiObHPC76RXBm5pF3C8DaXd6VVc~z1T0OSfp9Hx5y0U49yjZzsh2FHG55SJivmrUdFhOaeIqE2lkgahkGtUiDUpIR0NJ0qDT0hBS8pyLcfwy0TWcliD8b7n32AJzT2P6CFy2WlIN5tNTc~1onAwILGXFr58uZVBpRsmAmPnoPufgEZA__"),
              Positioned(
                top: screenHeight * 0.07,
                right: 20,
                child: buildNotificationComponent(3),
              ),
              Positioned(
                bottom: 0,
                left: 1,
                right: 1,
                child: SizedBox(
                    height: homeTapsCubitAccess.profileDetailsIsOpened
                        ? screenHeight * 0.8
                        : screenHeight * 0.25,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          top: 50,
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                border: Border(
                                    top: BorderSide(
                                        color:
                                            Color.fromRGBO(242, 73, 152, 0.5))),
                                gradient: LinearGradient(
                                    tileMode: TileMode.mirror,
                                    begin: Alignment.topCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Color.fromRGBO(26, 20, 31, 0.9),
                                      Color.fromRGBO(45, 24, 89, 0.95),
                                      Color.fromRGBO(88, 35, 103, 0.96),
                                    ])),
                            height: homeTapsCubitAccess.profileDetailsIsOpened
                                ? screenHeight * 0.8
                                : screenHeight * 0.15,
                            width: screenWidth,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: screenWidth*0.3,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${homeTapsCubitAccess.userData!.firstName} ${homeTapsCubitAccess.userData!.lastName}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700
                                            ),
                                          ),
                                          Text(
                                              "${homeTapsCubitAccess.userData!.gender}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600
                                              )
                                          ),
                                          Text(
                                              "${homeTapsCubitAccess.userData!.country}, ${homeTapsCubitAccess.userData!.city}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600
                                              )
                                          ),
                                        ],
                                      ),
                                      // const Icon(FontAwesomeIcons.ellipsisVertical),
                                      PopupMenuButton(
                                        // key: popUpKey,
                                        splashRadius: 10,
                                        onSelected: (item) {},
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                        shadowColor: const Color.fromRGBO(
                                            242, 132, 92, 1),

                                        padding: const EdgeInsets.all(15),
                                        constraints: BoxConstraints(
                                            minWidth: screenWidth * 0.4),
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry>[
                                          // popupMenuItem(
                                          //     '',
                                          //     FontAwesomeIcons.gamepad,
                                          //     "Send Game Invite",
                                          //     () {}),
                                          // popupMenuItem(
                                          //     '',
                                          //     FontAwesomeIcons.gift,
                                          //     "Send a Gift",
                                          //     () {}),
                                          // popupMenuItem(
                                          //     '',
                                          //     FontAwesomeIcons.userLock,
                                          //     "Block User",
                                          //     () {}),
                                          popupMenuItem(
                                              '',
                                              FontAwesomeIcons.edit,
                                              "Edit Profile", () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: EditProfile()),
                                                );
                                              },
                                            );
                                          }),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (homeTapsCubitAccess
                                      .profileDetailsIsOpened)
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                buildStaticCom(1, "Level"),
                                                Container(
                                                  height: 30,
                                                  width: 1,
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                ),
                                                buildStaticCom(0, "Friends"),
                                                Container(
                                                  height: 30,
                                                  width: 1,
                                                  color: const Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                ),
                                                buildStaticCom(0, "Victories"),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            // buildSharedButton(
                                            //     buttonName: "Invite To Portal",
                                            //     isEnabled: true,
                                            //     width: screenWidth * 0.9,
                                            //     height: 50,
                                            //     action: () {}),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              width: screenWidth * 0.9,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: const Color.fromRGBO(
                                                      26, 20, 31, 1)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "About",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    homeTapsCubitAccess
                                                            .userData!.about ??
                                                        "",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    child: ListView.separated(
                                                      itemCount:
                                                          homeTapsCubitAccess
                                                              .listOfUserFeathers
                                                              .length,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return const SizedBox(
                                                            width: 3);
                                                      },
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: const Color
                                                                  .fromRGBO(31,
                                                                  22, 50, 1),
                                                              border: Border.all(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      94,
                                                                      76,
                                                                      131,
                                                                      1))),
                                                          child: Center(
                                                              child: Text(
                                                            homeTapsCubitAccess
                                                                    .listOfUserFeathers[
                                                                index],
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            BGItems(
                                                "Jane’s Badges",
                                                homeTapsCubitAccess
                                                    .listOfUserBadges),
                                            BGItems(
                                                "Jane’s Gifts",
                                                homeTapsCubitAccess
                                                    .listOfUserGifts)
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 20,
                          child: InkWell(
                            onTap: () => homeTapsCubitAccess
                                .changeProfileDetailsIsOpenedStatus(),
                            child: CircleAvatar(
                              radius: screenHeight * 0.075,
                              backgroundColor: const Color(0xfff2845c),
                              child: SizedBox(
                                width: screenHeight * 0.18,
                                height: screenHeight * 0.18,
                                child: ClipOval(
                                  child:  buildSharedImageFromNetwork(homeTapsCubitAccess.userData!.imageURL == null ? "" : homeTapsCubitAccess.userData!.imageURL!),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildStaticCom(double count, String text) => Column(
        children: [
          Text(
            count.toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), ''),
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      );

  Widget BGItems(String name, List urls) => Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 70,
            child: ListView.separated(
              itemCount: urls.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 10);
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: buildSharedImageFromNetwork(urls[index]),
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );

 Widget BGItems(String name,List urls) => Column(
     children: [
       const SizedBox(height: 10,),
       Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Text(name,style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)
         ],
       ),
       const SizedBox(height: 10,),
       SizedBox(
         height: 70,
         child: ListView.separated(
           itemCount: urls.length,
           scrollDirection: Axis.horizontal,
           separatorBuilder: (BuildContext context, int index) {
             return const SizedBox(width: 10);
           },
           itemBuilder: (context,index){
             return ClipRRect(
               borderRadius: BorderRadius.circular(50),
               child: buildSharedImageFromNetwork(urls[index]),
             );
           },
         ),
       ),
       const SizedBox(height: 15,),
     ],
   );

   PopupMenuEntry popupMenuItem(String value,IconData icon,String label,VoidCallback action) => PopupMenuItem(
     value: value,
     onTap: action,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Icon(icon),
         Text(label,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white)),
       ],
     ),
   );
}
