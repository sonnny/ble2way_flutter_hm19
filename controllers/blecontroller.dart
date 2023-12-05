
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
List<int> packet = [0x41, 0x41, 0x41];
List<int> ledOn  = [0x4f, 0x4f, 0x4f];
List<int> ledOff = [0x46, 0x46, 0x46];
  
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
