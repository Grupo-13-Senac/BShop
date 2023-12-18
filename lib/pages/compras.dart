import 'package:bshop/colors.dart';
import 'package:flutter/material.dart';

class Compras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimareColor,
        title: Text('Minhas Compras',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Text('Compras Page Content'),
      ),
    );
  }
}
