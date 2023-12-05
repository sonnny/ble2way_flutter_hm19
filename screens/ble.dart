
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/blecontroller.dart';
import '../widgets/my_drawer.dart';
import '../widgets/my_appbar.dart';

final TextStyle myStyle = TextStyle(fontSize:20,fontWeight:FontWeight.bold);


class Ble extends StatelessWidget {
@override
Widget build(BuildContext context) {
final BleController ble = Get.put(BleController());
return Scaffold(
drawer: myDrawer(),
appBar: myAppBar(context),
body: Center(child: Column(children:[

SizedBox(height: 50.0),

ElevatedButton(
onPressed: ble.connect,
child: Obx(() => Text('${ble.status.value}',
style:myStyle))),
          
SizedBox(height: 40.0),
          
ElevatedButton(
child: Text('LED ON',style:myStyle),
onPressed:()=>ble.sendOn()),

SizedBox(height: 30.0),

ElevatedButton(
child: Text('LED OFF',style:myStyle),
onPressed:()=>ble.sendOff()),

SizedBox(height: 40.0),

Text('button status:',style:myStyle),
SizedBox(height:10.0),
Obx(()=>Text('${ble.buttonStatus.value}',style:myStyle)),
 
])));}}
