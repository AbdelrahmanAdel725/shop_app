// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_projects/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:flutter_projects/shared/components/components.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import 'package:flutter_projects/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/store.png',
      title: 'Screen Title 1',
      body: 'Screen Body 1',
    ),
    BoardingModel(
      image: 'assets/images/store.png',
      title: 'Screen Title 2',
      body: 'Screen Body 2',
    ),
    BoardingModel(
      image: 'assets/images/store.png',
      title: 'Screen Title 3',
      body: 'Screen Body 3',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ShopLoginScreen(),
          ),
          (route) {
            return false;
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 17),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              onPageChanged: (index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  isLast = false;
                }
              },
              controller: boardController,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: 3,
            )),
            SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 3,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    controller: boardController,
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
                image: AssetImage(
          model.image,
        ))),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          model.body,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
