import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokecenter_front/globals.dart';

class ScheduleConsultation extends StatefulWidget {
  @override
  _ScheduleConsultationState createState() => _ScheduleConsultationState();
}

class _ScheduleConsultationState extends State<ScheduleConsultation> {
  List<String> _locations = ['Selecione uma especialidade'];
  String _selectedLocation = 'Selecione uma especialidade';

  List<String> _medics = ['Selecione um medico'];
  String _selectedMedic = 'Selecione um medico';

  final _zip = TextEditingController();
  final _street = TextEditingController();
  final _district = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();

  void _fetchSpecialties() async {
    try {
      var response = await dio.get('especialidades');
      var specialties = response.data["especialidades"]
          .map((s) => s["especialidade"])
          .toList();

      _locations = [..._locations, ...specialties];
      setState(() {});

      print(_locations);
    } catch (e) {
      print(e);
    }
  }

  void _fetchMedic() async {
    try {
      var response = await dio.get('especialidades/$_selectedLocation');
      var specialties =
          response.data["medicos"].map((s) => s["medico"]).toList();

      _locations = [..._locations, ...specialties];
      setState(() {});

      print(_locations);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchSpecialties();
  }

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
            'Agende uma consulta',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: DropdownButton(
                      hint: Text(
                          'Escolha uma especialidade'), // Not necessary for Option 1
                      value: _selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation = newValue as String;
                        });

                        _fetchMedic();
                      },
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: DropdownButton(
                      hint: Text(
                          'Escolha um médico'), // Not necessary for Option 1
                      value: _selectedMedic,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation = newValue as String;
                        });
                      },
                      items: _medics.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
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
