// ignore_for_file: import_of_legacy_library_into_null_safe, use_function_type_syntax_for_parameters

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/layout/news_app/cubit/cubit.dart';
import 'package:flutter_projects/modules/news_app/web_view/web_view_screen.dart';
import 'package:flutter_projects/modules/shop_app/register/shop_register_screen.dart';
import 'package:flutter_projects/shared/styles/colors.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Container(
      height: 1.0,
      width: 4.0,
      color: Colors.grey[400],
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget articleBuilder(list,{isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        itemCount: NewsCubit.get(context).business.length,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: myDivider(),
        ),
      ),
      fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );


Widget textButton({required Function function, required String text,}) => TextButton(
  onPressed: function(),
  child: Text(text.toUpperCase(),style: TextStyle(color: defaultColor),),

);
