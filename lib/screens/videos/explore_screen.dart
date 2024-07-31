import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:Portals/screens/videos/content_screen.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<HomeTapsCubit,HomeTapsCubitStates>(
        listener: (context,state){},
        builder: (context,state){
          HomeTapsCubit homeTapsCubitAccess = HomeTapsCubit.get(context);
          return Container(
            color: Colors.black,
            child: Stack(
              children: [
                //We need swiper for every content
                Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return ContentScreen(
                      src: homeTapsCubitAccess.videosURL[index],
                    );
                  },
                  itemCount: homeTapsCubitAccess.videosURL.length,
                  scrollDirection: Axis.vertical,
                ),
                buildTopNav(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTopNav() =>  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Explore",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
          decoration: BoxDecoration(
              color: const Color(0xff2c1853),
              borderRadius: BorderRadius.circular(50)
          ),
          child: Row(
            children: [
              const Text("3",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              const SizedBox(width: 10,),
              SizedBox(
                height: 27,
                width: 27,
                child: Image.asset("assets/image/bell.png"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}