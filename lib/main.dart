// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/home_screen.dart';
import 'package:flutter_projects/layout/app_test/cubit/cubit.dart';
import 'package:flutter_projects/layout/app_test/cubit/states.dart';
import 'package:flutter_projects/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/shop_app/shop_layout.dart';
import 'package:flutter_projects/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:flutter_projects/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:flutter_projects/shared/bloc_observer.dart';
import 'package:flutter_projects/shared/components/constants.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import 'package:flutter_projects/shared/network/remote/dio_helper.dart';
import 'package:flutter_projects/shared/styles/themes.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(onBoarding);


  if(onBoarding != null)
    {
      if(token  != null)
        {
          widget = ShopLayout();
        }else
        {
          widget = ShopLoginScreen();
        }
    } else
    {
      widget = OnBoardingScreen();
    }

  BlocOverrides.runZoned(() {
    runApp(MyApp(
      isDark: isDark,
      startWidget: widget,
    ));
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.isDark,this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context) => AppCubit()
          ..changeAppMode(
            fromShared: isDark,
          ),),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories())
      ],

      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
