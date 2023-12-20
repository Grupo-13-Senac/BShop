import 'package:bshop/colors.dart';
import 'package:bshop/itens.dart';
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
        body: ListView.builder(
          itemCount: mercados.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/mercados_logos/shop$index.png',height: 50),
                      SizedBox(width: 20),
                      Text(mercados[index]),
                    ],
                  ),
                  Divider()
                ],
              ),
            );
          },
        )
    );
  }
}
