import 'package:flutter/material.dart';
import 'package:pokecenter_front/pages/home.dart';

void main() {
  runApp(MyApp());
}

// final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeCenter',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(title: 'PokeCenter'),
    );
  }
}
