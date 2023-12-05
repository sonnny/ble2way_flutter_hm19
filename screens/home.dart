import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../widgets/my_drawer.dart';

class Home extends StatelessWidget{
const Home({Key? key}) : super(key: key);

@override Widget build(BuildContext context) {
return Scaffold(

drawer: myDrawer(),

appBar: AppBar(title: const Text('BLE 2 Way'),
  actions: [ IconButton(icon: const Icon(Icons.lightbulb),
    onPressed:() {Get.isDarkMode
      ? Get.changeTheme(ThemeData.light())
      : Get.changeTheme(ThemeData.dark());
    })]),  

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
   
  SizedBox(height:20.0),
  Text('''
    press button attached to pin 19 before
    plug in power to the pico to start the local app
    main.py on the pico checks for pin 19 and if
    press will start the program.
  ''')
     
])));}}
