import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../widgets/my_drawer.dart';
import '../widgets/my_appbar.dart';

class Home extends StatelessWidget{

@override Widget build(context) {
return Scaffold(

drawer: myDrawer(),

appBar: myAppBar(context),

body: Center(child: Column(children: [

  SizedBox(height:50.0),  
    
  Text('''
    Bluetooth 2 way tutorial
    using HM-19 uart->ble
    click help screen for info
    and source code for flutter
    and micropython
    ''', style:TextStyle(fontFamily: 'semi-bold',          
    fontSize: 18)),
     
])));}}
