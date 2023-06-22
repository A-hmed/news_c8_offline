import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_c8_online/model/sources_response.dart';
import 'package:news_c8_online/screens/home/home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Home.routeName: (_)=>Home()
      },
      initialRoute: Home.routeName,
    );
  }


}
