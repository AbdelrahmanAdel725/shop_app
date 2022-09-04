// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_projects/shared/components/components.dart';
import 'package:flutter_projects/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: textButton(function: (){signOut(context);}, text: 'LOGOUT'),
    );
  }
}
