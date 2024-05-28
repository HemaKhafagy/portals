
import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/screens/portals_config/add_new_portal_second.dart';
import 'package:Portals/screens/portals_config/adding_new_portal.dart';
import 'package:Portals/screens/portals_config/cubit/cubit.dart';
import 'package:Portals/screens/portals_config/join_portal_screen.dart';
import 'package:Portals/screens/splash_scree.dart';
import 'package:Portals/screens/store/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Portals/screens/signup/cubit/cubit.dart';
import 'package:Portals/shared/bloc_observer.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDWXQkW7V-noKxiHYb83mmyjPlA-wckHiU',
        appId: '1:1087257024701:android:0c02e3f5a43a9d050dbfd4',
        messagingSenderId: '1087257024701',
        projectId: 'portas-dev',
        storageBucket: 'portas-dev.appspot.com',
      )
  );
  Bloc.observer = MyBlocObserver();
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<SignUPCubit>(
                create: (context)=> SignUPCubit()
            ),
            BlocProvider<HomeTapsCubit>(
                create: (context)=> HomeTapsCubit()
            ),
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: appUsedFont,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        )
      ),
      home: const SplashScreen(),
    );
  }
}

