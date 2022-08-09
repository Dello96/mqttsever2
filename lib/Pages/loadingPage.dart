import 'package:flutter/material.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'dart:async';

import 'package:mqttsever2/Pages/firstPage.dart';

class LoadingPage extends StatelessWidget {
  final MqttClient? mqttClient;
  LoadingPage({Key? key, @required this.mqttClient}) : super(key: key);

  int delayMiliseconds = 100;

  void moveToControlPage(BuildContext context) async {
    while(mqttClient?.getClient == null){
      if(mqttClient?.getClient != null) {
        print(mqttClient!.getClient);
        break;
      }
      await Future.delayed(Duration(milliseconds: delayMiliseconds));
      delayMiliseconds = delayMiliseconds*2;
    }
    Timer(const Duration(seconds: 2), (){
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: ((builder) => FirstPage(
                  mqttClient: mqttClient
              )))
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    moveToControlPage(context);

    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: height,
          width: width,
          child: Center(
            child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: height*0.5,
                child: Image.asset('assets/images/Glatic_logo.png', scale: 5,)
            ),
          ),
        ),
      ),
    );
  }
}