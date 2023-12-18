import 'package:bshop/pages/compras.dart';
import 'package:bshop/pages/configuracoes.dart';
import 'package:bshop/pages/mercados.dart';
import 'package:bshop/pages/minhaLista.dart';
import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Widget> pages = [
    minhaLista(),
    mercados(),
    compras(),
    configuracoes(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: FFNavigationBar(
            theme: FFNavigationBarTheme(
              barBackgroundColor: Colors.white,
              selectedItemBorderColor: Color(0xfffcb5d2),
              selectedItemBackgroundColor: Color(0xffeb89b5),
              selectedItemIconColor: Colors.white,
              selectedItemLabelColor: Colors.black,
            ),
            selectedIndex: selectedIndex,
            onSelectTab: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
          FFNavigationBarItem(
            iconData: Icons.calendar_today,
            label: 'Minha Lista',
          ),
          FFNavigationBarItem(
            iconData: Icons.people,
            label: 'Mercados',
          ),
          FFNavigationBarItem(
            iconData: Icons.attach_money,
            label: 'Compras',
          ),
          FFNavigationBarItem(
            iconData: Icons.note,
            label: 'Configurações',
          ),
        ]));
  }
}
