// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Session on _Session, Store {
  final _$tokenAtom = Atom(name: '_Session.token');

  @override
  String? get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String? value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  final _$employeeAtom = Atom(name: '_Session.employee');

  @override
  Employee? get employee {
    _$employeeAtom.reportRead();
    return super.employee;
  }

  @override
  set employee(Employee? value) {
    _$employeeAtom.reportWrite(value, super.employee, () {
      super.employee = value;
    });
  }

  final _$personAtom = Atom(name: '_Session.person');

  @override
  Person? get person {
    _$personAtom.reportRead();
    return super.person;
  }

  @override
  set person(Person? value) {
    _$personAtom.reportWrite(value, super.person, () {
      super.person = value;
    });
  }

  final _$medicAtom = Atom(name: '_Session.medic');

  @override
  Medic? get medic {
    _$medicAtom.reportRead();
    return super.medic;
  }

  @override
  set medic(Medic? value) {
    _$medicAtom.reportWrite(value, super.medic, () {
      super.medic = value;
    });
  }

  final _$isLoggedInAtom = Atom(name: '_Session.isLoggedIn');

  @override
  bool? get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool? value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$_SessionActionController = ActionController(name: '_Session');

  @override
  dynamic logout() {
    final _$actionInfo =
        _$_SessionActionController.startAction(name: '_Session.logout');
    try {
      return super.logout();
    } finally {
      _$_SessionActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
token: ${token},
employee: ${employee},
person: ${person},
medic: ${medic},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
