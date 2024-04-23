import 'package:flutter/material.dart';
import 'package:test_portals/screens/model_test.dart';

class HomeTabsScreen extends StatelessWidget {
  const HomeTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ModelTestScreen(),
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
              icon: Image.asset("images/robot.png",width: 32,height: 36,),
              label: 'Portals',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("images/fav.png",width: 32,height: 36,),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("images/movie.png",width: 32,height: 36,),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("images/chart.png",width: 32,height: 36,),
              label: 'Leaderboards',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("images/profile.png",width: 32,height: 36,),
              label: 'profile',
            ),
          ],
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xff1a141f).withOpacity(0.5),
          selectedItemColor: Colors.deepOrange[800],
          unselectedItemColor: Colors.white,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          // onTap: (){},
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 240,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.9, 1),
                colors: <Color>[
                  Color(0xfff24998),
                  Color(0xfff2845c)
                ],
              ),
            ),
            child: const Center(child: Text("Open New Portal",style: TextStyle(fontSize: 15,color: Colors.white),)),
          ),
        ],
      ),
    );
  }
}
