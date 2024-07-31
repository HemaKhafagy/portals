import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:Portals/screens/portals_config/adding_new_portal.dart';
import 'package:Portals/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabsScreen extends StatelessWidget {
  const HomeTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTapsCubit,HomeTapsCubitStates>(
      listener: (context,state){},
      builder: (context,state){
        HomeTapsCubit homeTapsCubitAccess = HomeTapsCubit.get(context);
        return Scaffold(
          body:  homeTapsCubitAccess.screens[homeTapsCubitAccess.currentHomeScreenIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.9, 1),
                colors: <Color>[
                  Color(0xff6941ab),
                  Color(0xff431e5b),
                  Color(0xff2c1853),
                ],
              ),
            ),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset("assets/image/robot.png",width: 32,height: 36,),
                  label: 'Portals',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/image/fav.png",width: 32,height: 36,),
                  label: 'Friends',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/image/movie.png",width: 32,height: 36,),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/image/chart.png",width: 32,height: 36,),
                  label: 'Leaderboards',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/image/profile.png",width: 32,height: 36,),
                  label: 'profile',
                ),
              ],
              currentIndex: homeTapsCubitAccess.currentHomeScreenIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xff1a141f).withOpacity(0.5),
              selectedItemColor: Colors.deepOrange[800],
              unselectedItemColor: Colors.white,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              onTap: (int index){
                homeTapsCubitAccess.changeCurrentHomeIndexValue(index);
              },
            ),
          ),
          floatingActionButton: homeTapsCubitAccess.currentHomeScreenIndex == 0 ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSharedButton(
                  buttonName: "Open New Portal",
                  isEnabled: true,
                  action: (){navigateTo(context: context, widget: const AddingNewPortal());}
              )
            ],
          ) : null,
        );
      },
    );
  }
}
