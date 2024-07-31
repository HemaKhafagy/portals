import 'package:Portals/shared/components.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: sharedContainerDecoration,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("NOTIFICATIONS",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromRGBO(242, 132, 92, 1),width: 2),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: buildNotificationComponent(3),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Latest",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
                      SizedBox(width: 10,),
                      Icon(FontAwesomeIcons.arrowUpWideShort)
                    ],
                  ),
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
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) => const Divider(color: Color.fromRGBO(255, 255, 255, 0.1),),
                    itemBuilder: (context,index){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 31,
                            backgroundColor: const Color.fromRGBO(242, 132, 92, 1),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipOval(
                                child:  buildSharedImageFromNetwork("https://s3-alpha-sig.figma.com/img/86c4/6f4f/348ca4f74a43c4a1c33104e4a68ec4b2?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=LTCuovp4aaHf5B8FqEY3BfXIQHa3uyq0dPSufAMkS1fEEe3DNxQNfLO3e~HvC1uqb~vDFP4zFrEMb-B3aYb9LzQberNGKm3ShMS118t3LhogCWILzgBXernFy-y0UdMwcdyxb7o949hHRWsIXDsEau-aV6DhXoHzIzVjXXNxOKPYUS7VM20LlbVQgr23Ox2s15RdgZgTjGoKRrHVPijVpB80mxvg7SdbozqS7H55Z85OSXiIBTb8Y12U9IwSijlbGAic0LIf-Oe9-ZRsRxO1fo0F~PPC9kh1ErA7j0XyGrQfuD3~N90vbXA2uIQno~6EQVz~Q-Q3Ptr0XhmTmvP~hg__"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Icon(FontAwesomeIcons.gamepad),
                                    SizedBox(width: 15,),
                                    Text("Game Invitation",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("By Sharkboy",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                                          Text("Just Now",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        buildSharedButton(buttonName: "Accept", isEnabled: true, width: 70,height: 25,textSize: 12,action: (){}),
                                        const SizedBox(width: 5,),
                                        buildSharedButton(buttonName: "Deny", isEnabled: false, width: 70,height: 25,textSize: 12,action: (){})
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
