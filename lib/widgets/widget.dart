import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Center(child: Text('Telegram')),
    ),
  );
}