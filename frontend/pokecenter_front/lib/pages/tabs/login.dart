import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokecenter_front/stores/session.dart';
import 'package:pokecenter_front/utils/employee.dart';
import 'package:pokecenter_front/utils/medic.dart';
import 'package:pokecenter_front/utils/person.dart';

import '../../globals.dart';

class LoginTab extends StatelessWidget {
  LoginTab({Key? key}) : super(key: key);

  final _email = TextEditingController();
  final _password = TextEditingController();

  _onClickLogin(BuildContext context) async {
    final login = _email.text;
    final senha = _password.text;

    print("Login: $login , Senha: $senha ");

    try {
      var response =
          await dio.post('/login', data: {'email': login, 'senha': senha});

      var funcionario = response.data["funcionario"];

      var token = response.data["token"] as String;

      var employee = Employee(funcionario["cpf"], funcionario["data_contrato"],
          funcionario["salario"]);

      var person = Person(
        response.data["pessoa"]["cpf"],
        response.data["pessoa"]["nome"],
        response.data["pessoa"]["email"],
        response.data["pessoa"]["telefone"],
        response.data["pessoa"]["cep"],
        response.data["pessoa"]["logradouro"],
        response.data["pessoa"]["bairro"],
        response.data["pessoa"]["cidade"],
        response.data["pessoa"]["estado"],
      );

      var medic = Medic(
          response.data["medico"]["cpf"],
          response.data["medico"]["especialidade"],
          response.data["medico"]["crm"]);

      var session = Session(token, employee, person, medic);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      obscureText: true,
                      controller: _password,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    ),
                    onPressed: () {
                      _onClickLogin(context);
                    },
                    icon: Icon(Icons.arrow_forward, size: 16),
                    label: Text('Entrar'),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
