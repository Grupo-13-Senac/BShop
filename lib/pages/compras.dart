import 'package:bshop/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animation_cart_green.json',height: 200),
            Text('Você ainda não realizou compras!'),
          ],
        ),
      ),
    );
  }
}
