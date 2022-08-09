import 'package:flutter/material.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'dart:async';

import 'package:mqttsever2/Widgets/glasscard.dart';

class FirstPage extends StatefulWidget {
  MqttClient? mqttClient;
  FirstPage({required this.mqttClient, Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 900,
        color: Colors.grey[300],
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  scale: 10,
                    image: AssetImage('assets/images/Glatic_logo.png'))
              ),
            ),
            Expanded(child: GlassControlCard(glassName: 'glass1'))
          ],
        ),
      ),
    );
  }
}
