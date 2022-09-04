// ignore_for_file: import_of_legacy_library_into_null_safe, use_function_type_syntax_for_parameters, constant_identifier_names, body_might_complete_normally_nullable

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/modules/shop_app/register/shop_register_screen.dart';
import 'package:flutter_projects/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:flutter_projects/shared/network/local/cache_helper.dart';
import 'package:flutter_projects/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/web_view/web_view_screen.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

// Widget buildArticleItem(article, context) => InkWell(
//       onTap: () {
//         navigateTo(context, WebViewScreen(article['url']));
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               width: 120.0,
//               height: 120.0,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 image: DecorationImage(
//                   image: NetworkImage('${article['urlToImage']}'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//             Expanded(
//               child: Container(
//                 height: 120.0,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         '${article['title']}',
//                         maxLines: 4,
//                         overflow: TextOverflow.ellipsis,
//                         style: Theme.of(context).textTheme.bodyText1,
//                       ),
//                     ),
//                     Text(
//                       '${article['publishedAt']}',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 18),
  child:   Container(
        height: 2.0,
        color: Colors.grey[400],
      ),
);

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

// Widget articleBuilder(list,{isSearch = false}) => ConditionalBuilder(
//       condition: list.length > 0,
//       builder: (context) => ListView.separated(
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) => buildArticleItem(list[index], context),
//         itemCount: NewsCubit.get(context).business.length,
//         separatorBuilder: (context, index) => Padding(
//           padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//           child: myDivider(),
//         ),
//       ),
//       fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
//     );


Widget textButton({required void Function()? function, required String text,}) => Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Container(
    color: defaultColor,
    child:   TextButton(
      onPressed: function,
      child: Text(text.toUpperCase(),style: TextStyle(color: Colors.white),),

    ),
  ),
);


void showToast({
  required String? msg,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: msg!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 4,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNING}

Color? chooseToastColor (ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;

  }
  return color;
}


void navigateAndFinish(context,widget)=> Navigator.pushReplacement(context, MaterialPageRoute(builder: widget,));