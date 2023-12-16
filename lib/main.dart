import 'package:bshop/loginPage.dart';
import 'package:bshop/scanPage.dart';
import 'package:bshop/splashScreen.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

void main(){
  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScanPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
