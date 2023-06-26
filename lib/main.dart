import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_c8_online/screens/home/home.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseFirestore.instance.settings =
  //     Settings(persistenceEnabled: false,
  //         cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
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
