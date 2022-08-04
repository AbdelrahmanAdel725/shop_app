// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/home_screen.dart';
import 'package:flutter_projects/layout/app_test/cubit/cubit.dart';
import 'package:flutter_projects/layout/app_test/cubit/states.dart';
import 'package:flutter_projects/layout/news_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/news_app/cubit/states.dart';
import 'package:flutter_projects/layout/news_app/news_layout.dart';
import 'package:flutter_projects/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import 'package:flutter_projects/shared/network/remote/dio_helper.dart';
import 'package:flutter_projects/shared/styles/themes.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..changeAppMode(
          fromShared: isDark,
        ),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
