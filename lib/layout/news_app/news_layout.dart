// ignore_for_file: prefer_const_constructors, avoid_print, avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/app_test/cubit/cubit.dart';
import 'package:flutter_projects/layout/news_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/news_app/cubit/states.dart';
import 'package:flutter_projects/modules/news_app/search/search_screen.dart';
import 'package:flutter_projects/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => NewsCubit()..getBusiness()..getSports()..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                      Icons.search),
                ),
                IconButton(
                    onPressed: ()
                    {
                      AppCubit.get(context).changeAppMode();
                      },
                    icon: Icon(
                        Icons.brightness_6_outlined,
                    ),),
              ],
              title: Text(
                'News App',
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: NewsCubit.get(context).currentIndex,
              onTap: (index)
              {
                NewsCubit.get(context).changeBottomNavBar(index);
              },
              items: NewsCubit.get(context).bottomItems,
            ),
            body: NewsCubit.get(context).screens[NewsCubit.get(context).currentIndex],
          );
        },
      ),
    );
  }
}
