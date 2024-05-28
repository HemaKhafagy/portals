import 'package:Portals/screens/store/cuibt/cubit.dart';
import 'package:Portals/screens/store/cuibt/states.dart';
import 'package:Portals/screens/store/exchange.dart';
import 'package:Portals/screens/store/is_done.dart';
import 'package:Portals/screens/store/store_content.dart';
import 'package:Portals/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StoreCubit(),
      child: BlocConsumer<StoreCubit,StoreCubitStates>(
        listener: (context,state){},
        builder: (context,state){
          StoreCubit storeCubitAccess = StoreCubit.get(context);
          return Scaffold(
            body: Container(
              decoration: sharedContainerDecoration,
              child: SafeArea(
                child: Stack(
                  children: [
                    const StoreContent(),
                    if(storeCubitAccess.exchangeIsOpened)
                      const Exchange(
                          selectedAvatarURL: "https://s3-alpha-sig.figma.com/img/9f28/a5e4/c06bd0238ce429dd2cafb03ed7163737?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=S6XmNQPx-XwMIsaOImzzCDd0Jzs8qOuWfLQZMpF5qODxMdGAurEHXIHQJqG68bSDgLtF3wEoKn9Dp1~EB5WkmrjIix9BFYIn3r~G3fE8PTQ67DM91xsg8mUUhywXnjf91Aff5gLJSJcFH9K6hcj63VqvoJ62ggGPCnBMH~J05DiYt-SXFBRGSR1ZsrIjAMG~IFOjzwzqTz1~Zte0FiUXNyjHHPHeQG9s8a2Pp8m51rSU4iVV973EecIXT0AgNWmDrcaJcY63FTWleLQEGRTq~osf~xn2jPPGxd5i1b4SrcHAGKQBTWUfPKekiNaR0jHoJuOVL-FVImWM24s9Dq1Wow__",
                          selectedAvatarName: "DJ Shark",
                          amount: 250,
                      ),
                    if(storeCubitAccess.isDone)
                      const IsDone()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }



}
