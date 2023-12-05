import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/my_drawer.dart';
import '../style.dart';

class Help extends StatelessWidget{

@override Widget build(context) {
return Scaffold(
 
appBar: AppBar(title: Text('Notes:')),

body: SingleChildScrollView(child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

SizedBox(height:20.0),

//Padding(padding: EdgeInsets.all(12.0),
//child: Text('Notes:', style: largeText())),

Padding(padding: EdgeInsets.all(12.0),
child: Text('this is also a tutorial on how to do 2 way communication with a ble device, this help file also shows how o refactor appbar and drawer of the scaffold, I included the flutter_reactive_ble plugin code on how to connect to a known device id (use nrf connect from appstore to find id), find services, find transmit characteristic, find receive characteristic, and subscribe to receive characteristic notification. I used getx plugin to update the values from a different screen instead of using stream subscription, I feel that getx simplifies the notification updating of values from different screens.\n\nI have tested this app with Samsung Galaxy 8+, Google Pixel 4, and OPPO A16 (CPH2269), while vacationing in the Philippines year 2023, GCash and BPI mobile app doesn\t work while developers mode is on, you have to turn it off.')),

Padding(padding: EdgeInsets.all(12.0),
child: Text('I also include the flutter code in this help file to show how to use the Drawer in Scaffold in flutter and separate that widget on another file with drawer and tile for easier updating of screens/pages. To add another screen/pages, create another screen in screens directory, update my_widget to add the code to route to the new screen and that\'s it.')),

Padding(padding: EdgeInsets.all(12.0),
child: Text('''
to add new screen/page

   create a new screen and save it to lib/screen directory
   edit lib/widgets/my_drawer.dart
      add import '../screens/new_screen.dart'
      add a new drawer tile
         drawerTile(() => Get.to(NewScreen()), Icons.new, 'New Screen')

''',
style: bold())),

Padding(padding: EdgeInsets.all(12.0),
child: Text('If you are getting compiler error about minSdk, edit file project/android/app/build.grade under defaultConfig and change minSdkVersion to 21, this is only if you are using plugin flutter_reactive_ble')),

Padding(padding: EdgeInsets.all(12.0),
child: Text('On android settings, make sure you give the app location permissions (needed for bluetooth).',
style: bold())),

Padding(padding: EdgeInsets.all(12.0),
child: Text('Make sure that the phone bluetooth is on.\n\nIf GCash/BPI mobile app is not working try to disable developers mode, to enable developers mode touch android build in settings 10 times, after you enable developers mode, make sure to turn on allow usb debugging in developers mode options, \n\n after pluggin your android device to laptop and when you do flutter run youre getting permission denied, try to swipe down and touch usb charging and switch it to ptp or file transfer or anything else\n you should get a pop up allow usb debugging with phone device id, this should eliminated the permission denied when doing flutter run.')),

Padding(padding: EdgeInsets.all(12.0),
child: Text('To find the ble device id, you can install NRF connect from playstore then scan and it will show you the device id.',
style: bold())),

Padding(padding: EdgeInsets.all(12.0),
child: Text('If you use HM-19 bluetooth -> UART, the transmit, receive, and notifcation characteristic are all the same, unlike other ble devices, i.e. on raspberry pi pico w emulating a nordic spp, the characteristic for transmit, receive, and notification are all different. You can see the service/characteristic by using nrf connect from the appstore.')),  

Padding(padding: EdgeInsets.all(12.0),
child: Text('To start a flutter project, \n\nflutter upgrade \nflutter create my_project --empty \ncd my_project \nflutter pub add get \nflutter pub add flutter_reactive_ble \nflutter run',
style: bold())),

Padding(padding: EdgeInsets.all(12.0),
child: Text('''

micropython setup
HM-19 uart to ble module

HM-19 tx -> pico gpio 5
HM-19 rx -> pico gpio 4

from machine import UART, Pin
import time

u = UART(1, 115200)
led1 = Pin(14, Pin.OUT)
button1 = Pin(16, Pin.IN, Pin.PULL_UP)
buf = bytearray(3)

while 1:
    time.sleep_ms(100)
    
    # check button
    if button1.value(): u.write('not pressed')
    if not button1.value(): u.write('pressed')

    # check incoming uart
    buf = u.read(3)
    if buf is not None:
        if buf == b'OOO': led1.value(1)
        elif buf == b'FFF': led1.value(0)
''')),

////////// flutter main.dart
Padding(padding: EdgeInsets.all(12.0),
child: Text('////////// main.dart', style: bold())),
Padding(padding: EdgeInsets.all(12.0),
child: Text('''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './screens/home.dart';

void main() => runApp(GetMaterialApp(home: Home(),
  debugShowCheckedModeBanner: false));
''')),

////////// flutter screens/ble.dart
Padding(padding: EdgeInsets.all(12.0),
child: Text('////////// screens/ble.dart', style: bold())),
Padding(padding: EdgeInsets.all(12.0),
child: Text('''

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
child: Obx(() => Text('\$\{ble.status.value\}',
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
Obx(()=>Text('\$\{ble.buttonStatus.value\}',style:myStyle)),
 
])));}}
''')),

////////// flutter controllers/blecontroller.dart
Padding(padding: EdgeInsets.all(12.0),
child: Text('////////// controllers/blecontroller.dart', style: bold())),
Padding(padding: EdgeInsets.all(12.0),
child: Text('''

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';

class BleController {
final frb = FlutterReactiveBle();
late StreamSubscription<ConnectionStateUpdate> c;
late QualifiedCharacteristic tx;
late QualifiedCharacteristic rx;
final devId = 'A4:DA:32:55:06:1E'; // use nrf connect from playstore to find
var status = 'connect to bluetooth'.obs;
var buttonStatus = '0'.obs;
List<int> packet = [0x41, 0x41, 0x41]; // A A A
List<int> ledOn  = [0x4f, 0x4f, 0x4f]; // O O O
List<int> ledOff = [0x46, 0x46, 0x46]; // F F F
  
void sendData(val) async{
//packet[0]=val.toInt();
await frb.writeCharacteristicWithoutResponse(tx, value: packet);}  

void sendOn() async{
await frb.writeCharacteristicWithoutResponse(tx, value: ledOn);}  

void sendOff() async{
await frb.writeCharacteristicWithoutResponse(tx, value: ledOff);}  

void connect() async {
status.value = 'connecting...';
c = frb.connectToDevice(id: devId).listen((state) {
if (state.connectionState == DeviceConnectionState.connected) {
status.value = 'connected!';

tx = QualifiedCharacteristic(
serviceId: Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"),
characteristicId: Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb"),
deviceId: devId);
         
rx = QualifiedCharacteristic(
serviceId: Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"),            
characteristicId: Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb"), 
deviceId: devId); 

frb.subscribeToCharacteristic(rx).listen((data){
   String temp = utf8.decode(data);
   buttonStatus.value = temp;});         
}});}}
''')),

////////// flutter screens/home.dart
Padding(padding: EdgeInsets.all(12.0),
child: Text('////////// screens/home.dart', style: bold())),
Padding(padding: EdgeInsets.all(12.0),
child: Text('''
import 'package:flutter/material.dart';
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
    
Text(
Bluetooth 2 way tutorial
using HM-19 uart->ble
click help screen for info
     , style:TextStyle(fontFamily: 'semi-bold',          
     fontSize: 18, color: Colors.teal.shade800)),
])));}}
''')),


////////// flutter widgets/drawer_tile.dart
Padding(padding: EdgeInsets.all(12.0),
child: Text('////////// widgets/drawer_tile.dart', style: bold())),
Padding(padding: EdgeInsets.all(12.0),
child: Text('''
import 'package:flutter/material.dart';

Widget drawerTile(route, icon, text){
  return ListTile(
            leading: Icon(icon, color:Color(0xFF06555C)),
            title: Text(
              text,
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: route);}
''')),


////////// flutter widgets/my_drawer.dart
Padding(padding: EdgeInsets.all(12.0),
child: Text('////////// widgets/my_drawer.dart', style: bold())),
Padding(padding: EdgeInsets.all(12.0),
child: Text('''
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
''')),

////////// flutter widgets/drawer_tile.dart
Padding(padding: EdgeInsets.all(12.0),
child: Text('////////// widgets/my_appbar.dart', style: bold())),
Padding(padding: EdgeInsets.all(12.0),
child: Text('''
import 'package:flutter/material.dart';
AppBar myAppBar(context){
  return AppBar(title: const Text('BLE 2 Way')
);}
''')),


])));}}
