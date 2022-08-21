// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, unused_import, avoid_web_libraries_in_flutter, sized_box_for_whitespace


import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/shop_app/cubit/states.dart';
import 'package:flutter_projects/models/shop_app/categories_model.dart';
import 'package:flutter_projects/models/shop_app/home_model.dart';
import 'package:flutter_projects/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:flutter_projects/shared/components/components.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import 'package:flutter_projects/shared/styles/colors.dart';
import '../../../models/shop_app/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context) => builderWidget(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget builderWidget(HomeModel? model,CategoriesModel? categoriesModel) => SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data!.banners!
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
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
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',
                style: TextStyle(fontSize: 35,fontWeight: FontWeight.w800),),
                SizedBox(height: 15,),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) => buildCategoryItem(categoriesModel!.data.data[index]),
                      separatorBuilder: (context,index) => SizedBox(width: 10,),
                      itemCount: categoriesModel!.data.data.length),
                ),
                SizedBox(height: 30,),
                Text('New Products',
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.w800),),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                childAspectRatio: 1 / 1.46,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                  model.data!.products!.length,
                  (index) => buildGridProduct(model.data!.products![index]),
                )),
          ),
        ],
      ),
    );

Widget buildGridProduct(Product model) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                height: 200,
                image: NetworkImage('${model.image}'),
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price!.round()}',
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice!.round()}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildCategoryItem(DataModel model) => Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(
      height: 100,
      width: 100,
      fit: BoxFit.cover,
      image: NetworkImage(
          model.image),
    ),
    Container(
        alignment: Alignment.center,
        width: 100,
        height: 25,
        color: Colors.black.withOpacity(0.8),
        child: Text(
          model.name,
          style: TextStyle(color: Colors.white,),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ))
  ],
);
