import 'package:bshop/pages/loginPage.dart';
import 'package:bshop/bluetooth%20controller/scanPage.dart';
import 'package:bshop/splashScreen.dart';
import 'package:flutter/material.dart';

import 'pages/homePage.dart';

void main(){
  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
