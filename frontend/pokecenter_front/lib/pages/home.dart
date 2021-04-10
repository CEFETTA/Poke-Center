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
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        tooltip: 'Aumentar contador',
        child: Icon(Icons.add),
      ),
    );
  }
}
