import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqttsever2/MQTTClient.dart';
import 'package:mqttsever2/main.dart';
import 'dart:async';
import 'package:mqttsever2/Resources/data.dart';

class ZeroControl extends StatefulWidget {
  MqttClient? mqttClient;
  MqttServerClient? client;
  String mqttTopic;
  ZeroControl({required this.mqttTopic, Key? key}) : super(key: key);

  @override
  State<ZeroControl> createState() => _ZeroControlState();
}


class _ZeroControlState extends State<ZeroControl> {
  final oneSec = Duration(milliseconds: 20);
  double _currentSliderValue = 0;

  @override
  /*void initState() {
    super.initState();
    Timer.periodic(oneSec, (Timer t) {
      widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : ${_currentSliderValue.round()}}', widget.client);
      print(_currentSliderValue);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Row(
        children: [

          Container(
              width: 100,
              height: 100,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : 0}', widget.client);
                      _currentSliderValue = 0.0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/rectangle2.png'))
                    ),
                  )
              )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 50,
            child: VerticalDivider(
              width: 20,
              thickness: 1,
              endIndent: 0,
              indent: 0,
              color: Colors.grey,
            ),
          ),
          Container(
              width: 100,
              height: 100,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\" : 100}', widget.client);
                      _currentSliderValue = 100.0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/rectangle1.png'))
                    ),
                  )
              )
          )
        ],
      )
    );
  }
}
