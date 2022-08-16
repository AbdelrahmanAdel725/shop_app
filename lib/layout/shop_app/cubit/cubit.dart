// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/shop_app/cubit/states.dart';
import 'package:flutter_projects/models/shop_app/home_model.dart';
import 'package:flutter_projects/modules/shop_app/categories/categories_screen.dart';
import 'package:flutter_projects/modules/shop_app/favorites/favorites_screen.dart';
import 'package:flutter_projects/modules/shop_app/products/products_screen.dart';
import 'package:flutter_projects/modules/shop_app/settings/settings_screen.dart';
import 'package:flutter_projects/shared/components/constants.dart';
import 'package:flutter_projects/shared/network/end_points.dart';
import 'package:flutter_projects/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(): super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomsScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Future<void> getHomeData() async {
    emit(ShopLoadingHomeDataState());

     await DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      print(value.data);
      homeModel = (HomeModel.fromJson(value.data));
      print('gjhag$homeModel');
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }
}
