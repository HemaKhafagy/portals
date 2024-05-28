import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Container(
            height: 150,
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color.fromRGBO(16, 12, 19, 0.75),
                      Color.fromRGBO(45, 24, 89, 1)
                    ]
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 110),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromRGBO(242, 132, 92, 1),
                          child: CircleAvatar(
                            radius: 23,
                            child:  Icon(Icons.person, size: 22),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jane Doe',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                            Text('Ultimate racing 4',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),)
                          ],
                        ),
                        const SizedBox(width: 10),
                        // const Icon(Icons.verified, size: 15),
                        // const SizedBox(width: 6),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            ' ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: screenWidth *0.7,
                      height: 60,
                      child: const Text(
                          'The Kotlin extensions library transitively includes the updated firebase-analytics library. The Kotlin extensions library has no additional updates The Kotlin extensions library has no additional updates.',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500)
                      ),
                    ),
                    const SizedBox(height: 10),
                    // const Row(
                    //   children: [
                    //     Icon(
                    //       Icons.music_note,
                    //       size: 15,
                    //     ),
                    //     Text('Original Audio - some music track--'),
                    //   ],
                    // ),
                  ],
                ),
                const Column(
                  children: [
                    // const Icon(Icons.favorite_outline),
                    // const Text('601k'),
                    // const SizedBox(height: 20),
                    // Transform(
                    //   transform: Matrix4.rotationZ(5.8),
                    //   child: const Icon(Icons.share_rounded),
                    // ),
                    Icon(Icons.share_rounded),
                    Text('share',style: TextStyle(fontSize: 9,fontWeight: FontWeight.w700),),
                    SizedBox(height: 20),
                    Icon(Icons.comment_outlined),
                    Text('comment',style: TextStyle(fontSize: 9,fontWeight: FontWeight.w700),),
                    // const SizedBox(height: 50),
                    // const Icon(Icons.more_vert),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}