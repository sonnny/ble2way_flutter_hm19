import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import './screens/home.dart';

void main() => runApp(GetMaterialApp(home: Home(),
  debugShowCheckedModeBanner: false,
  title: 'main',
  theme: ThemeData(primarySwatch: Colors.blue),
  darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.red)));
