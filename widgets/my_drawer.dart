//
// to add another screen:
//   create a new screen and save it to screen directory
//   add import below, import '../screens/new_screen.dart'
//   add a new drawer tile
//     drawerTile(() => Get.to(NewScreen()). Icons.new, 'New Screen'),

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import './drawer_tile.dart';

import '../screens/home.dart';
import '../screens/ble.dart';
import '../screens/help.dart';

Widget myDrawer(){
  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
        
SizedBox(height:50.0),

drawerTile(() => Get.to(Home()), Icons.house,     'Home'),
drawerTile(() => Get.to(Ble()),  Icons.bluetooth, 'Ble'),
drawerTile(() => Get.to(Help()), Icons.help,      'Help'),

const Divider(height: 10, thickness: 1),

drawerTile(() => SystemNavigator.pop(), Icons.exit_to_app, 'Exit'),   

]));}
