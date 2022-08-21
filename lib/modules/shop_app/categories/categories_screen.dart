// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/shop_app/cubit/states.dart';
import 'package:flutter_projects/models/shop_app/categories_model.dart';
import 'package:flutter_projects/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {} ,
      builder: (context, state)
      {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (context,index) => myDivider() ,
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
        );
      } ,
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(image: NetworkImage(model.image),width: 80,height: 80,),
        SizedBox(width: 15,),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded)),

      ],
    ),
  );
}
