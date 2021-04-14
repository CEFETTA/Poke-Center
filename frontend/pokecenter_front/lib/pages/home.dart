import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokecenter_front/pages/tabs/addresses.dart';
import 'package:pokecenter_front/pages/tabs/admin.dart';
import 'package:pokecenter_front/pages/tabs/galery.dart';
import 'package:pokecenter_front/pages/tabs/login.dart';
import 'package:pokecenter_front/pages/tabs/register_new_address.dart';
import 'dart:html';

import './tabs/not_found.dart';
import './tabs/info.dart';
import '../globals.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  Widget _getTab(int index) {
    switch (index) {
      case 0:
        return InfoTab();
      case 1:
        return Addresses();
      case 2:
        return Galery();
      case 3:
        return RegisterNewAddress();
      case 5:
        return session.isLoggedIn == true ? AdminPanel() : LoginTab();
      default:
        return NotFound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => _getTab(_pageIndex)
      ,),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: "Clínicas"),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_library_outlined), label: "Galeria"),
          BottomNavigationBarItem(
              icon: Icon(Icons.map), label: "Cadastrar Endereço"),
          BottomNavigationBarItem(
              icon: Icon(Icons.event), label: "Agendar consulta"),
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), label: "Administração"),
        ],
        currentIndex: _pageIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => window.open(locationUrl, "Location"),
        tooltip: 'Visite-nos',
        child: Icon(Icons.location_on),
      ),
    );
  }
}
