import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../globals.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Contador:',
            ),
            Observer(
                builder: (_) => Text(
                      '${counter.value}',
                      style: Theme.of(context).textTheme.headline4,
                    ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
        BottomNavigationBarItem(icon: Icon(Icons.business), label: "Clínica"),
        BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: "Administração")
      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        tooltip: 'Aumentar contador',
        child: Icon(Icons.add),
      ),
    );
  }
}
