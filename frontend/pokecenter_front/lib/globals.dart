import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokecenter_front/stores/counter.dart';

final counter = new Counter();
final locationUrl = "https://g.page/cefetmg-campus2?share";
final titleStyle = TextStyle(fontSize: 30);

var options = BaseOptions(
  baseUrl: 'https://api-pokemon-center.herokuapp.com/',
  connectTimeout: 20000,
  receiveTimeout: 20000,
);

final dio = Dio(options);
