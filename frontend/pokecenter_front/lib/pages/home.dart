import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
      default:
        return NotFound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "Home"),
      ),
      body: _getTab(_pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "Clínica"),
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), label: "Administração")
        ],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        tooltip: 'Aumentar contador',
        child: Icon(Icons.add),
      ),
    );
  }
}
