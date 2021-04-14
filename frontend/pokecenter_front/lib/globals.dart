import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokecenter_front/stores/counter.dart';
import 'package:pokecenter_front/stores/session.dart';
import 'package:pokecenter_front/utils/employee.dart';
import 'package:pokecenter_front/utils/medic.dart';
import 'package:pokecenter_front/utils/person.dart';

final counter = new Counter();
final locationUrl = "https://g.page/cefetmg-campus2?share";
final titleStyle = TextStyle(fontSize: 30);

var options = BaseOptions(
  baseUrl: 'https://api-pokemon-center.herokuapp.com/',
  connectTimeout: 20000,
  receiveTimeout: 20000,
);

Session session = Session("", Employee(0, "", 0), Person(0, "", "", 0, 0, "", "", "", ""), Medic(0, "", ""));

final dio = Dio(options);
