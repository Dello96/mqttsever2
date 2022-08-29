import 'package:flutter/material.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'dart:async';
import 'package:mqttsever2/Resources/data.dart';

import 'package:mqttsever2/Widgets/glasscard.dart';

class FirstPage extends StatefulWidget {
  MqttClient? mqttClient;
  FirstPage({required this.mqttClient, Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState () {
    super.initState();
    myData.changeState = changeState;
  }

  void changeState () {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 830,
        color: Colors.grey[300],
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  scale: 10,
                    image: AssetImage('assets/images/Glatic_logo.png'))
              ),
            ),
           Container(
             width: MediaQuery.of(context).size.width,
               height: 650,
               child: GlassControlCard(mqttClient: widget.mqttClient))
          ],
        ),
      ),
    );
  }
}
