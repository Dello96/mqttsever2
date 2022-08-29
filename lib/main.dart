import 'package:flutter/material.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:mqttsever2/Resources/data.dart';
import 'package:mqttsever2/Pages/logInPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: LoginPage(storage: IpStorage(),)),
    );
  }
}