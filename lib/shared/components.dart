import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';



Future<dynamic> navigateTo({required context,required widget})
{
  return Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

Future<dynamic> navigateToAndCloseCurrent({required context,required widget})
{
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>widget));
}

Future<dynamic> navigateAndFinish({required context,required widget})
{
  return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
}

sharedToast({required String text}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
);


Widget buildSharedButton({
  required String buttonName,
  required bool isEnabled,
  required var action,
  double width = 240,
  double height = 50,
  double textSize = 20,
}) =>  GestureDetector(
  onTap: action,
  child: Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color.fromRGBO(100, 82, 217, 1)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: const Alignment(0.9, 1),
        colors: isEnabled ? <Color>[
          const Color(0xfff24998),
          const Color(0xfff2845c)
        ] : <Color>[
           Colors.grey.withOpacity(0.5),
           Colors.grey.withOpacity(0.5),
        ],
      ),
    ),
    child: Center(child: Text(buttonName,style: TextStyle(fontSize: textSize,fontWeight: FontWeight.w700,color: Colors.white),)),
  ),
);


Widget buildUploadPhotoTemp(String name,File ? path,var fun) => Stack(
  children: [
    Center(
      child: Container(
        height: name == "profile" ? 280 : 200,
        width: name == "profile" ? 321 : 200,
        decoration: name == "profile" ? const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/upload-image.png",),
            fit: BoxFit.fill,
          ),
        ) : null,
        child: InkWell(
          onTap: fun,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: name == "portal" && path != null ? const Color.fromRGBO(242, 132, 92, 1) : Colors.white,width: 2),
              color: const Color.fromRGBO(0, 0, 0, 0.35),
            ),
            child: CircleAvatar(
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0.35),
              child: (path != null) ?
              ClipOval(
                  child: SizedBox(
                    height: 275,
                    width: 275,
                    child: Image.file(path,fit: BoxFit.cover,),
                  )
              ) :
              const CircleAvatar(
                maxRadius: 40.0,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.35),
                child: ClipOval(
                  child: Center(
                    child: Icon(Icons.camera_alt_outlined,size: 40,color: Colors.white,),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    if((path != null))
      SizedBox(
          height: name == "profile" ? 310 : 220,
          child: InkWell(
            onTap: fun,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color.fromRGBO(100, 82, 217, 1),width: 2),
                  ),
                  child: CircleAvatar(
                    radius: name == "profile" ? 26.0 : 23,
                    backgroundColor: const Color.fromRGBO(242, 122, 130, 1),
                    child: const ClipOval(
                      child: Center(
                        child: Icon(Icons.refresh,size: 40,color: Colors.white,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      )
  ],
);

Widget buildSharedShimmer() =>  Shimmer.fromColors(
  baseColor:  const Color.fromRGBO(16, 12, 19, 0.75),
  highlightColor: const Color.fromRGBO(45, 24, 89, 1),
  child: Container(color: Colors.black,),
);

Widget buildSharedImageFromNetwork(String url,{BoxFit fit = BoxFit.cover}) => Image.network(
  url,
  fit: fit,
  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;
    return buildSharedShimmer();
  },
  errorBuilder: (context,t,s) => const Center(child: Icon(Icons.error_outline,color: Colors.red,),),
);

InputDecoration sharedTextFiledDecoration ({
  required String hint,
  bool isFilled = true,
  hintStyle = const TextStyle(fontSize: 11,color: Colors.white),

}) => InputDecoration(
  filled: isFilled,
  fillColor: const Color.fromRGBO(16, 12, 19, 0.5),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: BorderSide.none,
  ),
  hintText: hint,
  hintStyle: hintStyle,
  suffixIcon: const Icon(Icons.search),
  suffixIconColor: Colors.white,
);

Widget buildNotificationComponent(int notificationCount) => Container(
  // padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
  width: 63,
  height: 35,
  decoration: BoxDecoration(
      color: const Color.fromRGBO(31, 22, 50, 1),
      borderRadius: BorderRadius.circular(50)
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(notificationCount.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      Image.asset("assets/image/bell.png",width: 21,height: 22.2,),
    ],
  ),
);

Widget buildPointsComponents(int count) => Container(
  // padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
  width: 93,
  height: 35,
  decoration: BoxDecoration(
      color: const Color.fromRGBO(31, 22, 50, 1),
      borderRadius: BorderRadius.circular(50)
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Image.asset("assets/image/moon.png",width: 31,height: 28,),
      Text(count.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
    ],
  ),
);
