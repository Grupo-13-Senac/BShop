import 'package:bshop/colors.dart';
import 'package:flutter/material.dart';

class MinhaLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimareColor,
        onPressed: () {  },
      child: Icon(Icons.playlist_add_sharp, color: Colors.white,),),
      appBar: AppBar(
        backgroundColor: kPrimareColor,
        title: Text('Minha Lista',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Text('Minha Lista Page Content'),
      ),
    );
  }
}
