import 'package:Portals/screens/profile/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';


class ProfileCubit extends Cubit<ProfileCubitStates>
{

  ProfileCubit() : super(ProfileCubitInitialState());

  static ProfileCubit get (context) => BlocProvider.of(context);



}