import 'package:bshop/colors.dart';
import 'package:flutter/material.dart';

class Mercados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimareColor,
        title: Text('Mercados',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Text('Mercados Page Content'),
      ),
    );
  }
}
