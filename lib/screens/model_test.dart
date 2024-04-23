import 'package:flutter/material.dart';
import '../shared/constants.dart';


class ModelTestScreen extends StatelessWidget {
   ModelTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 80,left: 10,right: 10,bottom: 10),
            child: Column(
              children: [
                buildTopNav(),
                const SizedBox(height: 20,),
                buildPortal(),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(5),
                    children: [
                      buildListViewButton("Tap",0),
                      buildListViewButton("Latest",1),
                      buildListViewButton("Music",2),
                      buildListViewButton("Movies",3),
                      buildListViewButton("Sports",4),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xff2d1859),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(15),
                itemCount: 7,
                separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.grey,),
                itemBuilder: (BuildContext context, int index) {
                  return buildCardItem(context,index);
                },
              )
            ),
          ),
        ],
      ),
    );
  }

  int listSelectedButton = 0;

  Widget buildListViewButton(String text,int index)=> Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 1),
        decoration: BoxDecoration(
            gradient: index == listSelectedButton ? const LinearGradient(
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
        child: Text(text,style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
      ),
      ),
  );

  Widget buildCardItem(BuildContext context,int index) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 29,
            backgroundColor: const Color(0xfff2845c),
            child: SizedBox(
              width: 55,
              height: 55,
              child: ClipOval(
                child:  Image.network(listViewCards[index].imageUrls!,fit: BoxFit.cover,),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(listViewCards[index].title!,style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800)),
              Text(listViewCards[index].description!,style: const TextStyle(color: Colors.white,fontSize: 12)),
            ],
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
            width: 98,
            height: 16,
            decoration: BoxDecoration(
              color: listViewCards[index].score! == 20 ? Colors.deepOrange.shade400 : Colors.deepPurple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(listViewCards[index].score! == 20 ? "Portal Full" : "Waiting For Guests",style: const TextStyle(color: Colors.white,fontSize: 8),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
            child: Row(
              children: [
                const Icon(Icons.supervised_user_circle_outlined,size: 17,color: Colors.white,),
                const SizedBox(width: 4,),
                Text("${listViewCards[index].score!}"+"/20",style: const TextStyle(color: Colors.white,fontSize: 10),)
              ],
            ),
          )
        ],
      )
    ],
  );

  Widget buildTopNav() =>  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
        decoration: BoxDecoration(
            color: const Color(0xff2c1853),
            borderRadius: BorderRadius.circular(50)
        ),
        child: Row(
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: ClipOval(
                child:  Image.asset("images/moon.png"),
              ),
            ),
            const SizedBox(width: 10,),
            const Text("5000",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
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
              child: Image.asset("images/bell.png"),
            ),
          ],
        ),
      ),
    ],
  );

  Widget buildPortal() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text("PORTALS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
      const SizedBox(width: 30,),
      Expanded(
        child: SizedBox(
          height: 35,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xff100c13).withOpacity(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              hintText: "Find a portal",
              hintStyle: const TextStyle(fontSize: 11,color: Colors.white),
              suffixIcon: const Icon(Icons.search),
              suffixIconColor: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}
