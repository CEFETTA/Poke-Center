import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pokecenter_front/utils/person.dart';

import '../../globals.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final Future<Widget> _employeesCard = listEmployees();
  final Future<Widget> _patientsCard = listPatients();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
            Observer(builder: (_) => buildEmployeeCard(_employeesCard)),
            Observer(builder: (_) => buildEmployeeCard(_patientsCard))
          ],
      ),
    );
  }

  Widget buildEmployeeCard(Future<Widget> future) {
    return FutureBuilder<Widget>(
      future: future, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: snapshot.data,
            )
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Carregando...'),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}

Future<Widget> listEmployees() async {
  var response = await dio.get('/funcionarios');

  List<dynamic> employees = response.data["funcionarios"].map((func) {
    var funcPerson = func["pessoa"];
    return Person(
        funcPerson["cpf"],
        funcPerson["nome"],
        funcPerson["email"],
        funcPerson["telefone"],
        funcPerson["cep"],
        funcPerson["logradouro"],
        funcPerson["bairro"],
        funcPerson["cidade"],
        funcPerson["estado"]);
  }).toList();
  return ExpansionTile(
    title:
        Text('Gerencie a lista de ${response.data["quantidade"]} funcionários'),
    children: buildEmployeesTiles(employees),
  );
}

List<Widget> buildEmployeesTiles(List<dynamic> people) {
  return people.map((person) => 
    Card(
      child: Padding(
        padding: EdgeInsets.all(20),
          child: Text('${person.name} (${person.email})'),
        ),
      
      margin: EdgeInsets.all(5),
    )
  ).toList();
}

Future<Widget> listPatients() async {
  var response = await dio.get('/pacientes');

  List<dynamic> employees = response.data["pacientes"].map((func) {
    var funcPerson = func["pessoa"];
    return Person(
        funcPerson["cpf"],
        funcPerson["nome"],
        funcPerson["email"],
        funcPerson["telefone"],
        funcPerson["cep"],
        funcPerson["logradouro"],
        funcPerson["bairro"],
        funcPerson["cidade"],
        funcPerson["estado"]);
  }).toList();
  return ExpansionTile(
    title:
        Text('Gerencie a lista de ${response.data["quantidade"]} pacientes'),
    children: buildEmployeesTiles(employees),
  );
}
