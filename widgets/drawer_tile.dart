import 'package:flutter/material.dart';

Widget drawerTile(route, icon, text){
  return ListTile(
            leading: Icon(icon, color:Color(0xFF06555C)),
            title: Text(
              text,
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: route);}
