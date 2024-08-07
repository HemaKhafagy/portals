import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationHandler
{
  static AndroidNotificationChannel localNotificationAppChannel = AndroidNotificationChannel(
    'high_importance_channel_portals', // id
    'High Importance Notifications  For portals', // title
    importance: Importance.max,
    description: 'This channel is used for portals important notifications.',
  );

  // static Future<void> saveTokenToDatabase() async {
  //   String token = "";
  //   await FirebaseMessaging.instance.getToken().then((value) {
  //     if(value != null) token = value;
  //   });
  //   final user = FirebaseAuth.instance.currentUser;
  //   if(user != null && token.isNotEmpty){
  //     await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(user.uid)
  //         .update({
  //       'token': token,
  //     }).catchError((error){
  //       print("UNABLE TO UPDATE DEVICE TOKEN");
  //     });
  //   }
  // }

  static Future handelNotification() async
  {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    if(Platform.isAndroid){
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(localNotificationAppChannel);
    }else if(Platform.isIOS){
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true
    );
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: (value){}
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.instance.subscribeToTopic("MessageToAll");
    // await saveTokenToDatabase();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      final user = FirebaseAuth.instance.currentUser;
      RemoteNotification? notification = message.notification;
      print("notification get one time");
      if(user != null){

      }
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print("start sending local notification");
        try{
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  localNotificationAppChannel.id,
                  localNotificationAppChannel.name,
                  icon: android.smallIcon,
                  channelDescription: localNotificationAppChannel.description,
                ),
              ));
        }catch(error){
          print("error get from sending local notification");
          print(error);
        }
      }
    });
  }
}