// https://newsapi.org/v2/everything?q=tesla&apiKey=a05a6cd9422e46bfa30e1d29af46c90c


import 'package:flutter/material.dart';
import 'package:flutter_projects/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token',).then((value) =>
  {
    if(value!)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ShopLoginScreen()))
      }
  });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


String token = '';