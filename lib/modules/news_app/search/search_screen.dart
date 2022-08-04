// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/news_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/news_app/cubit/states.dart';
import 'package:flutter_projects/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context,state) => {},
        builder: (context,state)
        {
          var list = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children:
              [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    onChanged: (value)
                    {
                      NewsCubit.get(context).getSearch(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search,),
                    ),
                    validator: (String? value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    controller: searchController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Expanded(child: articleBuilder(list,isSearch: true)),
              ],
            ),
          );
        },

      ),
    );
  }
}
