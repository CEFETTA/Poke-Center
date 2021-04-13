import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Info',
            ),
          ],
        ),
      );
  }
}