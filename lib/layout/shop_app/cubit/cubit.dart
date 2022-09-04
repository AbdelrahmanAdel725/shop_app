// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/shop_app/cubit/states.dart';
import 'package:flutter_projects/models/shop_app/categories_model.dart';
import 'package:flutter_projects/models/shop_app/change_favorties_model.dart';
import 'package:flutter_projects/models/shop_app/favoriets_model.dart';
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

  Map<int?, bool?> favorites = {};

  HomeModel? homeModel;
  Future<void> getHomeData() async {
    emit(ShopLoadingHomeDataState());
     await DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      // print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel);
      homeModel!.data!.products!.forEach((element)
      {
        favorites.addAll({
          element.id : element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }


  CategoriesModel? categoriesModel;
  late ChangeFavouritsModel changeFavouritsModel;
  Future<void> getCategories() async {

    await DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = (CategoriesModel.fromJson(value.data));
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
      print(error.toString());
    });
  }

  void changeFavorites(int? productId)
  {
    if(favorites[productId] == true)
    {
      favorites[productId] = false;
    }else
    {
      favorites[productId] = true;
    }
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId,
        },
        token: token,
    ).then((value)
    {
      changeFavouritsModel = ChangeFavouritsModel.fromJson(value.data);
      print(value.data);
      if(changeFavouritsModel.status == false)
      {
        if(favorites[productId] == true)
        {
          favorites[productId] = false;
        }else
        {
          favorites[productId] = true;
        }
      }
      emit(ShopSuccessChangeFavoritesState(changeFavouritsModel));
    }).catchError((error)
    {
      if(favorites[productId] == true)
      {
        favorites[productId] = false;
      }else
      {
        favorites[productId] = true;
      }
      emit(ShopErrorChangeFavoritesState());
      print(error.toString());
    });
  }


  FavorietsModel? favorietsModel;
  Future<void> getFavorites() async
  {
    emit(ShopLoadingFavoritesState());
    await DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favorietsModel = (FavorietsModel.fromJson(value.data));
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
      print(error.toString());
    });
  }


}
