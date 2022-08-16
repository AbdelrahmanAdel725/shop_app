// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe


import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/shop_app/cubit/states.dart';
import 'package:flutter_projects/models/shop_app/home_model.dart';
import 'package:flutter_projects/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:flutter_projects/shared/components/components.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import '../../../models/shop_app/home_model.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder: (context) => productsBuilder(ShopCubit.get(context).homeModel),
          fallback: (context) => Center(child: CircularProgressIndicator()),);
      },

    );
  }
}


Widget productsBuilder(HomeModel? model) => Column(
  children:
  [
    CarouselSlider(
        items: model!.data!.banners!.map((e) =>  Image(
          image: NetworkImage('${e.image}'),
          width: double.infinity,
          fit: BoxFit.cover,
        )).toList(),
        options: CarouselOptions(
          height: 250,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,

        )),
  ],
);
