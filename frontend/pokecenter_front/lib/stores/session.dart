import 'package:mobx/mobx.dart';
import 'package:pokecenter_front/utils/employee.dart';
import 'package:pokecenter_front/utils/medic.dart';
import 'package:pokecenter_front/utils/person.dart';

part 'session.g.dart';

class Session = _Session with _$Session;

abstract class _Session with Store {
  @observable
  String? token;
  @observable
  Employee? employee;
  @observable
  Person? person;
  @observable
  Medic? medic;
  @observable
  bool? isLoggedIn;

  @action
  _Session(this.token, this.employee, this.person, this.medic) {
    this.isLoggedIn = false;
  }

  @action
  login(String token, Employee employee, Person person, Medic medic) {
    this.token = token;
    this.employee = employee;
    this.person = person;
    this.medic = medic;
    this.isLoggedIn = true;
  }

  @action
  logout() {
    this.isLoggedIn = false;
  }
}
