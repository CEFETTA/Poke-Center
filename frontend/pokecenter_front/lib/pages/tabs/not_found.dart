import 'package:flutter/cupertino.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/images/notfound.png')),
          Padding(padding: EdgeInsets.all(20),),
          Text('Página não encontrada, peço perdão pelo vacilo', style: TextStyle(fontSize: 20), textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
