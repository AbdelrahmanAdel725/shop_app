// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/favoriets_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();

}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    super.initState();
    ShopCubit.get(context).getFavorites();
    print('ababfjbd ${ShopCubit.get(context).favorietsModel}');
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {} ,
      builder: (context, state)
      {
        var cubit = ShopCubit.get(context);
        return state is ShopLoadingFavoritesState ? Center(child: CircularProgressIndicator(),) : ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index) => buildFavItem(ShopCubit.get(context).favorietsModel!.data!.data![index],context),
          separatorBuilder: (context,index) => myDivider() ,
          itemCount: cubit.favorietsModel!.data!.data!.length,
        );
      } ,
    );
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack (
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                fit: BoxFit.cover,
                height: 120,
                image: NetworkImage('$model.product.image'),
                width: 120,
              ),
              if (model.product!.discount != 0)
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
          SizedBox(
            width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.product!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product!.price}',
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    if (1 != 0)
                      Text(
                        '${model.product!.oldPrice}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: ()
                      {
                         ShopCubit.get(context).changeFavorites(model.product!.id);
                         print(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).favorites[model.product!.id]??false ? Colors.red : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
