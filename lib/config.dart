import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadConfig() async {
  String jsonString = await rootBundle.loadString('assets/config.json');
  Map<String, dynamic> config = json.decode(jsonString);
  //debugger(message: config['address']);
  return config;
}