// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_string_interpolations, curly_braces_in_flow_control_structures, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/news_app/cubit/states.dart';
import 'package:flutter_projects/modules/news_app/business/business_screen.dart';
import 'package:flutter_projects/modules/news_app/science/science_screen.dart';
import 'package:flutter_projects/modules/news_app/sports/sports_screen.dart';
import 'package:flutter_projects/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super (NewsInitialStates());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(icon: Icon(Icons.business_sharp,),label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_esports_outlined,),label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science_outlined,),label: 'science'),
  ];

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar (int index){
    currentIndex = index;
    if(index==1)
      getSports();
    if(index==2)
      getScience();
    emit(NewsBottomNavStates());

  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  void getBusiness ()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        },).then((value)
    {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());

    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports ()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'a05a6cd9422e46bfa30e1d29af46c90c',
          },).then((value)
        {
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());

        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }else
        {
          emit(NewsGetSportsSuccessState());
        }

  }


  void getScience ()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length == 0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'a05a6cd9422e46bfa30e1d29af46c90c',
          },).then((value)
        {
          science = value.data['articles'];
          print(science[0]['title']);
          emit(NewsGetScienceSuccessState());

        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        });
      }else
        {
          emit(NewsGetScienceSuccessState());
        }

  }




  List<dynamic> search = [];
  void getSearch (String value)
  {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q' : '$value',
        'apiKey' : 'a05a6cd9422e46bfa30e1d29af46c90c',
      },).then((value)
    {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());

    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}




