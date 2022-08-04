// ignore_for_file: unnecessary_null_comparison, curly_braces_in_flow_control_structures

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/app_test/cubit/states.dart';
import 'package:flutter_projects/layout/news_app/cubit/states.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super (AppInitialStates());
  static AppCubit get(context) => BlocProvider.of(context);


  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {

    if (fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });

  }
}