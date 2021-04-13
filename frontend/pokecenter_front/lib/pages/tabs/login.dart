import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTab extends StatelessWidget {
  const LoginTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const fieldPadding = EdgeInsets.symmetric(horizontal: 200, vertical: 20);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Padding(
            padding: fieldPadding,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-mail',
              ),
            ),
          ),
          Padding(
            padding: fieldPadding,
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Padding(
              padding: fieldPadding,
              child: ElevatedButton.icon(
                onPressed: () {
                  print('login');
                },
                icon: Icon(Icons.arrow_forward, size: 16),
                label: Text('Entrar'),
              )),
        ],
      ),
    );
  }
}
