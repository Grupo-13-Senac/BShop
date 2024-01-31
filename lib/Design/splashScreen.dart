import 'package:bshop/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Importe isso

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Chame o método para navegar para a homepage após 3 segundos
    Timer(Duration(seconds: 2), () {Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage()));});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Image.asset("assets/logo_text.png"),
        ),
      ),
    );
  }
}
