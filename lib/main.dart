import 'package:flutter/material.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqttsever2/Pages/loadingPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  MqttClient mqttClient = MqttClient();
  MqttServerClient? client = null;
  int delayMiliseconds = 100;


  void setClient() async{
    while(client == null) {
      client = await mqttClient.getMqttClient();
      await Future.delayed((Duration(milliseconds: delayMiliseconds)));
      delayMiliseconds = delayMiliseconds * 2;
      print('$client  $delayMiliseconds');

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: LoadingPage(mqttClient: mqttClient)
      ),
    );
  }
}
