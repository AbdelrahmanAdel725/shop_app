// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Image(
              image: AssetImage(
                  'images/store.png',
              )
          ),
          SizedBox(
            height: 15.0,),
          Text('Screen Title',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(
            height: 15.0,),
          Text('Screen Body',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),),


        ],
      ),
    );
  }
}
