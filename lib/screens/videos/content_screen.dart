import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:Portals/screens/videos/like_icon.dart';
import 'package:Portals/screens/videos/options_screen.dart';
import 'package:Portals/shared/components.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentScreen extends StatefulWidget {
  final String ? src;

  const ContentScreen({super.key, this.src});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {

  @override
  void initState() {
    super.initState();
    HomeTapsCubit.get(context).initializeVideoPlayer(widget.src!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTapsCubit,HomeTapsCubitStates>(
        listener: (context,state){},
        builder: (context,state){
          HomeTapsCubit homeTapsCubitAccess = HomeTapsCubit.get(context);
          return Stack(
            fit: StackFit.expand,
            children: [
              homeTapsCubitAccess.chewieController != null && homeTapsCubitAccess.videoIsLoading != true &&
                  homeTapsCubitAccess.chewieController!.videoPlayerController.value.isInitialized ?
              GestureDetector(
                onDoubleTap: () {
                  homeTapsCubitAccess.changeLikeButtonState();
                },
                child: Chewie(
                  controller: homeTapsCubitAccess.chewieController!,
                ),
              ) :
              buildSharedShimmer(),
              if (homeTapsCubitAccess.liked)
                const Center(
                  child: LikeIcon(),
                ),
              const OptionsScreen()
            ],
          );
        }
    );
  }
}
