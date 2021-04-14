import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokecenter_front/globals.dart';

class RegisterNewAddress extends StatelessWidget {
  RegisterNewAddress({Key? key}) : super(key: key);

  final _zip = TextEditingController();
  final _street = TextEditingController();
  final _district = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();

  _onClickRegister(BuildContext context) async {
    final zip = _zip.text;
    final street = _street.text;
    final district = _district.text;
    final city = _city.text;
    final state = _state.text;

    print(
        "zip: $zip, rua: $street, bairro: $district, cidade: $city, estado: $state ");

    try {
      await dio.post('/enderecos', data: {
        'cep': zip,
        'logradouro': street,
        'bairro': district,
        'cidade': city,
        'estado': state,
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sucesso"),
              content: Text("O endereço foi criado com sucesso"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });

      _zip.text = '';
      _street.text = '';
      _district.text = '';
      _city.text = '';
      _state.text = '';
    } catch (e) {
      print(e);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Não foi possível criar o endereço"),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });

      _zip.text = '';
      _street.text = '';
      _district.text = '';
      _city.text = '';
      _state.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Cadastre um novo endereço',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: TextField(
                      controller: _zip,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CEP',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      controller: _street,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Logradouro',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      controller: _district,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Bairro',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      controller: _city,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cidade',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      controller: _state,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Estado',
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    ),
                    onPressed: () {
                      _onClickRegister(context);
                    },
                    icon: Icon(Icons.add, size: 16),
                    label: Text('Cadastrar'),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
